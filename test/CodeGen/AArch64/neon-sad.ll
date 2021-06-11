; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple aarch64-none-linux-gnu < %s | FileCheck %s

declare <16 x i32> @llvm.abs.v16i32(<16 x i32>, i1 immarg)
declare i32 @llvm.vector.reduce.add.v16i32(<16 x i32>)

define i32 @test_sad_v16i8_zext(i8* nocapture readonly %a, i8* nocapture readonly %b) {
; CHECK-LABEL: test_sad_v16i8_zext:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    uabd v0.16b, v1.16b, v0.16b
; CHECK-NEXT:    ushll2 v1.8h, v0.16b, #0
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    uaddl2 v2.4s, v0.8h, v1.8h
; CHECK-NEXT:    uaddl v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a to <16 x i8>*
  %1 = load <16 x i8>, <16 x i8>* %0
  %2 = zext <16 x i8> %1 to <16 x i32>
  %3 = bitcast i8* %b to <16 x i8>*
  %4 = load <16 x i8>, <16 x i8>* %3
  %5 = zext <16 x i8> %4 to <16 x i32>
  %6 = sub nsw <16 x i32> %5, %2
  %7 = call <16 x i32> @llvm.abs.v16i32(<16 x i32> %6, i1 true)
  %8 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %7)
  ret i32 %8
}

define i32 @test_sad_v16i8_sext(i8* nocapture readonly %a, i8* nocapture readonly %b) {
; CHECK-LABEL: test_sad_v16i8_sext:
; CHECK:       // %bb.0: // %entry
; CHECK-NEXT:    ldr q0, [x0]
; CHECK-NEXT:    ldr q1, [x1]
; CHECK-NEXT:    sabd v0.16b, v1.16b, v0.16b
; CHECK-NEXT:    ushll2 v1.8h, v0.16b, #0
; CHECK-NEXT:    ushll v0.8h, v0.8b, #0
; CHECK-NEXT:    uaddl2 v2.4s, v0.8h, v1.8h
; CHECK-NEXT:    uaddl v0.4s, v0.4h, v1.4h
; CHECK-NEXT:    add v0.4s, v0.4s, v2.4s
; CHECK-NEXT:    addv s0, v0.4s
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
entry:
  %0 = bitcast i8* %a to <16 x i8>*
  %1 = load <16 x i8>, <16 x i8>* %0
  %2 = sext <16 x i8> %1 to <16 x i32>
  %3 = bitcast i8* %b to <16 x i8>*
  %4 = load <16 x i8>, <16 x i8>* %3
  %5 = sext <16 x i8> %4 to <16 x i32>
  %6 = sub nsw <16 x i32> %5, %2
  %7 = call <16 x i32> @llvm.abs.v16i32(<16 x i32> %6, i1 true)
  %8 = call i32 @llvm.vector.reduce.add.v16i32(<16 x i32> %7)
  ret i32 %8
}
