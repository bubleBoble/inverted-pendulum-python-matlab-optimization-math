; ModuleID = 'test'
source_filename = "test"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @model_lqr_gora_optym_CGInitializeSizes(i8* %S_0) {
model_lqr_gora_optym_CGInitializeSizes_entry:
  %tmp_ = alloca [4 x i32], align 4
  call void @model_lqr_gora_optym_Checksum([4 x i32]* nonnull %tmp_)
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
  call void @vm_blockIOSizeCheck(i8* %S_0, i32 152)
  call void @vm_dworkSizeCheck(i8* %S_0, i32 56)
  call void @vm_paramSizeCheck(i8* %S_0, i32 368)
  ret void
}

define void @model_lqr_gora_optym_Checksum([4 x i32]* %y) {
model_lqr_gora_optym_Checksum_entry:
  %0 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 0
  store i32 720351631, i32* %0, align 1
  %1 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 1
  store i32 -619515992, i32* %1, align 1
  %2 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 2
  store i32 -1775914792, i32* %2, align 1
  %3 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 3
  store i32 -538940565, i32* %3, align 1
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
  %0 = call i8* @vm_ssGetSolverZcSignalVector(i8* %S)
  %1 = call i8* @vm_ssGetModelRtp(i8* %S)
  %2 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %3 = getelementptr inbounds i8, i8* %2, i64 40
  %4 = bitcast i8* %3 to double*
  %_rtB__stateFeedbackGain = load double, double* %4, align 1
  %5 = getelementptr inbounds i8, i8* %1, i64 160
  %6 = bitcast i8* %5 to double*
  %_rtP__Saturation_UpperSat = load double, double* %6, align 1
  %tmp0 = fsub double %_rtB__stateFeedbackGain, %_rtP__Saturation_UpperSat
  %7 = bitcast i8* %0 to double*
  store double %tmp0, double* %7, align 1
  %_rtB__stateFeedbackGain8 = load double, double* %4, align 1
  %8 = getelementptr inbounds i8, i8* %1, i64 168
  %9 = bitcast i8* %8 to double*
  %_rtP__Saturation_LowerSat = load double, double* %9, align 1
  %tmp1 = fsub double %_rtB__stateFeedbackGain8, %_rtP__Saturation_LowerSat
  %10 = getelementptr inbounds i8, i8* %0, i64 8
  %11 = bitcast i8* %10 to double*
  store double %tmp1, double* %11, align 1
  ret void
}

declare i8* @vm_ssGetSolverZcSignalVector(i8*)

define void @ForcingFunction(i8* %S) {
ForcingFunction_entry:
  %0 = call i8* @vm_ssGetdX(i8* %S)
  %1 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %2 = getelementptr inbounds i8, i8* %1, i64 56
  %3 = bitcast i8* %2 to double*
  %_rtB__Sum = load double, double* %3, align 1
  %4 = bitcast i8* %0 to double*
  store double %_rtB__Sum, double* %4, align 1
  %5 = getelementptr inbounds i8, i8* %1, i64 120
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el = load double, double* %6, align 1
  %7 = getelementptr inbounds i8, i8* %0, i64 8
  %8 = bitcast i8* %7 to double*
  store double %_rtB__Dx_el, double* %8, align 1
  %9 = getelementptr inbounds i8, i8* %1, i64 128
  %10 = bitcast i8* %9 to double*
  %_rtB__Dx_el8 = load double, double* %10, align 1
  %11 = getelementptr inbounds i8, i8* %0, i64 16
  %12 = bitcast i8* %11 to double*
  store double %_rtB__Dx_el8, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %1, i64 136
  %14 = bitcast i8* %13 to double*
  %_rtB__Dx_el11 = load double, double* %14, align 1
  %15 = getelementptr inbounds i8, i8* %0, i64 24
  %16 = bitcast i8* %15 to double*
  store double %_rtB__Dx_el11, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %1, i64 144
  %18 = bitcast i8* %17 to double*
  %_rtB__Dx_el14 = load double, double* %18, align 1
  %19 = getelementptr inbounds i8, i8* %0, i64 32
  %20 = bitcast i8* %19 to double*
  store double %_rtB__Dx_el14, double* %20, align 1
  ret void
}

declare i8* @vm_ssGetdX(i8*)

