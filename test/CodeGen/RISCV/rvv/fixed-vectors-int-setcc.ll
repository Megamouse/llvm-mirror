; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK
; RUN: llc -mtriple=riscv64 -mattr=+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s | FileCheck %s --check-prefixes=CHECK

; FIXME: We use exclusively byte types here because the MVT we use for the
; stores is calculated assuming byte elements. We need to deal with mismatched
; subvector "casts" to make other elements work.

define void @seteq_vv_v16i8(<16 x i8>* %x, <16 x i8>* %y) {
; CHECK-LABEL: seteq_vv_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vle8.v v26, (a1)
; CHECK-NEXT:    vmseq.vv v0, v25, v26
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, -1, v0
; CHECK-NEXT:    vse8.v v25, (a0)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = load <16 x i8>, <16 x i8>* %y
  %c = icmp eq <16 x i8> %a, %b
  %d = sext <16 x i1> %c to <16 x i8>
  store <16 x i8> %d, <16 x i8>* %x
  ret void
}

define void @setne_vv_v32i8(<32 x i8>* %x, <32 x i8>* %y) {
; CHECK-LABEL: setne_vv_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, 32
; CHECK-NEXT:    vsetvli a2, a2, e8,m2,ta,mu
; CHECK-NEXT:    vle8.v v26, (a0)
; CHECK-NEXT:    vle8.v v28, (a1)
; CHECK-NEXT:    vmsne.vv v0, v26, v28
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v26, v26, 1, v0
; CHECK-NEXT:    vse8.v v26, (a0)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = load <32 x i8>, <32 x i8>* %y
  %c = icmp ne <32 x i8> %a, %b
  %d = zext <32 x i1> %c to <32 x i8>
  store <32 x i8> %d, <32 x i8>* %x
  ret void
}

define void @setgt_vv_v64i8(<64 x i8>* %x, <64 x i8>* %y, <64 x i1>* %z) {
; CHECK-LABEL: setgt_vv_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 64
; CHECK-NEXT:    vsetvli a3, a3, e8,m4,ta,mu
; CHECK-NEXT:    vle8.v v28, (a0)
; CHECK-NEXT:    vle8.v v8, (a1)
; CHECK-NEXT:    vmslt.vv v25, v8, v28
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, <64 x i8>* %x
  %b = load <64 x i8>, <64 x i8>* %y
  %c = icmp sgt <64 x i8> %a, %b
  store <64 x i1> %c, <64 x i1>* %z
  ret void
}

define void @setlt_vv_v128i8(<128 x i8>* %x, <128 x i8>* %y, <128 x i1>* %z) {
; CHECK-LABEL: setlt_vv_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 128
; CHECK-NEXT:    vsetvli a3, a3, e8,m8,ta,mu
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v16, (a1)
; CHECK-NEXT:    vmslt.vv v25, v8, v16
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, <128 x i8>* %x
  %b = load <128 x i8>, <128 x i8>* %y
  %c = icmp slt <128 x i8> %a, %b
  store <128 x i1> %c, <128 x i1>* %z
  ret void
}

define void @setge_vv_v8i8(<8 x i8>* %x, <8 x i8>* %y, <8 x i1>* %z) {
; CHECK-LABEL: setge_vv_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vle8.v v26, (a1)
; CHECK-NEXT:    vmsle.vv v27, v26, v25
; CHECK-NEXT:    vse1.v v27, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = load <8 x i8>, <8 x i8>* %y
  %c = icmp sge <8 x i8> %a, %b
  store <8 x i1> %c, <8 x i1>* %z
  ret void
}

define void @setle_vv_v16i8(<16 x i8>* %x, <16 x i8>* %y, <16 x i1>* %z) {
; CHECK-LABEL: setle_vv_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vle8.v v26, (a1)
; CHECK-NEXT:    vmsle.vv v27, v25, v26
; CHECK-NEXT:    vse1.v v27, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = load <16 x i8>, <16 x i8>* %y
  %c = icmp sle <16 x i8> %a, %b
  store <16 x i1> %c, <16 x i1>* %z
  ret void
}

