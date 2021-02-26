; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -instcombine -S | FileCheck %s

define float @reduction_logical_or(<4 x float> %x) {
; CHECK-LABEL: @reduction_logical_or(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp ogt <4 x float> [[X:%.*]], <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
; CHECK-NEXT:    [[TMP2:%.*]] = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TMP2]], float -1.000000e+00, float 1.000000e+00
; CHECK-NEXT:    ret float [[R]]
;
  %1 = fcmp ogt <4 x float> %x, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %2 = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> %1)
  %r = select i1 %2, float -1.000000e+00, float 1.000000e+00
  ret float %r
}

define float @reduction_logical_and(<4 x float> %x) {
; CHECK-LABEL: @reduction_logical_and(
; CHECK-NEXT:    [[TMP1:%.*]] = fcmp ogt <4 x float> [[X:%.*]], <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
; CHECK-NEXT:    [[TMP2:%.*]] = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> [[TMP1]])
; CHECK-NEXT:    [[R:%.*]] = select i1 [[TMP2]], float -1.000000e+00, float 1.000000e+00
; CHECK-NEXT:    ret float [[R]]
;
  %1 = fcmp ogt <4 x float> %x, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  %2 = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %1)
  %r = select i1 %2, float -1.000000e+00, float 1.000000e+00
  ret float %r
}

declare i1 @llvm.vector.reduce.or.v4i1(<4 x i1>)
declare i1 @llvm.vector.reduce.and.v4i1(<4 x i1>)