define void @Derivatives(i8* %S) {
Derivatives_entry:
  %0 = call i8* @vm_ssGetdX(i8* %S)
  %1 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %2 = getelementptr inbounds i8, i8* %1, i64 56
  %3 = bitcast i8* %2 to double*
  %_rtB__Sum = load double, double* %3, align 1
  %4 = bitcast i8* %0 to double*
  store double %_rtB__Sum, double* %4, align 1
  %5 = getelementptr inbounds i8, i8* %1, i64 120
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el = load double, double* %6, align 1
  %7 = getelementptr inbounds i8, i8* %0, i64 8
  %8 = bitcast i8* %7 to double*
  store double %_rtB__Dx_el, double* %8, align 1
  %9 = getelementptr inbounds i8, i8* %1, i64 128
  %10 = bitcast i8* %9 to double*
  %_rtB__Dx_el8 = load double, double* %10, align 1
  %11 = getelementptr inbounds i8, i8* %0, i64 16
  %12 = bitcast i8* %11 to double*
  store double %_rtB__Dx_el8, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %1, i64 136
  %14 = bitcast i8* %13 to double*
  %_rtB__Dx_el11 = load double, double* %14, align 1
  %15 = getelementptr inbounds i8, i8* %0, i64 24
  %16 = bitcast i8* %15 to double*
  store double %_rtB__Dx_el11, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %1, i64 144
  %18 = bitcast i8* %17 to double*
  %_rtB__Dx_el14 = load double, double* %18, align 1
  %19 = getelementptr inbounds i8, i8* %0, i64 32
  %20 = bitcast i8* %19 to double*
  store double %_rtB__Dx_el14, double* %20, align 1
  ret void
}

define void @Update0(i8* %S) {
Update0_entry:
  %0 = call double @vm_ssGetT(i8* %S)
  %1 = call i8* @vm_ssGetRootDWork(i8* %S)
  %2 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %3 = getelementptr inbounds i8, i8* %1, i64 44
  %4 = bitcast i8* %3 to i32*
  store i32 0, i32* %4, align 1
  %5 = bitcast i8* %1 to double*
  %_rtDW__TimeStampA = load double, double* %5, align 1
  %6 = fcmp oeq double %_rtDW__TimeStampA, 0x7FF0000000000000
  br i1 %6, label %true, label %false

true:                                             ; preds = %Update0_entry
  store double %0, double* %5, align 1
  %7 = getelementptr inbounds i8, i8* %1, i64 8
  br label %merge6

false:                                            ; preds = %Update0_entry
  %8 = getelementptr inbounds i8, i8* %1, i64 16
  %9 = bitcast i8* %8 to double*
  %_rtDW__TimeStampB = load double, double* %9, align 1
  %10 = fcmp oeq double %_rtDW__TimeStampB, 0x7FF0000000000000
  br i1 %10, label %true1, label %false2

true1:                                            ; preds = %false
  store double %0, double* %9, align 1
  %11 = getelementptr inbounds i8, i8* %1, i64 24
  br label %merge6

false2:                                           ; preds = %false
  %12 = fcmp olt double %_rtDW__TimeStampA, %_rtDW__TimeStampB
  br i1 %12, label %true3, label %false4

true3:                                            ; preds = %false2
  store double %0, double* %5, align 1
  %13 = getelementptr inbounds i8, i8* %1, i64 8
  br label %merge6

false4:                                           ; preds = %false2
  store double %0, double* %9, align 1
  %14 = getelementptr inbounds i8, i8* %1, i64 24
  br label %merge6

merge6:                                           ; preds = %true1, %true3, %false4, %true
  %lastU_.2.in = phi i8* [ %7, %true ], [ %11, %true1 ], [ %13, %true3 ], [ %14, %false4 ]
  %lastU_.2 = bitcast i8* %lastU_.2.in to double*
  %15 = getelementptr inbounds i8, i8* %2, i64 48
  %16 = bitcast i8* %15 to double*
  %_rtB__Saturation = load double, double* %16, align 1
  store double %_rtB__Saturation, double* %lastU_.2, align 1
  ret void
}

declare double @vm_ssGetT(i8*)

declare i8* @vm_ssGetRootDWork(i8*)