define void @setugt_vv_v32i8(<32 x i8>* %x, <32 x i8>* %y, <32 x i1>* %z) {
; CHECK-LABEL: setugt_vv_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 32
; CHECK-NEXT:    vsetvli a3, a3, e8,m2,ta,mu
; CHECK-NEXT:    vle8.v v26, (a0)
; CHECK-NEXT:    vle8.v v28, (a1)
; CHECK-NEXT:    vmsltu.vv v25, v28, v26
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = load <32 x i8>, <32 x i8>* %y
  %c = icmp ugt <32 x i8> %a, %b
  store <32 x i1> %c, <32 x i1>* %z
  ret void
}

define void @setult_vv_v64i8(<64 x i8>* %x, <64 x i8>* %y, <64 x i1>* %z) {
; CHECK-LABEL: setult_vv_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 64
; CHECK-NEXT:    vsetvli a3, a3, e8,m4,ta,mu
; CHECK-NEXT:    vle8.v v28, (a0)
; CHECK-NEXT:    vle8.v v8, (a1)
; CHECK-NEXT:    vmsltu.vv v25, v28, v8
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, <64 x i8>* %x
  %b = load <64 x i8>, <64 x i8>* %y
  %c = icmp ult <64 x i8> %a, %b
  store <64 x i1> %c, <64 x i1>* %z
  ret void
}

define void @setuge_vv_v128i8(<128 x i8>* %x, <128 x i8>* %y, <128 x i1>* %z) {
; CHECK-LABEL: setuge_vv_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 128
; CHECK-NEXT:    vsetvli a3, a3, e8,m8,ta,mu
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vle8.v v16, (a1)
; CHECK-NEXT:    vmsleu.vv v25, v16, v8
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, <128 x i8>* %x
  %b = load <128 x i8>, <128 x i8>* %y
  %c = icmp uge <128 x i8> %a, %b
  store <128 x i1> %c, <128 x i1>* %z
  ret void
}

define void @setule_vv_v8i8(<8 x i8>* %x, <8 x i8>* %y, <8 x i1>* %z) {
; CHECK-LABEL: setule_vv_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vle8.v v26, (a1)
; CHECK-NEXT:    vmsleu.vv v27, v25, v26
; CHECK-NEXT:    vse1.v v27, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = load <8 x i8>, <8 x i8>* %y
  %c = icmp ule <8 x i8> %a, %b
  store <8 x i1> %c, <8 x i1>* %z
  ret void
}

define void @seteq_vx_v16i8(<16 x i8>* %x, i8 %y, <16 x i1>* %z) {
; CHECK-LABEL: seteq_vx_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmseq.vx v26, v25, a1
; CHECK-NEXT:    vse1.v v26, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = insertelement <16 x i8> undef, i8 %y, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> undef, <16 x i32> zeroinitializer
  %d = icmp eq <16 x i8> %a, %c
  store <16 x i1> %d, <16 x i1>* %z
  ret void
}

define void @setne_vx_v32i8(<32 x i8>* %x, i8 %y, <32 x i1>* %z) {
; CHECK-LABEL: setne_vx_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 32
; CHECK-NEXT:    vsetvli a3, a3, e8,m2,ta,mu
; CHECK-NEXT:    vle8.v v26, (a0)
; CHECK-NEXT:    vmsne.vx v25, v26, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = insertelement <32 x i8> undef, i8 %y, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> undef, <32 x i32> zeroinitializer
  %d = icmp ne <32 x i8> %a, %c
  store <32 x i1> %d, <32 x i1>* %z
  ret void
}

define void @setgt_vx_v64i8(<64 x i8>* %x, i8 %y, <64 x i1>* %z) {
; CHECK-LABEL: setgt_vx_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 64
; CHECK-NEXT:    vsetvli a3, a3, e8,m4,ta,mu
; CHECK-NEXT:    vle8.v v28, (a0)
; CHECK-NEXT:    vmsgt.vx v25, v28, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, <64 x i8>* %x
  %b = insertelement <64 x i8> undef, i8 %y, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> undef, <64 x i32> zeroinitializer
  %d = icmp sgt <64 x i8> %a, %c
  store <64 x i1> %d, <64 x i1>* %z
  ret void
}

