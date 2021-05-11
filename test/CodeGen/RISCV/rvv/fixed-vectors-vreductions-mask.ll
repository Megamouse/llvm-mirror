; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1
; RUN: llc -mtriple=riscv32 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=1 < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX1
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -verify-machineinstrs -riscv-v-vector-bits-min=128 -riscv-v-fixed-length-vector-lmul-max=8 < %s | FileCheck %s --check-prefixes=CHECK,LMULMAX8

declare i1 @llvm.vector.reduce.or.v1i1(<1 x i1>)

define signext i1 @vreduce_or_v1i1(<1 x i1> %v) {
; CHECK-LABEL: vreduce_or_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.v1i1(<1 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.v1i1(<1 x i1>)

define signext i1 @vreduce_xor_v1i1(<1 x i1> %v) {
; CHECK-LABEL: vreduce_xor_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.v1i1(<1 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.v1i1(<1 x i1>)

define signext i1 @vreduce_and_v1i1(<1 x i1> %v) {
; CHECK-LABEL: vreduce_and_v1i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli a0, zero, e8,mf8,ta,mu
; CHECK-NEXT:    vmv.v.i v25, 0
; CHECK-NEXT:    vmerge.vim v25, v25, 1, v0
; CHECK-NEXT:    vmv.x.s a0, v25
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.v1i1(<1 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.v2i1(<2 x i1>)

define signext i1 @vreduce_or_v2i1(<2 x i1> %v) {
; CHECK-LABEL: vreduce_or_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e8,mf8,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.v2i1(<2 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.v2i1(<2 x i1>)

define signext i1 @vreduce_xor_v2i1(<2 x i1> %v) {
; CHECK-LABEL: vreduce_xor_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e8,mf8,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.v2i1(<2 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.v2i1(<2 x i1>)

define signext i1 @vreduce_and_v2i1(<2 x i1> %v) {
; CHECK-LABEL: vreduce_and_v2i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 2, e8,mf8,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.v2i1(<2 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.v4i1(<4 x i1>)

define signext i1 @vreduce_or_v4i1(<4 x i1> %v) {
; CHECK-LABEL: vreduce_or_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.v4i1(<4 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.v4i1(<4 x i1>)

define signext i1 @vreduce_xor_v4i1(<4 x i1> %v) {
; CHECK-LABEL: vreduce_xor_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.v4i1(<4 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.v4i1(<4 x i1>)

define signext i1 @vreduce_and_v4i1(<4 x i1> %v) {
; CHECK-LABEL: vreduce_and_v4i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 4, e8,mf4,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.v8i1(<8 x i1>)

define signext i1 @vreduce_or_v8i1(<8 x i1> %v) {
; CHECK-LABEL: vreduce_or_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.v8i1(<8 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.v8i1(<8 x i1>)

define signext i1 @vreduce_xor_v8i1(<8 x i1> %v) {
; CHECK-LABEL: vreduce_xor_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.v8i1(<8 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.v8i1(<8 x i1>)

define signext i1 @vreduce_and_v8i1(<8 x i1> %v) {
; CHECK-LABEL: vreduce_and_v8i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 8, e8,mf2,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.v8i1(<8 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.v16i1(<16 x i1>)

define signext i1 @vreduce_or_v16i1(<16 x i1> %v) {
; CHECK-LABEL: vreduce_or_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    snez a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.v16i1(<16 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.v16i1(<16 x i1>)

define signext i1 @vreduce_xor_v16i1(<16 x i1> %v) {
; CHECK-LABEL: vreduce_xor_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; CHECK-NEXT:    vpopc.m a0, v0
; CHECK-NEXT:    andi a0, a0, 1
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.v16i1(<16 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.v16i1(<16 x i1>)

define signext i1 @vreduce_and_v16i1(<16 x i1> %v) {
; CHECK-LABEL: vreduce_and_v16i1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; CHECK-NEXT:    vmnand.mm v25, v0, v0
; CHECK-NEXT:    vpopc.m a0, v25
; CHECK-NEXT:    seqz a0, a0
; CHECK-NEXT:    neg a0, a0
; CHECK-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.v16i1(<16 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.v32i1(<32 x i1>)

define signext i1 @vreduce_or_v32i1(<32 x i1> %v) {
; LMULMAX1-LABEL: vreduce_or_v32i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmor.mm v25, v0, v8
; LMULMAX1-NEXT:    vpopc.m a0, v25
; LMULMAX1-NEXT:    snez a0, a0
; LMULMAX1-NEXT:    neg a0, a0
; LMULMAX1-NEXT:    ret
;
; LMULMAX8-LABEL: vreduce_or_v32i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a0, zero, 32
; LMULMAX8-NEXT:    vsetvli a0, a0, e8,m2,ta,mu
; LMULMAX8-NEXT:    vpopc.m a0, v0
; LMULMAX8-NEXT:    snez a0, a0
; LMULMAX8-NEXT:    neg a0, a0
; LMULMAX8-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.v32i1(<32 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.v32i1(<32 x i1>)

define signext i1 @vreduce_xor_v32i1(<32 x i1> %v) {
; LMULMAX1-LABEL: vreduce_xor_v32i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmxor.mm v25, v0, v8
; LMULMAX1-NEXT:    vpopc.m a0, v25
; LMULMAX1-NEXT:    andi a0, a0, 1
; LMULMAX1-NEXT:    neg a0, a0
; LMULMAX1-NEXT:    ret
;
; LMULMAX8-LABEL: vreduce_xor_v32i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a0, zero, 32
; LMULMAX8-NEXT:    vsetvli a0, a0, e8,m2,ta,mu
; LMULMAX8-NEXT:    vpopc.m a0, v0
; LMULMAX8-NEXT:    andi a0, a0, 1
; LMULMAX8-NEXT:    neg a0, a0
; LMULMAX8-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.v32i1(<32 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.v32i1(<32 x i1>)

define signext i1 @vreduce_and_v32i1(<32 x i1> %v) {
; LMULMAX1-LABEL: vreduce_and_v32i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmnand.mm v25, v0, v8
; LMULMAX1-NEXT:    vpopc.m a0, v25
; LMULMAX1-NEXT:    seqz a0, a0
; LMULMAX1-NEXT:    neg a0, a0
; LMULMAX1-NEXT:    ret
;
; LMULMAX8-LABEL: vreduce_and_v32i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a0, zero, 32
; LMULMAX8-NEXT:    vsetvli a0, a0, e8,m2,ta,mu
; LMULMAX8-NEXT:    vmnand.mm v25, v0, v0
; LMULMAX8-NEXT:    vpopc.m a0, v25
; LMULMAX8-NEXT:    seqz a0, a0
; LMULMAX8-NEXT:    neg a0, a0
; LMULMAX8-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.v32i1(<32 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.or.v64i1(<64 x i1>)

define signext i1 @vreduce_or_v64i1(<64 x i1> %v) {
; LMULMAX1-LABEL: vreduce_or_v64i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmor.mm v25, v8, v10
; LMULMAX1-NEXT:    vmor.mm v26, v0, v9
; LMULMAX1-NEXT:    vmor.mm v25, v26, v25
; LMULMAX1-NEXT:    vpopc.m a0, v25
; LMULMAX1-NEXT:    snez a0, a0
; LMULMAX1-NEXT:    neg a0, a0
; LMULMAX1-NEXT:    ret
;
; LMULMAX8-LABEL: vreduce_or_v64i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a0, zero, 64
; LMULMAX8-NEXT:    vsetvli a0, a0, e8,m4,ta,mu
; LMULMAX8-NEXT:    vpopc.m a0, v0
; LMULMAX8-NEXT:    snez a0, a0
; LMULMAX8-NEXT:    neg a0, a0
; LMULMAX8-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.or.v64i1(<64 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.xor.v64i1(<64 x i1>)

define signext i1 @vreduce_xor_v64i1(<64 x i1> %v) {
; LMULMAX1-LABEL: vreduce_xor_v64i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmxor.mm v25, v8, v10
; LMULMAX1-NEXT:    vmxor.mm v26, v0, v9
; LMULMAX1-NEXT:    vmxor.mm v25, v26, v25
; LMULMAX1-NEXT:    vpopc.m a0, v25
; LMULMAX1-NEXT:    andi a0, a0, 1
; LMULMAX1-NEXT:    neg a0, a0
; LMULMAX1-NEXT:    ret
;
; LMULMAX8-LABEL: vreduce_xor_v64i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a0, zero, 64
; LMULMAX8-NEXT:    vsetvli a0, a0, e8,m4,ta,mu
; LMULMAX8-NEXT:    vpopc.m a0, v0
; LMULMAX8-NEXT:    andi a0, a0, 1
; LMULMAX8-NEXT:    neg a0, a0
; LMULMAX8-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.xor.v64i1(<64 x i1> %v)
  ret i1 %red
}

declare i1 @llvm.vector.reduce.and.v64i1(<64 x i1>)

define signext i1 @vreduce_and_v64i1(<64 x i1> %v) {
; LMULMAX1-LABEL: vreduce_and_v64i1:
; LMULMAX1:       # %bb.0:
; LMULMAX1-NEXT:    vsetivli a0, 16, e8,m1,ta,mu
; LMULMAX1-NEXT:    vmand.mm v25, v8, v10
; LMULMAX1-NEXT:    vmand.mm v26, v0, v9
; LMULMAX1-NEXT:    vmnand.mm v25, v26, v25
; LMULMAX1-NEXT:    vpopc.m a0, v25
; LMULMAX1-NEXT:    seqz a0, a0
; LMULMAX1-NEXT:    neg a0, a0
; LMULMAX1-NEXT:    ret
;
; LMULMAX8-LABEL: vreduce_and_v64i1:
; LMULMAX8:       # %bb.0:
; LMULMAX8-NEXT:    addi a0, zero, 64
; LMULMAX8-NEXT:    vsetvli a0, a0, e8,m4,ta,mu
; LMULMAX8-NEXT:    vmnand.mm v25, v0, v0
; LMULMAX8-NEXT:    vpopc.m a0, v25
; LMULMAX8-NEXT:    seqz a0, a0
; LMULMAX8-NEXT:    neg a0, a0
; LMULMAX8-NEXT:    ret
  %red = call i1 @llvm.vector.reduce.and.v64i1(<64 x i1> %v)
  ret i1 %red
}
