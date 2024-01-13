; ModuleID = 'test'
source_filename = "test"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @model_wahadla_lepkie_CGInitializeSizes(i8* %S_0) {
model_wahadla_lepkie_CGInitializeSizes_entry:
  %tmp_ = alloca [4 x i32], align 4
  call void @model_wahadla_lepkie_Checksum([4 x i32]* nonnull %tmp_)
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
  call void @vm_USizeCheck(i8* %S_0, i32 8)
  call void @vm_blockIOSizeCheck(i8* %S_0, i32 128)
  call void @vm_dworkSizeCheck(i8* %S_0, i32 64)
  call void @vm_paramSizeCheck(i8* %S_0, i32 128)
  ret void
}

define void @model_wahadla_lepkie_Checksum([4 x i32]* %y) {
model_wahadla_lepkie_Checksum_entry:
  %0 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 0
  store i32 2074106671, i32* %0, align 1
  %1 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 1
  store i32 1526817008, i32* %1, align 1
  %2 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 2
  store i32 -1360829420, i32* %2, align 1
  %3 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 3
  store i32 1735918951, i32* %3, align 1
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
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 139)
  %2 = call i8 @vm_getHasError(i8* %S)
  ret void
}

declare i8* @vm_ssGetModelRtp(i8*)

declare i8* @vm__ssGetModelBlockIO(i8*)

declare void @vm_ssCallAccelRunBlock(i8*, i32 signext, i32 signext, i32 signext)

declare zeroext i8 @vm_getHasError(i8*)

define void @ZeroCrossings(i8* %S) {
ZeroCrossings_entry:
  %0 = call i8* @vm_ssGetSolverZcSignalVector(i8* %S)
  %1 = call i8* @vm_ssGetModelRtp(i8* %S)
  %2 = call i8* @vm_ssGetU(i8* %S)
  %3 = bitcast i8* %2 to double*
  %_rtU__Inport = load double, double* %3, align 1
  %4 = getelementptr inbounds i8, i8* %1, i64 72
  %5 = bitcast i8* %4 to double*
  %_rtP__Saturation1_UpperSat = load double, double* %5, align 1
  %tmp0 = fsub double %_rtU__Inport, %_rtP__Saturation1_UpperSat
  %6 = bitcast i8* %0 to double*
  store double %tmp0, double* %6, align 1
  %_rtU__Inport8 = load double, double* %3, align 1
  %7 = getelementptr inbounds i8, i8* %1, i64 80
  %8 = bitcast i8* %7 to double*
  %_rtP__Saturation1_LowerSat = load double, double* %8, align 1
  %tmp1 = fsub double %_rtU__Inport8, %_rtP__Saturation1_LowerSat
  %9 = getelementptr inbounds i8, i8* %0, i64 8
  %10 = bitcast i8* %9 to double*
  store double %tmp1, double* %10, align 1
  ret void
}

declare i8* @vm_ssGetSolverZcSignalVector(i8*)

declare i8* @vm_ssGetU(i8*)

define void @ForcingFunction(i8* %S) {
ForcingFunction_entry:
  %0 = call i8* @vm_ssGetdX(i8* %S)
  %1 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %2 = getelementptr inbounds i8, i8* %1, i64 96
  %3 = bitcast i8* %2 to double*
  %_rtB__Dx_el = load double, double* %3, align 1
  %4 = bitcast i8* %0 to double*
  store double %_rtB__Dx_el, double* %4, align 1
  %5 = getelementptr inbounds i8, i8* %1, i64 104
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el6 = load double, double* %6, align 1
  %7 = getelementptr inbounds i8, i8* %0, i64 8
  %8 = bitcast i8* %7 to double*
  store double %_rtB__Dx_el6, double* %8, align 1
  %9 = getelementptr inbounds i8, i8* %1, i64 112
  %10 = bitcast i8* %9 to double*
  %_rtB__Dx_el9 = load double, double* %10, align 1
  %11 = getelementptr inbounds i8, i8* %0, i64 16
  %12 = bitcast i8* %11 to double*
  store double %_rtB__Dx_el9, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %1, i64 120
  %14 = bitcast i8* %13 to double*
  %_rtB__Dx_el12 = load double, double* %14, align 1
  %15 = getelementptr inbounds i8, i8* %0, i64 24
  %16 = bitcast i8* %15 to double*
  store double %_rtB__Dx_el12, double* %16, align 1
  ret void
}