define void @setlt_vx_v128i8(<128 x i8>* %x, i8 %y, <128 x i1>* %z) {
; CHECK-LABEL: setlt_vx_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 128
; CHECK-NEXT:    vsetvli a3, a3, e8,m8,ta,mu
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmslt.vx v25, v8, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, <128 x i8>* %x
  %b = insertelement <128 x i8> undef, i8 %y, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> undef, <128 x i32> zeroinitializer
  %d = icmp slt <128 x i8> %a, %c
  store <128 x i1> %d, <128 x i1>* %z
  ret void
}

define void @setge_vx_v8i8(<8 x i8>* %x, i8 %y, <8 x i1>* %z) {
; CHECK-LABEL: setge_vx_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vmsle.vv v27, v26, v25
; CHECK-NEXT:    vse1.v v27, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = insertelement <8 x i8> undef, i8 %y, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> undef, <8 x i32> zeroinitializer
  %d = icmp sge <8 x i8> %a, %c
  store <8 x i1> %d, <8 x i1>* %z
  ret void
}

define void @setle_vx_v16i8(<16 x i8>* %x, i8 %y, <16 x i1>* %z) {
; CHECK-LABEL: setle_vx_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmsle.vx v26, v25, a1
; CHECK-NEXT:    vse1.v v26, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = insertelement <16 x i8> undef, i8 %y, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> undef, <16 x i32> zeroinitializer
  %d = icmp sle <16 x i8> %a, %c
  store <16 x i1> %d, <16 x i1>* %z
  ret void
}

define void @setugt_vx_v32i8(<32 x i8>* %x, i8 %y, <32 x i1>* %z) {
; CHECK-LABEL: setugt_vx_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 32
; CHECK-NEXT:    vsetvli a3, a3, e8,m2,ta,mu
; CHECK-NEXT:    vle8.v v26, (a0)
; CHECK-NEXT:    vmsgtu.vx v25, v26, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = insertelement <32 x i8> undef, i8 %y, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> undef, <32 x i32> zeroinitializer
  %d = icmp ugt <32 x i8> %a, %c
  store <32 x i1> %d, <32 x i1>* %z
  ret void
}

define void @setult_vx_v64i8(<64 x i8>* %x, i8 %y, <64 x i1>* %z) {
; CHECK-LABEL: setult_vx_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 64
; CHECK-NEXT:    vsetvli a3, a3, e8,m4,ta,mu
; CHECK-NEXT:    vle8.v v28, (a0)
; CHECK-NEXT:    vmsltu.vx v25, v28, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, <64 x i8>* %x
  %b = insertelement <64 x i8> undef, i8 %y, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> undef, <64 x i32> zeroinitializer
  %d = icmp ult <64 x i8> %a, %c
  store <64 x i1> %d, <64 x i1>* %z
  ret void
}

define void @setuge_vx_v128i8(<128 x i8>* %x, i8 %y, <128 x i1>* %z) {
; CHECK-LABEL: setuge_vx_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 128
; CHECK-NEXT:    vsetvli a3, a3, e8,m8,ta,mu
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmv.v.x v16, a1
; CHECK-NEXT:    vmsleu.vv v25, v16, v8
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, <128 x i8>* %x
  %b = insertelement <128 x i8> undef, i8 %y, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> undef, <128 x i32> zeroinitializer
  %d = icmp uge <128 x i8> %a, %c
  store <128 x i1> %d, <128 x i1>* %z
  ret void
}

define void @setule_vx_v8i8(<8 x i8>* %x, i8 %y, <8 x i1>* %z) {
; CHECK-LABEL: setule_vx_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmsleu.vx v26, v25, a1
; CHECK-NEXT:    vse1.v v26, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = insertelement <8 x i8> undef, i8 %y, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> undef, <8 x i32> zeroinitializer
  %d = icmp ule <8 x i8> %a, %c
  store <8 x i1> %d, <8 x i1>* %z
  ret void
}

define void @seteq_xv_v16i8(<16 x i8>* %x, i8 %y, <16 x i1>* %z) {
; CHECK-LABEL: seteq_xv_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmseq.vx v26, v25, a1
; CHECK-NEXT:    vse1.v v26, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = insertelement <16 x i8> undef, i8 %y, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> undef, <16 x i32> zeroinitializer
  %d = icmp eq <16 x i8> %c, %a
  store <16 x i1> %d, <16 x i1>* %z
  ret void
}