define void @Outputs1(i8* %S, i32 signext %controlPortIdx) {
Outputs1_entry:
  %0 = call i8* @vm_ssGetModelRtp(i8* %S)
  %1 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %2 = getelementptr inbounds i8, i8* %0, i64 312
  %3 = bitcast i8* %2 to double*
  %_rtP__Constant_Value_el = load double, double* %3, align 1
  %4 = getelementptr inbounds i8, i8* %1, i64 64
  %5 = bitcast i8* %4 to double*
  store double %_rtP__Constant_Value_el, double* %5, align 1
  %6 = getelementptr inbounds i8, i8* %0, i64 320
  %7 = bitcast i8* %6 to double*
  %_rtP__Constant_Value_el6 = load double, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %1, i64 72
  %9 = bitcast i8* %8 to double*
  store double %_rtP__Constant_Value_el6, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %0, i64 328
  %11 = bitcast i8* %10 to double*
  %_rtP__Constant_Value_el9 = load double, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %1, i64 80
  %13 = bitcast i8* %12 to double*
  store double %_rtP__Constant_Value_el9, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %0, i64 336
  %15 = bitcast i8* %14 to double*
  %_rtP__Constant_Value_el12 = load double, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %1, i64 88
  %17 = bitcast i8* %16 to double*
  store double %_rtP__Constant_Value_el12, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %0, i64 344
  %19 = bitcast i8* %18 to double*
  %_rtP__Constant1_Value_el = load double, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %1, i64 96
  %21 = bitcast i8* %20 to double*
  store double %_rtP__Constant1_Value_el, double* %21, align 1
  %22 = getelementptr inbounds i8, i8* %0, i64 352
  %23 = bitcast i8* %22 to double*
  %_rtP__Constant1_Value_el17 = load double, double* %23, align 1
  %24 = getelementptr inbounds i8, i8* %1, i64 104
  %25 = bitcast i8* %24 to double*
  store double %_rtP__Constant1_Value_el17, double* %25, align 1
  %26 = getelementptr inbounds i8, i8* %0, i64 360
  %27 = bitcast i8* %26 to double*
  %_rtP__Constant1_Value_el20 = load double, double* %27, align 1
  %28 = getelementptr inbounds i8, i8* %1, i64 112
  %29 = bitcast i8* %28 to double*
  store double %_rtP__Constant1_Value_el20, double* %29, align 1
  ret void
}

define void @Outputs0(i8* %S) {
Outputs0_entry:
  %rtb_e_stanu_ = alloca [4 x double], align 8
  %0 = call double @vm_ssGetT(i8* %S)
  %1 = call i32 @vm_ssIsSampleHit(i8* %S, i32 1, i32 0)
  %2 = call i8* @vm_ssGetRootDWork(i8* %S)
  %3 = call i8* @vm_ssGetX(i8* %S)
  %4 = call i8* @vm_ssGetModelRtp(i8* %S)
  %5 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %6 = call i8* @vm_ssGetU(i8* %S)
  %7 = bitcast i8* %3 to double*
  %_rtX__Integrator1_CSTATE = load double, double* %7, align 1
  %8 = bitcast i8* %5 to double*
  store double %_rtX__Integrator1_CSTATE, double* %8, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 1, i32 104)
  %9 = call i8 @vm_getHasError(i8* %S)
  %10 = and i8 %9, 1
  %.not = icmp eq i8 %10, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %false26, %merge30, %true1, %Outputs0_entry
  ret void

false:                                            ; preds = %Outputs0_entry
  %.not186 = icmp eq i32 %1, 0
  br i1 %.not186, label %false2, label %true1

true1:                                            ; preds = %false
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 2, i32 104)
  %11 = call i8 @vm_getHasError(i8* %S)
  %12 = and i8 %11, 1
  %.not192 = icmp eq i8 %12, 0
  br i1 %.not192, label %false2, label %true

false2:                                           ; preds = %true1, %false
  %13 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %14 = and i8 %13, 1
  %.not187 = icmp eq i8 %14, 0
  br i1 %.not187, label %false4, label %true3

true3:                                            ; preds = %false2
  %15 = getelementptr inbounds i8, i8* %2, i64 44
  %16 = bitcast i8* %15 to i32*
  %_rtDW__Integrator_IWORK = load i32, i32* %16, align 1
  %.not191 = icmp eq i32 %_rtDW__Integrator_IWORK, 0
  br i1 %.not191, label %true3.false6_crit_edge, label %true5

true3.false6_crit_edge:                           ; preds = %true3
  %.phi.trans.insert = getelementptr inbounds i8, i8* %3, i64 8
  %.phi.trans.insert193 = bitcast i8* %.phi.trans.insert to double*
  %_rtX__Integrator_CSTATE_el73.pre = load double, double* %.phi.trans.insert193, align 1
  br label %false6