declare i8* @vm_ssGetdX(i8*)

define void @Derivatives(i8* %S) {
Derivatives_entry:
  %0 = call i8* @vm_ssGetdX(i8* %S)
  %1 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %2 = getelementptr inbounds i8, i8* %1, i64 96
  %3 = bitcast i8* %2 to double*
  %_rtB__Dx_el = load double, double* %3, align 1
  %4 = bitcast i8* %0 to double*
  store double %_rtB__Dx_el, double* %4, align 1
  %5 = getelementptr inbounds i8, i8* %1, i64 104
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el6 = load double, double* %6, align 1
  %7 = getelementptr inbounds i8, i8* %0, i64 8
  %8 = bitcast i8* %7 to double*
  store double %_rtB__Dx_el6, double* %8, align 1
  %9 = getelementptr inbounds i8, i8* %1, i64 112
  %10 = bitcast i8* %9 to double*
  %_rtB__Dx_el9 = load double, double* %10, align 1
  %11 = getelementptr inbounds i8, i8* %0, i64 16
  %12 = bitcast i8* %11 to double*
  store double %_rtB__Dx_el9, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %1, i64 120
  %14 = bitcast i8* %13 to double*
  %_rtB__Dx_el12 = load double, double* %14, align 1
  %15 = getelementptr inbounds i8, i8* %0, i64 24
  %16 = bitcast i8* %15 to double*
  store double %_rtB__Dx_el12, double* %16, align 1
  ret void
}

define void @Update0(i8* %S) {
Update0_entry:
  %0 = call i8* @vm_ssGetRootDWork(i8* %S)
  %1 = getelementptr inbounds i8, i8* %0, i64 52
  %2 = bitcast i8* %1 to i32*
  store i32 0, i32* %2, align 1
  ret void
}

declare i8* @vm_ssGetRootDWork(i8*)

define void @Outputs1(i8* %S, i32 signext %controlPortIdx) {
Outputs1_entry:
  %0 = call i8* @vm_ssGetRootDWork(i8* %S)
  %1 = call i8* @vm_ssGetModelRtp(i8* %S)
  %2 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %3 = getelementptr inbounds i8, i8* %1, i64 88
  %4 = bitcast i8* %3 to double*
  %_rtP__Constant1_Value = load double, double* %4, align 1
  %5 = getelementptr inbounds i8, i8* %2, i64 56
  %6 = bitcast i8* %5 to double*
  store double %_rtP__Constant1_Value, double* %6, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 16, i32 104)
  %7 = call i8 @vm_getHasError(i8* %S)
  %8 = and i8 %7, 1
  %.not = icmp eq i8 %8, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %false1, %false, %Outputs1_entry
  ret void

false:                                            ; preds = %Outputs1_entry
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 17, i32 104)
  %9 = call i8 @vm_getHasError(i8* %S)
  %10 = and i8 %9, 1
  %.not22 = icmp eq i8 %10, 0
  br i1 %.not22, label %false1, label %true

false1:                                           ; preds = %false
  %11 = getelementptr inbounds i8, i8* %1, i64 96
  %12 = bitcast i8* %11 to double*
  %_rtP__Constant_Value_el = load double, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %2, i64 64
  %14 = bitcast i8* %13 to double*
  store double %_rtP__Constant_Value_el, double* %14, align 1
  %15 = getelementptr inbounds i8, i8* %1, i64 104
  %16 = bitcast i8* %15 to double*
  %_rtP__Constant_Value_el14 = load double, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %2, i64 72
  %18 = bitcast i8* %17 to double*
  store double %_rtP__Constant_Value_el14, double* %18, align 1
  %19 = getelementptr inbounds i8, i8* %1, i64 112
  %20 = bitcast i8* %19 to double*
  %_rtP__Constant_Value_el17 = load double, double* %20, align 1
  %21 = getelementptr inbounds i8, i8* %2, i64 80
  %22 = bitcast i8* %21 to double*
  store double %_rtP__Constant_Value_el17, double* %22, align 1
  %23 = getelementptr inbounds i8, i8* %1, i64 120
  %24 = bitcast i8* %23 to double*
  %_rtP__Constant_Value_el20 = load double, double* %24, align 1
  %25 = getelementptr inbounds i8, i8* %2, i64 88
  %26 = bitcast i8* %25 to double*
  store double %_rtP__Constant_Value_el20, double* %26, align 1
  br label %true
}

