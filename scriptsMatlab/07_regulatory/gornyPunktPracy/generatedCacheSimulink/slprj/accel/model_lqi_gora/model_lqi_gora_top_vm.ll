; ModuleID = 'test'
source_filename = "test"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @model_lqi_gora_CGInitializeSizes(i8* %S_0) {
model_lqi_gora_CGInitializeSizes_entry:
  %tmp_ = alloca [4 x i32], align 4
  call void @model_lqi_gora_Checksum([4 x i32]* nonnull %tmp_)
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
  call void @vm_blockIOSizeCheck(i8* %S_0, i32 248)
  call void @vm_dworkSizeCheck(i8* %S_0, i32 120)
  call void @vm_paramSizeCheck(i8* %S_0, i32 696)
  ret void
}

define void @model_lqi_gora_Checksum([4 x i32]* %y) {
model_lqi_gora_Checksum_entry:
  %0 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 0
  store i32 1107378320, i32* %0, align 1
  %1 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 1
  store i32 -1550482543, i32* %1, align 1
  %2 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 2
  store i32 -433917896, i32* %2, align 1
  %3 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 3
  store i32 -1939154613, i32* %3, align 1
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
  %6 = getelementptr inbounds i8, i8* %2, i64 480
  %7 = bitcast i8* %6 to double*
  %_rtP__Saturation_UpperSat_i = load double, double* %7, align 1
  %tmp0 = fsub double %_rtB__stateFeedbackGain, %_rtP__Saturation_UpperSat_i
  %8 = bitcast i8* %1 to double*
  store double %tmp0, double* %8, align 1
  %_rtB__stateFeedbackGain9 = load double, double* %5, align 1
  %9 = getelementptr inbounds i8, i8* %2, i64 488
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
  %15 = getelementptr inbounds i8, i8* %3, i64 176
  %16 = bitcast i8* %15 to double*
  %_rtB__Gain = load double, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %2, i64 384
  %18 = bitcast i8* %17 to double*
  %_rtP__Saturation_UpperSat = load double, double* %18, align 1
  %tmp2 = fsub double %_rtB__Gain, %_rtP__Saturation_UpperSat
  %19 = getelementptr inbounds i8, i8* %1, i64 16
  %20 = bitcast i8* %19 to double*
  store double %tmp2, double* %20, align 1
  %_rtB__Gain19 = load double, double* %16, align 1
  %21 = getelementptr inbounds i8, i8* %2, i64 392
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
  %5 = getelementptr inbounds i8, i8* %4, i64 216
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el = load double, double* %6, align 1
  %7 = bitcast i8* %1 to double*
  store double %_rtB__Dx_el, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 224
  %9 = bitcast i8* %8 to double*
  %_rtB__Dx_el24 = load double, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %1, i64 8
  %11 = bitcast i8* %10 to double*
  store double %_rtB__Dx_el24, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 232
  %13 = bitcast i8* %12 to double*
  %_rtB__Dx_el27 = load double, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %1, i64 16
  %15 = bitcast i8* %14 to double*
  store double %_rtB__Dx_el27, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 240
  %17 = bitcast i8* %16 to double*
  %_rtB__Dx_el30 = load double, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %1, i64 24
  %19 = bitcast i8* %18 to double*
  store double %_rtB__Dx_el30, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %4, i64 64
  %21 = bitcast i8* %20 to double*
  %_rtB__E = load double, double* %21, align 1
  %22 = getelementptr inbounds i8, i8* %1, i64 32
  %23 = bitcast i8* %22 to double*
  store double %_rtB__E, double* %23, align 1
  %24 = getelementptr inbounds i8, i8* %0, i64 117
  %_rtDW__Subsystem_MODE = load i8, i8* %24, align 1
  %25 = and i8 %_rtDW__Subsystem_MODE, 1
  %.not = icmp eq i8 %25, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %ForcingFunction_entry
  %26 = getelementptr inbounds i8, i8* %1, i64 40
  %27 = bitcast i8* %26 to double*
  store double 0.000000e+00, double* %27, align 1
  %28 = getelementptr inbounds i8, i8* %1, i64 48
  %29 = bitcast i8* %28 to double*
  store double 0.000000e+00, double* %29, align 1
  %30 = getelementptr inbounds i8, i8* %1, i64 56
  %31 = bitcast i8* %30 to double*
  store double 0.000000e+00, double* %31, align 1
  %32 = getelementptr inbounds i8, i8* %1, i64 64
  %33 = bitcast i8* %32 to double*
  store double 0.000000e+00, double* %33, align 1
  %34 = getelementptr inbounds i8, i8* %3, i64 624
  %35 = bitcast i8* %34 to i32*
  %_rtP__IPlinearmodel_A_jc_el = load i32, i32* %35, align 1
  br label %merge

false:                                            ; preds = %ForcingFunction_entry
  %36 = getelementptr inbounds i8, i8* %1, i64 40
  %37 = bitcast i8* %36 to double*
  store double 0.000000e+00, double* %37, align 1
  %38 = getelementptr inbounds i8, i8* %1, i64 48
  %39 = bitcast i8* %38 to double*
  store double 0.000000e+00, double* %39, align 1
  %40 = getelementptr inbounds i8, i8* %1, i64 56
  %41 = bitcast i8* %40 to double*
  store double 0.000000e+00, double* %41, align 1
  %42 = getelementptr inbounds i8, i8* %1, i64 64
  %43 = bitcast i8* %42 to double*
  store double 0.000000e+00, double* %43, align 1
  %44 = getelementptr inbounds i8, i8* %1, i64 72
  %45 = bitcast i8* %44 to double*
  store double 0.000000e+00, double* %45, align 1
  br label %merge15

true1:                                            ; preds = %merge
  %46 = getelementptr inbounds i8, i8* %3, i64 160
  %47 = bitcast i8* %46 to [8 x double]*
  %48 = sext i32 %ri_.0 to i64
  %49 = getelementptr inbounds [8 x double], [8 x double]* %47, i64 0, i64 %48
  %_rtP__IPlinearmodel_A_pr_el124 = load double, double* %49, align 1
  %50 = getelementptr inbounds i8, i8* %2, i64 40
  %51 = bitcast i8* %50 to double*
  %_rtX__IPlinearmodel_CSTATE_el126 = load double, double* %51, align 1
  %tmp12 = fmul double %_rtP__IPlinearmodel_A_pr_el124, %_rtX__IPlinearmodel_CSTATE_el126
  %52 = bitcast i8* %26 to [4 x double]*
  %53 = getelementptr inbounds i8, i8* %3, i64 592
  %54 = bitcast i8* %53 to [8 x i32]*
  %55 = getelementptr inbounds [8 x i32], [8 x i32]* %54, i64 0, i64 %48
  %_rtP__IPlinearmodel_A_ir_el130 = load i32, i32* %55, align 1
  %56 = sext i32 %_rtP__IPlinearmodel_A_ir_el130 to i64
  %57 = getelementptr inbounds [4 x double], [4 x double]* %52, i64 0, i64 %56
  %_rtXdot__IPlinearmodel_CSTATE_el131 = load double, double* %57, align 1
  %tmp13 = fadd double %tmp12, %_rtXdot__IPlinearmodel_CSTATE_el131
  store double %tmp13, double* %57, align 1
  %tmp14 = add i32 %ri_.0, 1
  br label %merge

true3:                                            ; preds = %merge11
  %58 = getelementptr inbounds i8, i8* %3, i64 160
  %59 = bitcast i8* %58 to [8 x double]*
  %60 = sext i32 %ri_.1 to i64
  %61 = getelementptr inbounds [8 x double], [8 x double]* %59, i64 0, i64 %60
  %_rtP__IPlinearmodel_A_pr_el109 = load double, double* %61, align 1
  %62 = getelementptr inbounds i8, i8* %2, i64 48
  %63 = bitcast i8* %62 to double*
  %_rtX__IPlinearmodel_CSTATE_el111 = load double, double* %63, align 1
  %tmp9 = fmul double %_rtP__IPlinearmodel_A_pr_el109, %_rtX__IPlinearmodel_CSTATE_el111
  %64 = bitcast i8* %26 to [4 x double]*
  %65 = getelementptr inbounds i8, i8* %3, i64 592
  %66 = bitcast i8* %65 to [8 x i32]*
  %67 = getelementptr inbounds [8 x i32], [8 x i32]* %66, i64 0, i64 %60
  %_rtP__IPlinearmodel_A_ir_el115 = load i32, i32* %67, align 1
  %68 = sext i32 %_rtP__IPlinearmodel_A_ir_el115 to i64
  %69 = getelementptr inbounds [4 x double], [4 x double]* %64, i64 0, i64 %68
  %_rtXdot__IPlinearmodel_CSTATE_el116 = load double, double* %69, align 1
  %tmp10 = fadd double %tmp9, %_rtXdot__IPlinearmodel_CSTATE_el116
  store double %tmp10, double* %69, align 1
  %tmp11 = add i32 %ri_.1, 1
  br label %merge11

true5:                                            ; preds = %merge12
  %70 = getelementptr inbounds i8, i8* %3, i64 160
  %71 = bitcast i8* %70 to [8 x double]*
  %72 = sext i32 %ri_.2 to i64
  %73 = getelementptr inbounds [8 x double], [8 x double]* %71, i64 0, i64 %72
  %_rtP__IPlinearmodel_A_pr_el94 = load double, double* %73, align 1
  %74 = getelementptr inbounds i8, i8* %2, i64 56
  %75 = bitcast i8* %74 to double*
  %_rtX__IPlinearmodel_CSTATE_el96 = load double, double* %75, align 1
  %tmp6 = fmul double %_rtP__IPlinearmodel_A_pr_el94, %_rtX__IPlinearmodel_CSTATE_el96
  %76 = bitcast i8* %26 to [4 x double]*
  %77 = getelementptr inbounds i8, i8* %3, i64 592
  %78 = bitcast i8* %77 to [8 x i32]*
  %79 = getelementptr inbounds [8 x i32], [8 x i32]* %78, i64 0, i64 %72
  %_rtP__IPlinearmodel_A_ir_el100 = load i32, i32* %79, align 1
  %80 = sext i32 %_rtP__IPlinearmodel_A_ir_el100 to i64
  %81 = getelementptr inbounds [4 x double], [4 x double]* %76, i64 0, i64 %80
  %_rtXdot__IPlinearmodel_CSTATE_el101 = load double, double* %81, align 1
  %tmp7 = fadd double %tmp6, %_rtXdot__IPlinearmodel_CSTATE_el101
  store double %tmp7, double* %81, align 1
  %tmp8 = add i32 %ri_.2, 1
  br label %merge12

true7:                                            ; preds = %merge13
  %82 = getelementptr inbounds i8, i8* %3, i64 160
  %83 = bitcast i8* %82 to [8 x double]*
  %84 = sext i32 %ri_.3 to i64
  %85 = getelementptr inbounds [8 x double], [8 x double]* %83, i64 0, i64 %84
  %_rtP__IPlinearmodel_A_pr_el = load double, double* %85, align 1
  %86 = getelementptr inbounds i8, i8* %2, i64 64
  %87 = bitcast i8* %86 to double*
  %_rtX__IPlinearmodel_CSTATE_el = load double, double* %87, align 1
  %tmp3 = fmul double %_rtP__IPlinearmodel_A_pr_el, %_rtX__IPlinearmodel_CSTATE_el
  %88 = bitcast i8* %26 to [4 x double]*
  %89 = getelementptr inbounds i8, i8* %3, i64 592
  %90 = bitcast i8* %89 to [8 x i32]*
  %91 = getelementptr inbounds [8 x i32], [8 x i32]* %90, i64 0, i64 %84
  %_rtP__IPlinearmodel_A_ir_el = load i32, i32* %91, align 1
  %92 = sext i32 %_rtP__IPlinearmodel_A_ir_el to i64
  %93 = getelementptr inbounds [4 x double], [4 x double]* %88, i64 0, i64 %92
  %_rtXdot__IPlinearmodel_CSTATE_el86 = load double, double* %93, align 1
  %tmp4 = fadd double %tmp3, %_rtXdot__IPlinearmodel_CSTATE_el86
  store double %tmp4, double* %93, align 1
  %tmp5 = add i32 %ri_.3, 1
  br label %merge13

false8:                                           ; preds = %merge13
  %94 = getelementptr inbounds i8, i8* %3, i64 652
  %95 = bitcast i8* %94 to i32*
  %_rtP__IPlinearmodel_B_jc_el = load i32, i32* %95, align 1
  br label %merge14

true9:                                            ; preds = %merge14
  %96 = getelementptr inbounds i8, i8* %3, i64 224
  %97 = bitcast i8* %96 to [2 x double]*
  %98 = sext i32 %ri_.4 to i64
  %99 = getelementptr inbounds [2 x double], [2 x double]* %97, i64 0, i64 %98
  %_rtP__IPlinearmodel_B_pr_el = load double, double* %99, align 1
  %100 = getelementptr inbounds i8, i8* %4, i64 192
  %101 = bitcast i8* %100 to double*
  %_rtB__ctrl_sig_lin = load double, double* %101, align 1
  %tmp0 = fmul double %_rtP__IPlinearmodel_B_pr_el, %_rtB__ctrl_sig_lin
  %102 = bitcast i8* %26 to [4 x double]*
  %103 = getelementptr inbounds i8, i8* %3, i64 644
  %104 = bitcast i8* %103 to [2 x i32]*
  %105 = getelementptr inbounds [2 x i32], [2 x i32]* %104, i64 0, i64 %98
  %_rtP__IPlinearmodel_B_ir_el = load i32, i32* %105, align 1
  %106 = sext i32 %_rtP__IPlinearmodel_B_ir_el to i64
  %107 = getelementptr inbounds [4 x double], [4 x double]* %102, i64 0, i64 %106
  %_rtXdot__IPlinearmodel_CSTATE_el = load double, double* %107, align 1
  %tmp1 = fadd double %tmp0, %_rtXdot__IPlinearmodel_CSTATE_el
  store double %tmp1, double* %107, align 1
  %tmp2 = add i32 %ri_.4, 1
  br label %merge14

false10:                                          ; preds = %merge14
  %108 = getelementptr inbounds i8, i8* %4, i64 168
  %109 = bitcast i8* %108 to double*
  %_rtB__E_a = load double, double* %109, align 1
  %110 = getelementptr inbounds i8, i8* %1, i64 72
  %111 = bitcast i8* %110 to double*
  store double %_rtB__E_a, double* %111, align 1
  br label %merge15

merge:                                            ; preds = %true1, %true
  %ri_.0 = phi i32 [ %_rtP__IPlinearmodel_A_jc_el, %true ], [ %tmp14, %true1 ]
  %112 = getelementptr inbounds i8, i8* %3, i64 628
  %113 = bitcast i8* %112 to i32*
  %_rtP__IPlinearmodel_A_jc_el47 = load i32, i32* %113, align 1
  %114 = icmp ult i32 %ri_.0, %_rtP__IPlinearmodel_A_jc_el47
  br i1 %114, label %true1, label %merge11

merge11:                                          ; preds = %merge, %true3
  %ri_.1 = phi i32 [ %tmp11, %true3 ], [ %_rtP__IPlinearmodel_A_jc_el47, %merge ]
  %115 = getelementptr inbounds i8, i8* %3, i64 632
  %116 = bitcast i8* %115 to i32*
  %_rtP__IPlinearmodel_A_jc_el52 = load i32, i32* %116, align 1
  %117 = icmp ult i32 %ri_.1, %_rtP__IPlinearmodel_A_jc_el52
  br i1 %117, label %true3, label %merge12

merge12:                                          ; preds = %merge11, %true5
  %ri_.2 = phi i32 [ %tmp8, %true5 ], [ %_rtP__IPlinearmodel_A_jc_el52, %merge11 ]
  %118 = getelementptr inbounds i8, i8* %3, i64 636
  %119 = bitcast i8* %118 to i32*
  %_rtP__IPlinearmodel_A_jc_el57 = load i32, i32* %119, align 1
  %120 = icmp ult i32 %ri_.2, %_rtP__IPlinearmodel_A_jc_el57
  br i1 %120, label %true5, label %merge13

merge13:                                          ; preds = %merge12, %true7
  %ri_.3 = phi i32 [ %tmp5, %true7 ], [ %_rtP__IPlinearmodel_A_jc_el57, %merge12 ]
  %121 = getelementptr inbounds i8, i8* %3, i64 640
  %122 = bitcast i8* %121 to i32*
  %_rtP__IPlinearmodel_A_jc_el62 = load i32, i32* %122, align 1
  %123 = icmp ult i32 %ri_.3, %_rtP__IPlinearmodel_A_jc_el62
  br i1 %123, label %true7, label %false8

merge14:                                          ; preds = %true9, %false8
  %ri_.4 = phi i32 [ %_rtP__IPlinearmodel_B_jc_el, %false8 ], [ %tmp2, %true9 ]
  %124 = getelementptr inbounds i8, i8* %3, i64 656
  %125 = bitcast i8* %124 to i32*
  %_rtP__IPlinearmodel_B_jc_el66 = load i32, i32* %125, align 1
  %126 = icmp ult i32 %ri_.4, %_rtP__IPlinearmodel_B_jc_el66
  br i1 %126, label %true9, label %false10

merge15:                                          ; preds = %false10, %false
  ret void
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
  %5 = getelementptr inbounds i8, i8* %4, i64 216
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el = load double, double* %6, align 1
  %7 = bitcast i8* %1 to double*
  store double %_rtB__Dx_el, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 224
  %9 = bitcast i8* %8 to double*
  %_rtB__Dx_el24 = load double, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %1, i64 8
  %11 = bitcast i8* %10 to double*
  store double %_rtB__Dx_el24, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 232
  %13 = bitcast i8* %12 to double*
  %_rtB__Dx_el27 = load double, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %1, i64 16
  %15 = bitcast i8* %14 to double*
  store double %_rtB__Dx_el27, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 240
  %17 = bitcast i8* %16 to double*
  %_rtB__Dx_el30 = load double, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %1, i64 24
  %19 = bitcast i8* %18 to double*
  store double %_rtB__Dx_el30, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %4, i64 64
  %21 = bitcast i8* %20 to double*
  %_rtB__E = load double, double* %21, align 1
  %22 = getelementptr inbounds i8, i8* %1, i64 32
  %23 = bitcast i8* %22 to double*
  store double %_rtB__E, double* %23, align 1
  %24 = getelementptr inbounds i8, i8* %0, i64 117
  %_rtDW__Subsystem_MODE = load i8, i8* %24, align 1
  %25 = and i8 %_rtDW__Subsystem_MODE, 1
  %.not = icmp eq i8 %25, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %Derivatives_entry
  %26 = getelementptr inbounds i8, i8* %1, i64 40
  %27 = bitcast i8* %26 to double*
  store double 0.000000e+00, double* %27, align 1
  %28 = getelementptr inbounds i8, i8* %1, i64 48
  %29 = bitcast i8* %28 to double*
  store double 0.000000e+00, double* %29, align 1
  %30 = getelementptr inbounds i8, i8* %1, i64 56
  %31 = bitcast i8* %30 to double*
  store double 0.000000e+00, double* %31, align 1
  %32 = getelementptr inbounds i8, i8* %1, i64 64
  %33 = bitcast i8* %32 to double*
  store double 0.000000e+00, double* %33, align 1
  %34 = getelementptr inbounds i8, i8* %3, i64 624
  %35 = bitcast i8* %34 to i32*
  %_rtP__IPlinearmodel_A_jc_el = load i32, i32* %35, align 1
  br label %merge

false:                                            ; preds = %Derivatives_entry
  %36 = getelementptr inbounds i8, i8* %1, i64 40
  %37 = bitcast i8* %36 to double*
  store double 0.000000e+00, double* %37, align 1
  %38 = getelementptr inbounds i8, i8* %1, i64 48
  %39 = bitcast i8* %38 to double*
  store double 0.000000e+00, double* %39, align 1
  %40 = getelementptr inbounds i8, i8* %1, i64 56
  %41 = bitcast i8* %40 to double*
  store double 0.000000e+00, double* %41, align 1
  %42 = getelementptr inbounds i8, i8* %1, i64 64
  %43 = bitcast i8* %42 to double*
  store double 0.000000e+00, double* %43, align 1
  %44 = getelementptr inbounds i8, i8* %1, i64 72
  %45 = bitcast i8* %44 to double*
  store double 0.000000e+00, double* %45, align 1
  br label %merge15

true1:                                            ; preds = %merge
  %46 = getelementptr inbounds i8, i8* %3, i64 160
  %47 = bitcast i8* %46 to [8 x double]*
  %48 = sext i32 %ri_.0 to i64
  %49 = getelementptr inbounds [8 x double], [8 x double]* %47, i64 0, i64 %48
  %_rtP__IPlinearmodel_A_pr_el124 = load double, double* %49, align 1
  %50 = getelementptr inbounds i8, i8* %2, i64 40
  %51 = bitcast i8* %50 to double*
  %_rtX__IPlinearmodel_CSTATE_el126 = load double, double* %51, align 1
  %tmp12 = fmul double %_rtP__IPlinearmodel_A_pr_el124, %_rtX__IPlinearmodel_CSTATE_el126
  %52 = bitcast i8* %26 to [4 x double]*
  %53 = getelementptr inbounds i8, i8* %3, i64 592
  %54 = bitcast i8* %53 to [8 x i32]*
  %55 = getelementptr inbounds [8 x i32], [8 x i32]* %54, i64 0, i64 %48
  %_rtP__IPlinearmodel_A_ir_el130 = load i32, i32* %55, align 1
  %56 = sext i32 %_rtP__IPlinearmodel_A_ir_el130 to i64
  %57 = getelementptr inbounds [4 x double], [4 x double]* %52, i64 0, i64 %56
  %_rtXdot__IPlinearmodel_CSTATE_el131 = load double, double* %57, align 1
  %tmp13 = fadd double %tmp12, %_rtXdot__IPlinearmodel_CSTATE_el131
  store double %tmp13, double* %57, align 1
  %tmp14 = add i32 %ri_.0, 1
  br label %merge

true3:                                            ; preds = %merge11
  %58 = getelementptr inbounds i8, i8* %3, i64 160
  %59 = bitcast i8* %58 to [8 x double]*
  %60 = sext i32 %ri_.1 to i64
  %61 = getelementptr inbounds [8 x double], [8 x double]* %59, i64 0, i64 %60
  %_rtP__IPlinearmodel_A_pr_el109 = load double, double* %61, align 1
  %62 = getelementptr inbounds i8, i8* %2, i64 48
  %63 = bitcast i8* %62 to double*
  %_rtX__IPlinearmodel_CSTATE_el111 = load double, double* %63, align 1
  %tmp9 = fmul double %_rtP__IPlinearmodel_A_pr_el109, %_rtX__IPlinearmodel_CSTATE_el111
  %64 = bitcast i8* %26 to [4 x double]*
  %65 = getelementptr inbounds i8, i8* %3, i64 592
  %66 = bitcast i8* %65 to [8 x i32]*
  %67 = getelementptr inbounds [8 x i32], [8 x i32]* %66, i64 0, i64 %60
  %_rtP__IPlinearmodel_A_ir_el115 = load i32, i32* %67, align 1
  %68 = sext i32 %_rtP__IPlinearmodel_A_ir_el115 to i64
  %69 = getelementptr inbounds [4 x double], [4 x double]* %64, i64 0, i64 %68
  %_rtXdot__IPlinearmodel_CSTATE_el116 = load double, double* %69, align 1
  %tmp10 = fadd double %tmp9, %_rtXdot__IPlinearmodel_CSTATE_el116
  store double %tmp10, double* %69, align 1
  %tmp11 = add i32 %ri_.1, 1
  br label %merge11

true5:                                            ; preds = %merge12
  %70 = getelementptr inbounds i8, i8* %3, i64 160
  %71 = bitcast i8* %70 to [8 x double]*
  %72 = sext i32 %ri_.2 to i64
  %73 = getelementptr inbounds [8 x double], [8 x double]* %71, i64 0, i64 %72
  %_rtP__IPlinearmodel_A_pr_el94 = load double, double* %73, align 1
  %74 = getelementptr inbounds i8, i8* %2, i64 56
  %75 = bitcast i8* %74 to double*
  %_rtX__IPlinearmodel_CSTATE_el96 = load double, double* %75, align 1
  %tmp6 = fmul double %_rtP__IPlinearmodel_A_pr_el94, %_rtX__IPlinearmodel_CSTATE_el96
  %76 = bitcast i8* %26 to [4 x double]*
  %77 = getelementptr inbounds i8, i8* %3, i64 592
  %78 = bitcast i8* %77 to [8 x i32]*
  %79 = getelementptr inbounds [8 x i32], [8 x i32]* %78, i64 0, i64 %72
  %_rtP__IPlinearmodel_A_ir_el100 = load i32, i32* %79, align 1
  %80 = sext i32 %_rtP__IPlinearmodel_A_ir_el100 to i64
  %81 = getelementptr inbounds [4 x double], [4 x double]* %76, i64 0, i64 %80
  %_rtXdot__IPlinearmodel_CSTATE_el101 = load double, double* %81, align 1
  %tmp7 = fadd double %tmp6, %_rtXdot__IPlinearmodel_CSTATE_el101
  store double %tmp7, double* %81, align 1
  %tmp8 = add i32 %ri_.2, 1
  br label %merge12

true7:                                            ; preds = %merge13
  %82 = getelementptr inbounds i8, i8* %3, i64 160
  %83 = bitcast i8* %82 to [8 x double]*
  %84 = sext i32 %ri_.3 to i64
  %85 = getelementptr inbounds [8 x double], [8 x double]* %83, i64 0, i64 %84
  %_rtP__IPlinearmodel_A_pr_el = load double, double* %85, align 1
  %86 = getelementptr inbounds i8, i8* %2, i64 64
  %87 = bitcast i8* %86 to double*
  %_rtX__IPlinearmodel_CSTATE_el = load double, double* %87, align 1
  %tmp3 = fmul double %_rtP__IPlinearmodel_A_pr_el, %_rtX__IPlinearmodel_CSTATE_el
  %88 = bitcast i8* %26 to [4 x double]*
  %89 = getelementptr inbounds i8, i8* %3, i64 592
  %90 = bitcast i8* %89 to [8 x i32]*
  %91 = getelementptr inbounds [8 x i32], [8 x i32]* %90, i64 0, i64 %84
  %_rtP__IPlinearmodel_A_ir_el = load i32, i32* %91, align 1
  %92 = sext i32 %_rtP__IPlinearmodel_A_ir_el to i64
  %93 = getelementptr inbounds [4 x double], [4 x double]* %88, i64 0, i64 %92
  %_rtXdot__IPlinearmodel_CSTATE_el86 = load double, double* %93, align 1
  %tmp4 = fadd double %tmp3, %_rtXdot__IPlinearmodel_CSTATE_el86
  store double %tmp4, double* %93, align 1
  %tmp5 = add i32 %ri_.3, 1
  br label %merge13

false8:                                           ; preds = %merge13
  %94 = getelementptr inbounds i8, i8* %3, i64 652
  %95 = bitcast i8* %94 to i32*
  %_rtP__IPlinearmodel_B_jc_el = load i32, i32* %95, align 1
  br label %merge14

true9:                                            ; preds = %merge14
  %96 = getelementptr inbounds i8, i8* %3, i64 224
  %97 = bitcast i8* %96 to [2 x double]*
  %98 = sext i32 %ri_.4 to i64
  %99 = getelementptr inbounds [2 x double], [2 x double]* %97, i64 0, i64 %98
  %_rtP__IPlinearmodel_B_pr_el = load double, double* %99, align 1
  %100 = getelementptr inbounds i8, i8* %4, i64 192
  %101 = bitcast i8* %100 to double*
  %_rtB__ctrl_sig_lin = load double, double* %101, align 1
  %tmp0 = fmul double %_rtP__IPlinearmodel_B_pr_el, %_rtB__ctrl_sig_lin
  %102 = bitcast i8* %26 to [4 x double]*
  %103 = getelementptr inbounds i8, i8* %3, i64 644
  %104 = bitcast i8* %103 to [2 x i32]*
  %105 = getelementptr inbounds [2 x i32], [2 x i32]* %104, i64 0, i64 %98
  %_rtP__IPlinearmodel_B_ir_el = load i32, i32* %105, align 1
  %106 = sext i32 %_rtP__IPlinearmodel_B_ir_el to i64
  %107 = getelementptr inbounds [4 x double], [4 x double]* %102, i64 0, i64 %106
  %_rtXdot__IPlinearmodel_CSTATE_el = load double, double* %107, align 1
  %tmp1 = fadd double %tmp0, %_rtXdot__IPlinearmodel_CSTATE_el
  store double %tmp1, double* %107, align 1
  %tmp2 = add i32 %ri_.4, 1
  br label %merge14

false10:                                          ; preds = %merge14
  %108 = getelementptr inbounds i8, i8* %4, i64 168
  %109 = bitcast i8* %108 to double*
  %_rtB__E_a = load double, double* %109, align 1
  %110 = getelementptr inbounds i8, i8* %1, i64 72
  %111 = bitcast i8* %110 to double*
  store double %_rtB__E_a, double* %111, align 1
  br label %merge15

merge:                                            ; preds = %true1, %true
  %ri_.0 = phi i32 [ %_rtP__IPlinearmodel_A_jc_el, %true ], [ %tmp14, %true1 ]
  %112 = getelementptr inbounds i8, i8* %3, i64 628
  %113 = bitcast i8* %112 to i32*
  %_rtP__IPlinearmodel_A_jc_el47 = load i32, i32* %113, align 1
  %114 = icmp ult i32 %ri_.0, %_rtP__IPlinearmodel_A_jc_el47
  br i1 %114, label %true1, label %merge11

merge11:                                          ; preds = %merge, %true3
  %ri_.1 = phi i32 [ %tmp11, %true3 ], [ %_rtP__IPlinearmodel_A_jc_el47, %merge ]
  %115 = getelementptr inbounds i8, i8* %3, i64 632
  %116 = bitcast i8* %115 to i32*
  %_rtP__IPlinearmodel_A_jc_el52 = load i32, i32* %116, align 1
  %117 = icmp ult i32 %ri_.1, %_rtP__IPlinearmodel_A_jc_el52
  br i1 %117, label %true3, label %merge12

merge12:                                          ; preds = %merge11, %true5
  %ri_.2 = phi i32 [ %tmp8, %true5 ], [ %_rtP__IPlinearmodel_A_jc_el52, %merge11 ]
  %118 = getelementptr inbounds i8, i8* %3, i64 636
  %119 = bitcast i8* %118 to i32*
  %_rtP__IPlinearmodel_A_jc_el57 = load i32, i32* %119, align 1
  %120 = icmp ult i32 %ri_.2, %_rtP__IPlinearmodel_A_jc_el57
  br i1 %120, label %true5, label %merge13

merge13:                                          ; preds = %merge12, %true7
  %ri_.3 = phi i32 [ %tmp5, %true7 ], [ %_rtP__IPlinearmodel_A_jc_el57, %merge12 ]
  %121 = getelementptr inbounds i8, i8* %3, i64 640
  %122 = bitcast i8* %121 to i32*
  %_rtP__IPlinearmodel_A_jc_el62 = load i32, i32* %122, align 1
  %123 = icmp ult i32 %ri_.3, %_rtP__IPlinearmodel_A_jc_el62
  br i1 %123, label %true7, label %false8

merge14:                                          ; preds = %true9, %false8
  %ri_.4 = phi i32 [ %_rtP__IPlinearmodel_B_jc_el, %false8 ], [ %tmp2, %true9 ]
  %124 = getelementptr inbounds i8, i8* %3, i64 656
  %125 = bitcast i8* %124 to i32*
  %_rtP__IPlinearmodel_B_jc_el66 = load i32, i32* %125, align 1
  %126 = icmp ult i32 %ri_.4, %_rtP__IPlinearmodel_B_jc_el66
  br i1 %126, label %true9, label %false10

merge15:                                          ; preds = %false10, %false
  ret void
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
  %2 = getelementptr inbounds i8, i8* %0, i64 528
  %3 = bitcast i8* %2 to double*
  %_rtP__Constant_Value_el = load double, double* %3, align 1
  %4 = getelementptr inbounds i8, i8* %1, i64 72
  %5 = bitcast i8* %4 to double*
  store double %_rtP__Constant_Value_el, double* %5, align 1
  %6 = getelementptr inbounds i8, i8* %0, i64 536
  %7 = bitcast i8* %6 to double*
  %_rtP__Constant_Value_el6 = load double, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %1, i64 80
  %9 = bitcast i8* %8 to double*
  store double %_rtP__Constant_Value_el6, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %0, i64 544
  %11 = bitcast i8* %10 to double*
  %_rtP__Constant_Value_el9 = load double, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %1, i64 88
  %13 = bitcast i8* %12 to double*
  store double %_rtP__Constant_Value_el9, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %0, i64 552
  %15 = bitcast i8* %14 to double*
  %_rtP__Constant_Value_el12 = load double, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %1, i64 96
  %17 = bitcast i8* %16 to double*
  store double %_rtP__Constant_Value_el12, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %0, i64 560
  %19 = bitcast i8* %18 to double*
  %_rtP__Constant1_Value_el = load double, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %1, i64 104
  %21 = bitcast i8* %20 to double*
  store double %_rtP__Constant1_Value_el, double* %21, align 1
  %22 = getelementptr inbounds i8, i8* %0, i64 568
  %23 = bitcast i8* %22 to double*
  %_rtP__Constant1_Value_el17 = load double, double* %23, align 1
  %24 = getelementptr inbounds i8, i8* %1, i64 112
  %25 = bitcast i8* %24 to double*
  store double %_rtP__Constant1_Value_el17, double* %25, align 1
  %26 = getelementptr inbounds i8, i8* %0, i64 576
  %27 = bitcast i8* %26 to double*
  %_rtP__Constant1_Value_el20 = load double, double* %27, align 1
  %28 = getelementptr inbounds i8, i8* %1, i64 120
  %29 = bitcast i8* %28 to double*
  store double %_rtP__Constant1_Value_el20, double* %29, align 1
  %30 = getelementptr inbounds i8, i8* %0, i64 584
  %31 = bitcast i8* %30 to double*
  %_rtP__Constant2_Value = load double, double* %31, align 1
  %32 = getelementptr inbounds i8, i8* %1, i64 128
  %33 = bitcast i8* %32 to double*
  store double %_rtP__Constant2_Value, double* %33, align 1
  ret void
}

