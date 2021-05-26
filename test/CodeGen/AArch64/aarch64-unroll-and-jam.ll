; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes='loop-unroll-and-jam' < %s -mcpu=cortex-a55 -mtriple=aarch64-none-linux-eabi -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"

define void @unj(i32 %I, i32 %argj, i32* noalias nocapture %A, i32* noalias nocapture readonly %B) #0 {
; CHECK-LABEL: @unj(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP:%.*]] = icmp eq i32 [[ARGJ:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_END:%.*]], label [[FOR_PREHEADER:%.*]]
; CHECK:       for.preheader:
; CHECK-NEXT:    br label [[FOR_OUTER:%.*]]
; CHECK:       for.outer:
; CHECK-NEXT:    br label [[FOR_INNER:%.*]]
; CHECK:       for.inner:
; CHECK-NEXT:    [[J:%.*]] = phi i32 [ 0, [[FOR_OUTER]] ], [ [[INC:%.*]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[SUM:%.*]] = phi i32 [ 0, [[FOR_OUTER]] ], [ [[ADD:%.*]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[J_1:%.*]] = phi i32 [ 0, [[FOR_OUTER]] ], [ [[INC_1:%.*]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[SUM_1:%.*]] = phi i32 [ 0, [[FOR_OUTER]] ], [ [[ADD_1:%.*]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[J_2:%.*]] = phi i32 [ 0, [[FOR_OUTER]] ], [ [[INC_2:%.*]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[SUM_2:%.*]] = phi i32 [ 0, [[FOR_OUTER]] ], [ [[ADD_2:%.*]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[J_3:%.*]] = phi i32 [ 0, [[FOR_OUTER]] ], [ [[INC_3:%.*]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[SUM_3:%.*]] = phi i32 [ 0, [[FOR_OUTER]] ], [ [[ADD_3:%.*]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], i32 [[J]]
; CHECK-NEXT:    [[TMP0:%.*]] = load i32, i32* [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[SUB:%.*]] = add i32 [[SUM]], 10
; CHECK-NEXT:    [[ADD]] = sub i32 [[SUB]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw i32 [[J]], 1
; CHECK-NEXT:    [[ARRAYIDX_1:%.*]] = getelementptr inbounds i32, i32* [[B]], i32 [[J_1]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ARRAYIDX_1]], align 4
; CHECK-NEXT:    [[SUB_1:%.*]] = add i32 [[SUM_1]], 10
; CHECK-NEXT:    [[ADD_1]] = sub i32 [[SUB_1]], [[TMP1]]
; CHECK-NEXT:    [[INC_1]] = add nuw i32 [[J_1]], 1
; CHECK-NEXT:    [[ARRAYIDX_2:%.*]] = getelementptr inbounds i32, i32* [[B]], i32 [[J_2]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[ARRAYIDX_2]], align 4
; CHECK-NEXT:    [[SUB_2:%.*]] = add i32 [[SUM_2]], 10
; CHECK-NEXT:    [[ADD_2]] = sub i32 [[SUB_2]], [[TMP2]]
; CHECK-NEXT:    [[INC_2]] = add nuw i32 [[J_2]], 1
; CHECK-NEXT:    [[ARRAYIDX_3:%.*]] = getelementptr inbounds i32, i32* [[B]], i32 [[J_3]]
; CHECK-NEXT:    [[TMP3:%.*]] = load i32, i32* [[ARRAYIDX_3]], align 4
; CHECK-NEXT:    [[SUB_3:%.*]] = add i32 [[SUM_3]], 10
; CHECK-NEXT:    [[ADD_3]] = sub i32 [[SUB_3]], [[TMP3]]
; CHECK-NEXT:    [[INC_3]] = add nuw i32 [[J_3]], 1
; CHECK-NEXT:    [[EXITCOND_3:%.*]] = icmp eq i32 [[INC_3]], [[ARGJ]]
; CHECK-NEXT:    br i1 [[EXITCOND_3]], label [[FOR_LATCH:%.*]], label [[FOR_INNER]]
; CHECK:       for.latch:
; CHECK-NEXT:    [[ADD_LCSSA:%.*]] = phi i32 [ [[ADD]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[ADD_LCSSA_1:%.*]] = phi i32 [ [[ADD_1]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[ADD_LCSSA_2:%.*]] = phi i32 [ [[ADD_2]], [[FOR_INNER]] ]
; CHECK-NEXT:    [[ADD_LCSSA_3:%.*]] = phi i32 [ [[ADD_3]], [[FOR_INNER]] ]
; CHECK-NEXT:    store i32 [[ADD_LCSSA]], i32* [[A:%.*]], align 4
; CHECK-NEXT:    [[ARRAYIDX6_1:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 1
; CHECK-NEXT:    store i32 [[ADD_LCSSA_1]], i32* [[ARRAYIDX6_1]], align 4
; CHECK-NEXT:    [[ARRAYIDX6_2:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 2
; CHECK-NEXT:    store i32 [[ADD_LCSSA_2]], i32* [[ARRAYIDX6_2]], align 4
; CHECK-NEXT:    [[ARRAYIDX6_3:%.*]] = getelementptr inbounds i32, i32* [[A]], i32 3
; CHECK-NEXT:    store i32 [[ADD_LCSSA_3]], i32* [[ARRAYIDX6_3]], align 4
; CHECK-NEXT:    br label [[FOR_END_LOOPEXIT:%.*]]
; CHECK:       for.end.loopexit:
; CHECK-NEXT:    br label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp = icmp eq i32 %argj, 0
  br i1 %cmp, label %for.end, label %for.preheader

for.preheader:
  br label %for.outer

for.outer:
  %i = phi i32 [ %add8, %for.latch ], [ 0, %for.preheader ]
  br label %for.inner

for.inner:
  %j = phi i32 [ 0, %for.outer ], [ %inc, %for.inner ]
  %sum = phi i32 [ 0, %for.outer ], [ %add, %for.inner ]
  %arrayidx = getelementptr inbounds i32, i32* %B, i32 %j
  %0 = load i32, i32* %arrayidx, align 4
  %sub = add i32 %sum, 10
  %add = sub i32 %sub, %0
  %inc = add nuw i32 %j, 1
  %exitcond = icmp eq i32 %inc, %argj
  br i1 %exitcond, label %for.latch, label %for.inner

for.latch:
  %arrayidx6 = getelementptr inbounds i32, i32* %A, i32 %i
  store i32 %add, i32* %arrayidx6, align 4
  %add8 = add nuw nsw i32 %i, 1
  %exitcond23 = icmp eq i32 %add8, 4
  br i1 %exitcond23, label %for.end, label %for.outer

for.end:
  ret void
}