define void @Outputs0(i8* %S) {
Outputs0_entry:
  %0 = call i32 @vm_ssIsSampleHit(i8* %S, i32 1, i32 0)
  %1 = call i8* @vm_ssGetRootDWork(i8* %S)
  %2 = call i8* @vm_ssGetX(i8* %S)
  %3 = call i8* @vm_ssGetModelRtp(i8* %S)
  %4 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %5 = call i8* @vm_ssGetU(i8* %S)
  %6 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %7 = and i8 %6, 1
  %.not = icmp eq i8 %7, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %Outputs0_entry
  %8 = getelementptr inbounds i8, i8* %1, i64 52
  %9 = bitcast i8* %8 to i32*
  %_rtDW__Integrator_IWORK = load i32, i32* %9, align 1
  %.not136 = icmp eq i32 %_rtDW__Integrator_IWORK, 0
  br i1 %.not136, label %true.false2_crit_edge, label %true1

true.false2_crit_edge:                            ; preds = %true
  %.phi.trans.insert = bitcast i8* %2 to double*
  %_rtX__Integrator_CSTATE_el60.pre = load double, double* %.phi.trans.insert, align 1
  br label %false2

false:                                            ; preds = %Outputs0_entry
  %10 = bitcast i8* %2 to double*
  %_rtX__Integrator_CSTATE_el = load double, double* %10, align 1
  %11 = bitcast i8* %4 to double*
  store double %_rtX__Integrator_CSTATE_el, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %2, i64 8
  %13 = bitcast i8* %12 to double*
  %_rtX__Integrator_CSTATE_el39 = load double, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %4, i64 8
  %15 = bitcast i8* %14 to double*
  store double %_rtX__Integrator_CSTATE_el39, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %2, i64 16
  %17 = bitcast i8* %16 to double*
  %_rtX__Integrator_CSTATE_el42 = load double, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %4, i64 16
  %19 = bitcast i8* %18 to double*
  store double %_rtX__Integrator_CSTATE_el42, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %2, i64 24
  %21 = bitcast i8* %20 to double*
  %_rtX__Integrator_CSTATE_el45 = load double, double* %21, align 1
  %22 = getelementptr inbounds i8, i8* %4, i64 24
  %23 = bitcast i8* %22 to double*
  store double %_rtX__Integrator_CSTATE_el45, double* %23, align 1
  br label %merge

true1:                                            ; preds = %true
  %24 = getelementptr inbounds i8, i8* %4, i64 64
  %25 = bitcast i8* %24 to double*
  %_rtB__Constant_el = load double, double* %25, align 1
  %26 = bitcast i8* %2 to double*
  store double %_rtB__Constant_el, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %4, i64 72
  %28 = bitcast i8* %27 to double*
  %_rtB__Constant_el51 = load double, double* %28, align 1
  %29 = getelementptr inbounds i8, i8* %2, i64 8
  %30 = bitcast i8* %29 to double*
  store double %_rtB__Constant_el51, double* %30, align 1
  %31 = getelementptr inbounds i8, i8* %4, i64 80
  %32 = bitcast i8* %31 to double*
  %_rtB__Constant_el54 = load double, double* %32, align 1
  %33 = getelementptr inbounds i8, i8* %2, i64 16
  %34 = bitcast i8* %33 to double*
  store double %_rtB__Constant_el54, double* %34, align 1
  %35 = getelementptr inbounds i8, i8* %4, i64 88
  %36 = bitcast i8* %35 to double*
  %_rtB__Constant_el57 = load double, double* %36, align 1
  %37 = getelementptr inbounds i8, i8* %2, i64 24
  %38 = bitcast i8* %37 to double*
  store double %_rtB__Constant_el57, double* %38, align 1
  br label %false2

false2:                                           ; preds = %true.false2_crit_edge, %true1
  %.pre-phi = phi double* [ %.phi.trans.insert, %true.false2_crit_edge ], [ %26, %true1 ]
  %_rtX__Integrator_CSTATE_el60 = phi double [ %_rtX__Integrator_CSTATE_el60.pre, %true.false2_crit_edge ], [ %_rtB__Constant_el, %true1 ]
  %39 = bitcast i8* %4 to double*
  store double %_rtX__Integrator_CSTATE_el60, double* %39, align 1
  %40 = getelementptr inbounds i8, i8* %2, i64 8
  %41 = bitcast i8* %40 to double*
  %_rtX__Integrator_CSTATE_el63 = load double, double* %41, align 1
  %42 = getelementptr inbounds i8, i8* %4, i64 8
  %43 = bitcast i8* %42 to double*
  store double %_rtX__Integrator_CSTATE_el63, double* %43, align 1
  %44 = getelementptr inbounds i8, i8* %2, i64 16
  %45 = bitcast i8* %44 to double*
  %_rtX__Integrator_CSTATE_el66 = load double, double* %45, align 1
  %46 = getelementptr inbounds i8, i8* %4, i64 16
  %47 = bitcast i8* %46 to double*
  store double %_rtX__Integrator_CSTATE_el66, double* %47, align 1
  %48 = getelementptr inbounds i8, i8* %2, i64 24
  %49 = bitcast i8* %48 to double*
  %_rtX__Integrator_CSTATE_el69 = load double, double* %49, align 1
  %50 = getelementptr inbounds i8, i8* %4, i64 24
  %51 = bitcast i8* %50 to double*
  store double %_rtX__Integrator_CSTATE_el69, double* %51, align 1
  br label %merge

true3:                                            ; preds = %merge28, %false14, %false13, %false12, %false11, %true9, %false7, %false6, %false5, %false4, %merge
  ret void

false4:                                           ; preds = %merge
  %52 = getelementptr inbounds i8, i8* %3, i64 56
  %53 = bitcast i8* %52 to double*
  %_rtP__Gain1_Gain = load double, double* %53, align 1
  %54 = getelementptr inbounds i8, i8* %4, i64 8
  %55 = bitcast i8* %54 to double*
  %_rtB__state_el = load double, double* %55, align 1
  %tmp0 = fmul double %_rtP__Gain1_Gain, %_rtB__state_el
  %56 = getelementptr inbounds i8, i8* %4, i64 32
  %57 = bitcast i8* %56 to double*
  store double %tmp0, double* %57, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 3, i32 104)
  %58 = call i8 @vm_getHasError(i8* %S)
  %59 = and i8 %58, 1
  %.not124 = icmp eq i8 %59, 0
  br i1 %.not124, label %false5, label %true3