define void @setne_xv_v32i8(<32 x i8>* %x, i8 %y, <32 x i1>* %z) {
; CHECK-LABEL: setne_xv_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 32
; CHECK-NEXT:    vsetvli a3, a3, e8,m2,ta,mu
; CHECK-NEXT:    vle8.v v26, (a0)
; CHECK-NEXT:    vmsne.vx v25, v26, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = insertelement <32 x i8> undef, i8 %y, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> undef, <32 x i32> zeroinitializer
  %d = icmp ne <32 x i8> %c, %a
  store <32 x i1> %d, <32 x i1>* %z
  ret void
}

define void @setgt_xv_v64i8(<64 x i8>* %x, i8 %y, <64 x i1>* %z) {
; CHECK-LABEL: setgt_xv_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 64
; CHECK-NEXT:    vsetvli a3, a3, e8,m4,ta,mu
; CHECK-NEXT:    vle8.v v28, (a0)
; CHECK-NEXT:    vmslt.vx v25, v28, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, <64 x i8>* %x
  %b = insertelement <64 x i8> undef, i8 %y, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> undef, <64 x i32> zeroinitializer
  %d = icmp sgt <64 x i8> %c, %a
  store <64 x i1> %d, <64 x i1>* %z
  ret void
}

define void @setlt_xv_v128i8(<128 x i8>* %x, i8 %y, <128 x i1>* %z) {
; CHECK-LABEL: setlt_xv_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 128
; CHECK-NEXT:    vsetvli a3, a3, e8,m8,ta,mu
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgt.vx v25, v8, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, <128 x i8>* %x
  %b = insertelement <128 x i8> undef, i8 %y, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> undef, <128 x i32> zeroinitializer
  %d = icmp slt <128 x i8> %c, %a
  store <128 x i1> %d, <128 x i1>* %z
  ret void
}

define void @setge_xv_v8i8(<8 x i8>* %x, i8 %y, <8 x i1>* %z) {
; CHECK-LABEL: setge_xv_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmsle.vx v26, v25, a1
; CHECK-NEXT:    vse1.v v26, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = insertelement <8 x i8> undef, i8 %y, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> undef, <8 x i32> zeroinitializer
  %d = icmp sge <8 x i8> %c, %a
  store <8 x i1> %d, <8 x i1>* %z
  ret void
}

define void @setle_xv_v16i8(<16 x i8>* %x, i8 %y, <16 x i1>* %z) {
; CHECK-LABEL: setle_xv_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vmsle.vv v27, v26, v25
; CHECK-NEXT:    vse1.v v27, (a2)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = insertelement <16 x i8> undef, i8 %y, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> undef, <16 x i32> zeroinitializer
  %d = icmp sle <16 x i8> %c, %a
  store <16 x i1> %d, <16 x i1>* %z
  ret void
}

define void @setugt_xv_v32i8(<32 x i8>* %x, i8 %y, <32 x i1>* %z) {
; CHECK-LABEL: setugt_xv_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 32
; CHECK-NEXT:    vsetvli a3, a3, e8,m2,ta,mu
; CHECK-NEXT:    vle8.v v26, (a0)
; CHECK-NEXT:    vmsltu.vx v25, v26, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = insertelement <32 x i8> undef, i8 %y, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> undef, <32 x i32> zeroinitializer
  %d = icmp ugt <32 x i8> %c, %a
  store <32 x i1> %d, <32 x i1>* %z
  ret void
}

define void @setult_xv_v64i8(<64 x i8>* %x, i8 %y, <64 x i1>* %z) {
; CHECK-LABEL: setult_xv_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 64
; CHECK-NEXT:    vsetvli a3, a3, e8,m4,ta,mu
; CHECK-NEXT:    vle8.v v28, (a0)
; CHECK-NEXT:    vmsgtu.vx v25, v28, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, <64 x i8>* %x
  %b = insertelement <64 x i8> undef, i8 %y, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> undef, <64 x i32> zeroinitializer
  %d = icmp ult <64 x i8> %c, %a
  store <64 x i1> %d, <64 x i1>* %z
  ret void
}