define void @Outputs0(i8* %S) {
Outputs0_entry:
  %rtb_e_stanu_0_ = alloca [5 x double], align 8
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

true:                                             ; preds = %false76, %false64, %false75, %false74, %false73, %false72, %false71, %false70, %false69, %false68, %false67, %false66, %false65, %true63, %false61, %false60, %false59, %false58, %false57, %false34, %merge90, %merge81, %false7, %false6, %false5, %merge, %Outputs0_entry
  ret void

false:                                            ; preds = %Outputs0_entry
  %11 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %12 = and i8 %11, 1
  %.not444 = icmp eq i8 %12, 0
  br i1 %.not444, label %false2, label %true1

true1:                                            ; preds = %false
  %13 = getelementptr inbounds i8, i8* %3, i64 104
  %14 = bitcast i8* %13 to i32*
  %_rtDW__Integrator_IWORK = load i32, i32* %14, align 1
  %.not479 = icmp eq i32 %_rtDW__Integrator_IWORK, 0
  br i1 %.not479, label %true1.false4_crit_edge, label %true3

true1.false4_crit_edge:                           ; preds = %true1
  %.phi.trans.insert = bitcast i8* %5 to double*
  %_rtX__Integrator_CSTATE_el127.pre = load double, double* %.phi.trans.insert, align 1
  br label %false4

false2:                                           ; preds = %false
  %15 = bitcast i8* %5 to double*
  %_rtX__Integrator_CSTATE_el = load double, double* %15, align 1
  %16 = bitcast i8* %7 to double*
  store double %_rtX__Integrator_CSTATE_el, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %5, i64 8
  %18 = bitcast i8* %17 to double*
  %_rtX__Integrator_CSTATE_el106 = load double, double* %18, align 1
  %19 = getelementptr inbounds i8, i8* %7, i64 8
  %20 = bitcast i8* %19 to double*
  store double %_rtX__Integrator_CSTATE_el106, double* %20, align 1
  %21 = getelementptr inbounds i8, i8* %5, i64 16
  %22 = bitcast i8* %21 to double*
  %_rtX__Integrator_CSTATE_el109 = load double, double* %22, align 1
  %23 = getelementptr inbounds i8, i8* %7, i64 16
  %24 = bitcast i8* %23 to double*
  store double %_rtX__Integrator_CSTATE_el109, double* %24, align 1
  %25 = getelementptr inbounds i8, i8* %5, i64 24
  %26 = bitcast i8* %25 to double*
  %_rtX__Integrator_CSTATE_el112 = load double, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %7, i64 24
  %28 = bitcast i8* %27 to double*
  store double %_rtX__Integrator_CSTATE_el112, double* %28, align 1
  br label %merge

true3:                                            ; preds = %true1
  %29 = getelementptr inbounds i8, i8* %7, i64 72
  %30 = bitcast i8* %29 to double*
  %_rtB__Constant_el = load double, double* %30, align 1
  %31 = bitcast i8* %5 to double*
  store double %_rtB__Constant_el, double* %31, align 1
  %32 = getelementptr inbounds i8, i8* %7, i64 80
  %33 = bitcast i8* %32 to double*
  %_rtB__Constant_el118 = load double, double* %33, align 1
  %34 = getelementptr inbounds i8, i8* %5, i64 8
  %35 = bitcast i8* %34 to double*
  store double %_rtB__Constant_el118, double* %35, align 1
  %36 = getelementptr inbounds i8, i8* %7, i64 88
  %37 = bitcast i8* %36 to double*
  %_rtB__Constant_el121 = load double, double* %37, align 1
  %38 = getelementptr inbounds i8, i8* %5, i64 16
  %39 = bitcast i8* %38 to double*
  store double %_rtB__Constant_el121, double* %39, align 1
  %40 = getelementptr inbounds i8, i8* %7, i64 96
  %41 = bitcast i8* %40 to double*
  %_rtB__Constant_el124 = load double, double* %41, align 1
  %42 = getelementptr inbounds i8, i8* %5, i64 24
  %43 = bitcast i8* %42 to double*
  store double %_rtB__Constant_el124, double* %43, align 1
  br label %false4

false4:                                           ; preds = %true1.false4_crit_edge, %true3
  %.pre-phi = phi double* [ %.phi.trans.insert, %true1.false4_crit_edge ], [ %31, %true3 ]
  %_rtX__Integrator_CSTATE_el127 = phi double [ %_rtX__Integrator_CSTATE_el127.pre, %true1.false4_crit_edge ], [ %_rtB__Constant_el, %true3 ]
  %44 = bitcast i8* %7 to double*
  store double %_rtX__Integrator_CSTATE_el127, double* %44, align 1
  %45 = getelementptr inbounds i8, i8* %5, i64 8
  %46 = bitcast i8* %45 to double*
  %_rtX__Integrator_CSTATE_el130 = load double, double* %46, align 1
  %47 = getelementptr inbounds i8, i8* %7, i64 8
  %48 = bitcast i8* %47 to double*
  store double %_rtX__Integrator_CSTATE_el130, double* %48, align 1
  %49 = getelementptr inbounds i8, i8* %5, i64 16
  %50 = bitcast i8* %49 to double*
  %_rtX__Integrator_CSTATE_el133 = load double, double* %50, align 1
  %51 = getelementptr inbounds i8, i8* %7, i64 16
  %52 = bitcast i8* %51 to double*
  store double %_rtX__Integrator_CSTATE_el133, double* %52, align 1
  %53 = getelementptr inbounds i8, i8* %5, i64 24
  %54 = bitcast i8* %53 to double*
  %_rtX__Integrator_CSTATE_el136 = load double, double* %54, align 1
  %55 = getelementptr inbounds i8, i8* %7, i64 24
  %56 = bitcast i8* %55 to double*
  store double %_rtX__Integrator_CSTATE_el136, double* %56, align 1
  br label %merge

false5:                                           ; preds = %merge
  %57 = getelementptr inbounds i8, i8* %6, i64 416
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
  %.not446 = icmp eq i8 %64, 0
  br i1 %.not446, label %false6, label %true

false6:                                           ; preds = %false5
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 5, i32 104)
  %65 = call i8 @vm_getHasError(i8* %S)
  %66 = and i8 %65, 1
  %.not447 = icmp eq i8 %66, 0
  br i1 %.not447, label %false7, label %true