false5:                                           ; preds = %false4
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 4, i32 104)
  %60 = call i8 @vm_getHasError(i8* %S)
  %61 = and i8 %60, 1
  %.not125 = icmp eq i8 %61, 0
  br i1 %.not125, label %false6, label %true3

false6:                                           ; preds = %false5
  %62 = getelementptr inbounds i8, i8* %3, i64 64
  %63 = bitcast i8* %62 to double*
  %_rtP__Gain2_Gain = load double, double* %63, align 1
  %64 = getelementptr inbounds i8, i8* %4, i64 24
  %65 = bitcast i8* %64 to double*
  %_rtB__state_el82 = load double, double* %65, align 1
  %tmp1 = fmul double %_rtP__Gain2_Gain, %_rtB__state_el82
  %66 = getelementptr inbounds i8, i8* %4, i64 40
  %67 = bitcast i8* %66 to double*
  store double %tmp1, double* %67, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 6, i32 104)
  %68 = call i8 @vm_getHasError(i8* %S)
  %69 = and i8 %68, 1
  %.not126 = icmp eq i8 %69, 0
  br i1 %.not126, label %false7, label %true3

false7:                                           ; preds = %false6
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 7, i32 104)
  %70 = call i8 @vm_getHasError(i8* %S)
  %71 = and i8 %70, 1
  %.not127 = icmp eq i8 %71, 0
  br i1 %.not127, label %false8, label %true3

false8:                                           ; preds = %false7
  %.not128 = icmp eq i32 %0, 0
  br i1 %.not128, label %false10, label %true9

true9:                                            ; preds = %false8
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 8, i32 104)
  %72 = call i8 @vm_getHasError(i8* %S)
  %73 = and i8 %72, 1
  %.not131 = icmp eq i8 %73, 0
  br i1 %.not131, label %false11, label %true3

