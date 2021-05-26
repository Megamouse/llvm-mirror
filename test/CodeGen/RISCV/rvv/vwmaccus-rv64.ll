; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v,+d -verify-machineinstrs \
; RUN:   < %s | FileCheck %s
declare <vscale x 1 x i16> @llvm.riscv.vwmaccus.nxv1i16.i8(
  <vscale x 1 x i16>,
  i8,
  <vscale x 1 x i8>,
  i64);

define <vscale x 1 x i16>  @intrinsic_vwmaccus_vx_nxv1i16_i8_nxv1i8(<vscale x 1 x i16> %0, i8 %1, <vscale x 1 x i8> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv1i16_i8_nxv1i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf8,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vwmaccus.nxv1i16.i8(
    <vscale x 1 x i16> %0,
    i8 %1,
    <vscale x 1 x i8> %2,
    i64 %3)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 1 x i16> @llvm.riscv.vwmaccus.mask.nxv1i16.i8(
  <vscale x 1 x i16>,
  i8,
  <vscale x 1 x i8>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x i16> @intrinsic_vwmaccus_mask_vx_nxv1i16_i8_nxv1i8(<vscale x 1 x i16> %0, i8 %1, <vscale x 1 x i8> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv1i16_i8_nxv1i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf8,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i16> @llvm.riscv.vwmaccus.mask.nxv1i16.i8(
    <vscale x 1 x i16> %0,
    i8 %1,
    <vscale x 1 x i8> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vwmaccus.nxv2i16.i8(
  <vscale x 2 x i16>,
  i8,
  <vscale x 2 x i8>,
  i64);

define <vscale x 2 x i16>  @intrinsic_vwmaccus_vx_nxv2i16_i8_nxv2i8(<vscale x 2 x i16> %0, i8 %1, <vscale x 2 x i8> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv2i16_i8_nxv2i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vwmaccus.nxv2i16.i8(
    <vscale x 2 x i16> %0,
    i8 %1,
    <vscale x 2 x i8> %2,
    i64 %3)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 2 x i16> @llvm.riscv.vwmaccus.mask.nxv2i16.i8(
  <vscale x 2 x i16>,
  i8,
  <vscale x 2 x i8>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x i16> @intrinsic_vwmaccus_mask_vx_nxv2i16_i8_nxv2i8(<vscale x 2 x i16> %0, i8 %1, <vscale x 2 x i8> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv2i16_i8_nxv2i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i16> @llvm.riscv.vwmaccus.mask.nxv2i16.i8(
    <vscale x 2 x i16> %0,
    i8 %1,
    <vscale x 2 x i8> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vwmaccus.nxv4i16.i8(
  <vscale x 4 x i16>,
  i8,
  <vscale x 4 x i8>,
  i64);

define <vscale x 4 x i16>  @intrinsic_vwmaccus_vx_nxv4i16_i8_nxv4i8(<vscale x 4 x i16> %0, i8 %1, <vscale x 4 x i8> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv4i16_i8_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vwmaccus.nxv4i16.i8(
    <vscale x 4 x i16> %0,
    i8 %1,
    <vscale x 4 x i8> %2,
    i64 %3)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 4 x i16> @llvm.riscv.vwmaccus.mask.nxv4i16.i8(
  <vscale x 4 x i16>,
  i8,
  <vscale x 4 x i8>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x i16> @intrinsic_vwmaccus_mask_vx_nxv4i16_i8_nxv4i8(<vscale x 4 x i16> %0, i8 %1, <vscale x 4 x i8> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv4i16_i8_nxv4i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,mf2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i16> @llvm.riscv.vwmaccus.mask.nxv4i16.i8(
    <vscale x 4 x i16> %0,
    i8 %1,
    <vscale x 4 x i8> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vwmaccus.nxv8i16.i8(
  <vscale x 8 x i16>,
  i8,
  <vscale x 8 x i8>,
  i64);

define <vscale x 8 x i16>  @intrinsic_vwmaccus_vx_nxv8i16_i8_nxv8i8(<vscale x 8 x i16> %0, i8 %1, <vscale x 8 x i8> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv8i16_i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m1,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vwmaccus.nxv8i16.i8(
    <vscale x 8 x i16> %0,
    i8 %1,
    <vscale x 8 x i8> %2,
    i64 %3)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 8 x i16> @llvm.riscv.vwmaccus.mask.nxv8i16.i8(
  <vscale x 8 x i16>,
  i8,
  <vscale x 8 x i8>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x i16> @intrinsic_vwmaccus_mask_vx_nxv8i16_i8_nxv8i8(<vscale x 8 x i16> %0, i8 %1, <vscale x 8 x i8> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv8i16_i8_nxv8i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m1,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i16> @llvm.riscv.vwmaccus.mask.nxv8i16.i8(
    <vscale x 8 x i16> %0,
    i8 %1,
    <vscale x 8 x i8> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vwmaccus.nxv16i16.i8(
  <vscale x 16 x i16>,
  i8,
  <vscale x 16 x i8>,
  i64);

define <vscale x 16 x i16>  @intrinsic_vwmaccus_vx_nxv16i16_i8_nxv16i8(<vscale x 16 x i16> %0, i8 %1, <vscale x 16 x i8> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv16i16_i8_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vwmaccus.nxv16i16.i8(
    <vscale x 16 x i16> %0,
    i8 %1,
    <vscale x 16 x i8> %2,
    i64 %3)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 16 x i16> @llvm.riscv.vwmaccus.mask.nxv16i16.i8(
  <vscale x 16 x i16>,
  i8,
  <vscale x 16 x i8>,
  <vscale x 16 x i1>,
  i64);

define <vscale x 16 x i16> @intrinsic_vwmaccus_mask_vx_nxv16i16_i8_nxv16i8(<vscale x 16 x i16> %0, i8 %1, <vscale x 16 x i8> %2, <vscale x 16 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv16i16_i8_nxv16i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i16> @llvm.riscv.vwmaccus.mask.nxv16i16.i8(
    <vscale x 16 x i16> %0,
    i8 %1,
    <vscale x 16 x i8> %2,
    <vscale x 16 x i1> %3,
    i64 %4)

  ret <vscale x 16 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vwmaccus.nxv32i16.i8(
  <vscale x 32 x i16>,
  i8,
  <vscale x 32 x i8>,
  i64);

define <vscale x 32 x i16>  @intrinsic_vwmaccus_vx_nxv32i16_i8_nxv32i8(<vscale x 32 x i16> %0, i8 %1, <vscale x 32 x i8> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv32i16_i8_nxv32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vwmaccus.nxv32i16.i8(
    <vscale x 32 x i16> %0,
    i8 %1,
    <vscale x 32 x i8> %2,
    i64 %3)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 32 x i16> @llvm.riscv.vwmaccus.mask.nxv32i16.i8(
  <vscale x 32 x i16>,
  i8,
  <vscale x 32 x i8>,
  <vscale x 32 x i1>,
  i64);

define <vscale x 32 x i16> @intrinsic_vwmaccus_mask_vx_nxv32i16_i8_nxv32i8(<vscale x 32 x i16> %0, i8 %1, <vscale x 32 x i8> %2, <vscale x 32 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv32i16_i8_nxv32i8:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e8,m4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i16> @llvm.riscv.vwmaccus.mask.nxv32i16.i8(
    <vscale x 32 x i16> %0,
    i8 %1,
    <vscale x 32 x i8> %2,
    <vscale x 32 x i1> %3,
    i64 %4)

  ret <vscale x 32 x i16> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vwmaccus.nxv1i32.i16(
  <vscale x 1 x i32>,
  i16,
  <vscale x 1 x i16>,
  i64);

define <vscale x 1 x i32>  @intrinsic_vwmaccus_vx_nxv1i32_i16_nxv1i16(<vscale x 1 x i32> %0, i16 %1, <vscale x 1 x i16> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv1i32_i16_nxv1i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,mf4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vwmaccus.nxv1i32.i16(
    <vscale x 1 x i32> %0,
    i16 %1,
    <vscale x 1 x i16> %2,
    i64 %3)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 1 x i32> @llvm.riscv.vwmaccus.mask.nxv1i32.i16(
  <vscale x 1 x i32>,
  i16,
  <vscale x 1 x i16>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x i32> @intrinsic_vwmaccus_mask_vx_nxv1i32_i16_nxv1i16(<vscale x 1 x i32> %0, i16 %1, <vscale x 1 x i16> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv1i32_i16_nxv1i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,mf4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i32> @llvm.riscv.vwmaccus.mask.nxv1i32.i16(
    <vscale x 1 x i32> %0,
    i16 %1,
    <vscale x 1 x i16> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vwmaccus.nxv2i32.i16(
  <vscale x 2 x i32>,
  i16,
  <vscale x 2 x i16>,
  i64);

define <vscale x 2 x i32>  @intrinsic_vwmaccus_vx_nxv2i32_i16_nxv2i16(<vscale x 2 x i32> %0, i16 %1, <vscale x 2 x i16> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv2i32_i16_nxv2i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,mf2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vwmaccus.nxv2i32.i16(
    <vscale x 2 x i32> %0,
    i16 %1,
    <vscale x 2 x i16> %2,
    i64 %3)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 2 x i32> @llvm.riscv.vwmaccus.mask.nxv2i32.i16(
  <vscale x 2 x i32>,
  i16,
  <vscale x 2 x i16>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x i32> @intrinsic_vwmaccus_mask_vx_nxv2i32_i16_nxv2i16(<vscale x 2 x i32> %0, i16 %1, <vscale x 2 x i16> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv2i32_i16_nxv2i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,mf2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i32> @llvm.riscv.vwmaccus.mask.nxv2i32.i16(
    <vscale x 2 x i32> %0,
    i16 %1,
    <vscale x 2 x i16> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vwmaccus.nxv4i32.i16(
  <vscale x 4 x i32>,
  i16,
  <vscale x 4 x i16>,
  i64);

define <vscale x 4 x i32>  @intrinsic_vwmaccus_vx_nxv4i32_i16_nxv4i16(<vscale x 4 x i32> %0, i16 %1, <vscale x 4 x i16> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv4i32_i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m1,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vwmaccus.nxv4i32.i16(
    <vscale x 4 x i32> %0,
    i16 %1,
    <vscale x 4 x i16> %2,
    i64 %3)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 4 x i32> @llvm.riscv.vwmaccus.mask.nxv4i32.i16(
  <vscale x 4 x i32>,
  i16,
  <vscale x 4 x i16>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x i32> @intrinsic_vwmaccus_mask_vx_nxv4i32_i16_nxv4i16(<vscale x 4 x i32> %0, i16 %1, <vscale x 4 x i16> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv4i32_i16_nxv4i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m1,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i32> @llvm.riscv.vwmaccus.mask.nxv4i32.i16(
    <vscale x 4 x i32> %0,
    i16 %1,
    <vscale x 4 x i16> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vwmaccus.nxv8i32.i16(
  <vscale x 8 x i32>,
  i16,
  <vscale x 8 x i16>,
  i64);

define <vscale x 8 x i32>  @intrinsic_vwmaccus_vx_nxv8i32_i16_nxv8i16(<vscale x 8 x i32> %0, i16 %1, <vscale x 8 x i16> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv8i32_i16_nxv8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vwmaccus.nxv8i32.i16(
    <vscale x 8 x i32> %0,
    i16 %1,
    <vscale x 8 x i16> %2,
    i64 %3)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 8 x i32> @llvm.riscv.vwmaccus.mask.nxv8i32.i16(
  <vscale x 8 x i32>,
  i16,
  <vscale x 8 x i16>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x i32> @intrinsic_vwmaccus_mask_vx_nxv8i32_i16_nxv8i16(<vscale x 8 x i32> %0, i16 %1, <vscale x 8 x i16> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv8i32_i16_nxv8i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i32> @llvm.riscv.vwmaccus.mask.nxv8i32.i16(
    <vscale x 8 x i32> %0,
    i16 %1,
    <vscale x 8 x i16> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vwmaccus.nxv16i32.i16(
  <vscale x 16 x i32>,
  i16,
  <vscale x 16 x i16>,
  i64);

define <vscale x 16 x i32>  @intrinsic_vwmaccus_vx_nxv16i32_i16_nxv16i16(<vscale x 16 x i32> %0, i16 %1, <vscale x 16 x i16> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv16i32_i16_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vwmaccus.nxv16i32.i16(
    <vscale x 16 x i32> %0,
    i16 %1,
    <vscale x 16 x i16> %2,
    i64 %3)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 16 x i32> @llvm.riscv.vwmaccus.mask.nxv16i32.i16(
  <vscale x 16 x i32>,
  i16,
  <vscale x 16 x i16>,
  <vscale x 16 x i1>,
  i64);

define <vscale x 16 x i32> @intrinsic_vwmaccus_mask_vx_nxv16i32_i16_nxv16i16(<vscale x 16 x i32> %0, i16 %1, <vscale x 16 x i16> %2, <vscale x 16 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv16i32_i16_nxv16i16:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e16,m4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i32> @llvm.riscv.vwmaccus.mask.nxv16i32.i16(
    <vscale x 16 x i32> %0,
    i16 %1,
    <vscale x 16 x i16> %2,
    <vscale x 16 x i1> %3,
    i64 %4)

  ret <vscale x 16 x i32> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vwmaccus.nxv1i64.i32(
  <vscale x 1 x i64>,
  i32,
  <vscale x 1 x i32>,
  i64);

define <vscale x 1 x i64>  @intrinsic_vwmaccus_vx_nxv1i64_i32_nxv1i32(<vscale x 1 x i64> %0, i32 %1, <vscale x 1 x i32> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv1i64_i32_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vwmaccus.nxv1i64.i32(
    <vscale x 1 x i64> %0,
    i32 %1,
    <vscale x 1 x i32> %2,
    i64 %3)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 1 x i64> @llvm.riscv.vwmaccus.mask.nxv1i64.i32(
  <vscale x 1 x i64>,
  i32,
  <vscale x 1 x i32>,
  <vscale x 1 x i1>,
  i64);

define <vscale x 1 x i64> @intrinsic_vwmaccus_mask_vx_nxv1i64_i32_nxv1i32(<vscale x 1 x i64> %0, i32 %1, <vscale x 1 x i32> %2, <vscale x 1 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv1i64_i32_nxv1i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,mf2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v9, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i64> @llvm.riscv.vwmaccus.mask.nxv1i64.i32(
    <vscale x 1 x i64> %0,
    i32 %1,
    <vscale x 1 x i32> %2,
    <vscale x 1 x i1> %3,
    i64 %4)

  ret <vscale x 1 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vwmaccus.nxv2i64.i32(
  <vscale x 2 x i64>,
  i32,
  <vscale x 2 x i32>,
  i64);

define <vscale x 2 x i64>  @intrinsic_vwmaccus_vx_nxv2i64_i32_nxv2i32(<vscale x 2 x i64> %0, i32 %1, <vscale x 2 x i32> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv2i64_i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m1,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v10
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vwmaccus.nxv2i64.i32(
    <vscale x 2 x i64> %0,
    i32 %1,
    <vscale x 2 x i32> %2,
    i64 %3)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 2 x i64> @llvm.riscv.vwmaccus.mask.nxv2i64.i32(
  <vscale x 2 x i64>,
  i32,
  <vscale x 2 x i32>,
  <vscale x 2 x i1>,
  i64);

define <vscale x 2 x i64> @intrinsic_vwmaccus_mask_vx_nxv2i64_i32_nxv2i32(<vscale x 2 x i64> %0, i32 %1, <vscale x 2 x i32> %2, <vscale x 2 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv2i64_i32_nxv2i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m1,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v10, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i64> @llvm.riscv.vwmaccus.mask.nxv2i64.i32(
    <vscale x 2 x i64> %0,
    i32 %1,
    <vscale x 2 x i32> %2,
    <vscale x 2 x i1> %3,
    i64 %4)

  ret <vscale x 2 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vwmaccus.nxv4i64.i32(
  <vscale x 4 x i64>,
  i32,
  <vscale x 4 x i32>,
  i64);

define <vscale x 4 x i64>  @intrinsic_vwmaccus_vx_nxv4i64_i32_nxv4i32(<vscale x 4 x i64> %0, i32 %1, <vscale x 4 x i32> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv4i64_i32_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v12
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vwmaccus.nxv4i64.i32(
    <vscale x 4 x i64> %0,
    i32 %1,
    <vscale x 4 x i32> %2,
    i64 %3)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 4 x i64> @llvm.riscv.vwmaccus.mask.nxv4i64.i32(
  <vscale x 4 x i64>,
  i32,
  <vscale x 4 x i32>,
  <vscale x 4 x i1>,
  i64);

define <vscale x 4 x i64> @intrinsic_vwmaccus_mask_vx_nxv4i64_i32_nxv4i32(<vscale x 4 x i64> %0, i32 %1, <vscale x 4 x i32> %2, <vscale x 4 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv4i64_i32_nxv4i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m2,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v12, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i64> @llvm.riscv.vwmaccus.mask.nxv4i64.i32(
    <vscale x 4 x i64> %0,
    i32 %1,
    <vscale x 4 x i32> %2,
    <vscale x 4 x i1> %3,
    i64 %4)

  ret <vscale x 4 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vwmaccus.nxv8i64.i32(
  <vscale x 8 x i64>,
  i32,
  <vscale x 8 x i32>,
  i64);

define <vscale x 8 x i64>  @intrinsic_vwmaccus_vx_nxv8i64_i32_nxv8i32(<vscale x 8 x i64> %0, i32 %1, <vscale x 8 x i32> %2, i64 %3) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_vx_nxv8i64_i32_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v16
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vwmaccus.nxv8i64.i32(
    <vscale x 8 x i64> %0,
    i32 %1,
    <vscale x 8 x i32> %2,
    i64 %3)

  ret <vscale x 8 x i64> %a
}

declare <vscale x 8 x i64> @llvm.riscv.vwmaccus.mask.nxv8i64.i32(
  <vscale x 8 x i64>,
  i32,
  <vscale x 8 x i32>,
  <vscale x 8 x i1>,
  i64);

define <vscale x 8 x i64> @intrinsic_vwmaccus_mask_vx_nxv8i64_i32_nxv8i32(<vscale x 8 x i64> %0, i32 %1, <vscale x 8 x i32> %2, <vscale x 8 x i1> %3, i64 %4) nounwind {
; CHECK-LABEL: intrinsic_vwmaccus_mask_vx_nxv8i64_i32_nxv8i32:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a1, a1, e32,m4,tu,mu
; CHECK-NEXT:    vwmaccus.vx v8, a0, v16, v0.t
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i64> @llvm.riscv.vwmaccus.mask.nxv8i64.i32(
    <vscale x 8 x i64> %0,
    i32 %1,
    <vscale x 8 x i32> %2,
    <vscale x 8 x i1> %3,
    i64 %4)

  ret <vscale x 8 x i64> %a
}
