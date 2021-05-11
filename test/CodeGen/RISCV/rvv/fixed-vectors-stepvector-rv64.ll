; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=2 < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX2

declare <2 x i8> @llvm.experimental.stepvector.v2i8()

define <2 x i8> @stepvector_v2i8() {
; CHECK-LABEL: stepvector_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e8,mf8,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i8> @llvm.experimental.stepvector.v2i8()
  ret <2 x i8> %v
}

declare <4 x i8> @llvm.experimental.stepvector.v4i8()

define <4 x i8> @stepvector_v4i8() {
; CHECK-LABEL: stepvector_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <4 x i8> @llvm.experimental.stepvector.v4i8()
  ret <4 x i8> %v
}

declare <8 x i8> @llvm.experimental.stepvector.v8i8()

define <8 x i8> @stepvector_v8i8() {
; CHECK-LABEL: stepvector_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <8 x i8> @llvm.experimental.stepvector.v8i8()
  ret <8 x i8> %v
}

declare <16 x i8> @llvm.experimental.stepvector.v16i8()

define <16 x i8> @stepvector_v16i8() {
; CHECK-LABEL: stepvector_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <16 x i8> @llvm.experimental.stepvector.v16i8()
  ret <16 x i8> %v
}

declare <2 x i16> @llvm.experimental.stepvector.v2i16()

define <2 x i16> @stepvector_v2i16() {
; CHECK-LABEL: stepvector_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e16,mf4,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i16> @llvm.experimental.stepvector.v2i16()
  ret <2 x i16> %v
}

declare <4 x i16> @llvm.experimental.stepvector.v4i16()

define <4 x i16> @stepvector_v4i16() {
; CHECK-LABEL: stepvector_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e16,mf2,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <4 x i16> @llvm.experimental.stepvector.v4i16()
  ret <4 x i16> %v
}

declare <8 x i16> @llvm.experimental.stepvector.v8i16()

define <8 x i16> @stepvector_v8i16() {
; CHECK-LABEL: stepvector_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e16,m1,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <8 x i16> @llvm.experimental.stepvector.v8i16()
  ret <8 x i16> %v
}

declare <16 x i16> @llvm.experimental.stepvector.v16i16()

define <16 x i16> @stepvector_v16i16() {
; LMULMAX1-LABEL: stepvector_v16i16:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    lui a0, %hi(.LCPI7_0)
; LMULMAX1-NEXT:    addi a0, a0, %lo(.LCPI7_0)
; LMULMAX1-NEXT:    vsetivli a1, 8, e16,m1,ta,mu
; LMULMAX1-NEXT:    vle16.v v9, (a0)
; LMULMAX1-NEXT:    vid.v v8
; LMULMAX1-NEXT:    ret
;
; LMULMAX2-LABEL: stepvector_v16i16:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli a0, 16, e16,m2,ta,mu
; LMULMAX2-NEXT:    vid.v v8
; LMULMAX2-NEXT:    ret
  %v = call <16 x i16> @llvm.experimental.stepvector.v16i16()
  ret <16 x i16> %v
}

declare <2 x i32> @llvm.experimental.stepvector.v2i32()

define <2 x i32> @stepvector_v2i32() {
; CHECK-LABEL: stepvector_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e32,mf2,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i32> @llvm.experimental.stepvector.v2i32()
  ret <2 x i32> %v
}

declare <4 x i32> @llvm.experimental.stepvector.v4i32()

define <4 x i32> @stepvector_v4i32() {
; CHECK-LABEL: stepvector_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e32,m1,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <4 x i32> @llvm.experimental.stepvector.v4i32()
  ret <4 x i32> %v
}

declare <8 x i32> @llvm.experimental.stepvector.v8i32()