false7:                                           ; preds = %false6
  %67 = getelementptr inbounds i8, i8* %6, i64 424
  %68 = bitcast i8* %67 to double*
  %_rtP__Gain2_Gain_m = load double, double* %68, align 1
  %69 = getelementptr inbounds i8, i8* %7, i64 24
  %70 = bitcast i8* %69 to double*
  %_rtB__state_el149 = load double, double* %70, align 1
  %tmp1 = fmul double %_rtP__Gain2_Gain_m, %_rtB__state_el149
  %71 = getelementptr inbounds i8, i8* %7, i64 40
  %72 = bitcast i8* %71 to double*
  store double %tmp1, double* %72, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 7, i32 104)
  %73 = call i8 @vm_getHasError(i8* %S)
  %74 = and i8 %73, 1
  %.not448 = icmp eq i8 %74, 0
  br i1 %.not448, label %false8, label %true

false8:                                           ; preds = %false7
  %75 = bitcast i8* %7 to double*
  %_rtB__state_el154 = load double, double* %75, align 1
  %76 = bitcast i8* %8 to double*
  %_rtU__xw_ref = load double, double* %76, align 1
  %tmp2 = fsub double %_rtB__state_el154, %_rtU__xw_ref
  %_rtB__state_el157 = load double, double* %60, align 1
  %77 = getelementptr inbounds i8, i8* %7, i64 104
  %78 = bitcast i8* %77 to double*
  %_rtB__Constant1_el = load double, double* %78, align 1
  %tmp3 = fsub double %_rtB__state_el157, %_rtB__Constant1_el
  %79 = getelementptr inbounds i8, i8* %7, i64 16
  %80 = bitcast i8* %79 to double*
  %_rtB__state_el160 = load double, double* %80, align 1
  %81 = getelementptr inbounds i8, i8* %7, i64 112
  %82 = bitcast i8* %81 to double*
  %_rtB__Constant1_el162 = load double, double* %82, align 1
  %tmp4 = fsub double %_rtB__state_el160, %_rtB__Constant1_el162
  %_rtB__state_el164 = load double, double* %70, align 1
  %83 = getelementptr inbounds i8, i8* %7, i64 120
  %84 = bitcast i8* %83 to double*
  %_rtB__Constant1_el166 = load double, double* %84, align 1
  %tmp5 = fsub double %_rtB__state_el164, %_rtB__Constant1_el166
  %85 = getelementptr inbounds [5 x double], [5 x double]* %rtb_e_stanu_0_, i64 0, i64 0
  store double %tmp2, double* %85, align 8
  %86 = getelementptr inbounds [5 x double], [5 x double]* %rtb_e_stanu_0_, i64 0, i64 1
  store double %tmp3, double* %86, align 8
  %87 = getelementptr inbounds [5 x double], [5 x double]* %rtb_e_stanu_0_, i64 0, i64 2
  store double %tmp4, double* %87, align 8
  %88 = getelementptr inbounds [5 x double], [5 x double]* %rtb_e_stanu_0_, i64 0, i64 3
  store double %tmp5, double* %88, align 8
  %89 = getelementptr inbounds i8, i8* %5, i64 32
  %90 = bitcast i8* %89 to double*
  %_rtX__Integrator_CSTATE_d = load double, double* %90, align 1
  %91 = getelementptr inbounds [5 x double], [5 x double]* %rtb_e_stanu_0_, i64 0, i64 4
  store double %_rtX__Integrator_CSTATE_d, double* %91, align 8
  br label %merge77