false4:                                           ; preds = %false2
  %17 = getelementptr inbounds i8, i8* %3, i64 8
  %18 = bitcast i8* %17 to double*
  %_rtX__Integrator_CSTATE_el = load double, double* %18, align 1
  %19 = getelementptr inbounds i8, i8* %5, i64 8
  %20 = bitcast i8* %19 to double*
  store double %_rtX__Integrator_CSTATE_el, double* %20, align 1
  %21 = getelementptr inbounds i8, i8* %3, i64 16
  %22 = bitcast i8* %21 to double*
  %_rtX__Integrator_CSTATE_el52 = load double, double* %22, align 1
  %23 = getelementptr inbounds i8, i8* %5, i64 16
  %24 = bitcast i8* %23 to double*
  store double %_rtX__Integrator_CSTATE_el52, double* %24, align 1
  %25 = getelementptr inbounds i8, i8* %3, i64 24
  %26 = bitcast i8* %25 to double*
  %_rtX__Integrator_CSTATE_el55 = load double, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %5, i64 24
  %28 = bitcast i8* %27 to double*
  store double %_rtX__Integrator_CSTATE_el55, double* %28, align 1
  %29 = getelementptr inbounds i8, i8* %3, i64 32
  %30 = bitcast i8* %29 to double*
  %_rtX__Integrator_CSTATE_el58 = load double, double* %30, align 1
  %31 = getelementptr inbounds i8, i8* %5, i64 32
  %32 = bitcast i8* %31 to double*
  store double %_rtX__Integrator_CSTATE_el58, double* %32, align 1
  br label %merge

true5:                                            ; preds = %true3
  %33 = getelementptr inbounds i8, i8* %5, i64 64
  %34 = bitcast i8* %33 to double*
  %_rtB__Constant_el = load double, double* %34, align 1
  %35 = getelementptr inbounds i8, i8* %3, i64 8
  %36 = bitcast i8* %35 to double*
  store double %_rtB__Constant_el, double* %36, align 1
  %37 = getelementptr inbounds i8, i8* %5, i64 72
  %38 = bitcast i8* %37 to double*
  %_rtB__Constant_el64 = load double, double* %38, align 1
  %39 = getelementptr inbounds i8, i8* %3, i64 16
  %40 = bitcast i8* %39 to double*
  store double %_rtB__Constant_el64, double* %40, align 1
  %41 = getelementptr inbounds i8, i8* %5, i64 80
  %42 = bitcast i8* %41 to double*
  %_rtB__Constant_el67 = load double, double* %42, align 1
  %43 = getelementptr inbounds i8, i8* %3, i64 24
  %44 = bitcast i8* %43 to double*
  store double %_rtB__Constant_el67, double* %44, align 1
  %45 = getelementptr inbounds i8, i8* %5, i64 88
  %46 = bitcast i8* %45 to double*
  %_rtB__Constant_el70 = load double, double* %46, align 1
  %47 = getelementptr inbounds i8, i8* %3, i64 32
  %48 = bitcast i8* %47 to double*
  store double %_rtB__Constant_el70, double* %48, align 1
  br label %false6

false6:                                           ; preds = %true3.false6_crit_edge, %true5
  %.pre-phi207 = phi double* [ %.phi.trans.insert193, %true3.false6_crit_edge ], [ %36, %true5 ]
  %_rtX__Integrator_CSTATE_el73 = phi double [ %_rtX__Integrator_CSTATE_el73.pre, %true3.false6_crit_edge ], [ %_rtB__Constant_el, %true5 ]
  %49 = getelementptr inbounds i8, i8* %3, i64 8
  %50 = getelementptr inbounds i8, i8* %5, i64 8
  %51 = bitcast i8* %50 to double*
  store double %_rtX__Integrator_CSTATE_el73, double* %51, align 1
  %52 = getelementptr inbounds i8, i8* %3, i64 16
  %53 = bitcast i8* %52 to double*
  %_rtX__Integrator_CSTATE_el76 = load double, double* %53, align 1
  %54 = getelementptr inbounds i8, i8* %5, i64 16
  %55 = bitcast i8* %54 to double*
  store double %_rtX__Integrator_CSTATE_el76, double* %55, align 1
  %56 = getelementptr inbounds i8, i8* %3, i64 24
  %57 = bitcast i8* %56 to double*
  %_rtX__Integrator_CSTATE_el79 = load double, double* %57, align 1
  %58 = getelementptr inbounds i8, i8* %5, i64 24
  %59 = bitcast i8* %58 to double*
  store double %_rtX__Integrator_CSTATE_el79, double* %59, align 1
  %60 = getelementptr inbounds i8, i8* %3, i64 32
  %61 = bitcast i8* %60 to double*
  %_rtX__Integrator_CSTATE_el82 = load double, double* %61, align 1
  %62 = getelementptr inbounds i8, i8* %5, i64 32
  %63 = bitcast i8* %62 to double*
  store double %_rtX__Integrator_CSTATE_el82, double* %63, align 1
  br label %merge