false10:                                          ; preds = %false14, %false8
  %74 = call i8 @vm_ssIsModeUpdateTimeStep(i8* %S)
  %75 = and i8 %74, 1
  %.not129 = icmp eq i8 %75, 0
  br i1 %.not129, label %false10.false16_crit_edge, label %true15

false10.false16_crit_edge:                        ; preds = %false10
  %.phi.trans.insert138 = getelementptr inbounds i8, i8* %1, i64 56
  %.phi.trans.insert139 = bitcast i8* %.phi.trans.insert138 to i32*
  %_rtDW__Saturation1_MODE.pre = load i32, i32* %.phi.trans.insert139, align 1
  br label %false16

false11:                                          ; preds = %true9
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 9, i32 104)
  %76 = call i8 @vm_getHasError(i8* %S)
  %77 = and i8 %76, 1
  %.not132 = icmp eq i8 %77, 0
  br i1 %.not132, label %false12, label %true3

false12:                                          ; preds = %false11
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 10, i32 104)
  %78 = call i8 @vm_getHasError(i8* %S)
  %79 = and i8 %78, 1
  %.not133 = icmp eq i8 %79, 0
  br i1 %.not133, label %false13, label %true3

false13:                                          ; preds = %false12
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 11, i32 104)
  %80 = call i8 @vm_getHasError(i8* %S)
  %81 = and i8 %80, 1
  %.not134 = icmp eq i8 %81, 0
  br i1 %.not134, label %false14, label %true3

false14:                                          ; preds = %false13
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 12, i32 104)
  %82 = call i8 @vm_getHasError(i8* %S)
  %83 = and i8 %82, 1
  %.not135 = icmp eq i8 %83, 0
  br i1 %.not135, label %false10, label %true3

true15:                                           ; preds = %false10
  %84 = bitcast i8* %5 to double*
  %_rtU__Inport = load double, double* %84, align 1
  %85 = getelementptr inbounds i8, i8* %3, i64 72
  %86 = bitcast i8* %85 to double*
  %_rtP__Saturation1_UpperSat = load double, double* %86, align 1
  %87 = fcmp ult double %_rtU__Inport, %_rtP__Saturation1_UpperSat
  br i1 %87, label %false18, label %true17

false16:                                          ; preds = %true17, %true19, %false20, %false10.false16_crit_edge
  %_rtDW__Saturation1_MODE111 = phi i32 [ %_rtDW__Saturation1_MODE.pre, %false10.false16_crit_edge ], [ 1, %true17 ], [ 0, %true19 ], [ -1, %false20 ]
  %88 = getelementptr inbounds i8, i8* %1, i64 56
  %89 = bitcast i8* %88 to i32*
  switch i32 %_rtDW__Saturation1_MODE111, label %false24 [
    i32 1, label %true21
    i32 -1, label %true23
  ]

true17:                                           ; preds = %true15
  %90 = getelementptr inbounds i8, i8* %1, i64 56
  %91 = bitcast i8* %90 to i32*
  store i32 1, i32* %91, align 1
  br label %false16

false18:                                          ; preds = %true15
  %92 = getelementptr inbounds i8, i8* %3, i64 80
  %93 = bitcast i8* %92 to double*
  %_rtP__Saturation1_LowerSat = load double, double* %93, align 1
  %94 = fcmp ogt double %_rtU__Inport, %_rtP__Saturation1_LowerSat
  br i1 %94, label %true19, label %false20

true19:                                           ; preds = %false18
  %95 = getelementptr inbounds i8, i8* %1, i64 56
  %96 = bitcast i8* %95 to i32*
  store i32 0, i32* %96, align 1
  br label %false16

false20:                                          ; preds = %false18
  %97 = getelementptr inbounds i8, i8* %1, i64 56
  %98 = bitcast i8* %97 to i32*
  store i32 -1, i32* %98, align 1
  br label %false16

true21:                                           ; preds = %false16
  %99 = getelementptr inbounds i8, i8* %3, i64 72
  %100 = bitcast i8* %99 to double*
  %_rtP__Saturation1_UpperSat119 = load double, double* %100, align 1
  %101 = getelementptr inbounds i8, i8* %4, i64 48
  %102 = bitcast i8* %101 to double*
  store double %_rtP__Saturation1_UpperSat119, double* %102, align 1
  br label %merge28

