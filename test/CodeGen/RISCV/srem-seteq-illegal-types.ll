; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 < %s | FileCheck %s --check-prefixes=RV32
; RUN: llc -mtriple=riscv64 < %s | FileCheck %s --check-prefixes=RV64
; RUN: llc -mtriple=riscv32 -mattr=+m < %s | FileCheck %s --check-prefixes=RV32M
; RUN: llc -mtriple=riscv64 -mattr=+m < %s | FileCheck %s --check-prefixes=RV64M
; RUN: llc -mtriple=riscv32 -mattr=+m,+experimental-v -riscv-v-vector-bits-min=128 < %s | FileCheck %s --check-prefixes=RV32MV
; RUN: llc -mtriple=riscv64 -mattr=+m,+experimental-v -riscv-v-vector-bits-min=128 < %s | FileCheck %s --check-prefixes=RV64MV

define i1 @test_srem_odd(i29 %X) nounwind {
; RV32-LABEL: test_srem_odd:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    lui a1, 128424
; RV32-NEXT:    addi a1, a1, 331
; RV32-NEXT:    call __mulsi3@plt
; RV32-NEXT:    lui a1, 662
; RV32-NEXT:    addi a1, a1, -83
; RV32-NEXT:    add a0, a0, a1
; RV32-NEXT:    lui a1, 131072
; RV32-NEXT:    addi a1, a1, -1
; RV32-NEXT:    and a0, a0, a1
; RV32-NEXT:    lui a1, 1324
; RV32-NEXT:    addi a1, a1, -165
; RV32-NEXT:    sltu a0, a0, a1
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: test_srem_odd:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    lui a1, 128424
; RV64-NEXT:    addiw a1, a1, 331
; RV64-NEXT:    call __muldi3@plt
; RV64-NEXT:    lui a1, 662
; RV64-NEXT:    addiw a1, a1, -83
; RV64-NEXT:    add a0, a0, a1
; RV64-NEXT:    lui a1, 131072
; RV64-NEXT:    addiw a1, a1, -1
; RV64-NEXT:    and a0, a0, a1
; RV64-NEXT:    lui a1, 1324
; RV64-NEXT:    addiw a1, a1, -165
; RV64-NEXT:    sltu a0, a0, a1
; RV64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    ret
;
; RV32M-LABEL: test_srem_odd:
; RV32M:       # %bb.0:
; RV32M-NEXT:    lui a1, 128424
; RV32M-NEXT:    addi a1, a1, 331
; RV32M-NEXT:    mul a0, a0, a1
; RV32M-NEXT:    lui a1, 662
; RV32M-NEXT:    addi a1, a1, -83
; RV32M-NEXT:    add a0, a0, a1
; RV32M-NEXT:    lui a1, 131072
; RV32M-NEXT:    addi a1, a1, -1
; RV32M-NEXT:    and a0, a0, a1
; RV32M-NEXT:    lui a1, 1324
; RV32M-NEXT:    addi a1, a1, -165
; RV32M-NEXT:    sltu a0, a0, a1
; RV32M-NEXT:    ret
;
; RV64M-LABEL: test_srem_odd:
; RV64M:       # %bb.0:
; RV64M-NEXT:    lui a1, 128424
; RV64M-NEXT:    addiw a1, a1, 331
; RV64M-NEXT:    mul a0, a0, a1
; RV64M-NEXT:    lui a1, 662
; RV64M-NEXT:    addiw a1, a1, -83
; RV64M-NEXT:    add a0, a0, a1
; RV64M-NEXT:    lui a1, 131072
; RV64M-NEXT:    addiw a1, a1, -1
; RV64M-NEXT:    and a0, a0, a1
; RV64M-NEXT:    lui a1, 1324
; RV64M-NEXT:    addiw a1, a1, -165
; RV64M-NEXT:    sltu a0, a0, a1
; RV64M-NEXT:    ret
;
; RV32MV-LABEL: test_srem_odd:
; RV32MV:       # %bb.0:
; RV32MV-NEXT:    lui a1, 128424
; RV32MV-NEXT:    addi a1, a1, 331
; RV32MV-NEXT:    mul a0, a0, a1
; RV32MV-NEXT:    lui a1, 662
; RV32MV-NEXT:    addi a1, a1, -83
; RV32MV-NEXT:    add a0, a0, a1
; RV32MV-NEXT:    lui a1, 131072
; RV32MV-NEXT:    addi a1, a1, -1
; RV32MV-NEXT:    and a0, a0, a1
; RV32MV-NEXT:    lui a1, 1324
; RV32MV-NEXT:    addi a1, a1, -165
; RV32MV-NEXT:    sltu a0, a0, a1
; RV32MV-NEXT:    ret
;
; RV64MV-LABEL: test_srem_odd:
; RV64MV:       # %bb.0:
; RV64MV-NEXT:    lui a1, 128424
; RV64MV-NEXT:    addiw a1, a1, 331
; RV64MV-NEXT:    mul a0, a0, a1
; RV64MV-NEXT:    lui a1, 662
; RV64MV-NEXT:    addiw a1, a1, -83
; RV64MV-NEXT:    add a0, a0, a1
; RV64MV-NEXT:    lui a1, 131072
; RV64MV-NEXT:    addiw a1, a1, -1
; RV64MV-NEXT:    and a0, a0, a1
; RV64MV-NEXT:    lui a1, 1324
; RV64MV-NEXT:    addiw a1, a1, -165
; RV64MV-NEXT:    sltu a0, a0, a1
; RV64MV-NEXT:    ret
  %srem = srem i29 %X, 99
  %cmp = icmp eq i29 %srem, 0
  ret i1 %cmp
}