true7:                                            ; preds = %merge
  %_rtB__stateFeedbackGain = load double, double* %142, align 1
  %64 = getelementptr inbounds i8, i8* %4, i64 160
  %65 = bitcast i8* %64 to double*
  %_rtP__Saturation_UpperSat = load double, double* %65, align 1
  %66 = fcmp ult double %_rtB__stateFeedbackGain, %_rtP__Saturation_UpperSat
  br i1 %66, label %false10, label %true9

false8:                                           ; preds = %true9, %true11, %false12, %merge.false8_crit_edge
  %_rtDW__Saturation_MODE119 = phi i32 [ %_rtDW__Saturation_MODE.pre, %merge.false8_crit_edge ], [ 1, %true9 ], [ 0, %true11 ], [ -1, %false12 ]
  %67 = getelementptr inbounds i8, i8* %2, i64 48
  %68 = bitcast i8* %67 to i32*
  switch i32 %_rtDW__Saturation_MODE119, label %false16 [
    i32 1, label %true13
    i32 -1, label %true15
  ]

true9:                                            ; preds = %true7
  %69 = getelementptr inbounds i8, i8* %2, i64 48
  %70 = bitcast i8* %69 to i32*
  store i32 1, i32* %70, align 1
  br label %false8

false10:                                          ; preds = %true7
  %71 = getelementptr inbounds i8, i8* %4, i64 168
  %72 = bitcast i8* %71 to double*
  %_rtP__Saturation_LowerSat = load double, double* %72, align 1
  %73 = fcmp ogt double %_rtB__stateFeedbackGain, %_rtP__Saturation_LowerSat
  br i1 %73, label %true11, label %false12

true11:                                           ; preds = %false10
  %74 = getelementptr inbounds i8, i8* %2, i64 48
  %75 = bitcast i8* %74 to i32*
  store i32 0, i32* %75, align 1
  br label %false8

false12:                                          ; preds = %false10
  %76 = getelementptr inbounds i8, i8* %2, i64 48
  %77 = bitcast i8* %76 to i32*
  store i32 -1, i32* %77, align 1
  br label %false8

true13:                                           ; preds = %false8
  %78 = getelementptr inbounds i8, i8* %4, i64 160
  %79 = bitcast i8* %78 to double*
  %_rtP__Saturation_UpperSat127 = load double, double* %79, align 1
  %80 = getelementptr inbounds i8, i8* %5, i64 48
  %81 = bitcast i8* %80 to double*
  store double %_rtP__Saturation_UpperSat127, double* %81, align 1
  br label %merge30

true15:                                           ; preds = %false8
  %82 = getelementptr inbounds i8, i8* %4, i64 168
  %83 = bitcast i8* %82 to double*
  %_rtP__Saturation_LowerSat124 = load double, double* %83, align 1
  %84 = getelementptr inbounds i8, i8* %5, i64 48
  %85 = bitcast i8* %84 to double*
  store double %_rtP__Saturation_LowerSat124, double* %85, align 1
  br label %merge30

false16:                                          ; preds = %false8
  %_rtB__stateFeedbackGain121 = load double, double* %142, align 1
  %86 = getelementptr inbounds i8, i8* %5, i64 48
  %87 = bitcast i8* %86 to double*
  store double %_rtB__stateFeedbackGain121, double* %87, align 1
  br label %merge30

false17:                                          ; preds = %merge30
  %88 = bitcast i8* %2 to double*
  %_rtDW__TimeStampA = load double, double* %88, align 1
  %89 = fcmp oge double %_rtDW__TimeStampA, %0
  %90 = getelementptr inbounds i8, i8* %2, i64 16
  %91 = bitcast i8* %90 to double*
  %_rtDW__TimeStampB = load double, double* %91, align 1
  %92 = fcmp oge double %_rtDW__TimeStampB, %0
  %93 = and i1 %89, %92
  br i1 %93, label %merge31, label %false19

false19:                                          ; preds = %false17
  %94 = getelementptr inbounds i8, i8* %2, i64 8
  %95 = fcmp olt double %_rtDW__TimeStampA, %_rtDW__TimeStampB
  br i1 %95, label %true20, label %false21

true20:                                           ; preds = %false19
  %96 = fcmp olt double %_rtDW__TimeStampB, %0
  br i1 %96, label %true24, label %false23

false21:                                          ; preds = %false19
  %97 = fcmp ult double %_rtDW__TimeStampA, %0
  br i1 %97, label %false23, label %true22