define <8 x i32> @stepvector_v8i32() {
; LMULMAX1-LABEL: stepvector_v8i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    lui a0, %hi(.LCPI10_0)
; LMULMAX1-NEXT:    addi a0, a0, %lo(.LCPI10_0)
; LMULMAX1-NEXT:    vsetivli a1, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vle32.v v9, (a0)
; LMULMAX1-NEXT:    vid.v v8
; LMULMAX1-NEXT:    ret
;
; LMULMAX2-LABEL: stepvector_v8i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; LMULMAX2-NEXT:    vid.v v8
; LMULMAX2-NEXT:    ret
  %v = call <8 x i32> @llvm.experimental.stepvector.v8i32()
  ret <8 x i32> %v
}

declare <16 x i32> @llvm.experimental.stepvector.v16i32()

define <16 x i32> @stepvector_v16i32() {
; LMULMAX1-LABEL: stepvector_v16i32:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    lui a0, %hi(.LCPI11_0)
; LMULMAX1-NEXT:    addi a0, a0, %lo(.LCPI11_0)
; LMULMAX1-NEXT:    vsetivli a1, 4, e32,m1,ta,mu
; LMULMAX1-NEXT:    vle32.v v9, (a0)
; LMULMAX1-NEXT:    lui a0, %hi(.LCPI11_1)
; LMULMAX1-NEXT:    addi a0, a0, %lo(.LCPI11_1)
; LMULMAX1-NEXT:    vle32.v v10, (a0)
; LMULMAX1-NEXT:    lui a0, %hi(.LCPI11_2)
; LMULMAX1-NEXT:    addi a0, a0, %lo(.LCPI11_2)
; LMULMAX1-NEXT:    vle32.v v11, (a0)
; LMULMAX1-NEXT:    vid.v v8
; LMULMAX1-NEXT:    ret
;
; LMULMAX2-LABEL: stepvector_v16i32:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    lui a0, %hi(.LCPI11_0)
; LMULMAX2-NEXT:    addi a0, a0, %lo(.LCPI11_0)
; LMULMAX2-NEXT:    vsetivli a1, 8, e32,m2,ta,mu
; LMULMAX2-NEXT:    vle32.v v10, (a0)
; LMULMAX2-NEXT:    vid.v v8
; LMULMAX2-NEXT:    ret
  %v = call <16 x i32> @llvm.experimental.stepvector.v16i32()
  ret <16 x i32> %v
}

declare <2 x i64> @llvm.experimental.stepvector.v2i64()

define <2 x i64> @stepvector_v2i64() {
; CHECK-LABEL: stepvector_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; CHECK-NEXT:    vid.v v8
; CHECK-NEXT:    ret
  %v = call <2 x i64> @llvm.experimental.stepvector.v2i64()
  ret <2 x i64> %v
}

declare <4 x i64> @llvm.experimental.stepvector.v4i64()

define <4 x i64> @stepvector_v4i64() {
; LMULMAX1-LABEL: stepvector_v4i64:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; LMULMAX1-NEXT:    vmv.v.i v9, 3
; LMULMAX1-NEXT:    addi a0, zero, 2
; LMULMAX1-NEXT:    vmv.s.x v9, a0
; LMULMAX1-NEXT:    vid.v v8
; LMULMAX1-NEXT:    ret
;
; LMULMAX2-LABEL: stepvector_v4i64:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; LMULMAX2-NEXT:    vid.v v8
; LMULMAX2-NEXT:    ret
  %v = call <4 x i64> @llvm.experimental.stepvector.v4i64()
  ret <4 x i64> %v
}

declare <8 x i64> @llvm.experimental.stepvector.v8i64()