define i1 @test_srem_even(i4 %X) nounwind {
; RV32-LABEL: test_srem_even:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -16
; RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    slli a0, a0, 28
; RV32-NEXT:    srai a0, a0, 28
; RV32-NEXT:    addi a1, zero, 6
; RV32-NEXT:    call __modsi3@plt
; RV32-NEXT:    addi a0, a0, -1
; RV32-NEXT:    seqz a0, a0
; RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 16
; RV32-NEXT:    ret
;
; RV64-LABEL: test_srem_even:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -16
; RV64-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    slli a0, a0, 60
; RV64-NEXT:    srai a0, a0, 60
; RV64-NEXT:    addi a1, zero, 6
; RV64-NEXT:    call __moddi3@plt
; RV64-NEXT:    addi a0, a0, -1
; RV64-NEXT:    seqz a0, a0
; RV64-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 16
; RV64-NEXT:    ret
;
; RV32M-LABEL: test_srem_even:
; RV32M:       # %bb.0:
; RV32M-NEXT:    slli a0, a0, 28
; RV32M-NEXT:    srai a0, a0, 28
; RV32M-NEXT:    lui a1, 174763
; RV32M-NEXT:    addi a1, a1, -1365
; RV32M-NEXT:    mulh a1, a0, a1
; RV32M-NEXT:    srli a2, a1, 31
; RV32M-NEXT:    add a1, a1, a2
; RV32M-NEXT:    addi a2, zero, 6
; RV32M-NEXT:    mul a1, a1, a2
; RV32M-NEXT:    sub a0, a0, a1
; RV32M-NEXT:    addi a0, a0, -1
; RV32M-NEXT:    seqz a0, a0
; RV32M-NEXT:    ret
;
; RV64M-LABEL: test_srem_even:
; RV64M:       # %bb.0:
; RV64M-NEXT:    slli a0, a0, 60
; RV64M-NEXT:    srai a0, a0, 60
; RV64M-NEXT:    lui a1, 10923
; RV64M-NEXT:    addiw a1, a1, -1365
; RV64M-NEXT:    slli a1, a1, 12
; RV64M-NEXT:    addi a1, a1, -1365
; RV64M-NEXT:    slli a1, a1, 12
; RV64M-NEXT:    addi a1, a1, -1365
; RV64M-NEXT:    slli a1, a1, 12
; RV64M-NEXT:    addi a1, a1, -1365
; RV64M-NEXT:    mulh a1, a0, a1
; RV64M-NEXT:    srli a2, a1, 63
; RV64M-NEXT:    add a1, a1, a2
; RV64M-NEXT:    addi a2, zero, 6
; RV64M-NEXT:    mul a1, a1, a2
; RV64M-NEXT:    sub a0, a0, a1
; RV64M-NEXT:    addi a0, a0, -1
; RV64M-NEXT:    seqz a0, a0
; RV64M-NEXT:    ret
;
; RV32MV-LABEL: test_srem_even:
; RV32MV:       # %bb.0:
; RV32MV-NEXT:    slli a0, a0, 28
; RV32MV-NEXT:    srai a0, a0, 28
; RV32MV-NEXT:    lui a1, 174763
; RV32MV-NEXT:    addi a1, a1, -1365
; RV32MV-NEXT:    mulh a1, a0, a1
; RV32MV-NEXT:    srli a2, a1, 31
; RV32MV-NEXT:    add a1, a1, a2
; RV32MV-NEXT:    addi a2, zero, 6
; RV32MV-NEXT:    mul a1, a1, a2
; RV32MV-NEXT:    sub a0, a0, a1
; RV32MV-NEXT:    addi a0, a0, -1
; RV32MV-NEXT:    seqz a0, a0
; RV32MV-NEXT:    ret
;
; RV64MV-LABEL: test_srem_even:
; RV64MV:       # %bb.0:
; RV64MV-NEXT:    slli a0, a0, 60
; RV64MV-NEXT:    srai a0, a0, 60
; RV64MV-NEXT:    lui a1, 10923
; RV64MV-NEXT:    addiw a1, a1, -1365
; RV64MV-NEXT:    slli a1, a1, 12
; RV64MV-NEXT:    addi a1, a1, -1365
; RV64MV-NEXT:    slli a1, a1, 12
; RV64MV-NEXT:    addi a1, a1, -1365
; RV64MV-NEXT:    slli a1, a1, 12
; RV64MV-NEXT:    addi a1, a1, -1365
; RV64MV-NEXT:    mulh a1, a0, a1
; RV64MV-NEXT:    srli a2, a1, 63
; RV64MV-NEXT:    add a1, a1, a2
; RV64MV-NEXT:    addi a2, zero, 6
; RV64MV-NEXT:    mul a1, a1, a2
; RV64MV-NEXT:    sub a0, a0, a1
; RV64MV-NEXT:    addi a0, a0, -1
; RV64MV-NEXT:    seqz a0, a0
; RV64MV-NEXT:    ret
  %srem = srem i4 %X, 6
  %cmp = icmp eq i4 %srem, 1
  ret i1 %cmp
}