define void @setuge_xv_v128i8(<128 x i8>* %x, i8 %y, <128 x i1>* %z) {
; CHECK-LABEL: setuge_xv_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a3, zero, 128
; CHECK-NEXT:    vsetvli a3, a3, e8,m8,ta,mu
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsleu.vx v25, v8, a1
; CHECK-NEXT:    vse1.v v25, (a2)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, <128 x i8>* %x
  %b = insertelement <128 x i8> undef, i8 %y, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> undef, <128 x i32> zeroinitializer
  %d = icmp uge <128 x i8> %c, %a
  store <128 x i1> %d, <128 x i1>* %z
  ret void
}

define void @setule_xv_v8i8(<8 x i8>* %x, i8 %y, <8 x i1>* %z) {
; CHECK-LABEL: setule_xv_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a3, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmv.v.x v26, a1
; CHECK-NEXT:    vmsleu.vv v27, v26, v25
; CHECK-NEXT:    vse1.v v27, (a2)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = insertelement <8 x i8> undef, i8 %y, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> undef, <8 x i32> zeroinitializer
  %d = icmp ule <8 x i8> %c, %a
  store <8 x i1> %d, <8 x i1>* %z
  ret void
}

define void @seteq_vi_v16i8(<16 x i8>* %x, <16 x i1>* %z) {
; CHECK-LABEL: seteq_vi_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmseq.vi v26, v25, 0
; CHECK-NEXT:    vse1.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = insertelement <16 x i8> undef, i8 0, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> undef, <16 x i32> zeroinitializer
  %d = icmp eq <16 x i8> %a, %c
  store <16 x i1> %d, <16 x i1>* %z
  ret void
}

define void @setne_vi_v32i8(<32 x i8>* %x, <32 x i1>* %z) {
; CHECK-LABEL: setne_vi_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, 32
; CHECK-NEXT:    vsetvli a2, a2, e8,m2,ta,mu
; CHECK-NEXT:    vle8.v v26, (a0)
; CHECK-NEXT:    vmsne.vi v25, v26, 0
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = insertelement <32 x i8> undef, i8 0, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> undef, <32 x i32> zeroinitializer
  %d = icmp ne <32 x i8> %a, %c
  store <32 x i1> %d, <32 x i1>* %z
  ret void
}

define void @setgt_vi_v64i8(<64 x i8>* %x, <64 x i1>* %z) {
; CHECK-LABEL: setgt_vi_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, 64
; CHECK-NEXT:    vsetvli a2, a2, e8,m4,ta,mu
; CHECK-NEXT:    vle8.v v28, (a0)
; CHECK-NEXT:    vmsgt.vx v25, v28, zero
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, <64 x i8>* %x
  %b = insertelement <64 x i8> undef, i8 0, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> undef, <64 x i32> zeroinitializer
  %d = icmp sgt <64 x i8> %a, %c
  store <64 x i1> %d, <64 x i1>* %z
  ret void
}

define void @setlt_vi_v128i8(<128 x i8>* %x, <128 x i1>* %z) {
; CHECK-LABEL: setlt_vi_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, 128
; CHECK-NEXT:    vsetvli a2, a2, e8,m8,ta,mu
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsle.vi v25, v8, -1
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, <128 x i8>* %x
  %b = insertelement <128 x i8> undef, i8 0, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> undef, <128 x i32> zeroinitializer
  %d = icmp slt <128 x i8> %a, %c
  store <128 x i1> %d, <128 x i1>* %z
  ret void
}

define void @setge_vi_v8i8(<8 x i8>* %x, <8 x i1>* %z) {
; CHECK-LABEL: setge_vi_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmsgt.vi v26, v25, -1
; CHECK-NEXT:    vse1.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = insertelement <8 x i8> undef, i8 0, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> undef, <8 x i32> zeroinitializer
  %d = icmp sge <8 x i8> %a, %c
  store <8 x i1> %d, <8 x i1>* %z
  ret void
}

define void @setle_vi_v16i8(<16 x i8>* %x, <16 x i1>* %z) {
; CHECK-LABEL: setle_vi_v16i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 16, e8,m1,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmsle.vi v26, v25, 0
; CHECK-NEXT:    vse1.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <16 x i8>, <16 x i8>* %x
  %b = insertelement <16 x i8> undef, i8 0, i32 0
  %c = shufflevector <16 x i8> %b, <16 x i8> undef, <16 x i32> zeroinitializer
  %d = icmp sle <16 x i8> %a, %c
  store <16 x i1> %d, <16 x i1>* %z
  ret void
}

