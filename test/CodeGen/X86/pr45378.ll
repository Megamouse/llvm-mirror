; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=sse2     | FileCheck %s --check-prefixes=CHECK,SSE,SSE2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=sse4.1   | FileCheck %s --check-prefixes=CHECK,SSE,SSE41
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=avx      | FileCheck %s --check-prefixes=CHECK,AVX,AVX1OR2,AVX1
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=avx2     | FileCheck %s --check-prefixes=CHECK,AVX,AVX1OR2,AVX2
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=avx512f  | FileCheck %s --check-prefixes=CHECK,AVX,AVX512,AVX512F
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=avx512bw | FileCheck %s --check-prefixes=CHECK,AVX,AVX512,AVX512BW

declare i64 @llvm.experimental.vector.reduce.or.v2i64(<2 x i64>)
declare void @TrapFunc(i64)

define void @parseHeaders(i64 * %ptr) {
; SSE2-LABEL: parseHeaders:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rax
; SSE2-NEXT:    .cfi_def_cfa_offset 16
; SSE2-NEXT:    movdqu (%rdi), %xmm1
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm1[2,3,0,1]
; SSE2-NEXT:    por %xmm0, %xmm1
; SSE2-NEXT:    movq %xmm1, %rax
; SSE2-NEXT:    testq %rax, %rax
; SSE2-NEXT:    je .LBB0_2
; SSE2-NEXT:  # %bb.1: # %trap
; SSE2-NEXT:    movq %xmm0, %rdi
; SSE2-NEXT:    callq TrapFunc
; SSE2-NEXT:  .LBB0_2: # %ret
; SSE2-NEXT:    popq %rax
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: parseHeaders:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pushq %rax
; SSE41-NEXT:    .cfi_def_cfa_offset 16
; SSE41-NEXT:    movdqu (%rdi), %xmm0
; SSE41-NEXT:    pshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; SSE41-NEXT:    por %xmm0, %xmm1
; SSE41-NEXT:    movq %xmm1, %rax
; SSE41-NEXT:    testq %rax, %rax
; SSE41-NEXT:    je .LBB0_2
; SSE41-NEXT:  # %bb.1: # %trap
; SSE41-NEXT:    pextrq $1, %xmm0, %rdi
; SSE41-NEXT:    callq TrapFunc
; SSE41-NEXT:  .LBB0_2: # %ret
; SSE41-NEXT:    popq %rax
; SSE41-NEXT:    .cfi_def_cfa_offset 8
; SSE41-NEXT:    retq
;
; AVX1-LABEL: parseHeaders:
; AVX1:       # %bb.0:
; AVX1-NEXT:    pushq %rax
; AVX1-NEXT:    .cfi_def_cfa_offset 16
; AVX1-NEXT:    vmovdqu (%rdi), %xmm0
; AVX1-NEXT:    vpshufd {{.*#+}} xmm1 = xmm0[2,3,0,1]
; AVX1-NEXT:    vpor %xmm1, %xmm0, %xmm1
; AVX1-NEXT:    vmovq %xmm1, %rax
; AVX1-NEXT:    testq %rax, %rax
; AVX1-NEXT:    je .LBB0_2
; AVX1-NEXT:  # %bb.1: # %trap
; AVX1-NEXT:    vpextrq $1, %xmm0, %rdi
; AVX1-NEXT:    callq TrapFunc
; AVX1-NEXT:  .LBB0_2: # %ret
; AVX1-NEXT:    popq %rax
; AVX1-NEXT:    .cfi_def_cfa_offset 8
; AVX1-NEXT:    retq
;
; AVX2-LABEL: parseHeaders:
; AVX2:       # %bb.0:
; AVX2-NEXT:    pushq %rax
; AVX2-NEXT:    .cfi_def_cfa_offset 16
; AVX2-NEXT:    vmovdqu (%rdi), %xmm0
; AVX2-NEXT:    vpbroadcastq 8(%rdi), %xmm1
; AVX2-NEXT:    vpor %xmm1, %xmm0, %xmm1
; AVX2-NEXT:    vmovq %xmm1, %rax
; AVX2-NEXT:    testq %rax, %rax
; AVX2-NEXT:    je .LBB0_2
; AVX2-NEXT:  # %bb.1: # %trap
; AVX2-NEXT:    vpextrq $1, %xmm0, %rdi
; AVX2-NEXT:    callq TrapFunc
; AVX2-NEXT:  .LBB0_2: # %ret
; AVX2-NEXT:    popq %rax
; AVX2-NEXT:    .cfi_def_cfa_offset 8
; AVX2-NEXT:    retq
;
; AVX512-LABEL: parseHeaders:
; AVX512:       # %bb.0:
; AVX512-NEXT:    pushq %rax
; AVX512-NEXT:    .cfi_def_cfa_offset 16
; AVX512-NEXT:    vmovdqu (%rdi), %xmm0
; AVX512-NEXT:    vpbroadcastq 8(%rdi), %xmm1
; AVX512-NEXT:    vpor %xmm1, %xmm0, %xmm1
; AVX512-NEXT:    vmovq %xmm1, %rax
; AVX512-NEXT:    testq %rax, %rax
; AVX512-NEXT:    je .LBB0_2
; AVX512-NEXT:  # %bb.1: # %trap
; AVX512-NEXT:    vpextrq $1, %xmm0, %rdi
; AVX512-NEXT:    callq TrapFunc
; AVX512-NEXT:  .LBB0_2: # %ret
; AVX512-NEXT:    popq %rax
; AVX512-NEXT:    .cfi_def_cfa_offset 8
; AVX512-NEXT:    retq
  %vptr = bitcast i64 * %ptr to <2 x i64> *
  %vload = load <2 x i64>, <2 x i64> * %vptr, align 8
  %vreduce = call i64 @llvm.experimental.vector.reduce.or.v2i64(<2 x i64> %vload)
  %vcheck = icmp eq i64 %vreduce, 0
  br i1 %vcheck, label %ret, label %trap
trap:
  %v2 = extractelement <2 x i64> %vload, i32 1
  call void @TrapFunc(i64 %v2)
  ret void
ret:
  ret void
}

define void @parseHeaders2_scalar_or(i64 * %ptr) {
; SSE2-LABEL: parseHeaders2_scalar_or:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rax
; SSE2-NEXT:    .cfi_def_cfa_offset 16
; SSE2-NEXT:    movdqu (%rdi), %xmm0
; SSE2-NEXT:    movq %xmm0, %rax
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    movq %xmm0, %rdi
; SSE2-NEXT:    orq %rdi, %rax
; SSE2-NEXT:    je .LBB1_2
; SSE2-NEXT:  # %bb.1: # %trap
; SSE2-NEXT:    callq TrapFunc
; SSE2-NEXT:  .LBB1_2: # %ret
; SSE2-NEXT:    popq %rax
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: parseHeaders2_scalar_or:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pushq %rax
; SSE41-NEXT:    .cfi_def_cfa_offset 16
; SSE41-NEXT:    movdqu (%rdi), %xmm0
; SSE41-NEXT:    ptest %xmm0, %xmm0
; SSE41-NEXT:    je .LBB1_2
; SSE41-NEXT:  # %bb.1: # %trap
; SSE41-NEXT:    pextrq $1, %xmm0, %rdi
; SSE41-NEXT:    callq TrapFunc
; SSE41-NEXT:  .LBB1_2: # %ret
; SSE41-NEXT:    popq %rax
; SSE41-NEXT:    .cfi_def_cfa_offset 8
; SSE41-NEXT:    retq
;
; AVX-LABEL: parseHeaders2_scalar_or:
; AVX:       # %bb.0:
; AVX-NEXT:    pushq %rax
; AVX-NEXT:    .cfi_def_cfa_offset 16
; AVX-NEXT:    vmovdqu (%rdi), %xmm0
; AVX-NEXT:    vptest %xmm0, %xmm0
; AVX-NEXT:    je .LBB1_2
; AVX-NEXT:  # %bb.1: # %trap
; AVX-NEXT:    vpextrq $1, %xmm0, %rdi
; AVX-NEXT:    callq TrapFunc
; AVX-NEXT:  .LBB1_2: # %ret
; AVX-NEXT:    popq %rax
; AVX-NEXT:    .cfi_def_cfa_offset 8
; AVX-NEXT:    retq
  %vptr = bitcast i64 * %ptr to <2 x i64> *
  %vload = load <2 x i64>, <2 x i64> * %vptr, align 8
  %v1 = extractelement <2 x i64> %vload, i32 0
  %v2 = extractelement <2 x i64> %vload, i32 1
  %vreduce = or i64 %v1, %v2
  %vcheck = icmp eq i64 %vreduce, 0
  br i1 %vcheck, label %ret, label %trap
trap:
  call void @TrapFunc(i64 %v2)
  ret void
ret:
  ret void
}

define void @parseHeaders2_scalar_and(i64 * %ptr) {
; SSE2-LABEL: parseHeaders2_scalar_and:
; SSE2:       # %bb.0:
; SSE2-NEXT:    pushq %rax
; SSE2-NEXT:    .cfi_def_cfa_offset 16
; SSE2-NEXT:    movdqu (%rdi), %xmm0
; SSE2-NEXT:    movq %xmm0, %rax
; SSE2-NEXT:    pshufd {{.*#+}} xmm0 = xmm0[2,3,0,1]
; SSE2-NEXT:    movq %xmm0, %rdi
; SSE2-NEXT:    testq %rdi, %rax
; SSE2-NEXT:    je .LBB2_2
; SSE2-NEXT:  # %bb.1: # %trap
; SSE2-NEXT:    callq TrapFunc
; SSE2-NEXT:  .LBB2_2: # %ret
; SSE2-NEXT:    popq %rax
; SSE2-NEXT:    .cfi_def_cfa_offset 8
; SSE2-NEXT:    retq
;
; SSE41-LABEL: parseHeaders2_scalar_and:
; SSE41:       # %bb.0:
; SSE41-NEXT:    pushq %rax
; SSE41-NEXT:    .cfi_def_cfa_offset 16
; SSE41-NEXT:    movdqu (%rdi), %xmm0
; SSE41-NEXT:    movq %xmm0, %rax
; SSE41-NEXT:    pextrq $1, %xmm0, %rdi
; SSE41-NEXT:    testq %rdi, %rax
; SSE41-NEXT:    je .LBB2_2
; SSE41-NEXT:  # %bb.1: # %trap
; SSE41-NEXT:    callq TrapFunc
; SSE41-NEXT:  .LBB2_2: # %ret
; SSE41-NEXT:    popq %rax
; SSE41-NEXT:    .cfi_def_cfa_offset 8
; SSE41-NEXT:    retq
;
; AVX-LABEL: parseHeaders2_scalar_and:
; AVX:       # %bb.0:
; AVX-NEXT:    pushq %rax
; AVX-NEXT:    .cfi_def_cfa_offset 16
; AVX-NEXT:    vmovdqu (%rdi), %xmm0
; AVX-NEXT:    vmovq %xmm0, %rax
; AVX-NEXT:    vpextrq $1, %xmm0, %rdi
; AVX-NEXT:    testq %rdi, %rax
; AVX-NEXT:    je .LBB2_2
; AVX-NEXT:  # %bb.1: # %trap
; AVX-NEXT:    callq TrapFunc
; AVX-NEXT:  .LBB2_2: # %ret
; AVX-NEXT:    popq %rax
; AVX-NEXT:    .cfi_def_cfa_offset 8
; AVX-NEXT:    retq
  %vptr = bitcast i64 * %ptr to <2 x i64> *
  %vload = load <2 x i64>, <2 x i64> * %vptr, align 8
  %v1 = extractelement <2 x i64> %vload, i32 0
  %v2 = extractelement <2 x i64> %vload, i32 1
  %vreduce = and i64 %v1, %v2
  %vcheck = icmp eq i64 %vreduce, 0
  br i1 %vcheck, label %ret, label %trap
trap:
  call void @TrapFunc(i64 %v2)
  ret void
ret:
  ret void
}