true22:                                           ; preds = %false21
  %98 = getelementptr inbounds i8, i8* %2, i64 24
  br label %false23

false23:                                          ; preds = %true24, %true20, %true22, %false21
  %rtb_Derivative_.0 = phi double [ %_rtDW__TimeStampB, %true24 ], [ %_rtDW__TimeStampA, %true20 ], [ %_rtDW__TimeStampB, %true22 ], [ %_rtDW__TimeStampA, %false21 ]
  %lastU_.0.in = phi i8* [ %101, %true24 ], [ %94, %true20 ], [ %98, %true22 ], [ %94, %false21 ]
  %lastU_.0 = bitcast i8* %lastU_.0.in to double*
  %99 = getelementptr inbounds i8, i8* %5, i64 48
  %100 = bitcast i8* %99 to double*
  %_rtB__Saturation = load double, double* %100, align 1
  %lastU_156 = load double, double* %lastU_.0, align 1
  %tmp11 = fsub double %_rtB__Saturation, %lastU_156
  %tmp12 = fsub double %0, %rtb_Derivative_.0
  %tmp13 = fdiv double %tmp11, %tmp12
  br label %merge31

true24:                                           ; preds = %true20
  %101 = getelementptr inbounds i8, i8* %2, i64 24
  br label %false23

true25:                                           ; preds = %merge32
  %102 = getelementptr inbounds i8, i8* %4, i64 176
  %103 = bitcast i8* %102 to [16 x double]*
  %tmp17 = add i32 %isHit_.0, 4
  %104 = sext i32 %tmp17 to i64
  %105 = getelementptr inbounds [16 x double], [16 x double]* %103, i64 0, i64 %104
  %_rtP__Gain_Gain_el = load double, double* %105, align 1
  %tmp18 = fmul double %_rtP__Gain_Gain_el, %tmp1
  %106 = sext i32 %isHit_.0 to i64
  %107 = getelementptr inbounds [16 x double], [16 x double]* %103, i64 0, i64 %106
  %_rtP__Gain_Gain_el172 = load double, double* %107, align 1
  %tmp19 = fmul double %_rtP__Gain_Gain_el172, %tmp0
  %tmp20 = fadd double %tmp18, %tmp19
  %tmp21 = add i32 %isHit_.0, 8
  %108 = sext i32 %tmp21 to i64
  %109 = getelementptr inbounds [16 x double], [16 x double]* %103, i64 0, i64 %108
  %_rtP__Gain_Gain_el176 = load double, double* %109, align 1
  %tmp22 = fmul double %_rtP__Gain_Gain_el176, %tmp2
  %tmp23 = fadd double %tmp20, %tmp22
  %tmp24 = add i32 %isHit_.0, 12
  %110 = sext i32 %tmp24 to i64
  %111 = getelementptr inbounds [16 x double], [16 x double]* %103, i64 0, i64 %110
  %_rtP__Gain_Gain_el180 = load double, double* %111, align 1
  %tmp25 = fmul double %_rtP__Gain_Gain_el180, %tmp3
  %tmp26 = fadd double %tmp23, %tmp25
  %112 = getelementptr inbounds [4 x double], [4 x double]* %rtb_e_stanu_, i64 0, i64 %106
  %rtb_e_stanu__el183 = load double, double* %112, align 8
  %tmp27 = fmul double %rtb_e_stanu__el183, %tmp26
  %tmp28 = fadd double %rtb_e_stanu_0_.0, %tmp27
  %tmp29 = add i32 %isHit_.0, 1
  br label %merge32

false26:                                          ; preds = %merge32
  %tmp14 = fmul double %rtb_Derivative_.1, %rtb_Derivative_.1
  %113 = getelementptr inbounds i8, i8* %4, i64 304
  %114 = bitcast i8* %113 to double*
  %_rtP__Gain1_Gain = load double, double* %114, align 1
  %tmp15 = fmul double %tmp14, %_rtP__Gain1_Gain
  %tmp16 = fadd double %rtb_e_stanu_0_.0, %tmp15
  %115 = getelementptr inbounds i8, i8* %5, i64 56
  %116 = bitcast i8* %115 to double*
  store double %tmp16, double* %116, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 14, i32 104)
  %117 = call i8 @vm_getHasError(i8* %S)
  br label %true