define i1 @test_srem_pow2_setne(i6 %X) nounwind {
; RV32-LABEL: test_srem_pow2_setne:
; RV32:       # %bb.0:
; RV32-NEXT:    slli a1, a0, 26
; RV32-NEXT:    srai a1, a1, 26
; RV32-NEXT:    srli a1, a1, 9
; RV32-NEXT:    andi a1, a1, 3
; RV32-NEXT:    add a1, a0, a1
; RV32-NEXT:    andi a1, a1, 60
; RV32-NEXT:    sub a0, a0, a1
; RV32-NEXT:    andi a0, a0, 63
; RV32-NEXT:    snez a0, a0
; RV32-NEXT:    ret
;
; RV64-LABEL: test_srem_pow2_setne:
; RV64:       # %bb.0:
; RV64-NEXT:    slli a1, a0, 58
; RV64-NEXT:    srai a1, a1, 58
; RV64-NEXT:    srli a1, a1, 9
; RV64-NEXT:    andi a1, a1, 3
; RV64-NEXT:    add a1, a0, a1
; RV64-NEXT:    andi a1, a1, 60
; RV64-NEXT:    sub a0, a0, a1
; RV64-NEXT:    andi a0, a0, 63
; RV64-NEXT:    snez a0, a0
; RV64-NEXT:    ret
;
; RV32M-LABEL: test_srem_pow2_setne:
; RV32M:       # %bb.0:
; RV32M-NEXT:    slli a1, a0, 26
; RV32M-NEXT:    srai a1, a1, 26
; RV32M-NEXT:    srli a1, a1, 9
; RV32M-NEXT:    andi a1, a1, 3
; RV32M-NEXT:    add a1, a0, a1
; RV32M-NEXT:    andi a1, a1, 60
; RV32M-NEXT:    sub a0, a0, a1
; RV32M-NEXT:    andi a0, a0, 63
; RV32M-NEXT:    snez a0, a0
; RV32M-NEXT:    ret
;
; RV64M-LABEL: test_srem_pow2_setne:
; RV64M:       # %bb.0:
; RV64M-NEXT:    slli a1, a0, 58
; RV64M-NEXT:    srai a1, a1, 58
; RV64M-NEXT:    srli a1, a1, 9
; RV64M-NEXT:    andi a1, a1, 3
; RV64M-NEXT:    add a1, a0, a1
; RV64M-NEXT:    andi a1, a1, 60
; RV64M-NEXT:    sub a0, a0, a1
; RV64M-NEXT:    andi a0, a0, 63
; RV64M-NEXT:    snez a0, a0
; RV64M-NEXT:    ret
;
; RV32MV-LABEL: test_srem_pow2_setne:
; RV32MV:       # %bb.0:
; RV32MV-NEXT:    slli a1, a0, 26
; RV32MV-NEXT:    srai a1, a1, 26
; RV32MV-NEXT:    srli a1, a1, 9
; RV32MV-NEXT:    andi a1, a1, 3
; RV32MV-NEXT:    add a1, a0, a1
; RV32MV-NEXT:    andi a1, a1, 60
; RV32MV-NEXT:    sub a0, a0, a1
; RV32MV-NEXT:    andi a0, a0, 63
; RV32MV-NEXT:    snez a0, a0
; RV32MV-NEXT:    ret
;
; RV64MV-LABEL: test_srem_pow2_setne:
; RV64MV:       # %bb.0:
; RV64MV-NEXT:    slli a1, a0, 58
; RV64MV-NEXT:    srai a1, a1, 58
; RV64MV-NEXT:    srli a1, a1, 9
; RV64MV-NEXT:    andi a1, a1, 3
; RV64MV-NEXT:    add a1, a0, a1
; RV64MV-NEXT:    andi a1, a1, 60
; RV64MV-NEXT:    sub a0, a0, a1
; RV64MV-NEXT:    andi a0, a0, 63
; RV64MV-NEXT:    snez a0, a0
; RV64MV-NEXT:    ret
  %srem = srem i6 %X, 4
  %cmp = icmp ne i6 %srem, 0
  ret i1 %cmp
}