true9:                                            ; preds = %merge77
  %92 = getelementptr inbounds i8, i8* %6, i64 440
  %93 = bitcast i8* %92 to [5 x double]*
  %94 = sext i32 %isHit_.0 to i64
  %95 = getelementptr inbounds [5 x double], [5 x double]* %93, i64 0, i64 %94
  %_rtP__stateFeedbackGain_Gain_el = load double, double* %95, align 1
  %96 = getelementptr inbounds [5 x double], [5 x double]* %rtb_e_stanu_0_, i64 0, i64 %94
  %rtb_e_stanu_0__el441 = load double, double* %96, align 8
  %tmp41 = fmul double %_rtP__stateFeedbackGain_Gain_el, %rtb_e_stanu_0__el441
  %tmp42 = fadd double %rtb_stateout_lin_idx_0_.0, %tmp41
  %tmp43 = add i32 %isHit_.0, 1
  br label %merge77

false10:                                          ; preds = %merge77
  %97 = getelementptr inbounds i8, i8* %7, i64 48
  %98 = bitcast i8* %97 to double*
  store double %rtb_stateout_lin_idx_0_.0, double* %98, align 1
  %99 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %100 = and i8 %99, 1
  %.not449 = icmp eq i8 %100, 0
  br i1 %.not449, label %false10.false12_crit_edge, label %true11