merge:                                            ; preds = %false6, %false4
  %.pre-phi206 = phi double* [ %63, %false6 ], [ %32, %false4 ]
  %.pre-phi205 = phi double* [ %59, %false6 ], [ %28, %false4 ]
  %.pre-phi204 = phi double* [ %55, %false6 ], [ %24, %false4 ]
  %.pre-phi = phi double* [ %51, %false6 ], [ %20, %false4 ]
  %_rtB__state_el94 = phi double [ %_rtX__Integrator_CSTATE_el82, %false6 ], [ %_rtX__Integrator_CSTATE_el58, %false4 ]
  %_rtB__state_el90 = phi double [ %_rtX__Integrator_CSTATE_el79, %false6 ], [ %_rtX__Integrator_CSTATE_el55, %false4 ]
  %_rtB__state_el87 = phi double [ %_rtX__Integrator_CSTATE_el76, %false6 ], [ %_rtX__Integrator_CSTATE_el52, %false4 ]
  %_rtB__state_el = phi double [ %_rtX__Integrator_CSTATE_el73, %false6 ], [ %_rtX__Integrator_CSTATE_el, %false4 ]
  %118 = getelementptr inbounds i8, i8* %5, i64 8
  %119 = bitcast i8* %6 to double*
  %_rtU__xw_ref = load double, double* %119, align 1
  %tmp0 = fsub double %_rtB__state_el, %_rtU__xw_ref
  %120 = getelementptr inbounds [4 x double], [4 x double]* %rtb_e_stanu_, i64 0, i64 0
  store double %tmp0, double* %120, align 8
  %121 = getelementptr inbounds i8, i8* %5, i64 16
  %122 = getelementptr inbounds i8, i8* %5, i64 96
  %123 = bitcast i8* %122 to double*
  %_rtB__Constant1_el = load double, double* %123, align 1
  %tmp1 = fsub double %_rtB__state_el87, %_rtB__Constant1_el
  %124 = getelementptr inbounds [4 x double], [4 x double]* %rtb_e_stanu_, i64 0, i64 1
  store double %tmp1, double* %124, align 8
  %125 = getelementptr inbounds i8, i8* %5, i64 24
  %126 = getelementptr inbounds i8, i8* %5, i64 104
  %127 = bitcast i8* %126 to double*
  %_rtB__Constant1_el92 = load double, double* %127, align 1
  %tmp2 = fsub double %_rtB__state_el90, %_rtB__Constant1_el92
  %128 = getelementptr inbounds [4 x double], [4 x double]* %rtb_e_stanu_, i64 0, i64 2
  store double %tmp2, double* %128, align 8
  %129 = getelementptr inbounds i8, i8* %5, i64 32
  %130 = getelementptr inbounds i8, i8* %5, i64 112
  %131 = bitcast i8* %130 to double*
  %_rtB__Constant1_el96 = load double, double* %131, align 1
  %tmp3 = fsub double %_rtB__state_el94, %_rtB__Constant1_el96
  %132 = getelementptr inbounds [4 x double], [4 x double]* %rtb_e_stanu_, i64 0, i64 3
  store double %tmp3, double* %132, align 8
  %133 = getelementptr inbounds i8, i8* %4, i64 128
  %134 = bitcast i8* %133 to double*
  %_rtP__stateFeedbackGain_Gain_el = load double, double* %134, align 1
  %tmp4 = fmul double %_rtP__stateFeedbackGain_Gain_el, %tmp0
  %135 = getelementptr inbounds i8, i8* %4, i64 136
  %136 = bitcast i8* %135 to double*
  %_rtP__stateFeedbackGain_Gain_el99 = load double, double* %136, align 1
  %tmp5 = fmul double %_rtP__stateFeedbackGain_Gain_el99, %tmp1
  %tmp6 = fadd double %tmp4, %tmp5
  %137 = getelementptr inbounds i8, i8* %4, i64 144
  %138 = bitcast i8* %137 to double*
  %_rtP__stateFeedbackGain_Gain_el102 = load double, double* %138, align 1
  %tmp7 = fmul double %_rtP__stateFeedbackGain_Gain_el102, %tmp2
  %tmp8 = fadd double %tmp6, %tmp7
  %139 = getelementptr inbounds i8, i8* %4, i64 152
  %140 = bitcast i8* %139 to double*
  %_rtP__stateFeedbackGain_Gain_el105 = load double, double* %140, align 1
  %tmp9 = fmul double %_rtP__stateFeedbackGain_Gain_el105, %tmp3
  %tmp10 = fadd double %tmp8, %tmp9
  %141 = getelementptr inbounds i8, i8* %5, i64 40
  %142 = bitcast i8* %141 to double*
  store double %tmp10, double* %142, align 1
  %143 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %144 = and i8 %143, 1
  %.not188 = icmp eq i8 %144, 0
  br i1 %.not188, label %merge.false8_crit_edge, label %true7