define void @setugt_vi_v32i8(<32 x i8>* %x, <32 x i1>* %z) {
; CHECK-LABEL: setugt_vi_v32i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, 32
; CHECK-NEXT:    vsetvli a2, a2, e8,m2,ta,mu
; CHECK-NEXT:    vle8.v v26, (a0)
; CHECK-NEXT:    addi a0, zero, 5
; CHECK-NEXT:    vmsgtu.vx v25, v26, a0
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <32 x i8>, <32 x i8>* %x
  %b = insertelement <32 x i8> undef, i8 5, i32 0
  %c = shufflevector <32 x i8> %b, <32 x i8> undef, <32 x i32> zeroinitializer
  %d = icmp ugt <32 x i8> %a, %c
  store <32 x i1> %d, <32 x i1>* %z
  ret void
}

define void @setult_vi_v64i8(<64 x i8>* %x, <64 x i1>* %z) {
; CHECK-LABEL: setult_vi_v64i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, 64
; CHECK-NEXT:    vsetvli a2, a2, e8,m4,ta,mu
; CHECK-NEXT:    vle8.v v28, (a0)
; CHECK-NEXT:    vmsleu.vi v25, v28, 4
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <64 x i8>, <64 x i8>* %x
  %b = insertelement <64 x i8> undef, i8 5, i32 0
  %c = shufflevector <64 x i8> %b, <64 x i8> undef, <64 x i32> zeroinitializer
  %d = icmp ult <64 x i8> %a, %c
  store <64 x i1> %d, <64 x i1>* %z
  ret void
}

define void @setuge_vi_v128i8(<128 x i8>* %x, <128 x i1>* %z) {
; CHECK-LABEL: setuge_vi_v128i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi a2, zero, 128
; CHECK-NEXT:    vsetvli a2, a2, e8,m8,ta,mu
; CHECK-NEXT:    vle8.v v8, (a0)
; CHECK-NEXT:    vmsgtu.vi v25, v8, 4
; CHECK-NEXT:    vse1.v v25, (a1)
; CHECK-NEXT:    ret
  %a = load <128 x i8>, <128 x i8>* %x
  %b = insertelement <128 x i8> undef, i8 5, i32 0
  %c = shufflevector <128 x i8> %b, <128 x i8> undef, <128 x i32> zeroinitializer
  %d = icmp uge <128 x i8> %a, %c
  store <128 x i1> %d, <128 x i1>* %z
  ret void
}

define void @setule_vi_v8i8(<8 x i8>* %x, <8 x i1>* %z) {
; CHECK-LABEL: setule_vi_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vle8.v v25, (a0)
; CHECK-NEXT:    vmsleu.vi v26, v25, 5
; CHECK-NEXT:    vse1.v v26, (a1)
; CHECK-NEXT:    ret
  %a = load <8 x i8>, <8 x i8>* %x
  %b = insertelement <8 x i8> undef, i8 5, i32 0
  %c = shufflevector <8 x i8> %b, <8 x i8> undef, <8 x i32> zeroinitializer
  %d = icmp ule <8 x i8> %a, %c
  store <8 x i1> %d, <8 x i1>* %z
  ret void
}

define void @seteq_vv_v8i16(<8 x i16>* %x, <8 x i16>* %y) {
; CHECK-LABEL: seteq_vv_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 8, e16,m1,ta,mu
; CHECK-NEXT:    vle16.v v25, (a0)
; CHECK-NEXT:    vle16.v v26, (a1)
; CHECK-NEXT:    vmseq.vv v0, v25, v26
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, -1, v0
; CHECK-NEXT:    vse16.v v25, (a0)
; CHECK-NEXT:    ret
  %a = load <8 x i16>, <8 x i16>* %x
  %b = load <8 x i16>, <8 x i16>* %y
  %c = icmp eq <8 x i16> %a, %b
  %d = sext <8 x i1> %c to <8 x i16>
  store <8 x i16> %d, <8 x i16>* %x
  ret void
}

