; ModuleID = 'test'
source_filename = "test"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"

define void @model1_CGInitializeSizes(i8* %S_0) {
model1_CGInitializeSizes_entry:
  %tmp_ = alloca [4 x i32], align 4
  call void @model1_Checksum([4 x i32]* nonnull %tmp_)
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
  call void @vm_blockIOSizeCheck(i8* %S_0, i32 112)
  call void @vm_dworkSizeCheck(i8* %S_0, i32 56)
  call void @vm_paramSizeCheck(i8* %S_0, i32 168)
  ret void
}

define void @model1_Checksum([4 x i32]* %y) {
model1_Checksum_entry:
  %0 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 0
  store i32 -978586114, i32* %0, align 1
  %1 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 1
  store i32 160836518, i32* %1, align 1
  %2 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 2
  store i32 668454335, i32* %2, align 1
  %3 = getelementptr inbounds [4 x i32], [4 x i32]* %y, i64 0, i64 3
  store i32 -966672803, i32* %3, align 1
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

define void @ForcingFunction(i8* %S) {
ForcingFunction_entry:
  %0 = call i8* @vm_ssGetdX(i8* %S)
  %1 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %2 = getelementptr inbounds i8, i8* %1, i64 80
  %3 = bitcast i8* %2 to double*
  %_rtB__Dx_el = load double, double* %3, align 1
  %4 = bitcast i8* %0 to double*
  store double %_rtB__Dx_el, double* %4, align 1
  %5 = getelementptr inbounds i8, i8* %1, i64 88
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el6 = load double, double* %6, align 1
  %7 = getelementptr inbounds i8, i8* %0, i64 8
  %8 = bitcast i8* %7 to double*
  store double %_rtB__Dx_el6, double* %8, align 1
  %9 = getelementptr inbounds i8, i8* %1, i64 96
  %10 = bitcast i8* %9 to double*
  %_rtB__Dx_el9 = load double, double* %10, align 1
  %11 = getelementptr inbounds i8, i8* %0, i64 16
  %12 = bitcast i8* %11 to double*
  store double %_rtB__Dx_el9, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %1, i64 104
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
  %2 = getelementptr inbounds i8, i8* %1, i64 80
  %3 = bitcast i8* %2 to double*
  %_rtB__Dx_el = load double, double* %3, align 1
  %4 = bitcast i8* %0 to double*
  store double %_rtB__Dx_el, double* %4, align 1
  %5 = getelementptr inbounds i8, i8* %1, i64 88
  %6 = bitcast i8* %5 to double*
  %_rtB__Dx_el6 = load double, double* %6, align 1
  %7 = getelementptr inbounds i8, i8* %0, i64 8
  %8 = bitcast i8* %7 to double*
  store double %_rtB__Dx_el6, double* %8, align 1
  %9 = getelementptr inbounds i8, i8* %1, i64 96
  %10 = bitcast i8* %9 to double*
  %_rtB__Dx_el9 = load double, double* %10, align 1
  %11 = getelementptr inbounds i8, i8* %0, i64 16
  %12 = bitcast i8* %11 to double*
  store double %_rtB__Dx_el9, double* %12, align 1
  %13 = getelementptr inbounds i8, i8* %1, i64 104
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
  %0 = call i8* @vm_ssGetModelRtp(i8* %S)
  %1 = call i8* @vm__ssGetModelBlockIO(i8* %S)
  %2 = getelementptr inbounds i8, i8* %0, i64 136
  %3 = bitcast i8* %2 to double*
  %_rtP__Constant_Value_el = load double, double* %3, align 1
  %4 = getelementptr inbounds i8, i8* %1, i64 48
  %5 = bitcast i8* %4 to double*
  store double %_rtP__Constant_Value_el, double* %5, align 1
  %6 = getelementptr inbounds i8, i8* %0, i64 144
  %7 = bitcast i8* %6 to double*
  %_rtP__Constant_Value_el6 = load double, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %1, i64 56
  %9 = bitcast i8* %8 to double*
  store double %_rtP__Constant_Value_el6, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %0, i64 152
  %11 = bitcast i8* %10 to double*
  %_rtP__Constant_Value_el9 = load double, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %1, i64 64
  %13 = bitcast i8* %12 to double*
  store double %_rtP__Constant_Value_el9, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %0, i64 160
  %15 = bitcast i8* %14 to double*
  %_rtP__Constant_Value_el12 = load double, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %1, i64 72
  %17 = bitcast i8* %16 to double*
  store double %_rtP__Constant_Value_el12, double* %17, align 1
  ret void
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
  %.not108 = icmp eq i32 %_rtDW__Integrator_IWORK, 0
  br i1 %.not108, label %true.false2_crit_edge, label %true1

true.false2_crit_edge:                            ; preds = %true
  %.phi.trans.insert = bitcast i8* %2 to double*
  %_rtX__Integrator_CSTATE_el48.pre = load double, double* %.phi.trans.insert, align 1
  br label %false2

false:                                            ; preds = %Outputs0_entry
  %10 = bitcast i8* %2 to double*
  %_rtX__Integrator_CSTATE_el = load double, double* %10, align 1
  %11 = bitcast i8* %4 to double*
  store double %_rtX__Integrator_CSTATE_el, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %2, i64 8
  %13 = bitcast i8* %12 to double*
  %_rtX__Integrator_CSTATE_el27 = load double, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %4, i64 8
  %15 = bitcast i8* %14 to double*
  store double %_rtX__Integrator_CSTATE_el27, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %2, i64 16
  %17 = bitcast i8* %16 to double*
  %_rtX__Integrator_CSTATE_el30 = load double, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %4, i64 16
  %19 = bitcast i8* %18 to double*
  store double %_rtX__Integrator_CSTATE_el30, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %2, i64 24
  %21 = bitcast i8* %20 to double*
  %_rtX__Integrator_CSTATE_el33 = load double, double* %21, align 1
  %22 = getelementptr inbounds i8, i8* %4, i64 24
  %23 = bitcast i8* %22 to double*
  store double %_rtX__Integrator_CSTATE_el33, double* %23, align 1
  br label %merge

true1:                                            ; preds = %true
  %24 = getelementptr inbounds i8, i8* %4, i64 48
  %25 = bitcast i8* %24 to double*
  %_rtB__Constant_el = load double, double* %25, align 1
  %26 = bitcast i8* %2 to double*
  store double %_rtB__Constant_el, double* %26, align 1
  %27 = getelementptr inbounds i8, i8* %4, i64 56
  %28 = bitcast i8* %27 to double*
  %_rtB__Constant_el39 = load double, double* %28, align 1
  %29 = getelementptr inbounds i8, i8* %2, i64 8
  %30 = bitcast i8* %29 to double*
  store double %_rtB__Constant_el39, double* %30, align 1
  %31 = getelementptr inbounds i8, i8* %4, i64 64
  %32 = bitcast i8* %31 to double*
  %_rtB__Constant_el42 = load double, double* %32, align 1
  %33 = getelementptr inbounds i8, i8* %2, i64 16
  %34 = bitcast i8* %33 to double*
  store double %_rtB__Constant_el42, double* %34, align 1
  %35 = getelementptr inbounds i8, i8* %4, i64 72
  %36 = bitcast i8* %35 to double*
  %_rtB__Constant_el45 = load double, double* %36, align 1
  %37 = getelementptr inbounds i8, i8* %2, i64 24
  %38 = bitcast i8* %37 to double*
  store double %_rtB__Constant_el45, double* %38, align 1
  br label %false2

false2:                                           ; preds = %true.false2_crit_edge, %true1
  %.pre-phi = phi double* [ %.phi.trans.insert, %true.false2_crit_edge ], [ %26, %true1 ]
  %_rtX__Integrator_CSTATE_el48 = phi double [ %_rtX__Integrator_CSTATE_el48.pre, %true.false2_crit_edge ], [ %_rtB__Constant_el, %true1 ]
  %39 = bitcast i8* %4 to double*
  store double %_rtX__Integrator_CSTATE_el48, double* %39, align 1
  %40 = getelementptr inbounds i8, i8* %2, i64 8
  %41 = bitcast i8* %40 to double*
  %_rtX__Integrator_CSTATE_el51 = load double, double* %41, align 1
  %42 = getelementptr inbounds i8, i8* %4, i64 8
  %43 = bitcast i8* %42 to double*
  store double %_rtX__Integrator_CSTATE_el51, double* %43, align 1
  %44 = getelementptr inbounds i8, i8* %2, i64 16
  %45 = bitcast i8* %44 to double*
  %_rtX__Integrator_CSTATE_el54 = load double, double* %45, align 1
  %46 = getelementptr inbounds i8, i8* %4, i64 16
  %47 = bitcast i8* %46 to double*
  store double %_rtX__Integrator_CSTATE_el54, double* %47, align 1
  %48 = getelementptr inbounds i8, i8* %2, i64 24
  %49 = bitcast i8* %48 to double*
  %_rtX__Integrator_CSTATE_el57 = load double, double* %49, align 1
  %50 = getelementptr inbounds i8, i8* %4, i64 24
  %51 = bitcast i8* %50 to double*
  store double %_rtX__Integrator_CSTATE_el57, double* %51, align 1
  br label %merge

true3:                                            ; preds = %false11, %false16, %false15, %false14, %false13, %false12, %true10, %false8, %false7, %false6, %false5, %false4, %merge
  ret void

false4:                                           ; preds = %merge
  %52 = getelementptr inbounds i8, i8* %3, i64 120
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
  %.not95 = icmp eq i8 %59, 0
  br i1 %.not95, label %false5, label %true3

false5:                                           ; preds = %false4
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 4, i32 104)
  %60 = call i8 @vm_getHasError(i8* %S)
  %61 = and i8 %60, 1
  %.not96 = icmp eq i8 %61, 0
  br i1 %.not96, label %false6, label %true3

false6:                                           ; preds = %false5
  %62 = getelementptr inbounds i8, i8* %3, i64 128
  %63 = bitcast i8* %62 to double*
  %_rtP__Gain2_Gain = load double, double* %63, align 1
  %64 = getelementptr inbounds i8, i8* %4, i64 24
  %65 = bitcast i8* %64 to double*
  %_rtB__state_el70 = load double, double* %65, align 1
  %tmp1 = fmul double %_rtP__Gain2_Gain, %_rtB__state_el70
  %66 = getelementptr inbounds i8, i8* %4, i64 40
  %67 = bitcast i8* %66 to double*
  store double %tmp1, double* %67, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 6, i32 104)
  %68 = call i8 @vm_getHasError(i8* %S)
  %69 = and i8 %68, 1
  %.not97 = icmp eq i8 %69, 0
  br i1 %.not97, label %false7, label %true3