merge.false8_crit_edge:                           ; preds = %merge
  %.phi.trans.insert199 = getelementptr inbounds i8, i8* %2, i64 48
  %.phi.trans.insert200 = bitcast i8* %.phi.trans.insert199 to i32*
  %_rtDW__Saturation_MODE.pre = load i32, i32* %.phi.trans.insert200, align 1
  br label %false8

merge30:                                          ; preds = %false16, %true15, %true13
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 104)
  %145 = call i8 @vm_getHasError(i8* %S)
  %146 = and i8 %145, 1
  %.not189 = icmp eq i8 %146, 0
  br i1 %.not189, label %false17, label %true

merge31:                                          ; preds = %false17, %false23
  %rtb_Derivative_.1 = phi double [ %tmp13, %false23 ], [ 0.000000e+00, %false17 ]
  br label %merge32

merge32:                                          ; preds = %true25, %merge31
  %rtb_e_stanu_0_.0 = phi double [ 0.000000e+00, %merge31 ], [ %tmp28, %true25 ]
  %isHit_.0 = phi i32 [ 0, %merge31 ], [ %tmp29, %true25 ]
  %147 = icmp slt i32 %isHit_.0, 4
  br i1 %147, label %true25, label %false26
}

declare signext i32 @vm_ssIsSampleHit(i8*, i32 signext, i32 signext)

declare i8* @vm_ssGetX(i8*)

declare zeroext i8 @vm_ssIsModeUpdateTimeStep(i8*)

define void @SystemInitialize(i8* %S) {
SystemInitialize_entry:
  %0 = call i8 @vm_ssIsFirstInitCond(i8* %S)
  %1 = call i8* @vm_ssGetRootDWork(i8* %S)
  %2 = call i8* @vm_ssGetX(i8* %S)
  %3 = call i8* @vm_ssGetModelRtp(i8* %S)
  %4 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %5 = call i8* @vm_ssGetU(i8* %S)
  %6 = getelementptr inbounds i8, i8* %3, i64 312
  %7 = bitcast i8* %6 to double*
  %_rtP__Constant_Value_el = load double, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 64
  %9 = bitcast i8* %8 to double*
  store double %_rtP__Constant_Value_el, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 320
  %11 = bitcast i8* %10 to double*
  %_rtP__Constant_Value_el11 = load double, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 72
  %13 = bitcast i8* %12 to double*
  store double %_rtP__Constant_Value_el11, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 328
  %15 = bitcast i8* %14 to double*
  %_rtP__Constant_Value_el14 = load double, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 80
  %17 = bitcast i8* %16 to double*
  store double %_rtP__Constant_Value_el14, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %3, i64 336
  %19 = bitcast i8* %18 to double*
  %_rtP__Constant_Value_el17 = load double, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %4, i64 88
  %21 = bitcast i8* %20 to double*
  store double %_rtP__Constant_Value_el17, double* %21, align 1
  %22 = getelementptr inbounds i8, i8* %3, i64 120
  %23 = bitcast i8* %22 to double*
  %_rtP__Integrator1_IC = load double, double* %23, align 1
  %24 = bitcast i8* %2 to double*
  store double %_rtP__Integrator1_IC, double* %24, align 1
  %.not = icmp eq i8 %0, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %SystemInitialize_entry
  %25 = getelementptr inbounds i8, i8* %2, i64 8
  %26 = bitcast i8* %25 to double*
  store double 2.350000e-01, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %2, i64 16
  %28 = bitcast i8* %27 to double*
  store double 0.000000e+00, double* %28, align 1
  %29 = getelementptr inbounds i8, i8* %2, i64 24
  %30 = bitcast i8* %29 to double*
  store double 0.000000e+00, double* %30, align 1
  %31 = getelementptr inbounds i8, i8* %2, i64 32
  %32 = bitcast i8* %31 to double*
  store double 0.000000e+00, double* %32, align 1
  br label %false

false:                                            ; preds = %true, %SystemInitialize_entry
  %33 = getelementptr inbounds i8, i8* %1, i64 44
  %34 = bitcast i8* %33 to i32*
  store i32 1, i32* %34, align 1
  %35 = bitcast i8* %1 to double*
  store double 0x7FF0000000000000, double* %35, align 1
  %36 = getelementptr inbounds i8, i8* %1, i64 16
  %37 = bitcast i8* %36 to double*
  store double 0x7FF0000000000000, double* %37, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 102)
  %38 = call i8 @vm_getHasError(i8* %S)
  ret void
}

declare zeroext i8 @vm_ssIsFirstInitCond(i8*)