true23:                                           ; preds = %false16
  %103 = getelementptr inbounds i8, i8* %3, i64 80
  %104 = bitcast i8* %103 to double*
  %_rtP__Saturation1_LowerSat116 = load double, double* %104, align 1
  %105 = getelementptr inbounds i8, i8* %4, i64 48
  %106 = bitcast i8* %105 to double*
  store double %_rtP__Saturation1_LowerSat116, double* %106, align 1
  br label %merge28

false24:                                          ; preds = %false16
  %107 = bitcast i8* %5 to double*
  %_rtU__Inport113 = load double, double* %107, align 1
  %108 = getelementptr inbounds i8, i8* %4, i64 48
  %109 = bitcast i8* %108 to double*
  store double %_rtU__Inport113, double* %109, align 1
  br label %merge28

merge:                                            ; preds = %false2, %false
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 1, i32 104)
  %110 = call i8 @vm_getHasError(i8* %S)
  %111 = and i8 %110, 1
  %.not123 = icmp eq i8 %111, 0
  br i1 %.not123, label %false4, label %true3

merge28:                                          ; preds = %false24, %true23, %true21
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 104)
  %112 = call i8 @vm_getHasError(i8* %S)
  br label %true3
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
  %5 = getelementptr inbounds i8, i8* %3, i64 88
  %6 = bitcast i8* %5 to double*
  %_rtP__Constant1_Value = load double, double* %6, align 1
  %7 = getelementptr inbounds i8, i8* %4, i64 56
  %8 = bitcast i8* %7 to double*
  store double %_rtP__Constant1_Value, double* %8, align 1
  %9 = getelementptr inbounds i8, i8* %3, i64 96
  %10 = bitcast i8* %9 to double*
  %_rtP__Constant_Value_el = load double, double* %10, align 1
  %11 = getelementptr inbounds i8, i8* %4, i64 64
  %12 = bitcast i8* %11 to double*
  store double %_rtP__Constant_Value_el, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %3, i64 104
  %14 = bitcast i8* %13 to double*
  %_rtP__Constant_Value_el12 = load double, double* %14, align 1
  %15 = getelementptr inbounds i8, i8* %4, i64 72
  %16 = bitcast i8* %15 to double*
  store double %_rtP__Constant_Value_el12, double* %16, align 1
  %17 = getelementptr inbounds i8, i8* %3, i64 112
  %18 = bitcast i8* %17 to double*
  %_rtP__Constant_Value_el15 = load double, double* %18, align 1
  %19 = getelementptr inbounds i8, i8* %4, i64 80
  %20 = bitcast i8* %19 to double*
  store double %_rtP__Constant_Value_el15, double* %20, align 1
  %21 = getelementptr inbounds i8, i8* %3, i64 120
  %22 = bitcast i8* %21 to double*
  %_rtP__Constant_Value_el18 = load double, double* %22, align 1
  %23 = getelementptr inbounds i8, i8* %4, i64 88
  %24 = bitcast i8* %23 to double*
  store double %_rtP__Constant_Value_el18, double* %24, align 1
  %.not = icmp eq i8 %0, 0
  br i1 %.not, label %false, label %true

true:                                             ; preds = %SystemInitialize_entry
  %25 = bitcast i8* %2 to double*
  store double 0.000000e+00, double* %25, align 1
  %26 = getelementptr inbounds i8, i8* %2, i64 8
  %27 = bitcast i8* %26 to double*
  store double 0x400921FB54442D18, double* %27, align 1
  %28 = getelementptr inbounds i8, i8* %2, i64 16
  %29 = bitcast i8* %28 to double*
  store double 0.000000e+00, double* %29, align 1
  %30 = getelementptr inbounds i8, i8* %2, i64 24
  %31 = bitcast i8* %30 to double*
  store double 0.000000e+00, double* %31, align 1
  br label %false

false:                                            ; preds = %true, %SystemInitialize_entry
  %32 = getelementptr inbounds i8, i8* %1, i64 52
  %33 = bitcast i8* %32 to i32*
  store i32 1, i32* %33, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 102)
  %34 = call i8 @vm_getHasError(i8* %S)
  ret void
}

declare zeroext i8 @vm_ssIsFirstInitCond(i8*)