define void @test_srem_vec(<3 x i33>* %X) nounwind {
; RV32-LABEL: test_srem_vec:
; RV32:       # %bb.0:
; RV32-NEXT:    addi sp, sp, -32
; RV32-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s5, 4(sp) # 4-byte Folded Spill
; RV32-NEXT:    sw s6, 0(sp) # 4-byte Folded Spill
; RV32-NEXT:    mv s0, a0
; RV32-NEXT:    lw a0, 4(a0)
; RV32-NEXT:    lbu a1, 12(s0)
; RV32-NEXT:    lw a2, 8(s0)
; RV32-NEXT:    andi a3, a0, 1
; RV32-NEXT:    neg s2, a3
; RV32-NEXT:    slli a3, a1, 30
; RV32-NEXT:    srli a4, a2, 2
; RV32-NEXT:    or s3, a4, a3
; RV32-NEXT:    srli a1, a1, 2
; RV32-NEXT:    andi a1, a1, 1
; RV32-NEXT:    neg s1, a1
; RV32-NEXT:    slli a1, a2, 31
; RV32-NEXT:    srli a0, a0, 1
; RV32-NEXT:    or a0, a0, a1
; RV32-NEXT:    lw s4, 0(s0)
; RV32-NEXT:    srli a1, a2, 1
; RV32-NEXT:    andi a1, a1, 1
; RV32-NEXT:    neg a1, a1
; RV32-NEXT:    addi a2, zero, 7
; RV32-NEXT:    mv a3, zero
; RV32-NEXT:    call __moddi3@plt
; RV32-NEXT:    mv s5, a0
; RV32-NEXT:    mv s6, a1
; RV32-NEXT:    addi a2, zero, -5
; RV32-NEXT:    addi a3, zero, -1
; RV32-NEXT:    mv a0, s3
; RV32-NEXT:    mv a1, s1
; RV32-NEXT:    call __moddi3@plt
; RV32-NEXT:    mv s1, a0
; RV32-NEXT:    mv s3, a1
; RV32-NEXT:    addi a2, zero, 6
; RV32-NEXT:    mv a0, s4
; RV32-NEXT:    mv a1, s2
; RV32-NEXT:    mv a3, zero
; RV32-NEXT:    call __moddi3@plt
; RV32-NEXT:    xori a2, s1, 2
; RV32-NEXT:    or a2, a2, s3
; RV32-NEXT:    snez a2, a2
; RV32-NEXT:    xori a3, s5, 1
; RV32-NEXT:    or a3, a3, s6
; RV32-NEXT:    snez a3, a3
; RV32-NEXT:    or a0, a0, a1
; RV32-NEXT:    snez a0, a0
; RV32-NEXT:    neg a1, a3
; RV32-NEXT:    neg a4, a2
; RV32-NEXT:    neg a5, a0
; RV32-NEXT:    sw a5, 0(s0)
; RV32-NEXT:    slli a3, a3, 1
; RV32-NEXT:    sub a0, a0, a3
; RV32-NEXT:    sw a0, 4(s0)
; RV32-NEXT:    slli a0, a2, 2
; RV32-NEXT:    srli a2, a4, 30
; RV32-NEXT:    sub a2, a2, a0
; RV32-NEXT:    andi a2, a2, 7
; RV32-NEXT:    sb a2, 12(s0)
; RV32-NEXT:    srli a2, a1, 31
; RV32-NEXT:    andi a1, a1, 1
; RV32-NEXT:    slli a1, a1, 1
; RV32-NEXT:    or a1, a2, a1
; RV32-NEXT:    sub a0, a1, a0
; RV32-NEXT:    sw a0, 8(s0)
; RV32-NEXT:    lw s6, 0(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s5, 4(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32-NEXT:    addi sp, sp, 32
; RV32-NEXT:    ret
;
; RV64-LABEL: test_srem_vec:
; RV64:       # %bb.0:
; RV64-NEXT:    addi sp, sp, -64
; RV64-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s1, 40(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s2, 32(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s3, 24(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s4, 16(sp) # 8-byte Folded Spill
; RV64-NEXT:    sd s5, 8(sp) # 8-byte Folded Spill
; RV64-NEXT:    mv s0, a0
; RV64-NEXT:    lb a0, 12(a0)
; RV64-NEXT:    lwu a1, 8(s0)
; RV64-NEXT:    slli a0, a0, 32
; RV64-NEXT:    or a0, a1, a0
; RV64-NEXT:    addi s4, zero, -1
; RV64-NEXT:    srli a1, s4, 24
; RV64-NEXT:    and a0, a0, a1
; RV64-NEXT:    ld a1, 0(s0)
; RV64-NEXT:    slli a2, a0, 29
; RV64-NEXT:    srai s1, a2, 31
; RV64-NEXT:    slli a0, a0, 31
; RV64-NEXT:    srli a2, a1, 33
; RV64-NEXT:    or a0, a2, a0
; RV64-NEXT:    slli a0, a0, 31
; RV64-NEXT:    srai a0, a0, 31
; RV64-NEXT:    slli a1, a1, 31
; RV64-NEXT:    srai s2, a1, 31
; RV64-NEXT:    addi a1, zero, 7
; RV64-NEXT:    addi s5, zero, 7
; RV64-NEXT:    call __moddi3@plt
; RV64-NEXT:    mv s3, a0
; RV64-NEXT:    addi a1, zero, -5
; RV64-NEXT:    mv a0, s1
; RV64-NEXT:    call __moddi3@plt
; RV64-NEXT:    mv s1, a0
; RV64-NEXT:    lui a0, 1026731
; RV64-NEXT:    addiw a0, a0, -1365
; RV64-NEXT:    slli a0, a0, 12
; RV64-NEXT:    addi a0, a0, -1365
; RV64-NEXT:    slli a0, a0, 12
; RV64-NEXT:    addi a0, a0, -1365
; RV64-NEXT:    slli a0, a0, 12
; RV64-NEXT:    addi a1, a0, -1365
; RV64-NEXT:    mv a0, s2
; RV64-NEXT:    call __muldi3@plt
; RV64-NEXT:    lui a1, 10923
; RV64-NEXT:    addiw a1, a1, -1365
; RV64-NEXT:    slli a1, a1, 12
; RV64-NEXT:    addi a1, a1, -1365
; RV64-NEXT:    slli a1, a1, 12
; RV64-NEXT:    addi a1, a1, -1365
; RV64-NEXT:    slli a1, a1, 12
; RV64-NEXT:    addi a1, a1, -1366
; RV64-NEXT:    add a0, a0, a1
; RV64-NEXT:    slli a2, a0, 63
; RV64-NEXT:    srli a0, a0, 1
; RV64-NEXT:    or a0, a0, a2
; RV64-NEXT:    sltu a0, a1, a0
; RV64-NEXT:    addi a1, s1, -2
; RV64-NEXT:    snez a1, a1
; RV64-NEXT:    addi a2, s3, -1
; RV64-NEXT:    snez a2, a2
; RV64-NEXT:    neg a0, a0
; RV64-NEXT:    neg a2, a2
; RV64-NEXT:    neg a3, a1
; RV64-NEXT:    slli a4, s5, 32
; RV64-NEXT:    and a3, a3, a4
; RV64-NEXT:    srli a3, a3, 32
; RV64-NEXT:    sb a3, 12(s0)
; RV64-NEXT:    slli a1, a1, 2
; RV64-NEXT:    srli a3, s4, 31
; RV64-NEXT:    and a2, a2, a3
; RV64-NEXT:    srli a4, a2, 31
; RV64-NEXT:    sub a1, a4, a1
; RV64-NEXT:    sw a1, 8(s0)
; RV64-NEXT:    and a0, a0, a3
; RV64-NEXT:    slli a1, a2, 33
; RV64-NEXT:    or a0, a0, a1
; RV64-NEXT:    sd a0, 0(s0)
; RV64-NEXT:    ld s5, 8(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s4, 16(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s3, 24(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s2, 32(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s1, 40(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; RV64-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; RV64-NEXT:    addi sp, sp, 64
; RV64-NEXT:    ret
;
; RV32M-LABEL: test_srem_vec:
; RV32M:       # %bb.0:
; RV32M-NEXT:    addi sp, sp, -32
; RV32M-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32M-NEXT:    sw s0, 24(sp) # 4-byte Folded Spill
; RV32M-NEXT:    sw s1, 20(sp) # 4-byte Folded Spill
; RV32M-NEXT:    sw s2, 16(sp) # 4-byte Folded Spill
; RV32M-NEXT:    sw s3, 12(sp) # 4-byte Folded Spill
; RV32M-NEXT:    sw s4, 8(sp) # 4-byte Folded Spill
; RV32M-NEXT:    sw s5, 4(sp) # 4-byte Folded Spill
; RV32M-NEXT:    sw s6, 0(sp) # 4-byte Folded Spill
; RV32M-NEXT:    mv s0, a0
; RV32M-NEXT:    lw a0, 4(a0)
; RV32M-NEXT:    lbu a1, 12(s0)
; RV32M-NEXT:    lw a2, 8(s0)
; RV32M-NEXT:    andi a3, a0, 1
; RV32M-NEXT:    neg s2, a3
; RV32M-NEXT:    slli a3, a1, 30
; RV32M-NEXT:    srli a4, a2, 2
; RV32M-NEXT:    or s3, a4, a3
; RV32M-NEXT:    srli a1, a1, 2
; RV32M-NEXT:    andi a1, a1, 1
; RV32M-NEXT:    neg s1, a1
; RV32M-NEXT:    slli a1, a2, 31
; RV32M-NEXT:    srli a0, a0, 1
; RV32M-NEXT:    or a0, a0, a1
; RV32M-NEXT:    lw s4, 0(s0)
; RV32M-NEXT:    srli a1, a2, 1
; RV32M-NEXT:    andi a1, a1, 1
; RV32M-NEXT:    neg a1, a1
; RV32M-NEXT:    addi a2, zero, 7
; RV32M-NEXT:    mv a3, zero
; RV32M-NEXT:    call __moddi3@plt
; RV32M-NEXT:    mv s5, a0
; RV32M-NEXT:    mv s6, a1
; RV32M-NEXT:    addi a2, zero, -5
; RV32M-NEXT:    addi a3, zero, -1
; RV32M-NEXT:    mv a0, s3
; RV32M-NEXT:    mv a1, s1
; RV32M-NEXT:    call __moddi3@plt
; RV32M-NEXT:    mv s1, a0
; RV32M-NEXT:    mv s3, a1
; RV32M-NEXT:    addi a2, zero, 6
; RV32M-NEXT:    mv a0, s4
; RV32M-NEXT:    mv a1, s2
; RV32M-NEXT:    mv a3, zero
; RV32M-NEXT:    call __moddi3@plt
; RV32M-NEXT:    xori a2, s1, 2
; RV32M-NEXT:    or a2, a2, s3
; RV32M-NEXT:    snez a2, a2
; RV32M-NEXT:    xori a3, s5, 1
; RV32M-NEXT:    or a3, a3, s6
; RV32M-NEXT:    snez a3, a3
; RV32M-NEXT:    or a0, a0, a1
; RV32M-NEXT:    snez a0, a0
; RV32M-NEXT:    neg a1, a3
; RV32M-NEXT:    neg a4, a2
; RV32M-NEXT:    neg a5, a0
; RV32M-NEXT:    sw a5, 0(s0)
; RV32M-NEXT:    slli a3, a3, 1
; RV32M-NEXT:    sub a0, a0, a3
; RV32M-NEXT:    sw a0, 4(s0)
; RV32M-NEXT:    slli a0, a2, 2
; RV32M-NEXT:    srli a2, a4, 30
; RV32M-NEXT:    sub a2, a2, a0
; RV32M-NEXT:    andi a2, a2, 7
; RV32M-NEXT:    sb a2, 12(s0)
; RV32M-NEXT:    srli a2, a1, 31
; RV32M-NEXT:    andi a1, a1, 1
; RV32M-NEXT:    slli a1, a1, 1
; RV32M-NEXT:    or a1, a2, a1
; RV32M-NEXT:    sub a0, a1, a0
; RV32M-NEXT:    sw a0, 8(s0)
; RV32M-NEXT:    lw s6, 0(sp) # 4-byte Folded Reload
; RV32M-NEXT:    lw s5, 4(sp) # 4-byte Folded Reload
; RV32M-NEXT:    lw s4, 8(sp) # 4-byte Folded Reload
; RV32M-NEXT:    lw s3, 12(sp) # 4-byte Folded Reload
; RV32M-NEXT:    lw s2, 16(sp) # 4-byte Folded Reload
; RV32M-NEXT:    lw s1, 20(sp) # 4-byte Folded Reload
; RV32M-NEXT:    lw s0, 24(sp) # 4-byte Folded Reload
; RV32M-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32M-NEXT:    addi sp, sp, 32
; RV32M-NEXT:    ret
;
; RV64M-LABEL: test_srem_vec:
; RV64M:       # %bb.0:
; RV64M-NEXT:    lb a1, 12(a0)
; RV64M-NEXT:    lwu a2, 8(a0)
; RV64M-NEXT:    slli a1, a1, 32
; RV64M-NEXT:    or a2, a2, a1
; RV64M-NEXT:    addi a6, zero, -1
; RV64M-NEXT:    srli a3, a6, 24
; RV64M-NEXT:    and a2, a2, a3
; RV64M-NEXT:    ld a3, 0(a0)
; RV64M-NEXT:    slli a4, a2, 29
; RV64M-NEXT:    srai a4, a4, 31
; RV64M-NEXT:    slli a2, a2, 31
; RV64M-NEXT:    srli a5, a3, 33
; RV64M-NEXT:    or a2, a5, a2
; RV64M-NEXT:    slli a2, a2, 31
; RV64M-NEXT:    srai a2, a2, 31
; RV64M-NEXT:    slli a3, a3, 31
; RV64M-NEXT:    srai a3, a3, 31
; RV64M-NEXT:    lui a5, 18725
; RV64M-NEXT:    addiw a5, a5, -1755
; RV64M-NEXT:    slli a5, a5, 12
; RV64M-NEXT:    addi a5, a5, -1755
; RV64M-NEXT:    slli a5, a5, 12
; RV64M-NEXT:    addi a5, a5, -1755
; RV64M-NEXT:    slli a5, a5, 12
; RV64M-NEXT:    addi a5, a5, -1755
; RV64M-NEXT:    mulh a5, a2, a5
; RV64M-NEXT:    srli a1, a5, 63
; RV64M-NEXT:    srai a5, a5, 1
; RV64M-NEXT:    add a1, a5, a1
; RV64M-NEXT:    slli a5, a1, 3
; RV64M-NEXT:    sub a1, a1, a5
; RV64M-NEXT:    add a1, a2, a1
; RV64M-NEXT:    lui a2, 1035469
; RV64M-NEXT:    addiw a2, a2, -819
; RV64M-NEXT:    slli a2, a2, 12
; RV64M-NEXT:    addi a2, a2, -819
; RV64M-NEXT:    slli a2, a2, 12
; RV64M-NEXT:    addi a2, a2, -819
; RV64M-NEXT:    slli a2, a2, 13
; RV64M-NEXT:    addi a2, a2, -1639
; RV64M-NEXT:    mulh a2, a4, a2
; RV64M-NEXT:    srli a5, a2, 63
; RV64M-NEXT:    srai a2, a2, 1
; RV64M-NEXT:    add a2, a2, a5
; RV64M-NEXT:    slli a5, a2, 2
; RV64M-NEXT:    add a2, a5, a2
; RV64M-NEXT:    add a2, a4, a2
; RV64M-NEXT:    addi a2, a2, -2
; RV64M-NEXT:    snez a2, a2
; RV64M-NEXT:    addi a1, a1, -1
; RV64M-NEXT:    snez a1, a1
; RV64M-NEXT:    lui a4, 1026731
; RV64M-NEXT:    addiw a4, a4, -1365
; RV64M-NEXT:    slli a4, a4, 12
; RV64M-NEXT:    addi a4, a4, -1365
; RV64M-NEXT:    slli a4, a4, 12
; RV64M-NEXT:    addi a4, a4, -1365
; RV64M-NEXT:    slli a4, a4, 12
; RV64M-NEXT:    addi a4, a4, -1365
; RV64M-NEXT:    mul a3, a3, a4
; RV64M-NEXT:    lui a4, 10923
; RV64M-NEXT:    addiw a4, a4, -1365
; RV64M-NEXT:    slli a4, a4, 12
; RV64M-NEXT:    addi a4, a4, -1365
; RV64M-NEXT:    slli a4, a4, 12
; RV64M-NEXT:    addi a4, a4, -1365
; RV64M-NEXT:    slli a4, a4, 12
; RV64M-NEXT:    addi a4, a4, -1366
; RV64M-NEXT:    add a3, a3, a4
; RV64M-NEXT:    slli a5, a3, 63
; RV64M-NEXT:    srli a3, a3, 1
; RV64M-NEXT:    or a3, a3, a5
; RV64M-NEXT:    sltu a3, a4, a3
; RV64M-NEXT:    neg a1, a1
; RV64M-NEXT:    neg a4, a2
; RV64M-NEXT:    neg a3, a3
; RV64M-NEXT:    addi a5, zero, 7
; RV64M-NEXT:    slli a5, a5, 32
; RV64M-NEXT:    and a4, a4, a5
; RV64M-NEXT:    srli a4, a4, 32
; RV64M-NEXT:    sb a4, 12(a0)
; RV64M-NEXT:    slli a2, a2, 2
; RV64M-NEXT:    srli a4, a6, 31
; RV64M-NEXT:    and a1, a1, a4
; RV64M-NEXT:    srli a5, a1, 31
; RV64M-NEXT:    sub a2, a5, a2
; RV64M-NEXT:    sw a2, 8(a0)
; RV64M-NEXT:    slli a1, a1, 33
; RV64M-NEXT:    and a2, a3, a4
; RV64M-NEXT:    or a1, a2, a1
; RV64M-NEXT:    sd a1, 0(a0)
; RV64M-NEXT:    ret
;
; RV32MV-LABEL: test_srem_vec:
; RV32MV:       # %bb.0:
; RV32MV-NEXT:    addi sp, sp, -64
; RV32MV-NEXT:    sw ra, 60(sp) # 4-byte Folded Spill
; RV32MV-NEXT:    sw s0, 56(sp) # 4-byte Folded Spill
; RV32MV-NEXT:    sw s1, 52(sp) # 4-byte Folded Spill
; RV32MV-NEXT:    sw s2, 48(sp) # 4-byte Folded Spill
; RV32MV-NEXT:    sw s3, 44(sp) # 4-byte Folded Spill
; RV32MV-NEXT:    sw s4, 40(sp) # 4-byte Folded Spill
; RV32MV-NEXT:    sw s5, 36(sp) # 4-byte Folded Spill
; RV32MV-NEXT:    addi s0, sp, 64
; RV32MV-NEXT:    andi sp, sp, -32
; RV32MV-NEXT:    mv s1, a0
; RV32MV-NEXT:    lw a0, 8(a0)
; RV32MV-NEXT:    lw a1, 4(s1)
; RV32MV-NEXT:    slli a2, a0, 31
; RV32MV-NEXT:    srli a3, a1, 1
; RV32MV-NEXT:    or s2, a3, a2
; RV32MV-NEXT:    lbu a2, 12(s1)
; RV32MV-NEXT:    srli a3, a0, 1
; RV32MV-NEXT:    andi a3, a3, 1
; RV32MV-NEXT:    neg s3, a3
; RV32MV-NEXT:    slli a3, a2, 30
; RV32MV-NEXT:    srli a0, a0, 2
; RV32MV-NEXT:    or s4, a0, a3
; RV32MV-NEXT:    srli a0, a2, 2
; RV32MV-NEXT:    andi a2, a0, 1
; RV32MV-NEXT:    lw a0, 0(s1)
; RV32MV-NEXT:    neg s5, a2
; RV32MV-NEXT:    andi a1, a1, 1
; RV32MV-NEXT:    neg a1, a1
; RV32MV-NEXT:    addi a2, zero, 6
; RV32MV-NEXT:    mv a3, zero
; RV32MV-NEXT:    call __moddi3@plt
; RV32MV-NEXT:    sw a1, 4(sp)
; RV32MV-NEXT:    sw a0, 0(sp)
; RV32MV-NEXT:    addi a2, zero, -5
; RV32MV-NEXT:    addi a3, zero, -1
; RV32MV-NEXT:    mv a0, s4
; RV32MV-NEXT:    mv a1, s5
; RV32MV-NEXT:    call __moddi3@plt
; RV32MV-NEXT:    sw a1, 20(sp)
; RV32MV-NEXT:    sw a0, 16(sp)
; RV32MV-NEXT:    addi a2, zero, 7
; RV32MV-NEXT:    mv a0, s2
; RV32MV-NEXT:    mv a1, s3
; RV32MV-NEXT:    mv a3, zero
; RV32MV-NEXT:    call __moddi3@plt
; RV32MV-NEXT:    sw a1, 12(sp)
; RV32MV-NEXT:    sw a0, 8(sp)
; RV32MV-NEXT:    addi a0, zero, 85
; RV32MV-NEXT:    vsetivli a1, 1, e8,mf8,ta,mu
; RV32MV-NEXT:    vmv.s.x v0, a0
; RV32MV-NEXT:    vsetivli a0, 8, e32,m2,ta,mu
; RV32MV-NEXT:    vmv.v.i v26, 1
; RV32MV-NEXT:    vle32.v v28, (sp)
; RV32MV-NEXT:    lui a0, %hi(.LCPI3_0)
; RV32MV-NEXT:    addi a0, a0, %lo(.LCPI3_0)
; RV32MV-NEXT:    vle32.v v30, (a0)
; RV32MV-NEXT:    vmerge.vim v26, v26, -1, v0
; RV32MV-NEXT:    vand.vv v26, v28, v26
; RV32MV-NEXT:    vsetivli a0, 4, e64,m2,ta,mu
; RV32MV-NEXT:    vmsne.vv v0, v26, v30
; RV32MV-NEXT:    vmv.v.i v26, 0
; RV32MV-NEXT:    vmerge.vim v26, v26, -1, v0
; RV32MV-NEXT:    vsetvli zero, zero, e32,m2,ta,mu
; RV32MV-NEXT:    vmv.x.s a0, v26
; RV32MV-NEXT:    sw a0, 0(s1)
; RV32MV-NEXT:    vsetivli a0, 1, e32,m2,ta,mu
; RV32MV-NEXT:    vslidedown.vi v28, v26, 1
; RV32MV-NEXT:    vmv.x.s a0, v28
; RV32MV-NEXT:    vslidedown.vi v28, v26, 2
; RV32MV-NEXT:    vmv.x.s a1, v28
; RV32MV-NEXT:    slli a2, a1, 1
; RV32MV-NEXT:    sub a0, a2, a0
; RV32MV-NEXT:    sw a0, 4(s1)
; RV32MV-NEXT:    vslidedown.vi v28, v26, 4
; RV32MV-NEXT:    vmv.x.s a0, v28
; RV32MV-NEXT:    srli a2, a0, 30
; RV32MV-NEXT:    vslidedown.vi v28, v26, 5
; RV32MV-NEXT:    vmv.x.s a3, v28
; RV32MV-NEXT:    slli a3, a3, 2
; RV32MV-NEXT:    or a2, a3, a2
; RV32MV-NEXT:    andi a2, a2, 7
; RV32MV-NEXT:    sb a2, 12(s1)
; RV32MV-NEXT:    srli a1, a1, 31
; RV32MV-NEXT:    vslidedown.vi v26, v26, 3
; RV32MV-NEXT:    vmv.x.s a2, v26
; RV32MV-NEXT:    andi a2, a2, 1
; RV32MV-NEXT:    slli a2, a2, 1
; RV32MV-NEXT:    or a1, a1, a2
; RV32MV-NEXT:    slli a0, a0, 2
; RV32MV-NEXT:    or a0, a1, a0
; RV32MV-NEXT:    sw a0, 8(s1)
; RV32MV-NEXT:    addi sp, s0, -64
; RV32MV-NEXT:    lw s5, 36(sp) # 4-byte Folded Reload
; RV32MV-NEXT:    lw s4, 40(sp) # 4-byte Folded Reload
; RV32MV-NEXT:    lw s3, 44(sp) # 4-byte Folded Reload
; RV32MV-NEXT:    lw s2, 48(sp) # 4-byte Folded Reload
; RV32MV-NEXT:    lw s1, 52(sp) # 4-byte Folded Reload
; RV32MV-NEXT:    lw s0, 56(sp) # 4-byte Folded Reload
; RV32MV-NEXT:    lw ra, 60(sp) # 4-byte Folded Reload
; RV32MV-NEXT:    addi sp, sp, 64
; RV32MV-NEXT:    ret
;
; RV64MV-LABEL: test_srem_vec:
; RV64MV:       # %bb.0:
; RV64MV-NEXT:    addi sp, sp, -64
; RV64MV-NEXT:    sd ra, 56(sp) # 8-byte Folded Spill
; RV64MV-NEXT:    sd s0, 48(sp) # 8-byte Folded Spill
; RV64MV-NEXT:    addi s0, sp, 64
; RV64MV-NEXT:    andi sp, sp, -32
; RV64MV-NEXT:    lb a1, 12(a0)
; RV64MV-NEXT:    lwu a2, 8(a0)
; RV64MV-NEXT:    slli a1, a1, 32
; RV64MV-NEXT:    or a2, a2, a1
; RV64MV-NEXT:    addi a6, zero, -1
; RV64MV-NEXT:    ld a3, 0(a0)
; RV64MV-NEXT:    srli a4, a6, 24
; RV64MV-NEXT:    and a2, a2, a4
; RV64MV-NEXT:    slli a4, a2, 31
; RV64MV-NEXT:    srli a5, a3, 33
; RV64MV-NEXT:    or a4, a5, a4
; RV64MV-NEXT:    slli a4, a4, 31
; RV64MV-NEXT:    srai a4, a4, 31
; RV64MV-NEXT:    slli a2, a2, 29
; RV64MV-NEXT:    srai a2, a2, 31
; RV64MV-NEXT:    slli a3, a3, 31
; RV64MV-NEXT:    srai a3, a3, 31
; RV64MV-NEXT:    lui a5, 10923
; RV64MV-NEXT:    addiw a5, a5, -1365
; RV64MV-NEXT:    slli a5, a5, 12
; RV64MV-NEXT:    addi a5, a5, -1365
; RV64MV-NEXT:    slli a5, a5, 12
; RV64MV-NEXT:    addi a5, a5, -1365
; RV64MV-NEXT:    slli a5, a5, 12
; RV64MV-NEXT:    addi a5, a5, -1365
; RV64MV-NEXT:    mulh a5, a3, a5
; RV64MV-NEXT:    srli a1, a5, 63
; RV64MV-NEXT:    add a1, a5, a1
; RV64MV-NEXT:    addi a5, zero, 6
; RV64MV-NEXT:    mul a1, a1, a5
; RV64MV-NEXT:    sub a1, a3, a1
; RV64MV-NEXT:    sd a1, 0(sp)
; RV64MV-NEXT:    lui a1, 1035469
; RV64MV-NEXT:    addiw a1, a1, -819
; RV64MV-NEXT:    slli a1, a1, 12
; RV64MV-NEXT:    addi a1, a1, -819
; RV64MV-NEXT:    slli a1, a1, 12
; RV64MV-NEXT:    addi a1, a1, -819
; RV64MV-NEXT:    slli a1, a1, 13
; RV64MV-NEXT:    addi a1, a1, -1639
; RV64MV-NEXT:    mulh a1, a2, a1
; RV64MV-NEXT:    srli a3, a1, 63
; RV64MV-NEXT:    srai a1, a1, 1
; RV64MV-NEXT:    add a1, a1, a3
; RV64MV-NEXT:    slli a3, a1, 2
; RV64MV-NEXT:    add a1, a3, a1
; RV64MV-NEXT:    add a1, a2, a1
; RV64MV-NEXT:    sd a1, 16(sp)
; RV64MV-NEXT:    lui a1, 18725
; RV64MV-NEXT:    addiw a1, a1, -1755
; RV64MV-NEXT:    slli a1, a1, 12
; RV64MV-NEXT:    addi a1, a1, -1755
; RV64MV-NEXT:    slli a1, a1, 12
; RV64MV-NEXT:    addi a1, a1, -1755
; RV64MV-NEXT:    slli a1, a1, 12
; RV64MV-NEXT:    addi a1, a1, -1755
; RV64MV-NEXT:    mulh a1, a4, a1
; RV64MV-NEXT:    srli a2, a1, 63
; RV64MV-NEXT:    srai a1, a1, 1
; RV64MV-NEXT:    add a1, a1, a2
; RV64MV-NEXT:    slli a2, a1, 3
; RV64MV-NEXT:    sub a1, a1, a2
; RV64MV-NEXT:    add a1, a4, a1
; RV64MV-NEXT:    sd a1, 8(sp)
; RV64MV-NEXT:    vsetivli a1, 4, e64,m2,ta,mu
; RV64MV-NEXT:    vle64.v v26, (sp)
; RV64MV-NEXT:    lui a1, %hi(.LCPI3_0)
; RV64MV-NEXT:    addi a1, a1, %lo(.LCPI3_0)
; RV64MV-NEXT:    vle64.v v28, (a1)
; RV64MV-NEXT:    srli a1, a6, 31
; RV64MV-NEXT:    vand.vx v26, v26, a1
; RV64MV-NEXT:    vmsne.vv v0, v26, v28
; RV64MV-NEXT:    vmv.v.i v26, 0
; RV64MV-NEXT:    vmerge.vim v26, v26, -1, v0
; RV64MV-NEXT:    vsetivli a2, 1, e64,m2,ta,mu
; RV64MV-NEXT:    vslidedown.vi v28, v26, 2
; RV64MV-NEXT:    vmv.x.s a2, v28
; RV64MV-NEXT:    srli a3, a2, 30
; RV64MV-NEXT:    andi a3, a3, 7
; RV64MV-NEXT:    sb a3, 12(a0)
; RV64MV-NEXT:    slli a2, a2, 2
; RV64MV-NEXT:    vslidedown.vi v28, v26, 1
; RV64MV-NEXT:    vmv.x.s a3, v28
; RV64MV-NEXT:    and a3, a3, a1
; RV64MV-NEXT:    srli a4, a3, 31
; RV64MV-NEXT:    or a2, a4, a2
; RV64MV-NEXT:    sw a2, 8(a0)
; RV64MV-NEXT:    vmv.x.s a2, v26
; RV64MV-NEXT:    and a1, a2, a1
; RV64MV-NEXT:    slli a2, a3, 33
; RV64MV-NEXT:    or a1, a1, a2
; RV64MV-NEXT:    sd a1, 0(a0)
; RV64MV-NEXT:    addi sp, s0, -64
; RV64MV-NEXT:    ld s0, 48(sp) # 8-byte Folded Reload
; RV64MV-NEXT:    ld ra, 56(sp) # 8-byte Folded Reload
; RV64MV-NEXT:    addi sp, sp, 64
; RV64MV-NEXT:    ret
  %ld = load <3 x i33>, <3 x i33>* %X
  %srem = srem <3 x i33> %ld, <i33 6, i33 7, i33 -5>
  %cmp = icmp ne <3 x i33> %srem, <i33 0, i33 1, i33 2>
  %ext = sext <3 x i1> %cmp to <3 x i33>
  store <3 x i33> %ext, <3 x i33>* %X
  ret void
}
