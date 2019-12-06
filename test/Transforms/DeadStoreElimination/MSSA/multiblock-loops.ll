; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -basicaa -dse -enable-dse-memoryssa -S | FileCheck %s

target datalayout = "e-m:e-p:32:32-i64:64-v128:64:128-a:0:32-n32-S64"
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) nounwind

define void @test13(i32* noalias %P) {
; CHECK-LABEL: @test13(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[FOR:%.*]]
; CHECK:       for:
; CHECK-NEXT:    store i32 0, i32* [[P:%.*]]
; CHECK-NEXT:    br i1 false, label [[FOR]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  br label %for
for:
  store i32 0, i32* %P
  br i1 false, label %for, label %end
end:
  ret void
}


define void @test14(i32* noalias %P) {
; CHECK-LABEL: @test14(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    store i32 1, i32* [[P:%.*]]
; CHECK-NEXT:    br label [[FOR:%.*]]
; CHECK:       for:
; CHECK-NEXT:    store i32 0, i32* [[P]]
; CHECK-NEXT:    br i1 false, label [[FOR]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  store i32 1, i32* %P
  br label %for
for:
  store i32 0, i32* %P
  br i1 false, label %for, label %end
end:
  ret void
}

define void @test18(i32* noalias %P) {
; CHECK-LABEL: @test18(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[P2:%.*]] = bitcast i32* [[P:%.*]] to i8*
; CHECK-NEXT:    store i32 0, i32* [[P]]
; CHECK-NEXT:    br label [[FOR:%.*]]
; CHECK:       for:
; CHECK-NEXT:    store i8 1, i8* [[P2]]
; CHECK-NEXT:    [[X:%.*]] = load i32, i32* [[P]]
; CHECK-NEXT:    store i8 2, i8* [[P2]]
; CHECK-NEXT:    br i1 false, label [[FOR]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  %P2 = bitcast i32* %P to i8*
  store i32 0, i32* %P
  br label %for
for:
  store i8 1, i8* %P2
  %x = load i32, i32* %P
  store i8 2, i8* %P2
  br i1 false, label %for, label %end
end:
  ret void
}

define void @test21(i32* noalias %P) {
; CHECK-LABEL: @test21(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[ARRAYIDX0:%.*]] = getelementptr inbounds i32, i32* [[P:%.*]], i64 1
; CHECK-NEXT:    [[P3:%.*]] = bitcast i32* [[ARRAYIDX0]] to i8*
; CHECK-NEXT:    call void @llvm.memset.p0i8.i64(i8* align 4 [[P3]], i8 0, i64 28, i1 false)
; CHECK-NEXT:    br label [[FOR:%.*]]
; CHECK:       for:
; CHECK-NEXT:    [[ARRAYIDX1:%.*]] = getelementptr inbounds i32, i32* [[P]], i64 1
; CHECK-NEXT:    store i32 1, i32* [[ARRAYIDX1]], align 4
; CHECK-NEXT:    br i1 false, label [[FOR]], label [[END:%.*]]
; CHECK:       end:
; CHECK-NEXT:    ret void
;
entry:
  %arrayidx0 = getelementptr inbounds i32, i32* %P, i64 1
  %p3 = bitcast i32* %arrayidx0 to i8*
  call void @llvm.memset.p0i8.i64(i8* %p3, i8 0, i64 28, i32 4, i1 false)
  br label %for
for:
  %arrayidx1 = getelementptr inbounds i32, i32* %P, i64 1
  store i32 1, i32* %arrayidx1, align 4
  br i1 false, label %for, label %end
end:
  ret void
}

define void @test_loop(i32 %N, i32* noalias nocapture readonly %A, i32* noalias nocapture readonly %x, i32* noalias nocapture %b) local_unnamed_addr {
; CHECK-LABEL: @test_loop(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP27:%.*]] = icmp sgt i32 [[N:%.*]], 0
; CHECK-NEXT:    br i1 [[CMP27]], label [[FOR_BODY4_LR_PH_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body4.lr.ph.preheader:
; CHECK-NEXT:    br label [[FOR_BODY4_LR_PH:%.*]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body4.lr.ph:
; CHECK-NEXT:    [[I_028:%.*]] = phi i32 [ [[INC11:%.*]], [[FOR_COND_CLEANUP3:%.*]] ], [ 0, [[FOR_BODY4_LR_PH_PREHEADER]] ]
; CHECK-NEXT:    [[ARRAYIDX:%.*]] = getelementptr inbounds i32, i32* [[B:%.*]], i32 [[I_028]]
; CHECK-NEXT:    store i32 0, i32* [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[MUL:%.*]] = mul nsw i32 [[I_028]], [[N]]
; CHECK-NEXT:    br label [[FOR_BODY4:%.*]]
; CHECK:       for.body4:
; CHECK-NEXT:    [[TMP0:%.*]] = phi i32 [ 0, [[FOR_BODY4_LR_PH]] ], [ [[ADD9:%.*]], [[FOR_BODY4]] ]
; CHECK-NEXT:    [[J_026:%.*]] = phi i32 [ 0, [[FOR_BODY4_LR_PH]] ], [ [[INC:%.*]], [[FOR_BODY4]] ]
; CHECK-NEXT:    [[ADD:%.*]] = add nsw i32 [[J_026]], [[MUL]]
; CHECK-NEXT:    [[ARRAYIDX5:%.*]] = getelementptr inbounds i32, i32* [[A:%.*]], i32 [[ADD]]
; CHECK-NEXT:    [[TMP1:%.*]] = load i32, i32* [[ARRAYIDX5]], align 4
; CHECK-NEXT:    [[ARRAYIDX6:%.*]] = getelementptr inbounds i32, i32* [[X:%.*]], i32 [[J_026]]
; CHECK-NEXT:    [[TMP2:%.*]] = load i32, i32* [[ARRAYIDX6]], align 4
; CHECK-NEXT:    [[MUL7:%.*]] = mul nsw i32 [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[ADD9]] = add nsw i32 [[MUL7]], [[TMP0]]
; CHECK-NEXT:    [[INC]] = add nuw nsw i32 [[J_026]], 1
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp eq i32 [[INC]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_COND_CLEANUP3]], label [[FOR_BODY4]]
; CHECK:       for.cond.cleanup3:
; CHECK-NEXT:    store i32 [[ADD9]], i32* [[ARRAYIDX]], align 4
; CHECK-NEXT:    [[INC11]] = add nuw nsw i32 [[I_028]], 1
; CHECK-NEXT:    [[EXITCOND29:%.*]] = icmp eq i32 [[INC11]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND29]], label [[FOR_COND_CLEANUP]], label [[FOR_BODY4_LR_PH]]
;
entry:
  %cmp27 = icmp sgt i32 %N, 0
  br i1 %cmp27, label %for.body4.lr.ph.preheader, label %for.cond.cleanup

for.body4.lr.ph.preheader:                        ; preds = %entry
  br label %for.body4.lr.ph

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3, %entry
  ret void

for.body4.lr.ph:                                  ; preds = %for.body4.lr.ph.preheader, %for.cond.cleanup3
  %i.028 = phi i32 [ %inc11, %for.cond.cleanup3 ], [ 0, %for.body4.lr.ph.preheader ]
  %arrayidx = getelementptr inbounds i32, i32* %b, i32 %i.028
  store i32 0, i32* %arrayidx, align 4
  %mul = mul nsw i32 %i.028, %N
  br label %for.body4

for.body4:                                        ; preds = %for.body4, %for.body4.lr.ph
  %0 = phi i32 [ 0, %for.body4.lr.ph ], [ %add9, %for.body4 ]
  %j.026 = phi i32 [ 0, %for.body4.lr.ph ], [ %inc, %for.body4 ]
  %add = add nsw i32 %j.026, %mul
  %arrayidx5 = getelementptr inbounds i32, i32* %A, i32 %add
  %1 = load i32, i32* %arrayidx5, align 4
  %arrayidx6 = getelementptr inbounds i32, i32* %x, i32 %j.026
  %2 = load i32, i32* %arrayidx6, align 4
  %mul7 = mul nsw i32 %2, %1
  %add9 = add nsw i32 %mul7, %0
  %inc = add nuw nsw i32 %j.026, 1
  %exitcond = icmp eq i32 %inc, %N
  br i1 %exitcond, label %for.cond.cleanup3, label %for.body4

for.cond.cleanup3:                                ; preds = %for.body4
  store i32 %add9, i32* %arrayidx, align 4
  %inc11 = add nuw nsw i32 %i.028, 1
  %exitcond29 = icmp eq i32 %inc11, %N
  br i1 %exitcond29, label %for.cond.cleanup, label %for.body4.lr.ph
}