false10.false12_crit_edge:                        ; preds = %false10
  %.phi.trans.insert481 = getelementptr inbounds i8, i8* %3, i64 108
  %.phi.trans.insert482 = bitcast i8* %.phi.trans.insert481 to i32*
  %_rtDW__Saturation_MODE.pre = load i32, i32* %.phi.trans.insert482, align 1
  br label %false12

true11:                                           ; preds = %false10
  %_rtB__stateFeedbackGain = load double, double* %98, align 1
  %101 = getelementptr inbounds i8, i8* %6, i64 480
  %102 = bitcast i8* %101 to double*
  %_rtP__Saturation_UpperSat_i = load double, double* %102, align 1
  %103 = fcmp ult double %_rtB__stateFeedbackGain, %_rtP__Saturation_UpperSat_i
  br i1 %103, label %false14, label %true13

false12:                                          ; preds = %true13, %true15, %false16, %false10.false12_crit_edge
  %_rtDW__Saturation_MODE186 = phi i32 [ %_rtDW__Saturation_MODE.pre, %false10.false12_crit_edge ], [ 1, %true13 ], [ 0, %true15 ], [ -1, %false16 ]
  %104 = getelementptr inbounds i8, i8* %3, i64 108
  %105 = bitcast i8* %104 to i32*
  switch i32 %_rtDW__Saturation_MODE186, label %false20 [
    i32 1, label %true17
    i32 -1, label %true19
  ]

true13:                                           ; preds = %true11
  %106 = getelementptr inbounds i8, i8* %3, i64 108
  %107 = bitcast i8* %106 to i32*
  store i32 1, i32* %107, align 1
  br label %false12

false14:                                          ; preds = %true11
  %108 = getelementptr inbounds i8, i8* %6, i64 488
  %109 = bitcast i8* %108 to double*
  %_rtP__Saturation_LowerSat_g = load double, double* %109, align 1
  %110 = fcmp ogt double %_rtB__stateFeedbackGain, %_rtP__Saturation_LowerSat_g
  br i1 %110, label %true15, label %false16

true15:                                           ; preds = %false14
  %111 = getelementptr inbounds i8, i8* %3, i64 108
  %112 = bitcast i8* %111 to i32*
  store i32 0, i32* %112, align 1
  br label %false12

false16:                                          ; preds = %false14
  %113 = getelementptr inbounds i8, i8* %3, i64 108
  %114 = bitcast i8* %113 to i32*
  store i32 -1, i32* %114, align 1
  br label %false12

true17:                                           ; preds = %false12
  %115 = getelementptr inbounds i8, i8* %6, i64 480
  %116 = bitcast i8* %115 to double*
  %_rtP__Saturation_UpperSat_i194 = load double, double* %116, align 1
  %117 = getelementptr inbounds i8, i8* %7, i64 56
  %118 = bitcast i8* %117 to double*
  store double %_rtP__Saturation_UpperSat_i194, double* %118, align 1
  br label %merge81

true19:                                           ; preds = %false12
  %119 = getelementptr inbounds i8, i8* %6, i64 488
  %120 = bitcast i8* %119 to double*
  %_rtP__Saturation_LowerSat_g191 = load double, double* %120, align 1
  %121 = getelementptr inbounds i8, i8* %7, i64 56
  %122 = bitcast i8* %121 to double*
  store double %_rtP__Saturation_LowerSat_g191, double* %122, align 1
  br label %merge81

false20:                                          ; preds = %false12
  %_rtB__stateFeedbackGain188 = load double, double* %98, align 1
  %123 = getelementptr inbounds i8, i8* %7, i64 56
  %124 = bitcast i8* %123 to double*
  store double %_rtB__stateFeedbackGain188, double* %124, align 1
  br label %merge81

false21:                                          ; preds = %merge81
  %.not451 = icmp eq i32 %2, 0
  br i1 %.not451, label %false23, label %true22

true22:                                           ; preds = %false21
  %125 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %126 = and i8 %125, 1
  %.not476 = icmp eq i8 %126, 0
  br i1 %.not476, label %false23, label %true24

false23:                                          ; preds = %false32, %true25, %true29, %false28, %true22, %false21
  %127 = getelementptr inbounds i8, i8* %3, i64 117
  %_rtDW__Subsystem_MODE229 = load i8, i8* %127, align 1
  %128 = and i8 %_rtDW__Subsystem_MODE229, 1
  %.not452 = icmp eq i8 %128, 0
  br i1 %.not452, label %false34, label %true33

true24:                                           ; preds = %true22
  %129 = getelementptr inbounds i8, i8* %7, i64 128
  %130 = bitcast i8* %129 to double*
  %_rtB__Constant2 = load double, double* %130, align 1
  %131 = fcmp ogt double %_rtB__Constant2, 0.000000e+00
  br i1 %131, label %true25, label %false26

true25:                                           ; preds = %true24
  %132 = getelementptr inbounds i8, i8* %3, i64 117
  %_rtDW__Subsystem_MODE218 = load i8, i8* %132, align 1
  %133 = and i8 %_rtDW__Subsystem_MODE218, 1
  %.not478 = icmp eq i8 %133, 0
  br i1 %.not478, label %true30, label %false23

false26:                                          ; preds = %true24
  %134 = fcmp oeq double %1, %0
  br i1 %134, label %true27, label %false28

true27:                                           ; preds = %false26
  %135 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 1, i8* %135, align 1
  %136 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 1, i8* %136, align 1
  %137 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 1, i8* %137, align 1
  %138 = getelementptr inbounds i8, i8* %4, i64 8
  store i8 1, i8* %138, align 1
  %139 = getelementptr inbounds i8, i8* %4, i64 9
  store i8 1, i8* %139, align 1
  br label %false28

false28:                                          ; preds = %true27, %false26
  %140 = getelementptr inbounds i8, i8* %3, i64 117
  %_rtDW__Subsystem_MODE = load i8, i8* %140, align 1
  %141 = and i8 %_rtDW__Subsystem_MODE, 1
  %.not477 = icmp eq i8 %141, 0
  br i1 %.not477, label %false23, label %true29

true29:                                           ; preds = %false28
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(i8* %S)
  %142 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 1, i8* %142, align 1
  %143 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 1, i8* %143, align 1
  %144 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 1, i8* %144, align 1
  %145 = getelementptr inbounds i8, i8* %4, i64 8
  store i8 1, i8* %145, align 1
  %146 = getelementptr inbounds i8, i8* %4, i64 9
  store i8 1, i8* %146, align 1
  store i8 0, i8* %140, align 1
  br label %false23

true30:                                           ; preds = %true25
  %147 = fcmp une double %1, %0
  br i1 %147, label %true31, label %false32

true31:                                           ; preds = %true30
  call void @vm_ssSetBlockStateForSolverChangedAtMajorStep(i8* %S)
  br label %false32

false32:                                          ; preds = %true31, %true30
  %148 = getelementptr inbounds i8, i8* %4, i64 5
  store i8 0, i8* %148, align 1
  %149 = getelementptr inbounds i8, i8* %4, i64 6
  store i8 0, i8* %149, align 1
  %150 = getelementptr inbounds i8, i8* %4, i64 7
  store i8 0, i8* %150, align 1
  %151 = getelementptr inbounds i8, i8* %4, i64 8
  store i8 0, i8* %151, align 1
  %152 = getelementptr inbounds i8, i8* %4, i64 9
  store i8 0, i8* %152, align 1
  store i8 1, i8* %132, align 1
  br label %false23

