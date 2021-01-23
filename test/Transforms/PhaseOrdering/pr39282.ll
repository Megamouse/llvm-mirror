; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -O2 -S < %s -enable-new-pm=0 | FileCheck %s
; RUN: opt -passes='default<O2>' -S < %s | FileCheck %s

define void @copy(i32* noalias %to, i32* noalias %from) {
; CHECK-LABEL: @copy(
; CHECK-NEXT:    [[X:%.*]] = load i32, i32* [[FROM:%.*]], align 4
; CHECK-NEXT:    store i32 [[X]], i32* [[TO:%.*]], align 4
; CHECK-NEXT:    ret void
;
  %x = load i32, i32* %from
  store i32 %x, i32* %to
  ret void
}

; Consider that %addr1 = %addr2 + 1, in which case %addr2i and %addr1i are
; noalias within one iteration, but may alias across iterations.
; TODO: This is a micompile.
define void @pr39282(i32* %addr1, i32* %addr2) {
; CHECK-LABEL: @pr39282(
; CHECK-NEXT:  start:
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl([[META0:metadata !.*]])
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl([[META3:metadata !.*]])
; CHECK-NEXT:    [[X_I:%.*]] = load i32, i32* [[ADDR1:%.*]], align 4, !alias.scope !3, !noalias !0
; CHECK-NEXT:    [[ADDR1I_1:%.*]] = getelementptr inbounds i32, i32* [[ADDR1]], i64 1
; CHECK-NEXT:    [[ADDR2I_1:%.*]] = getelementptr inbounds i32, i32* [[ADDR2:%.*]], i64 1
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl([[META0]])
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl([[META3]])
; CHECK-NEXT:    [[X_I_1:%.*]] = load i32, i32* [[ADDR1I_1]], align 4, !alias.scope !3, !noalias !0
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl([[META0]])
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl([[META3]])
; CHECK-NEXT:    store i32 [[X_I]], i32* [[ADDR2]], align 4, !alias.scope !0, !noalias !3
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl([[META0]])
; CHECK-NEXT:    tail call void @llvm.experimental.noalias.scope.decl([[META3]])
; CHECK-NEXT:    store i32 [[X_I_1]], i32* [[ADDR2I_1]], align 4, !alias.scope !0, !noalias !3
; CHECK-NEXT:    ret void
;
start:
  br label %body

body:
  %i = phi i32 [ 0, %start ], [ %i.next, %body ]
  %j = and i32 %i, 1
  %addr1i = getelementptr inbounds i32, i32* %addr1, i32 %j
  %addr2i = getelementptr inbounds i32, i32* %addr2, i32 %j
  call void @copy(i32* %addr2i, i32* %addr1i)
  %i.next = add i32 %i, 1
  %cmp = icmp slt i32 %i.next, 4
  br i1 %cmp, label %body, label %end

end:
  ret void
}
