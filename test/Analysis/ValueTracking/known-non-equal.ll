; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -instsimplify < %s -S | FileCheck %s

define i1 @test(i8* %pq, i8 %B) {
; CHECK-LABEL: @test(
; CHECK-NEXT:    ret i1 false
;
  %q = load i8, i8* %pq, !range !0 ; %q is known nonzero; no known bits
  %A = add nsw i8 %B, %q
  %cmp = icmp eq i8 %A, %B
  ret i1 %cmp
}

define i1 @test2(i8 %a, i8 %b) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:    ret i1 false
;
  %A = or i8 %a, 2    ; %A[1] = 1
  %B = and i8 %b, -3  ; %B[1] = 0
  %cmp = icmp eq i8 %A, %B ; %A[1] and %B[1] are contradictory.
  ret i1 %cmp
}

define i1 @test3(i8 %B) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:    ret i1 false
;
  %A = add nsw i8 %B, 1
  %cmp = icmp eq i8 %A, %B
  ret i1 %cmp
}

define i1 @sext(i8 %B) {
; CHECK-LABEL: @sext(
; CHECK-NEXT:    ret i1 false
;
  %A = add nsw i8 %B, 1
  %A.cast = sext i8 %A to i32
  %B.cast = sext i8 %B to i32
  %cmp = icmp eq i32 %A.cast, %B.cast
  ret i1 %cmp
}

define i1 @zext(i8 %B) {
; CHECK-LABEL: @zext(
; CHECK-NEXT:    ret i1 false
;
  %A = add nsw i8 %B, 1
  %A.cast = zext i8 %A to i32
  %B.cast = zext i8 %B to i32
  %cmp = icmp eq i32 %A.cast, %B.cast
  ret i1 %cmp
}

define i1 @inttoptr(i32 %B) {
; CHECK-LABEL: @inttoptr(
; CHECK-NEXT:    [[A:%.*]] = add nsw i32 [[B:%.*]], 1
; CHECK-NEXT:    [[A_CAST:%.*]] = inttoptr i32 [[A]] to i8*
; CHECK-NEXT:    [[B_CAST:%.*]] = inttoptr i32 [[B]] to i8*
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8* [[A_CAST]], [[B_CAST]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %A = add nsw i32 %B, 1
  %A.cast = inttoptr i32 %A to i8*
  %B.cast = inttoptr i32 %B to i8*
  %cmp = icmp eq i8* %A.cast, %B.cast
  ret i1 %cmp
}

define i1 @ptrtoint(i32* %B) {
; CHECK-LABEL: @ptrtoint(
; CHECK-NEXT:    [[A:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], i32 1
; CHECK-NEXT:    [[A_CAST:%.*]] = ptrtoint i32* [[A]] to i32
; CHECK-NEXT:    [[B_CAST:%.*]] = ptrtoint i32* [[B]] to i32
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[A_CAST]], [[B_CAST]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %A = getelementptr inbounds i32, i32* %B, i32 1
  %A.cast = ptrtoint i32* %A to i32
  %B.cast = ptrtoint i32* %B to i32
  %cmp = icmp eq i32 %A.cast, %B.cast
  ret i1 %cmp
}

define i1 @add1(i8 %B, i8 %C) {
; CHECK-LABEL: @add1(
; CHECK-NEXT:    ret i1 false
;
  %A = add i8 %B, 1
  %A.op = add i8 %A, %C
  %B.op = add i8 %B, %C

  %cmp = icmp eq i8 %A.op, %B.op
  ret i1 %cmp
}

define i1 @add2(i8 %B, i8 %C) {
; CHECK-LABEL: @add2(
; CHECK-NEXT:    ret i1 false
;
  %A = add i8 %B, 1
  %A.op = add i8 %C, %A
  %B.op = add i8 %C, %B

  %cmp = icmp eq i8 %A.op, %B.op
  ret i1 %cmp
}

define i1 @sub1(i8 %B, i8 %C) {
; CHECK-LABEL: @sub1(
; CHECK-NEXT:    ret i1 false
;
  %A = add i8 %B, 1
  %A.op = sub i8 %A, %C
  %B.op = sub i8 %B, %C

  %cmp = icmp eq i8 %A.op, %B.op
  ret i1 %cmp
}

define i1 @sub2(i8 %B, i8 %C) {
; CHECK-LABEL: @sub2(
; CHECK-NEXT:    ret i1 false
;
  %A = add i8 %B, 1
  %A.op = sub i8 %C, %A
  %B.op = sub i8 %C, %B

  %cmp = icmp eq i8 %A.op, %B.op
  ret i1 %cmp
}

; op could wrap mapping two values to the same output value.
define i1 @mul1(i8 %B) {
; CHECK-LABEL: @mul1(
; CHECK-NEXT:    [[A:%.*]] = add i8 [[B:%.*]], 1
; CHECK-NEXT:    [[A_OP:%.*]] = mul i8 [[A]], 27
; CHECK-NEXT:    [[B_OP:%.*]] = mul i8 [[B]], 27
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A_OP]], [[B_OP]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %A = add i8 %B, 1
  %A.op = mul i8 %A, 27
  %B.op = mul i8 %B, 27

  %cmp = icmp eq i8 %A.op, %B.op
  ret i1 %cmp
}

define i1 @mul2(i8 %B) {
; CHECK-LABEL: @mul2(
; CHECK-NEXT:    ret i1 false
;
  %A = add i8 %B, 1
  %A.op = mul nuw i8 %A, 27
  %B.op = mul nuw i8 %B, 27

  %cmp = icmp eq i8 %A.op, %B.op
  ret i1 %cmp
}

define i1 @mul3(i8 %B) {
; CHECK-LABEL: @mul3(
; CHECK-NEXT:    ret i1 false
;
  %A = add i8 %B, 1
  %A.op = mul nsw i8 %A, 27
  %B.op = mul nsw i8 %B, 27

  %cmp = icmp eq i8 %A.op, %B.op
  ret i1 %cmp
}

; Multiply by zero collapses all values to one
define i1 @mul4(i8 %B) {
; CHECK-LABEL: @mul4(
; CHECK-NEXT:    ret i1 true
;
  %A = add i8 %B, 1
  %A.op = mul nuw i8 %A, 0
  %B.op = mul nuw i8 %B, 0

  %cmp = icmp eq i8 %A.op, %B.op
  ret i1 %cmp
}

; C might be zero, we can't tell
define i1 @mul5(i8 %B, i8 %C) {
; CHECK-LABEL: @mul5(
; CHECK-NEXT:    [[A:%.*]] = add i8 [[B:%.*]], 1
; CHECK-NEXT:    [[A_OP:%.*]] = mul nuw nsw i8 [[A]], [[C:%.*]]
; CHECK-NEXT:    [[B_OP:%.*]] = mul nuw nsw i8 [[B]], [[C]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i8 [[A_OP]], [[B_OP]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %A = add i8 %B, 1
  %A.op = mul nsw nuw i8 %A, %C
  %B.op = mul nsw nuw i8 %B, %C

  %cmp = icmp eq i8 %A.op, %B.op
  ret i1 %cmp
}

@g = external global i16, align 1

define i1 @mul_constantexpr(i16 %a) {
; CHECK-LABEL: @mul_constantexpr(
; CHECK-NEXT:    [[MUL:%.*]] = mul nsw i16 [[A:%.*]], 3
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i16 mul nsw (i16 ptrtoint (i16* @g to i16), i16 -1), [[MUL]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %mul = mul nsw i16 %a, 3
  %cmp = icmp eq i16 mul nsw (i16 ptrtoint (i16* @g to i16), i16 -1), %mul
  ret i1 %cmp
}

define i1 @mul_nuw(i16 %x) {
; CHECK-LABEL: @mul_nuw(
; CHECK-NEXT:    ret i1 false
;
  %nz = or i16 %x, 2
  %mul = mul nuw i16 %nz, 2
  %cmp = icmp eq i16 %nz, %mul
  ret i1 %cmp
}

define i1 @mul_nuw_comm(i16 %x) {
; CHECK-LABEL: @mul_nuw_comm(
; CHECK-NEXT:    ret i1 false
;
  %nz = or i16 %x, 2
  %mul = mul nuw i16 %nz, 2
  %cmp = icmp eq i16 %mul, %nz
  ret i1 %cmp
}

define i1 @mul_nsw(i16 %x) {
; CHECK-LABEL: @mul_nsw(
; CHECK-NEXT:    ret i1 false
;
  %nz = or i16 %x, 2
  %mul = mul nsw i16 %nz, 2
  %cmp = icmp eq i16 %nz, %mul
  ret i1 %cmp
}

define i1 @mul_nsw_comm(i16 %x) {
; CHECK-LABEL: @mul_nsw_comm(
; CHECK-NEXT:    ret i1 false
;
  %nz = or i16 %x, 2
  %mul = mul nsw i16 %nz, 2
  %cmp = icmp eq i16 %mul, %nz
  ret i1 %cmp
}

define i1 @mul_may_wrap(i16 %x) {
; CHECK-LABEL: @mul_may_wrap(
; CHECK-NEXT:    [[NZ:%.*]] = or i16 [[X:%.*]], 2
; CHECK-NEXT:    [[MUL:%.*]] = mul i16 [[NZ]], 2
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i16 [[NZ]], [[MUL]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %nz = or i16 %x, 2
  %mul = mul i16 %nz, 2
  %cmp = icmp eq i16 %nz, %mul
  ret i1 %cmp
}

define i1 @mul_may_be_zero(i16 %x) {
; CHECK-LABEL: @mul_may_be_zero(
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw i16 [[X:%.*]], 2
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i16 [[X]], [[MUL]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %mul = mul nuw i16 %x, 2
  %cmp = icmp eq i16 %x, %mul
  ret i1 %cmp
}

define i1 @mul_other_may_be_zero_or_one(i16 %x, i16 %y) {
; CHECK-LABEL: @mul_other_may_be_zero_or_one(
; CHECK-NEXT:    [[NZ:%.*]] = or i16 [[X:%.*]], 2
; CHECK-NEXT:    [[MUL:%.*]] = mul nuw i16 [[NZ]], [[Y:%.*]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i16 [[NZ]], [[MUL]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
  %nz = or i16 %x, 2
  %mul = mul nuw i16 %nz, %y
  %cmp = icmp eq i16 %nz, %mul
  ret i1 %cmp
}

define i1 @known_non_equal_phis(i8 %p, i8* %pq, i8 %n, i8 %r) {
; CHECK-LABEL: @known_non_equal_phis(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[A:%.*]] = phi i8 [ 2, [[ENTRY:%.*]] ], [ [[NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[NEXT]] = mul nsw i8 [[A]], 2
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i8 [[A]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i1 true
;
entry:
  br label %loop
loop:
  %A = phi i8 [ 2, %entry ], [ %next, %loop ]
  %B = phi i8 [ 3, %entry ], [ %A, %loop ]
  %next = mul nsw i8 %A, 2
  %cmp1 = icmp eq i8 %A, %n
  br i1 %cmp1, label %exit, label %loop
exit:
  %cmp = icmp ne i8 %A, %B
  ret i1 %cmp
}

define i1 @known_non_equal_phis_fail(i8 %p, i8* %pq, i8 %n, i8 %r) {
; CHECK-LABEL: @known_non_equal_phis_fail(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[A:%.*]] = phi i8 [ 2, [[ENTRY:%.*]] ], [ [[NEXT:%.*]], [[LOOP]] ]
; CHECK-NEXT:    [[B:%.*]] = phi i8 [ 2, [[ENTRY]] ], [ [[A]], [[LOOP]] ]
; CHECK-NEXT:    [[NEXT]] = mul nsw i8 [[A]], 2
; CHECK-NEXT:    [[CMP1:%.*]] = icmp eq i8 [[A]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    [[CMP:%.*]] = icmp ne i8 [[A]], [[B]]
; CHECK-NEXT:    ret i1 [[CMP]]
;
entry:
  br label %loop
loop:
  %A = phi i8 [ 2, %entry ], [ %next, %loop ]
  %B = phi i8 [ 2, %entry ], [ %A, %loop ]
  %next = mul nsw i8 %A, 2
  %cmp1 = icmp eq i8 %A, %n
  br i1 %cmp1, label %exit, label %loop
exit:
  %cmp = icmp ne i8 %A, %B
  ret i1 %cmp
}

!0 = !{ i8 1, i8 5 }
