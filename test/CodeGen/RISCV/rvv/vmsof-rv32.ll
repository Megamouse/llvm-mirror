; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs \
; RUN:   < %s | FileCheck %s
declare <vscale x 1 x i1> @llvm.riscv.vmsof.nxv1i1(
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i1> @intrinsic_vmsof_m_nxv1i1(<vscale x 1 x i1> %0, i32 %1) nounwind {
; CHECK-LABEL: intrinsic_vmsof_m_nxv1i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,mf8,ta,mu
; CHECK-NEXT:    vmsof.m v25, v0
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i1> @llvm.riscv.vmsof.nxv1i1(
    <vscale x 1 x i1> %0,
    i32 %1)
  ret <vscale x 1 x i1> %a
}

declare <vscale x 1 x i1> @llvm.riscv.vmsof.mask.nxv1i1(
  <vscale x 1 x i1>,
  <vscale x 1 x i1>,
  <vscale x 1 x i1>,
  i32);

define <vscale x 1 x i1> @intrinsic_vmsof_mask_m_nxv1i1_nxv1i1(<vscale x 1 x i1> %0, <vscale x 1 x i1> %1, <vscale x 1 x i1> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vmsof_mask_m_nxv1i1_nxv1i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmv1r.v v25, v0
; CHECK-NEXT:    vsetvli a0, a0, e8,mf8,tu,mu
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vmsof.m v25, v8, v0.t
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 1 x i1> @llvm.riscv.vmsof.mask.nxv1i1(
    <vscale x 1 x i1> %0,
    <vscale x 1 x i1> %1,
    <vscale x 1 x i1> %2,
    i32 %3)
  ret <vscale x 1 x i1> %a
}

declare <vscale x 2 x i1> @llvm.riscv.vmsof.nxv2i1(
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i1> @intrinsic_vmsof_m_nxv2i1(<vscale x 2 x i1> %0, i32 %1) nounwind {
; CHECK-LABEL: intrinsic_vmsof_m_nxv2i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,mf4,ta,mu
; CHECK-NEXT:    vmsof.m v25, v0
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i1> @llvm.riscv.vmsof.nxv2i1(
    <vscale x 2 x i1> %0,
    i32 %1)
  ret <vscale x 2 x i1> %a
}

declare <vscale x 2 x i1> @llvm.riscv.vmsof.mask.nxv2i1(
  <vscale x 2 x i1>,
  <vscale x 2 x i1>,
  <vscale x 2 x i1>,
  i32);

define <vscale x 2 x i1> @intrinsic_vmsof_mask_m_nxv2i1_nxv2i1(<vscale x 2 x i1> %0, <vscale x 2 x i1> %1, <vscale x 2 x i1> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vmsof_mask_m_nxv2i1_nxv2i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmv1r.v v25, v0
; CHECK-NEXT:    vsetvli a0, a0, e8,mf4,tu,mu
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vmsof.m v25, v8, v0.t
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 2 x i1> @llvm.riscv.vmsof.mask.nxv2i1(
    <vscale x 2 x i1> %0,
    <vscale x 2 x i1> %1,
    <vscale x 2 x i1> %2,
    i32 %3)
  ret <vscale x 2 x i1> %a
}

declare <vscale x 4 x i1> @llvm.riscv.vmsof.nxv4i1(
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i1> @intrinsic_vmsof_m_nxv4i1(<vscale x 4 x i1> %0, i32 %1) nounwind {
; CHECK-LABEL: intrinsic_vmsof_m_nxv4i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,mf2,ta,mu
; CHECK-NEXT:    vmsof.m v25, v0
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i1> @llvm.riscv.vmsof.nxv4i1(
    <vscale x 4 x i1> %0,
    i32 %1)
  ret <vscale x 4 x i1> %a
}

declare <vscale x 4 x i1> @llvm.riscv.vmsof.mask.nxv4i1(
  <vscale x 4 x i1>,
  <vscale x 4 x i1>,
  <vscale x 4 x i1>,
  i32);

define <vscale x 4 x i1> @intrinsic_vmsof_mask_m_nxv4i1_nxv4i1(<vscale x 4 x i1> %0, <vscale x 4 x i1> %1, <vscale x 4 x i1> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vmsof_mask_m_nxv4i1_nxv4i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmv1r.v v25, v0
; CHECK-NEXT:    vsetvli a0, a0, e8,mf2,tu,mu
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vmsof.m v25, v8, v0.t
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 4 x i1> @llvm.riscv.vmsof.mask.nxv4i1(
    <vscale x 4 x i1> %0,
    <vscale x 4 x i1> %1,
    <vscale x 4 x i1> %2,
    i32 %3)
  ret <vscale x 4 x i1> %a
}

declare <vscale x 8 x i1> @llvm.riscv.vmsof.nxv8i1(
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i1> @intrinsic_vmsof_m_nxv8i1(<vscale x 8 x i1> %0, i32 %1) nounwind {
; CHECK-LABEL: intrinsic_vmsof_m_nxv8i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,m1,ta,mu
; CHECK-NEXT:    vmsof.m v25, v0
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i1> @llvm.riscv.vmsof.nxv8i1(
    <vscale x 8 x i1> %0,
    i32 %1)
  ret <vscale x 8 x i1> %a
}

declare <vscale x 8 x i1> @llvm.riscv.vmsof.mask.nxv8i1(
  <vscale x 8 x i1>,
  <vscale x 8 x i1>,
  <vscale x 8 x i1>,
  i32);

define <vscale x 8 x i1> @intrinsic_vmsof_mask_m_nxv8i1_nxv8i1(<vscale x 8 x i1> %0, <vscale x 8 x i1> %1, <vscale x 8 x i1> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vmsof_mask_m_nxv8i1_nxv8i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmv1r.v v25, v0
; CHECK-NEXT:    vsetvli a0, a0, e8,m1,tu,mu
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vmsof.m v25, v8, v0.t
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 8 x i1> @llvm.riscv.vmsof.mask.nxv8i1(
    <vscale x 8 x i1> %0,
    <vscale x 8 x i1> %1,
    <vscale x 8 x i1> %2,
    i32 %3)
  ret <vscale x 8 x i1> %a
}

declare <vscale x 16 x i1> @llvm.riscv.vmsof.nxv16i1(
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i1> @intrinsic_vmsof_m_nxv16i1(<vscale x 16 x i1> %0, i32 %1) nounwind {
; CHECK-LABEL: intrinsic_vmsof_m_nxv16i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,m2,ta,mu
; CHECK-NEXT:    vmsof.m v25, v0
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i1> @llvm.riscv.vmsof.nxv16i1(
    <vscale x 16 x i1> %0,
    i32 %1)
  ret <vscale x 16 x i1> %a
}

declare <vscale x 16 x i1> @llvm.riscv.vmsof.mask.nxv16i1(
  <vscale x 16 x i1>,
  <vscale x 16 x i1>,
  <vscale x 16 x i1>,
  i32);

define <vscale x 16 x i1> @intrinsic_vmsof_mask_m_nxv16i1_nxv16i1(<vscale x 16 x i1> %0, <vscale x 16 x i1> %1, <vscale x 16 x i1> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vmsof_mask_m_nxv16i1_nxv16i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmv1r.v v25, v0
; CHECK-NEXT:    vsetvli a0, a0, e8,m2,tu,mu
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vmsof.m v25, v8, v0.t
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 16 x i1> @llvm.riscv.vmsof.mask.nxv16i1(
    <vscale x 16 x i1> %0,
    <vscale x 16 x i1> %1,
    <vscale x 16 x i1> %2,
    i32 %3)
  ret <vscale x 16 x i1> %a
}

declare <vscale x 32 x i1> @llvm.riscv.vmsof.nxv32i1(
  <vscale x 32 x i1>,
  i32);

define <vscale x 32 x i1> @intrinsic_vmsof_m_nxv32i1(<vscale x 32 x i1> %0, i32 %1) nounwind {
; CHECK-LABEL: intrinsic_vmsof_m_nxv32i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,m4,ta,mu
; CHECK-NEXT:    vmsof.m v25, v0
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i1> @llvm.riscv.vmsof.nxv32i1(
    <vscale x 32 x i1> %0,
    i32 %1)
  ret <vscale x 32 x i1> %a
}

declare <vscale x 32 x i1> @llvm.riscv.vmsof.mask.nxv32i1(
  <vscale x 32 x i1>,
  <vscale x 32 x i1>,
  <vscale x 32 x i1>,
  i32);

define <vscale x 32 x i1> @intrinsic_vmsof_mask_m_nxv32i1_nxv32i1(<vscale x 32 x i1> %0, <vscale x 32 x i1> %1, <vscale x 32 x i1> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vmsof_mask_m_nxv32i1_nxv32i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmv1r.v v25, v0
; CHECK-NEXT:    vsetvli a0, a0, e8,m4,tu,mu
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vmsof.m v25, v8, v0.t
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 32 x i1> @llvm.riscv.vmsof.mask.nxv32i1(
    <vscale x 32 x i1> %0,
    <vscale x 32 x i1> %1,
    <vscale x 32 x i1> %2,
    i32 %3)
  ret <vscale x 32 x i1> %a
}

declare <vscale x 64 x i1> @llvm.riscv.vmsof.nxv64i1(
  <vscale x 64 x i1>,
  i32);

define <vscale x 64 x i1> @intrinsic_vmsof_m_nxv64i1(<vscale x 64 x i1> %0, i32 %1) nounwind {
; CHECK-LABEL: intrinsic_vmsof_m_nxv64i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsetvli a0, a0, e8,m8,ta,mu
; CHECK-NEXT:    vmsof.m v25, v0
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 64 x i1> @llvm.riscv.vmsof.nxv64i1(
    <vscale x 64 x i1> %0,
    i32 %1)
  ret <vscale x 64 x i1> %a
}

declare <vscale x 64 x i1> @llvm.riscv.vmsof.mask.nxv64i1(
  <vscale x 64 x i1>,
  <vscale x 64 x i1>,
  <vscale x 64 x i1>,
  i32);

define <vscale x 64 x i1> @intrinsic_vmsof_mask_m_nxv64i1_nxv64i1(<vscale x 64 x i1> %0, <vscale x 64 x i1> %1, <vscale x 64 x i1> %2, i32 %3) nounwind {
; CHECK-LABEL: intrinsic_vmsof_mask_m_nxv64i1_nxv64i1:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vmv1r.v v25, v0
; CHECK-NEXT:    vsetvli a0, a0, e8,m8,tu,mu
; CHECK-NEXT:    vmv1r.v v0, v9
; CHECK-NEXT:    vmsof.m v25, v8, v0.t
; CHECK-NEXT:    vmv1r.v v0, v25
; CHECK-NEXT:    ret
entry:
  %a = call <vscale x 64 x i1> @llvm.riscv.vmsof.mask.nxv64i1(
    <vscale x 64 x i1> %0,
    <vscale x 64 x i1> %1,
    <vscale x 64 x i1> %2,
    i32 %3)
  ret <vscale x 64 x i1> %a
}