true33:                                           ; preds = %false23
  %153 = getelementptr inbounds i8, i8* %7, i64 136
  %154 = bitcast i8* %153 to double*
  store double 0.000000e+00, double* %154, align 1
  %155 = getelementptr inbounds i8, i8* %7, i64 144
  %156 = bitcast i8* %155 to double*
  store double 0.000000e+00, double* %156, align 1
  %157 = getelementptr inbounds i8, i8* %7, i64 152
  %158 = bitcast i8* %157 to double*
  store double 0.000000e+00, double* %158, align 1
  %159 = getelementptr inbounds i8, i8* %7, i64 160
  %160 = bitcast i8* %159 to double*
  store double 0.000000e+00, double* %160, align 1
  %161 = getelementptr inbounds i8, i8* %6, i64 676
  %162 = bitcast i8* %161 to i32*
  %_rtP__IPlinearmodel_C_jc_el = load i32, i32* %162, align 1
  br label %merge82

false34:                                          ; preds = %true56, %false55, %false23
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 15, i32 104)
  %163 = call i8 @vm_getHasError(i8* %S)
  %164 = and i8 %163, 1
  %.not453 = icmp eq i8 %164, 0
  br i1 %.not453, label %false57, label %true

true35:                                           ; preds = %merge82
  %165 = getelementptr inbounds i8, i8* %6, i64 240
  %166 = bitcast i8* %165 to [4 x double]*
  %167 = sext i32 %ri_.0 to i64
  %168 = getelementptr inbounds [4 x double], [4 x double]* %166, i64 0, i64 %167
  %_rtP__IPlinearmodel_C_pr_el425 = load double, double* %168, align 1
  %169 = getelementptr inbounds i8, i8* %5, i64 40
  %170 = bitcast i8* %169 to double*
  %_rtX__IPlinearmodel_CSTATE_el427 = load double, double* %170, align 1
  %tmp38 = fmul double %_rtP__IPlinearmodel_C_pr_el425, %_rtX__IPlinearmodel_CSTATE_el427
  %171 = bitcast i8* %153 to [4 x double]*
  %172 = getelementptr inbounds i8, i8* %6, i64 660
  %173 = bitcast i8* %172 to [4 x i32]*
  %174 = getelementptr inbounds [4 x i32], [4 x i32]* %173, i64 0, i64 %167
  %_rtP__IPlinearmodel_C_ir_el431 = load i32, i32* %174, align 1
  %175 = sext i32 %_rtP__IPlinearmodel_C_ir_el431 to i64
  %176 = getelementptr inbounds [4 x double], [4 x double]* %171, i64 0, i64 %175
  %_rtB__IPlinearmodel_el432 = load double, double* %176, align 1
  %tmp39 = fadd double %tmp38, %_rtB__IPlinearmodel_el432
  store double %tmp39, double* %176, align 1
  %tmp40 = add i32 %ri_.0, 1
  br label %merge82

true37:                                           ; preds = %merge83
  %177 = getelementptr inbounds i8, i8* %6, i64 240
  %178 = bitcast i8* %177 to [4 x double]*
  %179 = sext i32 %ri_.1 to i64
  %180 = getelementptr inbounds [4 x double], [4 x double]* %178, i64 0, i64 %179
  %_rtP__IPlinearmodel_C_pr_el410 = load double, double* %180, align 1
  %181 = getelementptr inbounds i8, i8* %5, i64 48
  %182 = bitcast i8* %181 to double*
  %_rtX__IPlinearmodel_CSTATE_el412 = load double, double* %182, align 1
  %tmp35 = fmul double %_rtP__IPlinearmodel_C_pr_el410, %_rtX__IPlinearmodel_CSTATE_el412
  %183 = bitcast i8* %153 to [4 x double]*
  %184 = getelementptr inbounds i8, i8* %6, i64 660
  %185 = bitcast i8* %184 to [4 x i32]*
  %186 = getelementptr inbounds [4 x i32], [4 x i32]* %185, i64 0, i64 %179
  %_rtP__IPlinearmodel_C_ir_el416 = load i32, i32* %186, align 1
  %187 = sext i32 %_rtP__IPlinearmodel_C_ir_el416 to i64
  %188 = getelementptr inbounds [4 x double], [4 x double]* %183, i64 0, i64 %187
  %_rtB__IPlinearmodel_el417 = load double, double* %188, align 1
  %tmp36 = fadd double %tmp35, %_rtB__IPlinearmodel_el417
  store double %tmp36, double* %188, align 1
  %tmp37 = add i32 %ri_.1, 1
  br label %merge83

true39:                                           ; preds = %merge84
  %189 = getelementptr inbounds i8, i8* %6, i64 240
  %190 = bitcast i8* %189 to [4 x double]*
  %191 = sext i32 %ri_.2 to i64
  %192 = getelementptr inbounds [4 x double], [4 x double]* %190, i64 0, i64 %191
  %_rtP__IPlinearmodel_C_pr_el395 = load double, double* %192, align 1
  %193 = getelementptr inbounds i8, i8* %5, i64 56
  %194 = bitcast i8* %193 to double*
  %_rtX__IPlinearmodel_CSTATE_el397 = load double, double* %194, align 1
  %tmp32 = fmul double %_rtP__IPlinearmodel_C_pr_el395, %_rtX__IPlinearmodel_CSTATE_el397
  %195 = bitcast i8* %153 to [4 x double]*
  %196 = getelementptr inbounds i8, i8* %6, i64 660
  %197 = bitcast i8* %196 to [4 x i32]*
  %198 = getelementptr inbounds [4 x i32], [4 x i32]* %197, i64 0, i64 %191
  %_rtP__IPlinearmodel_C_ir_el401 = load i32, i32* %198, align 1
  %199 = sext i32 %_rtP__IPlinearmodel_C_ir_el401 to i64
  %200 = getelementptr inbounds [4 x double], [4 x double]* %195, i64 0, i64 %199
  %_rtB__IPlinearmodel_el402 = load double, double* %200, align 1
  %tmp33 = fadd double %tmp32, %_rtB__IPlinearmodel_el402
  store double %tmp33, double* %200, align 1
  %tmp34 = add i32 %ri_.2, 1
  br label %merge84

true41:                                           ; preds = %merge85
  %201 = getelementptr inbounds i8, i8* %6, i64 240
  %202 = bitcast i8* %201 to [4 x double]*
  %203 = sext i32 %ri_.3 to i64
  %204 = getelementptr inbounds [4 x double], [4 x double]* %202, i64 0, i64 %203
  %_rtP__IPlinearmodel_C_pr_el = load double, double* %204, align 1
  %205 = getelementptr inbounds i8, i8* %5, i64 64
  %206 = bitcast i8* %205 to double*
  %_rtX__IPlinearmodel_CSTATE_el = load double, double* %206, align 1
  %tmp29 = fmul double %_rtP__IPlinearmodel_C_pr_el, %_rtX__IPlinearmodel_CSTATE_el
  %207 = bitcast i8* %153 to [4 x double]*
  %208 = getelementptr inbounds i8, i8* %6, i64 660
  %209 = bitcast i8* %208 to [4 x i32]*
  %210 = getelementptr inbounds [4 x i32], [4 x i32]* %209, i64 0, i64 %203
  %_rtP__IPlinearmodel_C_ir_el = load i32, i32* %210, align 1
  %211 = sext i32 %_rtP__IPlinearmodel_C_ir_el to i64
  %212 = getelementptr inbounds [4 x double], [4 x double]* %207, i64 0, i64 %211
  %_rtB__IPlinearmodel_el387 = load double, double* %212, align 1
  %tmp30 = fadd double %tmp29, %_rtB__IPlinearmodel_el387
  store double %tmp30, double* %212, align 1
  %tmp31 = add i32 %ri_.3, 1
  br label %merge85

false42:                                          ; preds = %merge85
  %_rtU__xw_ref254 = load double, double* %76, align 1
  %_rtB__IPlinearmodel_el = load double, double* %154, align 1
  %tmp6 = fsub double %_rtU__xw_ref254, %_rtB__IPlinearmodel_el
  %_rtB__Constant1_el257 = load double, double* %78, align 1
  %_rtB__IPlinearmodel_el259 = load double, double* %156, align 1
  %tmp7 = fsub double %_rtB__Constant1_el257, %_rtB__IPlinearmodel_el259
  %_rtB__Constant1_el261 = load double, double* %82, align 1
  %_rtB__IPlinearmodel_el263 = load double, double* %158, align 1
  %tmp8 = fsub double %_rtB__Constant1_el261, %_rtB__IPlinearmodel_el263
  %_rtB__Constant1_el265 = load double, double* %84, align 1
  %_rtB__IPlinearmodel_el267 = load double, double* %160, align 1
  %tmp9 = fsub double %_rtB__Constant1_el265, %_rtB__IPlinearmodel_el267
  store double %tmp6, double* %85, align 8
  store double %tmp7, double* %86, align 8
  store double %tmp8, double* %87, align 8
  store double %tmp9, double* %88, align 8
  %213 = getelementptr inbounds i8, i8* %6, i64 304
  %214 = bitcast i8* %213 to double*
  %_rtP__E_Gain_el = load double, double* %214, align 1
  %tmp10 = fmul double %tmp6, %_rtP__E_Gain_el
  %215 = getelementptr inbounds i8, i8* %6, i64 312
  %216 = bitcast i8* %215 to double*
  %_rtP__E_Gain_el275 = load double, double* %216, align 1
  %tmp11 = fmul double %tmp7, %_rtP__E_Gain_el275
  %tmp12 = fadd double %tmp10, %tmp11
  %217 = getelementptr inbounds i8, i8* %6, i64 320
  %218 = bitcast i8* %217 to double*
  %_rtP__E_Gain_el278 = load double, double* %218, align 1
  %tmp13 = fmul double %tmp8, %_rtP__E_Gain_el278
  %tmp14 = fadd double %tmp12, %tmp13
  %219 = getelementptr inbounds i8, i8* %6, i64 328
  %220 = bitcast i8* %219 to double*
  %_rtP__E_Gain_el281 = load double, double* %220, align 1
  %tmp15 = fmul double %tmp9, %_rtP__E_Gain_el281
  %tmp16 = fadd double %tmp14, %tmp15
  %221 = getelementptr inbounds i8, i8* %7, i64 168
  %222 = bitcast i8* %221 to double*
  store double %tmp16, double* %222, align 1
  %223 = getelementptr inbounds i8, i8* %5, i64 72
  %224 = bitcast i8* %223 to double*
  %_rtX__Integrator_CSTATE_a = load double, double* %224, align 1
  store double %_rtX__Integrator_CSTATE_a, double* %91, align 8
  br label %merge86

