; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV32IFD %s
; RUN: llc -mtriple=riscv64 -mattr=+d -verify-machineinstrs < %s \
; RUN:   | FileCheck -check-prefix=RV64IFD %s

define dso_local double @fld(double *%a) nounwind {
; RV32IFD-LABEL: fld:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    fld ft0, 0(a0)
; RV32IFD-NEXT:    fld ft1, 24(a0)
; RV32IFD-NEXT:    fadd.d ft0, ft0, ft1
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fld:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fld ft0, 0(a0)
; RV64IFD-NEXT:    fld ft1, 24(a0)
; RV64IFD-NEXT:    fadd.d ft0, ft0, ft1
; RV64IFD-NEXT:    fmv.x.d a0, ft0
; RV64IFD-NEXT:    ret
  %1 = load double, double* %a
  %2 = getelementptr double, double* %a, i32 3
  %3 = load double, double* %2
; Use both loaded values in an FP op to ensure an fld is used, even for the
; soft float ABI
  %4 = fadd double %1, %3
  ret double %4
}

define dso_local void @fsd(double *%a, double %b, double %c) nounwind {
; RV32IFD-LABEL: fsd:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw a3, 8(sp)
; RV32IFD-NEXT:    sw a4, 12(sp)
; RV32IFD-NEXT:    fld ft0, 8(sp)
; RV32IFD-NEXT:    sw a1, 8(sp)
; RV32IFD-NEXT:    sw a2, 12(sp)
; RV32IFD-NEXT:    fld ft1, 8(sp)
; RV32IFD-NEXT:    fadd.d ft0, ft1, ft0
; RV32IFD-NEXT:    fsd ft0, 0(a0)
; RV32IFD-NEXT:    fsd ft0, 64(a0)
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fsd:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fmv.d.x ft0, a2
; RV64IFD-NEXT:    fmv.d.x ft1, a1
; RV64IFD-NEXT:    fadd.d ft0, ft1, ft0
; RV64IFD-NEXT:    fsd ft0, 0(a0)
; RV64IFD-NEXT:    fsd ft0, 64(a0)
; RV64IFD-NEXT:    ret
; Use %b and %c in an FP op to ensure floating point registers are used, even
; for the soft float ABI
  %1 = fadd double %b, %c
  store double %1, double* %a
  %2 = getelementptr double, double* %a, i32 8
  store double %1, double* %2
  ret void
}

; Check load and store to a global
@G = dso_local global double 0.0

define dso_local double @fld_fsd_global(double %a, double %b) nounwind {
; RV32IFD-LABEL: fld_fsd_global:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw a2, 8(sp)
; RV32IFD-NEXT:    sw a3, 12(sp)
; RV32IFD-NEXT:    fld ft0, 8(sp)
; RV32IFD-NEXT:    sw a0, 8(sp)
; RV32IFD-NEXT:    sw a1, 12(sp)
; RV32IFD-NEXT:    fld ft1, 8(sp)
; RV32IFD-NEXT:    fadd.d ft0, ft1, ft0
; RV32IFD-NEXT:    lui a0, %hi(G)
; RV32IFD-NEXT:    fld ft1, %lo(G)(a0)
; RV32IFD-NEXT:    fsd ft0, %lo(G)(a0)
; RV32IFD-NEXT:    addi a0, a0, %lo(G)
; RV32IFD-NEXT:    fld ft1, 72(a0)
; RV32IFD-NEXT:    fsd ft0, 72(a0)
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fld_fsd_global:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fmv.d.x ft0, a1
; RV64IFD-NEXT:    fmv.d.x ft1, a0
; RV64IFD-NEXT:    fadd.d ft0, ft1, ft0
; RV64IFD-NEXT:    lui a0, %hi(G)
; RV64IFD-NEXT:    fld ft1, %lo(G)(a0)
; RV64IFD-NEXT:    fsd ft0, %lo(G)(a0)
; RV64IFD-NEXT:    addi a1, a0, %lo(G)
; RV64IFD-NEXT:    fld ft1, 72(a1)
; RV64IFD-NEXT:    fmv.x.d a0, ft0
; RV64IFD-NEXT:    fsd ft0, 72(a1)
; RV64IFD-NEXT:    ret
; Use %a and %b in an FP op to ensure floating point registers are used, even
; for the soft float ABI
  %1 = fadd double %a, %b
  %2 = load volatile double, double* @G
  store double %1, double* @G
  %3 = getelementptr double, double* @G, i32 9
  %4 = load volatile double, double* %3
  store double %1, double* %3
  ret double %1
}

; Ensure that 1 is added to the high 20 bits if bit 11 of the low part is 1
define dso_local double @fld_fsd_constant(double %a) nounwind {
; RV32IFD-LABEL: fld_fsd_constant:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw a0, 8(sp)
; RV32IFD-NEXT:    sw a1, 12(sp)
; RV32IFD-NEXT:    fld ft0, 8(sp)
; RV32IFD-NEXT:    lui a0, 912092
; RV32IFD-NEXT:    fld ft1, -273(a0)
; RV32IFD-NEXT:    fadd.d ft0, ft0, ft1
; RV32IFD-NEXT:    fsd ft0, -273(a0)
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fld_fsd_constant:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    lui a1, 56
; RV64IFD-NEXT:    addiw a1, a1, -1353
; RV64IFD-NEXT:    slli a1, a1, 14
; RV64IFD-NEXT:    fld ft0, -273(a1)
; RV64IFD-NEXT:    fmv.d.x ft1, a0
; RV64IFD-NEXT:    fadd.d ft0, ft1, ft0
; RV64IFD-NEXT:    fmv.x.d a0, ft0
; RV64IFD-NEXT:    fsd ft0, -273(a1)
; RV64IFD-NEXT:    ret
  %1 = inttoptr i32 3735928559 to double*
  %2 = load volatile double, double* %1
  %3 = fadd double %a, %2
  store double %3, double* %1
  ret double %3
}