define <8 x i64> @stepvector_v8i64() {
; LMULMAX1-LABEL: stepvector_v8i64:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; LMULMAX1-NEXT:    vmv.v.i v9, 3
; LMULMAX1-NEXT:    addi a0, zero, 2
; LMULMAX1-NEXT:    vmv.s.x v9, a0
; LMULMAX1-NEXT:    vmv.v.i v10, 5
; LMULMAX1-NEXT:    addi a0, zero, 4
; LMULMAX1-NEXT:    vmv.s.x v10, a0
; LMULMAX1-NEXT:    vmv.v.i v11, 7
; LMULMAX1-NEXT:    addi a0, zero, 6
; LMULMAX1-NEXT:    vmv.s.x v11, a0
; LMULMAX1-NEXT:    vid.v v8
; LMULMAX1-NEXT:    ret
;
; LMULMAX2-LABEL: stepvector_v8i64:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    lui a0, %hi(.LCPI14_0)
; LMULMAX2-NEXT:    addi a0, a0, %lo(.LCPI14_0)
; LMULMAX2-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; LMULMAX2-NEXT:    vle64.v v10, (a0)
; LMULMAX2-NEXT:    vid.v v8
; LMULMAX2-NEXT:    ret
  %v = call <8 x i64> @llvm.experimental.stepvector.v8i64()
  ret <8 x i64> %v
}

declare <16 x i64> @llvm.experimental.stepvector.v16i64()

define <16 x i64> @stepvector_v16i64() {
; LMULMAX1-LABEL: stepvector_v16i64:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a0, 2, e64,m1,ta,mu
; LMULMAX1-NEXT:    vmv.v.i v9, 3
; LMULMAX1-NEXT:    addi a0, zero, 2
; LMULMAX1-NEXT:    vmv.s.x v9, a0
; LMULMAX1-NEXT:    vmv.v.i v10, 5
; LMULMAX1-NEXT:    addi a0, zero, 4
; LMULMAX1-NEXT:    vmv.s.x v10, a0
; LMULMAX1-NEXT:    vmv.v.i v11, 7
; LMULMAX1-NEXT:    addi a0, zero, 6
; LMULMAX1-NEXT:    vmv.s.x v11, a0
; LMULMAX1-NEXT:    vmv.v.i v12, 9
; LMULMAX1-NEXT:    addi a0, zero, 8
; LMULMAX1-NEXT:    vmv.s.x v12, a0
; LMULMAX1-NEXT:    vmv.v.i v13, 11
; LMULMAX1-NEXT:    addi a0, zero, 10
; LMULMAX1-NEXT:    vmv.s.x v13, a0
; LMULMAX1-NEXT:    vmv.v.i v14, 13
; LMULMAX1-NEXT:    addi a0, zero, 12
; LMULMAX1-NEXT:    vmv.s.x v14, a0
; LMULMAX1-NEXT:    vmv.v.i v15, 15
; LMULMAX1-NEXT:    addi a0, zero, 14
; LMULMAX1-NEXT:    vmv.s.x v15, a0
; LMULMAX1-NEXT:    vid.v v8
; LMULMAX1-NEXT:    ret
;
; LMULMAX2-LABEL: stepvector_v16i64:
; LMULMAX2:       # %bb.0:
; LMULMAX2-NEXT:    lui a0, %hi(.LCPI15_0)
; LMULMAX2-NEXT:    addi a0, a0, %lo(.LCPI15_0)
; LMULMAX2-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; LMULMAX2-NEXT:    vle64.v v10, (a0)
; LMULMAX2-NEXT:    lui a0, %hi(.LCPI15_1)
; LMULMAX2-NEXT:    addi a0, a0, %lo(.LCPI15_1)
; LMULMAX2-NEXT:    vle64.v v12, (a0)
; LMULMAX2-NEXT:    lui a0, %hi(.LCPI15_2)
; LMULMAX2-NEXT:    addi a0, a0, %lo(.LCPI15_2)
; LMULMAX2-NEXT:    vle64.v v14, (a0)
; LMULMAX2-NEXT:    vid.v v8
; LMULMAX2-NEXT:    ret
  %v = call <16 x i64> @llvm.experimental.stepvector.v16i64()
  ret <16 x i64> %v
}