define void @setne_vv_v4i32(<4 x i32>* %x, <4 x i32>* %y) {
; CHECK-LABEL: setne_vv_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 4, e32,m1,ta,mu
; CHECK-NEXT:    vle32.v v25, (a0)
; CHECK-NEXT:    vle32.v v26, (a1)
; CHECK-NEXT:    vmsne.vv v0, v25, v26
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, -1, v0
; CHECK-NEXT:    vse32.v v25, (a0)
; CHECK-NEXT:    ret
  %a = load <4 x i32>, <4 x i32>* %x
  %b = load <4 x i32>, <4 x i32>* %y
  %c = icmp ne <4 x i32> %a, %b
  %d = sext <4 x i1> %c to <4 x i32>
  store <4 x i32> %d, <4 x i32>* %x
  ret void
}

define void @setgt_vv_v2i64(<2 x i64>* %x, <2 x i64>* %y) {
; CHECK-LABEL: setgt_vv_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 2, e64,m1,ta,mu
; CHECK-NEXT:    vle64.v v25, (a0)
; CHECK-NEXT:    vle64.v v26, (a1)
; CHECK-NEXT:    vmslt.vv v0, v26, v25
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, -1, v0
; CHECK-NEXT:    vse64.v v25, (a0)
; CHECK-NEXT:    ret
  %a = load <2 x i64>, <2 x i64>* %x
  %b = load <2 x i64>, <2 x i64>* %y
  %c = icmp sgt <2 x i64> %a, %b
  %d = sext <2 x i1> %c to <2 x i64>
  store <2 x i64> %d, <2 x i64>* %x
  ret void
}

define void @setlt_vv_v16i16(<16 x i16>* %x, <16 x i16>* %y) {
; CHECK-LABEL: setlt_vv_v16i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 16, e16,m2,ta,mu
; CHECK-NEXT:    vle16.v v26, (a0)
; CHECK-NEXT:    vle16.v v28, (a1)
; CHECK-NEXT:    vmslt.vv v0, v26, v28
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v26, v26, 1, v0
; CHECK-NEXT:    vse16.v v26, (a0)
; CHECK-NEXT:    ret
  %a = load <16 x i16>, <16 x i16>* %x
  %b = load <16 x i16>, <16 x i16>* %y
  %c = icmp slt <16 x i16> %a, %b
  %d = zext <16 x i1> %c to <16 x i16>
  store <16 x i16> %d, <16 x i16>* %x
  ret void
}

define void @setugt_vv_v8i32(<8 x i32>* %x, <8 x i32>* %y) {
; CHECK-LABEL: setugt_vv_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 8, e32,m2,ta,mu
; CHECK-NEXT:    vle32.v v26, (a0)
; CHECK-NEXT:    vle32.v v28, (a1)
; CHECK-NEXT:    vmsltu.vv v0, v28, v26
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v26, v26, 1, v0
; CHECK-NEXT:    vse32.v v26, (a0)
; CHECK-NEXT:    ret
  %a = load <8 x i32>, <8 x i32>* %x
  %b = load <8 x i32>, <8 x i32>* %y
  %c = icmp ugt <8 x i32> %a, %b
  %d = zext <8 x i1> %c to <8 x i32>
  store <8 x i32> %d, <8 x i32>* %x
  ret void
}

define void @setult_vv_v4i64(<4 x i64>* %x, <4 x i64>* %y) {
; CHECK-LABEL: setult_vv_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a2, 4, e64,m2,ta,mu
; CHECK-NEXT:    vle64.v v26, (a0)
; CHECK-NEXT:    vle64.v v28, (a1)
; CHECK-NEXT:    vmsltu.vv v0, v26, v28
; CHECK-NEXT:    vmv.v.i v26, 0
; CHECK-NEXT:    vmerge.vim v26, v26, 1, v0
; CHECK-NEXT:    vse64.v v26, (a0)
; CHECK-NEXT:    ret
  %a = load <4 x i64>, <4 x i64>* %x
  %b = load <4 x i64>, <4 x i64>* %y
  %c = icmp ult <4 x i64> %a, %b
  %d = zext <4 x i1> %c to <4 x i64>
  store <4 x i64> %d, <4 x i64>* %x
  ret void
}