declare void @notdead(i8*)

define dso_local double @fld_stack(double %a) nounwind {
; RV32IFD-LABEL: fld_stack:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    sw a0, 8(sp)
; RV32IFD-NEXT:    sw a1, 12(sp)
; RV32IFD-NEXT:    fld ft0, 8(sp)
; RV32IFD-NEXT:    fsd ft0, 0(sp) # 8-byte Folded Spill
; RV32IFD-NEXT:    addi a0, sp, 16
; RV32IFD-NEXT:    call notdead@plt
; RV32IFD-NEXT:    fld ft0, 16(sp)
; RV32IFD-NEXT:    fld ft1, 0(sp) # 8-byte Folded Reload
; RV32IFD-NEXT:    fadd.d ft0, ft0, ft1
; RV32IFD-NEXT:    fsd ft0, 8(sp)
; RV32IFD-NEXT:    lw a0, 8(sp)
; RV32IFD-NEXT:    lw a1, 12(sp)
; RV32IFD-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fld_stack:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    addi sp, sp, -32
; RV64IFD-NEXT:    sd ra, 24(sp) # 8-byte Folded Spill
; RV64IFD-NEXT:    fmv.d.x ft0, a0
; RV64IFD-NEXT:    fsd ft0, 8(sp) # 8-byte Folded Spill
; RV64IFD-NEXT:    addi a0, sp, 16
; RV64IFD-NEXT:    call notdead@plt
; RV64IFD-NEXT:    fld ft0, 16(sp)
; RV64IFD-NEXT:    fld ft1, 8(sp) # 8-byte Folded Reload
; RV64IFD-NEXT:    fadd.d ft0, ft0, ft1
; RV64IFD-NEXT:    fmv.x.d a0, ft0
; RV64IFD-NEXT:    ld ra, 24(sp) # 8-byte Folded Reload
; RV64IFD-NEXT:    addi sp, sp, 32
; RV64IFD-NEXT:    ret
  %1 = alloca double, align 8
  %2 = bitcast double* %1 to i8*
  call void @notdead(i8* %2)
  %3 = load double, double* %1
  %4 = fadd double %3, %a ; force load in to FPR64
  ret double %4
}

define dso_local void @fsd_stack(double %a, double %b) nounwind {
; RV32IFD-LABEL: fsd_stack:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -32
; RV32IFD-NEXT:    sw ra, 28(sp) # 4-byte Folded Spill
; RV32IFD-NEXT:    sw a2, 8(sp)
; RV32IFD-NEXT:    sw a3, 12(sp)
; RV32IFD-NEXT:    fld ft0, 8(sp)
; RV32IFD-NEXT:    sw a0, 8(sp)
; RV32IFD-NEXT:    sw a1, 12(sp)
; RV32IFD-NEXT:    fld ft1, 8(sp)
; RV32IFD-NEXT:    fadd.d ft0, ft1, ft0
; RV32IFD-NEXT:    fsd ft0, 16(sp)
; RV32IFD-NEXT:    addi a0, sp, 16
; RV32IFD-NEXT:    call notdead@plt
; RV32IFD-NEXT:    lw ra, 28(sp) # 4-byte Folded Reload
; RV32IFD-NEXT:    addi sp, sp, 32
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fsd_stack:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    addi sp, sp, -16
; RV64IFD-NEXT:    sd ra, 8(sp) # 8-byte Folded Spill
; RV64IFD-NEXT:    fmv.d.x ft0, a1
; RV64IFD-NEXT:    fmv.d.x ft1, a0
; RV64IFD-NEXT:    fadd.d ft0, ft1, ft0
; RV64IFD-NEXT:    fsd ft0, 0(sp)
; RV64IFD-NEXT:    mv a0, sp
; RV64IFD-NEXT:    call notdead@plt
; RV64IFD-NEXT:    ld ra, 8(sp) # 8-byte Folded Reload
; RV64IFD-NEXT:    addi sp, sp, 16
; RV64IFD-NEXT:    ret
  %1 = fadd double %a, %b ; force store from FPR64
  %2 = alloca double, align 8
  store double %1, double* %2
  %3 = bitcast double* %2 to i8*
  call void @notdead(i8* %3)
  ret void
}

; Test selection of store<ST4[%a], trunc to f32>, ..
define dso_local void @fsd_trunc(float* %a, double %b) nounwind noinline optnone {
; RV32IFD-LABEL: fsd_trunc:
; RV32IFD:       # %bb.0:
; RV32IFD-NEXT:    addi sp, sp, -16
; RV32IFD-NEXT:    sw a1, 8(sp)
; RV32IFD-NEXT:    sw a2, 12(sp)
; RV32IFD-NEXT:    fld ft0, 8(sp)
; RV32IFD-NEXT:    fcvt.s.d ft0, ft0
; RV32IFD-NEXT:    fsw ft0, 0(a0)
; RV32IFD-NEXT:    addi sp, sp, 16
; RV32IFD-NEXT:    ret
;
; RV64IFD-LABEL: fsd_trunc:
; RV64IFD:       # %bb.0:
; RV64IFD-NEXT:    fmv.d.x ft0, a1
; RV64IFD-NEXT:    fcvt.s.d ft0, ft0
; RV64IFD-NEXT:    fsw ft0, 0(a0)
; RV64IFD-NEXT:    ret
  %1 = fptrunc double %b to float
  store float %1, float* %a, align 4
  ret void
}
