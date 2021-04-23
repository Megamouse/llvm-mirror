; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --check-globals
; Test that the printf library call simplifier works correctly.
;
; RUN: opt < %s -instcombine -S | FileCheck %s

target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:128:128"

@hello_world = constant [13 x i8] c"hello world\0A\00"
@h = constant [2 x i8] c"h\00"
@percent_s = constant [4 x i8] c"%s\0A\00"
@format_str = constant [3 x i8] c"%s\00"
@charstr = constant [2 x i8] c"a\00"
@empty = constant [1 x i8] c"\00"

declare void @printf(i8*, ...)

; Check simplification of printf with void return type.

;.
; CHECK: @[[HELLO_WORLD:[a-zA-Z0-9_$"\\.-]+]] = constant [13 x i8] c"hello world\0A\00"
; CHECK: @[[H:[a-zA-Z0-9_$"\\.-]+]] = constant [2 x i8] c"h\00"
; CHECK: @[[PERCENT_S:[a-zA-Z0-9_$"\\.-]+]] = constant [4 x i8] c"%s\0A\00"
; CHECK: @[[FORMAT_STR:[a-zA-Z0-9_$"\\.-]+]] = constant [3 x i8] c"%s\00"
; CHECK: @[[CHARSTR:[a-zA-Z0-9_$"\\.-]+]] = constant [2 x i8] c"a\00"
; CHECK: @[[EMPTY:[a-zA-Z0-9_$"\\.-]+]] = constant [1 x i8] zeroinitializer
; CHECK: @[[STR:[a-zA-Z0-9_$"\\.-]+]] = private unnamed_addr constant [12 x i8] c"hello world\00", align 1
;.
define void @test_simplify1() {
; CHECK-LABEL: @test_simplify1(
; CHECK-NEXT:    [[PUTCHAR:%.*]] = call i32 @putchar(i32 104)
; CHECK-NEXT:    ret void
;
  %fmt = getelementptr [2 x i8], [2 x i8]* @h, i32 0, i32 0
  call void (i8*, ...) @printf(i8* %fmt)
  ret void
}

define void @test_simplify2() {
; CHECK-LABEL: @test_simplify2(
; CHECK-NEXT:    [[PUTS:%.*]] = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([12 x i8], [12 x i8]* @str, i32 0, i32 0))
; CHECK-NEXT:    ret void
;
  %fmt = getelementptr [13 x i8], [13 x i8]* @hello_world, i32 0, i32 0
  call void (i8*, ...) @printf(i8* %fmt)
  ret void
}

define void @test_simplify6() {
; CHECK-LABEL: @test_simplify6(
; CHECK-NEXT:    [[PUTS:%.*]] = call i32 @puts(i8* nonnull dereferenceable(1) getelementptr inbounds ([13 x i8], [13 x i8]* @hello_world, i32 0, i32 0))
; CHECK-NEXT:    ret void
;
  %fmt = getelementptr [4 x i8], [4 x i8]* @percent_s, i32 0, i32 0
  %str = getelementptr [13 x i8], [13 x i8]* @hello_world, i32 0, i32 0
  call void (i8*, ...) @printf(i8* %fmt, i8* %str)
  ret void
}

define void @test_simplify7() {
; CHECK-LABEL: @test_simplify7(
; CHECK-NEXT:    [[PUTCHAR:%.*]] = call i32 @putchar(i32 97)
; CHECK-NEXT:    ret void
;
  %fmt = getelementptr [3 x i8], [3 x i8]* @format_str, i32 0, i32 0
  %str = getelementptr [2 x i8], [2 x i8]* @charstr, i32 0, i32 0
  call void (i8*, ...) @printf(i8* %fmt, i8* %str)
  ret void
}

define void @test_simplify8() {
; CHECK-LABEL: @test_simplify8(
; CHECK-NEXT:    call void (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([3 x i8], [3 x i8]* @format_str, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @empty, i32 0, i32 0))
; CHECK-NEXT:    ret void
;
  %fmt = getelementptr [3 x i8], [3 x i8]* @format_str, i32 0, i32 0
  %str = getelementptr [1 x i8], [1 x i8]* @empty, i32 0, i32 0
  call void (i8*, ...) @printf(i8* %fmt, i8* %str)
  ret void
}

define void @test_simplify9() {
; CHECK-LABEL: @test_simplify9(
; CHECK-NEXT:    call void (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([3 x i8], [3 x i8]* @format_str, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @hello_world, i32 0, i32 0))
; CHECK-NEXT:    ret void
;
  %fmt = getelementptr [3 x i8], [3 x i8]* @format_str, i32 0, i32 0
  %str = getelementptr [13 x i8], [13 x i8]* @hello_world, i32 0, i32 0
  call void (i8*, ...) @printf(i8* %fmt, i8* %str)
  ret void
}

define void @test_simplify10() {
; CHECK-LABEL: @test_simplify10(
; CHECK-NEXT:    call void (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([3 x i8], [3 x i8]* @format_str, i32 0, i32 0), i8* getelementptr inbounds ([1 x i8], [1 x i8]* @empty, i32 0, i32 0), i32 42, double 0x40091EB860000000)
; CHECK-NEXT:    [[PUTCHAR:%.*]] = call i32 @putchar(i32 97)
; CHECK-NEXT:    call void (i8*, ...) @printf(i8* nonnull dereferenceable(1) getelementptr inbounds ([3 x i8], [3 x i8]* @format_str, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @hello_world, i32 0, i32 0), i32 42, double 0x40091EB860000000)
; CHECK-NEXT:    ret void
;
  %fmt = getelementptr [3 x i8], [3 x i8]* @format_str, i32 0, i32 0
  %str1 = getelementptr [1 x i8], [1 x i8]* @empty, i32 0, i32 0
  call void (i8*, ...) @printf(i8* %fmt, i8* %str1, i32 42, double 0x40091EB860000000)
  %str2 = getelementptr [2 x i8], [2 x i8]* @charstr, i32 0, i32 0
  call void (i8*, ...) @printf(i8* %fmt, i8* %str2, i32 42, double 0x40091EB860000000)
  %str3 = getelementptr [13 x i8], [13 x i8]* @hello_world, i32 0, i32 0
  call void (i8*, ...) @printf(i8* %fmt, i8* %str3, i32 42, double 0x40091EB860000000)
  ret void
}
;.
; CHECK: attributes #[[ATTR0:[0-9]+]] = { nofree nounwind }
;.