true43:                                           ; preds = %merge86
  %225 = getelementptr inbounds i8, i8* %6, i64 344
  %226 = bitcast i8* %225 to [5 x double]*
  %227 = sext i32 %isHit_.1 to i64
  %228 = getelementptr inbounds [5 x double], [5 x double]* %226, i64 0, i64 %227
  %_rtP__Gain_Gain_el = load double, double* %228, align 1
  %229 = getelementptr inbounds [5 x double], [5 x double]* %rtb_e_stanu_0_, i64 0, i64 %227
  %rtb_e_stanu_0__el = load double, double* %229, align 8
  %tmp26 = fmul double %_rtP__Gain_Gain_el, %rtb_e_stanu_0__el
  %tmp27 = fadd double %rtb_stateout_lin_idx_0_.1, %tmp26
  %tmp28 = add i32 %isHit_.1, 1
  br label %merge86

false44:                                          ; preds = %merge86
  %230 = getelementptr inbounds i8, i8* %7, i64 176
  %231 = bitcast i8* %230 to double*
  store double %rtb_stateout_lin_idx_0_.1, double* %231, align 1
  %232 = getelementptr inbounds i8, i8* %7, i64 184
  %233 = bitcast i8* %232 to double*
  store double %_rtB__IPlinearmodel_el263, double* %233, align 1
  %234 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %235 = and i8 %234, 1
  %.not473 = icmp eq i8 %235, 0
  br i1 %.not473, label %false44.false46_crit_edge, label %true45

false44.false46_crit_edge:                        ; preds = %false44
  %.phi.trans.insert486 = getelementptr inbounds i8, i8* %3, i64 112
  %.phi.trans.insert487 = bitcast i8* %.phi.trans.insert486 to i32*
  %_rtDW__Saturation_MODE_d.pre = load i32, i32* %.phi.trans.insert487, align 1
  br label %false46

true45:                                           ; preds = %false44
  %_rtB__Gain = load double, double* %231, align 1
  %236 = getelementptr inbounds i8, i8* %6, i64 384
  %237 = bitcast i8* %236 to double*
  %_rtP__Saturation_UpperSat = load double, double* %237, align 1
  %238 = fcmp ult double %_rtB__Gain, %_rtP__Saturation_UpperSat
  br i1 %238, label %false48, label %true47

false46:                                          ; preds = %true47, %true49, %false50, %false44.false46_crit_edge
  %_rtDW__Saturation_MODE_d302 = phi i32 [ %_rtDW__Saturation_MODE_d.pre, %false44.false46_crit_edge ], [ 1, %true47 ], [ 0, %true49 ], [ -1, %false50 ]
  %239 = getelementptr inbounds i8, i8* %3, i64 112
  %240 = bitcast i8* %239 to i32*
  switch i32 %_rtDW__Saturation_MODE_d302, label %false54 [
    i32 1, label %true51
    i32 -1, label %true53
  ]

true47:                                           ; preds = %true45
  %241 = getelementptr inbounds i8, i8* %3, i64 112
  %242 = bitcast i8* %241 to i32*
  store i32 1, i32* %242, align 1
  br label %false46

false48:                                          ; preds = %true45
  %243 = getelementptr inbounds i8, i8* %6, i64 392
  %244 = bitcast i8* %243 to double*
  %_rtP__Saturation_LowerSat = load double, double* %244, align 1
  %245 = fcmp ogt double %_rtB__Gain, %_rtP__Saturation_LowerSat
  br i1 %245, label %true49, label %false50

true49:                                           ; preds = %false48
  %246 = getelementptr inbounds i8, i8* %3, i64 112
  %247 = bitcast i8* %246 to i32*
  store i32 0, i32* %247, align 1
  br label %false46

false50:                                          ; preds = %false48
  %248 = getelementptr inbounds i8, i8* %3, i64 112
  %249 = bitcast i8* %248 to i32*
  store i32 -1, i32* %249, align 1
  br label %false46

true51:                                           ; preds = %false46
  %250 = getelementptr inbounds i8, i8* %6, i64 384
  %251 = bitcast i8* %250 to double*
  %_rtP__Saturation_UpperSat310 = load double, double* %251, align 1
  %252 = getelementptr inbounds i8, i8* %7, i64 192
  %253 = bitcast i8* %252 to double*
  store double %_rtP__Saturation_UpperSat310, double* %253, align 1
  br label %merge90

true53:                                           ; preds = %false46
  %254 = getelementptr inbounds i8, i8* %6, i64 392
  %255 = bitcast i8* %254 to double*
  %_rtP__Saturation_LowerSat307 = load double, double* %255, align 1
  %256 = getelementptr inbounds i8, i8* %7, i64 192
  %257 = bitcast i8* %256 to double*
  store double %_rtP__Saturation_LowerSat307, double* %257, align 1
  br label %merge90

false54:                                          ; preds = %false46
  %_rtB__Gain304 = load double, double* %231, align 1
  %258 = getelementptr inbounds i8, i8* %7, i64 192
  %259 = bitcast i8* %258 to double*
  store double %_rtB__Gain304, double* %259, align 1
  br label %merge90

false55:                                          ; preds = %merge90
  %260 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %261 = and i8 %260, 1
  %.not475 = icmp eq i8 %261, 0
  br i1 %.not475, label %false34, label %true56

true56:                                           ; preds = %false55
  %262 = getelementptr inbounds i8, i8* %3, i64 116
  call void @vm_srUpdateBC(i8* nonnull %262)
  br label %false34

false57:                                          ; preds = %false34
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 16, i32 104)
  %263 = call i8 @vm_getHasError(i8* %S)
  %264 = and i8 %263, 1
  %.not454 = icmp eq i8 %264, 0
  br i1 %.not454, label %false58, label %true

false58:                                          ; preds = %false57
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 17, i32 104)
  %265 = call i8 @vm_getHasError(i8* %S)
  %266 = and i8 %265, 1
  %.not455 = icmp eq i8 %266, 0
  br i1 %.not455, label %false59, label %true

false59:                                          ; preds = %false58
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 18, i32 104)
  %267 = call i8 @vm_getHasError(i8* %S)
  %268 = and i8 %267, 1
  %.not456 = icmp eq i8 %268, 0
  br i1 %.not456, label %false60, label %true

false60:                                          ; preds = %false59
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 19, i32 104)
  %269 = call i8 @vm_getHasError(i8* %S)
  %270 = and i8 %269, 1
  %.not457 = icmp eq i8 %270, 0
  br i1 %.not457, label %false61, label %true

false61:                                          ; preds = %false60
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 20, i32 104)
  %271 = call i8 @vm_getHasError(i8* %S)
  %272 = and i8 %271, 1
  %.not458 = icmp eq i8 %272, 0
  br i1 %.not458, label %false62, label %true

false62:                                          ; preds = %false61
  br i1 %.not451, label %false64, label %true63

true63:                                           ; preds = %false62
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 21, i32 104)
  %273 = call i8 @vm_getHasError(i8* %S)
  %274 = and i8 %273, 1
  %.not461 = icmp eq i8 %274, 0
  br i1 %.not461, label %false65, label %true

false64:                                          ; preds = %false75, %false62
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 104)
  %275 = call i8 @vm_getHasError(i8* %S)
  %276 = and i8 %275, 1
  %.not460 = icmp eq i8 %276, 0
  br i1 %.not460, label %false76, label %true

false65:                                          ; preds = %true63
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 22, i32 104)
  %277 = call i8 @vm_getHasError(i8* %S)
  %278 = and i8 %277, 1
  %.not462 = icmp eq i8 %278, 0
  br i1 %.not462, label %false66, label %true

false66:                                          ; preds = %false65
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 23, i32 104)
  %279 = call i8 @vm_getHasError(i8* %S)
  %280 = and i8 %279, 1
  %.not463 = icmp eq i8 %280, 0
  br i1 %.not463, label %false67, label %true

false67:                                          ; preds = %false66
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 24, i32 104)
  %281 = call i8 @vm_getHasError(i8* %S)
  %282 = and i8 %281, 1
  %.not464 = icmp eq i8 %282, 0
  br i1 %.not464, label %false68, label %true

false68:                                          ; preds = %false67
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 25, i32 104)
  %283 = call i8 @vm_getHasError(i8* %S)
  %284 = and i8 %283, 1
  %.not465 = icmp eq i8 %284, 0
  br i1 %.not465, label %false69, label %true

false69:                                          ; preds = %false68
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 26, i32 104)
  %285 = call i8 @vm_getHasError(i8* %S)
  %286 = and i8 %285, 1
  %.not466 = icmp eq i8 %286, 0
  br i1 %.not466, label %false70, label %true

false70:                                          ; preds = %false69
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 27, i32 104)
  %287 = call i8 @vm_getHasError(i8* %S)
  %288 = and i8 %287, 1
  %.not467 = icmp eq i8 %288, 0
  br i1 %.not467, label %false71, label %true

false71:                                          ; preds = %false70
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 28, i32 104)
  %289 = call i8 @vm_getHasError(i8* %S)
  %290 = and i8 %289, 1
  %.not468 = icmp eq i8 %290, 0
  br i1 %.not468, label %false72, label %true

false72:                                          ; preds = %false71
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 29, i32 104)
  %291 = call i8 @vm_getHasError(i8* %S)
  %292 = and i8 %291, 1
  %.not469 = icmp eq i8 %292, 0
  br i1 %.not469, label %false73, label %true

false73:                                          ; preds = %false72
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 30, i32 104)
  %293 = call i8 @vm_getHasError(i8* %S)
  %294 = and i8 %293, 1
  %.not470 = icmp eq i8 %294, 0
  br i1 %.not470, label %false74, label %true

false74:                                          ; preds = %false73
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 31, i32 104)
  %295 = call i8 @vm_getHasError(i8* %S)
  %296 = and i8 %295, 1
  %.not471 = icmp eq i8 %296, 0
  br i1 %.not471, label %false75, label %true

false75:                                          ; preds = %false74
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 32, i32 104)
  %297 = call i8 @vm_getHasError(i8* %S)
  %298 = and i8 %297, 1
  %.not472 = icmp eq i8 %298, 0
  br i1 %.not472, label %false64, label %true

false76:                                          ; preds = %false64
  %299 = getelementptr inbounds i8, i8* %6, i64 496
  %300 = bitcast i8* %299 to double*
  %_rtP__E_Gain_c_el = load double, double* %300, align 1
  %tmp19 = fmul double %tmp2, %_rtP__E_Gain_c_el
  %301 = getelementptr inbounds i8, i8* %6, i64 504
  %302 = bitcast i8* %301 to double*
  %_rtP__E_Gain_c_el367 = load double, double* %302, align 1
  %tmp20 = fmul double %tmp3, %_rtP__E_Gain_c_el367
  %tmp21 = fadd double %tmp19, %tmp20
  %303 = getelementptr inbounds i8, i8* %6, i64 512
  %304 = bitcast i8* %303 to double*
  %_rtP__E_Gain_c_el370 = load double, double* %304, align 1
  %tmp22 = fmul double %tmp4, %_rtP__E_Gain_c_el370
  %tmp23 = fadd double %tmp21, %tmp22
  %305 = getelementptr inbounds i8, i8* %6, i64 520
  %306 = bitcast i8* %305 to double*
  %_rtP__E_Gain_c_el373 = load double, double* %306, align 1
  %tmp24 = fmul double %tmp5, %_rtP__E_Gain_c_el373
  %tmp25 = fadd double %tmp23, %tmp24
  %307 = getelementptr inbounds i8, i8* %7, i64 64
  %308 = bitcast i8* %307 to double*
  store double %tmp25, double* %308, align 1
  br label %true