false7:                                           ; preds = %false6
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 7, i32 104)
  %70 = call i8 @vm_getHasError(i8* %S)
  %71 = and i8 %70, 1
  %.not98 = icmp eq i8 %71, 0
  br i1 %.not98, label %false8, label %true3

false8:                                           ; preds = %false7
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 8, i32 104)
  %72 = call i8 @vm_getHasError(i8* %S)
  %73 = and i8 %72, 1
  %.not99 = icmp eq i8 %73, 0
  br i1 %.not99, label %false9, label %true3

false9:                                           ; preds = %false8
  %.not100 = icmp eq i32 %0, 0
  br i1 %.not100, label %false11, label %true10

true10:                                           ; preds = %false9
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 9, i32 104)
  %74 = call i8 @vm_getHasError(i8* %S)
  %75 = and i8 %74, 1
  %.not102 = icmp eq i8 %75, 0
  br i1 %.not102, label %false12, label %true3

false11:                                          ; preds = %false16, %false9
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 104)
  %76 = call i8 @vm_getHasError(i8* %S)
  br label %true3

false12:                                          ; preds = %true10
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 10, i32 104)
  %77 = call i8 @vm_getHasError(i8* %S)
  %78 = and i8 %77, 1
  %.not103 = icmp eq i8 %78, 0
  br i1 %.not103, label %false13, label %true3