merge:                                            ; preds = %false4, %false2
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 2, i32 104)
  %309 = call i8 @vm_getHasError(i8* %S)
  %310 = and i8 %309, 1
  %.not445 = icmp eq i8 %310, 0
  br i1 %.not445, label %false5, label %true

merge77:                                          ; preds = %true9, %false8
  %rtb_stateout_lin_idx_0_.0 = phi double [ 0.000000e+00, %false8 ], [ %tmp42, %true9 ]
  %isHit_.0 = phi i32 [ 0, %false8 ], [ %tmp43, %true9 ]
  %311 = icmp slt i32 %isHit_.0, 5
  br i1 %311, label %true9, label %false10

merge81:                                          ; preds = %false20, %true19, %true17
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 2, i32 13, i32 104)
  %312 = call i8 @vm_getHasError(i8* %S)
  %313 = and i8 %312, 1
  %.not450 = icmp eq i8 %313, 0
  br i1 %.not450, label %false21, label %true

merge82:                                          ; preds = %true35, %true33
  %ri_.0 = phi i32 [ %_rtP__IPlinearmodel_C_jc_el, %true33 ], [ %tmp40, %true35 ]
  %314 = getelementptr inbounds i8, i8* %6, i64 680
  %315 = bitcast i8* %314 to i32*
  %_rtP__IPlinearmodel_C_jc_el237 = load i32, i32* %315, align 1
  %316 = icmp ult i32 %ri_.0, %_rtP__IPlinearmodel_C_jc_el237
  br i1 %316, label %true35, label %merge83

merge83:                                          ; preds = %merge82, %true37
  %ri_.1 = phi i32 [ %tmp37, %true37 ], [ %_rtP__IPlinearmodel_C_jc_el237, %merge82 ]
  %317 = getelementptr inbounds i8, i8* %6, i64 684
  %318 = bitcast i8* %317 to i32*
  %_rtP__IPlinearmodel_C_jc_el242 = load i32, i32* %318, align 1
  %319 = icmp ult i32 %ri_.1, %_rtP__IPlinearmodel_C_jc_el242
  br i1 %319, label %true37, label %merge84

merge84:                                          ; preds = %merge83, %true39
  %ri_.2 = phi i32 [ %tmp34, %true39 ], [ %_rtP__IPlinearmodel_C_jc_el242, %merge83 ]
  %320 = getelementptr inbounds i8, i8* %6, i64 688
  %321 = bitcast i8* %320 to i32*
  %_rtP__IPlinearmodel_C_jc_el247 = load i32, i32* %321, align 1
  %322 = icmp ult i32 %ri_.2, %_rtP__IPlinearmodel_C_jc_el247
  br i1 %322, label %true39, label %merge85

merge85:                                          ; preds = %merge84, %true41
  %ri_.3 = phi i32 [ %tmp31, %true41 ], [ %_rtP__IPlinearmodel_C_jc_el247, %merge84 ]
  %323 = getelementptr inbounds i8, i8* %6, i64 692
  %324 = bitcast i8* %323 to i32*
  %_rtP__IPlinearmodel_C_jc_el252 = load i32, i32* %324, align 1
  %325 = icmp ult i32 %ri_.3, %_rtP__IPlinearmodel_C_jc_el252
  br i1 %325, label %true41, label %false42

merge86:                                          ; preds = %true43, %false42
  %rtb_stateout_lin_idx_0_.1 = phi double [ 0.000000e+00, %false42 ], [ %tmp27, %true43 ]
  %isHit_.1 = phi i32 [ 0, %false42 ], [ %tmp28, %true43 ]
  %326 = icmp slt i32 %isHit_.1, 5
  br i1 %326, label %true43, label %false44

merge90:                                          ; preds = %false54, %true53, %true51
  %327 = getelementptr inbounds i8, i8* %6, i64 400
  %328 = bitcast i8* %327 to double*
  %_rtP__Gain1_Gain = load double, double* %328, align 1
  %_rtB__IPlinearmodel_el314 = load double, double* %156, align 1
  %tmp17 = fmul double %_rtP__Gain1_Gain, %_rtB__IPlinearmodel_el314
  %329 = getelementptr inbounds i8, i8* %7, i64 200
  %330 = bitcast i8* %329 to double*
  store double %tmp17, double* %330, align 1
  %331 = getelementptr inbounds i8, i8* %6, i64 408
  %332 = bitcast i8* %331 to double*
  %_rtP__Gain2_Gain = load double, double* %332, align 1
  %_rtB__IPlinearmodel_el318 = load double, double* %160, align 1
  %tmp18 = fmul double %_rtP__Gain2_Gain, %_rtB__IPlinearmodel_el318
  %333 = getelementptr inbounds i8, i8* %7, i64 208
  %334 = bitcast i8* %333 to double*
  store double %tmp18, double* %334, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 10, i32 104)
  %335 = call i8 @vm_getHasError(i8* %S)
  %336 = and i8 %335, 1
  %.not474 = icmp eq i8 %336, 0
  br i1 %.not474, label %false55, label %true
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
  %6 = getelementptr inbounds i8, i8* %3, i64 528
  %7 = bitcast i8* %6 to double*
  %_rtP__Constant_Value_el = load double, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 72
  %9 = bitcast i8* %8 to double*
  store double %_rtP__Constant_Value_el, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 536
  %11 = bitcast i8* %10 to double*
  %_rtP__Constant_Value_el11 = load double, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 80
  %13 = bitcast i8* %12 to double*
  store double %_rtP__Constant_Value_el11, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 544
  %15 = bitcast i8* %14 to double*
  %_rtP__Constant_Value_el14 = load double, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 88
  %17 = bitcast i8* %16 to double*
  store double %_rtP__Constant_Value_el14, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %3, i64 552
  %19 = bitcast i8* %18 to double*
  %_rtP__Constant_Value_el17 = load double, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %4, i64 96
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
  %31 = getelementptr inbounds i8, i8* %3, i64 432
  %32 = bitcast i8* %31 to double*
  %_rtP__Integrator_IC_b = load double, double* %32, align 1
  %33 = getelementptr inbounds i8, i8* %2, i64 32
  %34 = bitcast i8* %33 to double*
  store double %_rtP__Integrator_IC_b, double* %34, align 1
  %35 = getelementptr inbounds i8, i8* %3, i64 272
  %36 = bitcast i8* %35 to double*
  %_rtP__IPlinearmodel_InitialCondition_el = load double, double* %36, align 1
  %37 = getelementptr inbounds i8, i8* %2, i64 40
  %38 = bitcast i8* %37 to double*
  store double %_rtP__IPlinearmodel_InitialCondition_el, double* %38, align 1
  %39 = getelementptr inbounds i8, i8* %3, i64 280
  %40 = bitcast i8* %39 to double*
  %_rtP__IPlinearmodel_InitialCondition_el30 = load double, double* %40, align 1
  %41 = getelementptr inbounds i8, i8* %2, i64 48
  %42 = bitcast i8* %41 to double*
  store double %_rtP__IPlinearmodel_InitialCondition_el30, double* %42, align 1
  %43 = getelementptr inbounds i8, i8* %3, i64 288
  %44 = bitcast i8* %43 to double*
  %_rtP__IPlinearmodel_InitialCondition_el33 = load double, double* %44, align 1
  %45 = getelementptr inbounds i8, i8* %2, i64 56
  %46 = bitcast i8* %45 to double*
  store double %_rtP__IPlinearmodel_InitialCondition_el33, double* %46, align 1
  %47 = getelementptr inbounds i8, i8* %3, i64 296
  %48 = bitcast i8* %47 to double*
  %_rtP__IPlinearmodel_InitialCondition_el36 = load double, double* %48, align 1
  %49 = getelementptr inbounds i8, i8* %2, i64 64
  %50 = bitcast i8* %49 to double*
  store double %_rtP__IPlinearmodel_InitialCondition_el36, double* %50, align 1
  %51 = getelementptr inbounds i8, i8* %3, i64 336
  %52 = bitcast i8* %51 to double*
  %_rtP__Integrator_IC = load double, double* %52, align 1
  %53 = getelementptr inbounds i8, i8* %2, i64 72
  %54 = bitcast i8* %53 to double*
  store double %_rtP__Integrator_IC, double* %54, align 1
  %55 = getelementptr inbounds i8, i8* %3, i64 120
  %56 = bitcast i8* %55 to double*
  %_rtP__Output3_Y0 = load double, double* %56, align 1
  %57 = getelementptr inbounds i8, i8* %4, i64 136
  %58 = bitcast i8* %57 to double*
  store double %_rtP__Output3_Y0, double* %58, align 1
  %59 = getelementptr inbounds i8, i8* %3, i64 128
  %60 = bitcast i8* %59 to double*
  %_rtP__Output5_Y0 = load double, double* %60, align 1
  %61 = getelementptr inbounds i8, i8* %4, i64 200
  %62 = bitcast i8* %61 to double*
  store double %_rtP__Output5_Y0, double* %62, align 1
  %63 = getelementptr inbounds i8, i8* %3, i64 136
  %64 = bitcast i8* %63 to double*
  %_rtP__Output8_Y0 = load double, double* %64, align 1
  %65 = getelementptr inbounds i8, i8* %4, i64 184
  %66 = bitcast i8* %65 to double*
  store double %_rtP__Output8_Y0, double* %66, align 1
  %67 = getelementptr inbounds i8, i8* %3, i64 144
  %68 = bitcast i8* %67 to double*
  %_rtP__Output9_Y0 = load double, double* %68, align 1
  %69 = getelementptr inbounds i8, i8* %4, i64 208
  %70 = bitcast i8* %69 to double*
  store double %_rtP__Output9_Y0, double* %70, align 1
  %71 = getelementptr inbounds i8, i8* %3, i64 152
  %72 = bitcast i8* %71 to double*
  %_rtP__Output10_Y0 = load double, double* %72, align 1
  %73 = getelementptr inbounds i8, i8* %4, i64 192
  %74 = bitcast i8* %73 to double*
  store double %_rtP__Output10_Y0, double* %74, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 102)
  %75 = call i8 @vm_getHasError(i8* %S)
  ret void
}

declare zeroext i8 @vm_ssIsFirstInitCond(i8*)