false13:                                          ; preds = %false12
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 11, i32 104)
  %79 = call i8 @vm_getHasError(i8* %S)
  %80 = and i8 %79, 1
  %.not104 = icmp eq i8 %80, 0
  br i1 %.not104, label %false14, label %true3

false14:                                          ; preds = %false13
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 12, i32 104)
  %81 = call i8 @vm_getHasError(i8* %S)
  %82 = and i8 %81, 1
  %.not105 = icmp eq i8 %82, 0
  br i1 %.not105, label %false15, label %true3

false15:                                          ; preds = %false14
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 13, i32 104)
  %83 = call i8 @vm_getHasError(i8* %S)
  %84 = and i8 %83, 1
  %.not106 = icmp eq i8 %84, 0
  br i1 %.not106, label %false16, label %true3

false16:                                          ; preds = %false15
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 14, i32 104)
  %85 = call i8 @vm_getHasError(i8* %S)
  %86 = and i8 %85, 1
  %.not107 = icmp eq i8 %86, 0
  br i1 %.not107, label %false11, label %true3

merge:                                            ; preds = %false2, %false
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 1, i32 1, i32 104)
  %87 = call i8 @vm_getHasError(i8* %S)
  %88 = and i8 %87, 1
  %.not94 = icmp eq i8 %88, 0
  br i1 %.not94, label %false4, label %true3
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
  %6 = getelementptr inbounds i8, i8* %3, i64 136
  %7 = bitcast i8* %6 to double*
  %_rtP__Constant_Value_el = load double, double* %7, align 1
  %8 = getelementptr inbounds i8, i8* %4, i64 48
  %9 = bitcast i8* %8 to double*
  store double %_rtP__Constant_Value_el, double* %9, align 1
  %10 = getelementptr inbounds i8, i8* %3, i64 144
  %11 = bitcast i8* %10 to double*
  %_rtP__Constant_Value_el11 = load double, double* %11, align 1
  %12 = getelementptr inbounds i8, i8* %4, i64 56
  %13 = bitcast i8* %12 to double*
  store double %_rtP__Constant_Value_el11, double* %13, align 1
  %14 = getelementptr inbounds i8, i8* %3, i64 152
  %15 = bitcast i8* %14 to double*
  %_rtP__Constant_Value_el14 = load double, double* %15, align 1
  %16 = getelementptr inbounds i8, i8* %4, i64 64
  %17 = bitcast i8* %16 to double*
  store double %_rtP__Constant_Value_el14, double* %17, align 1
  %18 = getelementptr inbounds i8, i8* %3, i64 160
  %19 = bitcast i8* %18 to double*
  %_rtP__Constant_Value_el17 = load double, double* %19, align 1
  %20 = getelementptr inbounds i8, i8* %4, i64 72
  %21 = bitcast i8* %20 to double*
  store double %_rtP__Constant_Value_el17, double* %21, align 1
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
  %29 = getelementptr inbounds i8, i8* %1, i64 52
  %30 = bitcast i8* %29 to i32*
  store i32 1, i32* %30, align 1
  call void @vm_ssCallAccelRunBlock(i8* %S, i32 0, i32 0, i32 102)
  %31 = call i8 @vm_getHasError(i8* %S)
  ret void
}

declare zeroext i8 @vm_ssIsFirstInitCond(i8*)

