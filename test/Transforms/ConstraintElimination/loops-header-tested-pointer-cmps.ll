; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -constraint-elimination -S %s | FileCheck %s

declare void @use(i1)

define void @test1(i8* %src, i8* noundef %lower, i8* noundef %upper, i8 %N) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SRC_END:%.*]] = getelementptr inbounds i8, i8* [[SRC:%.*]], i8 [[N:%.*]]
; CHECK-NEXT:    [[CMP_SRC_START:%.*]] = icmp ult i8* [[SRC]], [[LOWER:%.*]]
; CHECK-NEXT:    [[CMP_SRC_END:%.*]] = icmp uge i8* [[SRC_END]], [[UPPER:%.*]]
; CHECK-NEXT:    [[OR_0:%.*]] = or i1 [[CMP_SRC_START]], [[CMP_SRC_END]]
; CHECK-NEXT:    br i1 [[OR_0]], label [[TRAP_BB:%.*]], label [[LOOP_HEADER:%.*]]
; CHECK:       trap.bb:
; CHECK-NEXT:    ret void
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i8 [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ], [ 0, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[EC:%.*]] = icmp uge i8 [[IV]], [[N]]
; CHECK-NEXT:    br i1 [[EC]], label [[EXIT:%.*]], label [[LOOP_BODY:%.*]]
; CHECK:       loop.body:
; CHECK-NEXT:    [[SRC_IV:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[IV]]
; CHECK-NEXT:    [[CMP_IV_START:%.*]] = icmp ult i8* [[SRC_IV]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_END:%.*]] = icmp uge i8* [[SRC_IV]], [[UPPER]]
; CHECK-NEXT:    [[OR_1:%.*]] = or i1 [[CMP_IV_START]], false
; CHECK-NEXT:    br i1 [[OR_1]], label [[TRAP_BB]], label [[LOOP_BODY_1:%.*]]
; CHECK:       loop.body.1:
; CHECK-NEXT:    [[PTR_SRC_IV:%.*]] = bitcast i8* [[SRC_IV]] to i32*
; CHECK-NEXT:    store i32 0, i32* [[PTR_SRC_IV]], align 4
; CHECK-NEXT:    [[ADD_1:%.*]] = add nuw nsw i8 [[IV]], 1
; CHECK-NEXT:    [[SRC_IV_1:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[ADD_1]]
; CHECK-NEXT:    [[CMP_IV_1_START:%.*]] = icmp ult i8* [[SRC_IV_1]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_1_END:%.*]] = icmp uge i8* [[SRC_IV_1]], [[UPPER]]
; CHECK-NEXT:    [[OR_2:%.*]] = or i1 [[CMP_IV_1_START]], [[CMP_IV_1_END]]
; CHECK-NEXT:    br i1 [[OR_2]], label [[TRAP_BB]], label [[LOOP_BODY_2:%.*]]
; CHECK:       loop.body.2:
; CHECK-NEXT:    [[PTR_SRC_IV_1:%.*]] = bitcast i8* [[SRC_IV_1]] to i32*
; CHECK-NEXT:    store i32 0, i32* [[PTR_SRC_IV_1]], align 4
; CHECK-NEXT:    [[ADD_2:%.*]] = add nuw nsw i8 [[IV]], 2
; CHECK-NEXT:    [[SRC_IV_2:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[ADD_2]]
; CHECK-NEXT:    [[CMP_IV_2_START:%.*]] = icmp ult i8* [[SRC_IV_2]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_2_END:%.*]] = icmp uge i8* [[SRC_IV_2]], [[UPPER]]
; CHECK-NEXT:    [[OR_3:%.*]] = or i1 [[CMP_IV_2_START]], [[CMP_IV_2_END]]
; CHECK-NEXT:    br i1 [[OR_3]], label [[TRAP_BB]], label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[PTR_SRC_IV_2:%.*]] = bitcast i8* [[SRC_IV_2]] to i32*
; CHECK-NEXT:    store i32 0, i32* [[PTR_SRC_IV_2]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i8 [[IV]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %src.end = getelementptr inbounds i8, i8* %src, i8 %N
  %cmp.src.start = icmp ult i8* %src, %lower
  %cmp.src.end = icmp uge i8* %src.end, %upper
  %or.0 = or i1 %cmp.src.start, %cmp.src.end
  br i1 %or.0, label %trap.bb, label %loop.header

trap.bb:
  ret void

loop.header:
  %iv = phi i8 [ %iv.next, %loop.latch ], [ 0, %entry ]
  %ec = icmp uge i8 %iv, %N
  br i1 %ec, label %exit, label %loop.body

loop.body:
  %src.iv = getelementptr inbounds i8, i8* %src, i8 %iv
  %cmp.iv.start = icmp ult i8* %src.iv, %lower
  %cmp.iv.end = icmp uge i8* %src.iv, %upper
  %or.1 = or i1 %cmp.iv.start, %cmp.iv.end
  br i1 %or.1, label %trap.bb, label %loop.body.1

loop.body.1:
  %ptr.src.iv = bitcast i8* %src.iv to i32*
  store i32 0, i32* %ptr.src.iv, align 4
  %add.1 = add nuw nsw i8 %iv, 1
  %src.iv.1 = getelementptr inbounds i8, i8* %src, i8 %add.1
  %cmp.iv.1.start = icmp ult i8* %src.iv.1, %lower
  %cmp.iv.1.end = icmp uge i8* %src.iv.1, %upper
  %or.2 = or i1 %cmp.iv.1.start, %cmp.iv.1.end
  br i1 %or.2, label %trap.bb, label %loop.body.2

loop.body.2:
  %ptr.src.iv.1 = bitcast i8* %src.iv.1 to i32*
  store i32 0, i32* %ptr.src.iv.1, align 4
  %add.2 = add nuw nsw i8 %iv, 2
  %src.iv.2 = getelementptr inbounds i8, i8* %src, i8 %add.2
  %cmp.iv.2.start = icmp ult i8* %src.iv.2, %lower
  %cmp.iv.2.end = icmp uge i8* %src.iv.2, %upper
  %or.3 = or i1 %cmp.iv.2.start, %cmp.iv.2.end
  br i1 %or.3, label %trap.bb, label %loop.latch


loop.latch:
  %ptr.src.iv.2 = bitcast i8* %src.iv.2 to i32*
  store i32 0, i32* %ptr.src.iv.2, align 4
  %iv.next = add nuw nsw i8 %iv, 1
  br label %loop.header

exit:
  ret void
}

define void @test2(i8* %src, i8* %lower, i8* %upper, i8 %N) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SRC_END:%.*]] = getelementptr inbounds i8, i8* [[SRC:%.*]], i8 [[N:%.*]]
; CHECK-NEXT:    [[CMP_SRC_START:%.*]] = icmp ult i8* [[SRC]], [[LOWER:%.*]]
; CHECK-NEXT:    [[CMP_SRC_END:%.*]] = icmp uge i8* [[SRC_END]], [[UPPER:%.*]]
; CHECK-NEXT:    [[CMP_OVERFLOW:%.*]] = icmp ugt i8* [[SRC]], [[SRC_END]]
; CHECK-NEXT:    [[OR_0:%.*]] = or i1 [[CMP_SRC_START]], [[CMP_SRC_END]]
; CHECK-NEXT:    [[OR_11:%.*]] = or i1 [[OR_0]], [[CMP_OVERFLOW]]
; CHECK-NEXT:    br i1 [[OR_11]], label [[TRAP_BB:%.*]], label [[LOOP_HEADER:%.*]]
; CHECK:       trap.bb:
; CHECK-NEXT:    ret void
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i8 [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[NEXT:%.*]] = add nuw nsw i8 [[IV]], 2
; CHECK-NEXT:    [[EC:%.*]] = icmp uge i8 [[NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EC]], label [[EXIT:%.*]], label [[LOOP_BODY:%.*]]
; CHECK:       loop.body:
; CHECK-NEXT:    [[SRC_IV:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[IV]]
; CHECK-NEXT:    [[CMP_IV_START:%.*]] = icmp ult i8* [[SRC_IV]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_END:%.*]] = icmp uge i8* [[SRC_IV]], [[UPPER]]
; CHECK-NEXT:    [[OR_1:%.*]] = or i1 [[CMP_IV_START]], [[CMP_IV_END]]
; CHECK-NEXT:    br i1 [[OR_1]], label [[TRAP_BB]], label [[LOOP_BODY_1:%.*]]
; CHECK:       loop.body.1:
; CHECK-NEXT:    [[ADD_1:%.*]] = add nuw nsw i8 [[IV]], 1
; CHECK-NEXT:    [[SRC_IV_1:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[ADD_1]]
; CHECK-NEXT:    [[CMP_IV_1_START:%.*]] = icmp ult i8* [[SRC_IV_1]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_1_END:%.*]] = icmp uge i8* [[SRC_IV_1]], [[UPPER]]
; CHECK-NEXT:    [[OR_2:%.*]] = or i1 [[CMP_IV_1_START]], [[CMP_IV_1_END]]
; CHECK-NEXT:    br i1 [[OR_2]], label [[TRAP_BB]], label [[LOOP_BODY_2:%.*]]
; CHECK:       loop.body.2:
; CHECK-NEXT:    [[ADD_2:%.*]] = add nuw nsw i8 [[IV]], 2
; CHECK-NEXT:    [[SRC_IV_2:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[ADD_2]]
; CHECK-NEXT:    [[CMP_IV_2_START:%.*]] = icmp ult i8* [[SRC_IV_2]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_2_END:%.*]] = icmp uge i8* [[SRC_IV_2]], [[UPPER]]
; CHECK-NEXT:    [[OR_3:%.*]] = or i1 [[CMP_IV_2_START]], [[CMP_IV_2_END]]
; CHECK-NEXT:    br i1 [[OR_3]], label [[TRAP_BB]], label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[PTR:%.*]] = bitcast i8* [[SRC_IV]] to i32*
; CHECK-NEXT:    store i32 0, i32* [[PTR]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i8 [[IV]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %src.end = getelementptr inbounds i8, i8* %src, i8 %N
  %cmp.src.start = icmp ult i8* %src, %lower
  %cmp.src.end = icmp uge i8* %src.end, %upper
  %cmp.overflow = icmp ugt i8* %src, %src.end
  %or.0 = or i1 %cmp.src.start, %cmp.src.end
  %or.11 = or i1 %or.0, %cmp.overflow
  br i1 %or.11, label %trap.bb, label %loop.header

trap.bb:
  ret void

loop.header:
  %iv = phi i8 [ %iv.next, %loop.latch ], [ 1, %entry ]
  %next = add nsw nuw i8 %iv, 2
  %ec = icmp uge i8 %next, %N
  br i1 %ec, label %exit, label %loop.body

loop.body:
  %src.iv = getelementptr inbounds i8, i8* %src, i8 %iv
  %cmp.iv.start = icmp ult i8* %src.iv, %lower
  %cmp.iv.end = icmp uge i8* %src.iv, %upper
  %or.1 = or i1 %cmp.iv.start, %cmp.iv.end
  br i1 %or.1, label %trap.bb, label %loop.body.1

loop.body.1:
  %add.1 = add nsw nuw i8 %iv, 1
  %src.iv.1 = getelementptr inbounds i8, i8* %src, i8 %add.1
  %cmp.iv.1.start = icmp ult i8* %src.iv.1, %lower
  %cmp.iv.1.end = icmp uge i8* %src.iv.1, %upper
  %or.2 = or i1 %cmp.iv.1.start, %cmp.iv.1.end
  br i1 %or.2, label %trap.bb, label %loop.body.2

loop.body.2:
  %add.2 = add nsw nuw i8 %iv, 2
  %src.iv.2 = getelementptr inbounds i8, i8* %src, i8 %add.2
  %cmp.iv.2.start = icmp ult i8* %src.iv.2, %lower
  %cmp.iv.2.end = icmp uge i8* %src.iv.2, %upper
  %or.3 = or i1 %cmp.iv.2.start, %cmp.iv.2.end
  br i1 %or.3, label %trap.bb, label %loop.latch

loop.latch:
  %ptr = bitcast i8* %src.iv to i32*
  store i32 0, i32* %ptr, align 4
  %iv.next = add nuw nsw i8 %iv, 1
  br label %loop.header

exit:
  ret void
}

define void @test2_with_ne(i8* %src, i8* %lower, i8* %upper, i8 %N) {
; CHECK-LABEL: @test2_with_ne(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SRC_END:%.*]] = getelementptr inbounds i8, i8* [[SRC:%.*]], i8 [[N:%.*]]
; CHECK-NEXT:    [[CMP_SRC_START:%.*]] = icmp ult i8* [[SRC]], [[LOWER:%.*]]
; CHECK-NEXT:    [[CMP_SRC_END:%.*]] = icmp uge i8* [[SRC_END]], [[UPPER:%.*]]
; CHECK-NEXT:    [[CMP_OVERFLOW:%.*]] = icmp ugt i8* [[SRC]], [[SRC_END]]
; CHECK-NEXT:    [[OR_0:%.*]] = or i1 [[CMP_SRC_START]], [[CMP_SRC_END]]
; CHECK-NEXT:    [[OR_11:%.*]] = or i1 [[OR_0]], [[CMP_OVERFLOW]]
; CHECK-NEXT:    br i1 [[OR_11]], label [[TRAP_BB:%.*]], label [[LOOP_HEADER:%.*]]
; CHECK:       trap.bb:
; CHECK-NEXT:    ret void
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i8 [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[NEXT:%.*]] = add nuw nsw i8 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp eq i8 [[NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EC]], label [[EXIT:%.*]], label [[LOOP_BODY:%.*]]
; CHECK:       loop.body:
; CHECK-NEXT:    [[SRC_IV:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[IV]]
; CHECK-NEXT:    [[CMP_IV_START:%.*]] = icmp ult i8* [[SRC_IV]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_END:%.*]] = icmp uge i8* [[SRC_IV]], [[UPPER]]
; CHECK-NEXT:    [[OR_1:%.*]] = or i1 [[CMP_IV_START]], [[CMP_IV_END]]
; CHECK-NEXT:    br i1 [[OR_1]], label [[TRAP_BB]], label [[LOOP_BODY_1:%.*]]
; CHECK:       loop.body.1:
; CHECK-NEXT:    [[ADD_1:%.*]] = add nuw nsw i8 [[IV]], 1
; CHECK-NEXT:    [[SRC_IV_1:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[ADD_1]]
; CHECK-NEXT:    [[CMP_IV_1_START:%.*]] = icmp ult i8* [[SRC_IV_1]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_1_END:%.*]] = icmp uge i8* [[SRC_IV_1]], [[UPPER]]
; CHECK-NEXT:    [[OR_2:%.*]] = or i1 [[CMP_IV_1_START]], [[CMP_IV_1_END]]
; CHECK-NEXT:    br i1 [[OR_2]], label [[TRAP_BB]], label [[LOOP_BODY_2:%.*]]
; CHECK:       loop.body.2:
; CHECK-NEXT:    [[ADD_2:%.*]] = add nuw nsw i8 [[IV]], 2
; CHECK-NEXT:    [[SRC_IV_2:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[ADD_2]]
; CHECK-NEXT:    [[CMP_IV_2_START:%.*]] = icmp ult i8* [[SRC_IV_2]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_2_END:%.*]] = icmp uge i8* [[SRC_IV_2]], [[UPPER]]
; CHECK-NEXT:    [[OR_3:%.*]] = or i1 [[CMP_IV_2_START]], [[CMP_IV_2_END]]
; CHECK-NEXT:    br i1 [[OR_3]], label [[TRAP_BB]], label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[PTR:%.*]] = bitcast i8* [[SRC_IV]] to i32*
; CHECK-NEXT:    store i32 0, i32* [[PTR]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i8 [[IV]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %src.end = getelementptr inbounds i8, i8* %src, i8 %N
  %cmp.src.start = icmp ult i8* %src, %lower
  %cmp.src.end = icmp uge i8* %src.end, %upper
  %cmp.overflow = icmp ugt i8* %src, %src.end
  %or.0 = or i1 %cmp.src.start, %cmp.src.end
  %or.11 = or i1 %or.0, %cmp.overflow
  br i1 %or.11, label %trap.bb, label %loop.header

trap.bb:
  ret void

loop.header:
  %iv = phi i8 [ %iv.next, %loop.latch ], [ 1, %entry ]
  %next = add nsw nuw i8 %iv, 1
  %ec = icmp eq i8 %next, %N
  br i1 %ec, label %exit, label %loop.body

loop.body:
  %src.iv = getelementptr inbounds i8, i8* %src, i8 %iv
  %cmp.iv.start = icmp ult i8* %src.iv, %lower
  %cmp.iv.end = icmp uge i8* %src.iv, %upper
  %or.1 = or i1 %cmp.iv.start, %cmp.iv.end
  br i1 %or.1, label %trap.bb, label %loop.body.1

loop.body.1:
  %add.1 = add nsw nuw i8 %iv, 1
  %src.iv.1 = getelementptr inbounds i8, i8* %src, i8 %add.1
  %cmp.iv.1.start = icmp ult i8* %src.iv.1, %lower
  %cmp.iv.1.end = icmp uge i8* %src.iv.1, %upper
  %or.2 = or i1 %cmp.iv.1.start, %cmp.iv.1.end
  br i1 %or.2, label %trap.bb, label %loop.body.2

loop.body.2:
  %add.2 = add nsw nuw i8 %iv, 2
  %src.iv.2 = getelementptr inbounds i8, i8* %src, i8 %add.2
  %cmp.iv.2.start = icmp ult i8* %src.iv.2, %lower
  %cmp.iv.2.end = icmp uge i8* %src.iv.2, %upper
  %or.3 = or i1 %cmp.iv.2.start, %cmp.iv.2.end
  br i1 %or.3, label %trap.bb, label %loop.latch

loop.latch:
  %ptr = bitcast i8* %src.iv to i32*
  store i32 0, i32* %ptr, align 4
  %iv.next = add nuw nsw i8 %iv, 1
  br label %loop.header

exit:
  ret void
}


define void @test3(i8* %src, i8* %lower, i8* %upper, i8 %N) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[SRC_END:%.*]] = getelementptr inbounds i8, i8* [[SRC:%.*]], i8 [[N:%.*]]
; CHECK-NEXT:    [[CMP_SRC_START:%.*]] = icmp ult i8* [[SRC]], [[LOWER:%.*]]
; CHECK-NEXT:    [[CMP_SRC_END:%.*]] = icmp uge i8* [[SRC_END]], [[UPPER:%.*]]
; CHECK-NEXT:    [[CMP_OVERFLOW:%.*]] = icmp ugt i8* [[SRC]], [[SRC_END]]
; CHECK-NEXT:    [[OR_0:%.*]] = or i1 [[CMP_SRC_START]], [[CMP_SRC_END]]
; CHECK-NEXT:    [[OR_11:%.*]] = or i1 [[OR_0]], [[CMP_OVERFLOW]]
; CHECK-NEXT:    br i1 [[OR_11]], label [[TRAP_BB:%.*]], label [[LOOP_HEADER:%.*]]
; CHECK:       trap.bb:
; CHECK-NEXT:    ret void
; CHECK:       loop.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i8 [ [[IV_NEXT:%.*]], [[LOOP_LATCH:%.*]] ], [ 1, [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[NEXT:%.*]] = or i8 [[IV]], 1
; CHECK-NEXT:    [[EC:%.*]] = icmp ult i8 [[NEXT]], [[N]]
; CHECK-NEXT:    br i1 [[EC]], label [[LOOP_BODY:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.body:
; CHECK-NEXT:    [[SRC_IV:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[IV]]
; CHECK-NEXT:    [[CMP_IV_START:%.*]] = icmp ult i8* [[SRC_IV]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_END:%.*]] = icmp uge i8* [[SRC_IV]], [[UPPER]]
; CHECK-NEXT:    [[OR_1:%.*]] = or i1 [[CMP_IV_START]], [[CMP_IV_END]]
; CHECK-NEXT:    br i1 [[OR_1]], label [[TRAP_BB]], label [[LOOP_BODY_1:%.*]]
; CHECK:       loop.body.1:
; CHECK-NEXT:    [[SRC_IV_1:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[NEXT]]
; CHECK-NEXT:    [[CMP_IV_1_START:%.*]] = icmp ult i8* [[SRC_IV_1]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_1_END:%.*]] = icmp uge i8* [[SRC_IV_1]], [[UPPER]]
; CHECK-NEXT:    [[OR_2:%.*]] = or i1 [[CMP_IV_1_START]], [[CMP_IV_1_END]]
; CHECK-NEXT:    br i1 [[OR_2]], label [[TRAP_BB]], label [[LOOP_BODY_2:%.*]]
; CHECK:       loop.body.2:
; CHECK-NEXT:    [[ADD_2:%.*]] = add nuw nsw i8 [[IV]], 2
; CHECK-NEXT:    [[SRC_IV_2:%.*]] = getelementptr inbounds i8, i8* [[SRC]], i8 [[ADD_2]]
; CHECK-NEXT:    [[CMP_IV_2_START:%.*]] = icmp ult i8* [[SRC_IV_2]], [[LOWER]]
; CHECK-NEXT:    [[CMP_IV_2_END:%.*]] = icmp uge i8* [[SRC_IV_2]], [[UPPER]]
; CHECK-NEXT:    [[OR_3:%.*]] = or i1 [[CMP_IV_2_START]], [[CMP_IV_2_END]]
; CHECK-NEXT:    br i1 [[OR_3]], label [[TRAP_BB]], label [[LOOP_LATCH]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[PTR:%.*]] = bitcast i8* [[SRC_IV]] to i32*
; CHECK-NEXT:    store i32 0, i32* [[PTR]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i8 [[IV]], 1
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  %src.end = getelementptr inbounds i8, i8* %src, i8 %N
  %cmp.src.start = icmp ult i8* %src, %lower
  %cmp.src.end = icmp uge i8* %src.end, %upper
  %cmp.overflow = icmp ugt i8* %src, %src.end
  %or.0 = or i1 %cmp.src.start, %cmp.src.end
  %or.11 = or i1 %or.0, %cmp.overflow
  br i1 %or.11, label %trap.bb, label %loop.header

trap.bb:
  ret void

loop.header:
  %iv = phi i8 [ %iv.next, %loop.latch ], [ 1, %entry ]
  %next = or i8 %iv, 1
  %ec = icmp ult i8 %next, %N
  br i1 %ec, label %loop.body, label %exit

loop.body:
  %src.iv = getelementptr inbounds i8, i8* %src, i8 %iv
  %cmp.iv.start = icmp ult i8* %src.iv, %lower
  %cmp.iv.end = icmp uge i8* %src.iv, %upper
  %or.1 = or i1 %cmp.iv.start, %cmp.iv.end
  br i1 %or.1, label %trap.bb, label %loop.body.1

loop.body.1:
  %src.iv.1 = getelementptr inbounds i8, i8* %src, i8 %next
  %cmp.iv.1.start = icmp ult i8* %src.iv.1, %lower
  %cmp.iv.1.end = icmp uge i8* %src.iv.1, %upper
  %or.2 = or i1 %cmp.iv.1.start, %cmp.iv.1.end
  br i1 %or.2, label %trap.bb, label %loop.body.2

loop.body.2:
  %add.2 = add nsw nuw i8 %iv, 2
  %src.iv.2 = getelementptr inbounds i8, i8* %src, i8 %add.2
  %cmp.iv.2.start = icmp ult i8* %src.iv.2, %lower
  %cmp.iv.2.end = icmp uge i8* %src.iv.2, %upper
  %or.3 = or i1 %cmp.iv.2.start, %cmp.iv.2.end
  br i1 %or.3, label %trap.bb, label %loop.latch

loop.latch:
  %ptr = bitcast i8* %src.iv to i32*
  store i32 0, i32* %ptr, align 4
  %iv.next = add nuw nsw i8 %iv, 1
  br label %loop.header

exit:
  ret void
}

; Cannot remove checks, because %n may be negative.
define void @ne_check_in_loop_no_zext_n_may_be_negative(i8* %ptr, i8* %lower, i8* %upper, i16 %n) {
; CHECK-LABEL: @ne_check_in_loop_no_zext_n_may_be_negative(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_PTR_LOWER:%.*]] = icmp ult i8* [[PTR:%.*]], [[LOWER:%.*]]
; CHECK-NEXT:    br i1 [[CMP_PTR_LOWER]], label [[TRAP:%.*]], label [[PRE:%.*]]
; CHECK:       pre:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i16 [[N:%.*]]
; CHECK-NEXT:    [[CMP_PTR_N_UPPER:%.*]] = icmp ult i8* [[ADD_PTR]], [[UPPER:%.*]]
; CHECK-NEXT:    br i1 [[CMP_PTR_N_UPPER]], label [[FOR_COND_PREHEADER:%.*]], label [[TRAP]]
; CHECK:       for.cond.preheader:
; CHECK-NEXT:    br label [[FOR_HEADER:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret void
; CHECK:       for.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i16 [ 0, [[FOR_COND_PREHEADER]] ], [ [[IV_NEXT:%.*]], [[FOR_LATCH:%.*]] ]
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i16 [[IV]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[GEP_IV:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i16 [[IV]]
; CHECK-NEXT:    [[CMP_IV_LOWER:%.*]] = icmp ugt i8* [[LOWER]], [[GEP_IV]]
; CHECK-NEXT:    [[CMP_IV_UPPER:%.*]] = icmp ule i8* [[UPPER]], [[GEP_IV]]
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[CMP_IV_LOWER]], [[CMP_IV_UPPER]]
; CHECK-NEXT:    br i1 [[OR]], label [[TRAP]], label [[FOR_BODY_1:%.*]]
; CHECK:       for.body.1:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i16 [[IV]], 1
; CHECK-NEXT:    [[GEP_IV_1:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i16 [[ADD]]
; CHECK-NEXT:    [[CMP_IV_1_LOWER:%.*]] = icmp ugt i8* [[LOWER]], [[GEP_IV_1]]
; CHECK-NEXT:    [[CMP_IV_1_UPPER:%.*]] = icmp ule i8* [[UPPER]], [[GEP_IV_1]]
; CHECK-NEXT:    [[OR_1:%.*]] = or i1 [[CMP_IV_1_LOWER]], [[CMP_IV_1_UPPER]]
; CHECK-NEXT:    br i1 [[OR_1]], label [[TRAP]], label [[FOR_LATCH]]
; CHECK:       for.latch:
; CHECK-NEXT:    store i8 0, i8* [[GEP_IV]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i16 [[IV]], 1
; CHECK-NEXT:    br label [[FOR_HEADER]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.ptr.lower = icmp ult i8* %ptr, %lower
  br i1 %cmp.ptr.lower, label %trap, label %pre

pre:
  %add.ptr = getelementptr inbounds i8, i8* %ptr, i16 %n
  %cmp.ptr.n.upper = icmp ult i8* %add.ptr, %upper
  br i1 %cmp.ptr.n.upper, label %for.cond.preheader, label %trap

for.cond.preheader:
  br label %for.header

trap:
  ret void

for.header:
  %iv = phi i16 [ 0, %for.cond.preheader ], [ %iv.next, %for.latch ]
  %exitcond = icmp ne i16 %iv, %n
  br i1 %exitcond, label %for.body, label %for.end

for.body:
  %gep.iv = getelementptr inbounds i8, i8* %ptr, i16 %iv
  %cmp.iv.lower = icmp ugt i8* %lower, %gep.iv
  %cmp.iv.upper = icmp ule i8* %upper, %gep.iv
  %or = or i1 %cmp.iv.lower, %cmp.iv.upper
  br i1 %or, label %trap, label %for.body.1

for.body.1:
  %add = add nuw nsw i16 %iv, 1
  %gep.iv.1 = getelementptr inbounds i8, i8* %ptr, i16 %add
  %cmp.iv.1.lower = icmp ugt i8* %lower, %gep.iv.1
  %cmp.iv.1.upper = icmp ule i8* %upper, %gep.iv.1
  %or.1 = or i1 %cmp.iv.1.lower, %cmp.iv.1.upper
  br i1 %or.1, label %trap, label %for.latch

for.latch:
  store i8 0, i8* %gep.iv, align 4
  %iv.next = add nuw nsw i16 %iv, 1
  br label %for.header

for.end:
  ret void
}

; Should be able to remove the checks in the loop, because %n is signed positive.
define void @ne_check_in_loop_no_zext_n_positive_check(i8* %ptr, i8* %lower, i8* %upper, i16 %n) {
; CHECK-LABEL: @ne_check_in_loop_no_zext_n_positive_check(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[N_SIGNED_POSITIVE:%.*]] = icmp slt i16 [[N:%.*]], 0
; CHECK-NEXT:    [[CMP_PTR_LOWER:%.*]] = icmp ult i8* [[PTR:%.*]], [[LOWER:%.*]]
; CHECK-NEXT:    [[OR_T:%.*]] = or i1 [[N_SIGNED_POSITIVE]], [[CMP_PTR_LOWER]]
; CHECK-NEXT:    br i1 [[OR_T]], label [[TRAP:%.*]], label [[PRE:%.*]]
; CHECK:       pre:
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i16 [[N]]
; CHECK-NEXT:    [[CMP_PTR_N_UPPER:%.*]] = icmp ult i8* [[ADD_PTR]], [[UPPER:%.*]]
; CHECK-NEXT:    br i1 [[CMP_PTR_N_UPPER]], label [[FOR_COND_PREHEADER:%.*]], label [[TRAP]]
; CHECK:       for.cond.preheader:
; CHECK-NEXT:    br label [[FOR_HEADER:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret void
; CHECK:       for.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i16 [ 0, [[FOR_COND_PREHEADER]] ], [ [[IV_NEXT:%.*]], [[FOR_LATCH:%.*]] ]
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i16 [[IV]], [[N]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[GEP_IV:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i16 [[IV]]
; CHECK-NEXT:    [[CMP_IV_LOWER:%.*]] = icmp ugt i8* [[LOWER]], [[GEP_IV]]
; CHECK-NEXT:    [[CMP_IV_UPPER:%.*]] = icmp ule i8* [[UPPER]], [[GEP_IV]]
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[CMP_IV_LOWER]], [[CMP_IV_UPPER]]
; CHECK-NEXT:    br i1 [[OR]], label [[TRAP]], label [[FOR_BODY_1:%.*]]
; CHECK:       for.body.1:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i16 [[IV]], 1
; CHECK-NEXT:    [[GEP_IV_1:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i16 [[ADD]]
; CHECK-NEXT:    [[CMP_IV_1_LOWER:%.*]] = icmp ugt i8* [[LOWER]], [[GEP_IV_1]]
; CHECK-NEXT:    [[CMP_IV_1_UPPER:%.*]] = icmp ule i8* [[UPPER]], [[GEP_IV_1]]
; CHECK-NEXT:    [[OR_1:%.*]] = or i1 [[CMP_IV_1_LOWER]], [[CMP_IV_1_UPPER]]
; CHECK-NEXT:    br i1 [[OR_1]], label [[TRAP]], label [[FOR_LATCH]]
; CHECK:       for.latch:
; CHECK-NEXT:    store i8 0, i8* [[GEP_IV]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i16 [[IV]], 1
; CHECK-NEXT:    br label [[FOR_HEADER]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %n.signed.positive = icmp slt i16 %n, 0
  %cmp.ptr.lower = icmp ult i8* %ptr, %lower
  %or.t = or i1 %n.signed.positive, %cmp.ptr.lower
  br i1 %or.t, label %trap, label %pre

pre:
  %add.ptr = getelementptr inbounds i8, i8* %ptr, i16 %n
  %cmp.ptr.n.upper = icmp ult i8* %add.ptr, %upper
  br i1 %cmp.ptr.n.upper, label %for.cond.preheader, label %trap

for.cond.preheader:
  br label %for.header

trap:
  ret void

for.header:
  %iv = phi i16 [ 0, %for.cond.preheader ], [ %iv.next, %for.latch ]
  %exitcond = icmp ne i16 %iv, %n
  br i1 %exitcond, label %for.body, label %for.end

for.body:
  %gep.iv = getelementptr inbounds i8, i8* %ptr, i16 %iv
  %cmp.iv.lower = icmp ugt i8* %lower, %gep.iv
  %cmp.iv.upper = icmp ule i8* %upper, %gep.iv
  %or = or i1 %cmp.iv.lower, %cmp.iv.upper
  br i1 %or, label %trap, label %for.body.1

for.body.1:
  %add = add nuw nsw i16 %iv, 1
  %gep.iv.1 = getelementptr inbounds i8, i8* %ptr, i16 %add
  %cmp.iv.1.lower = icmp ugt i8* %lower, %gep.iv.1
  %cmp.iv.1.upper = icmp ule i8* %upper, %gep.iv.1
  %or.1 = or i1 %cmp.iv.1.lower, %cmp.iv.1.upper
  br i1 %or.1, label %trap, label %for.latch

for.latch:
  store i8 0, i8* %gep.iv, align 4
  %iv.next = add nuw nsw i16 %iv, 1
  br label %for.header

for.end:
  ret void
}

; Make sure icmp ne of the induction variable in the loop body can be handled
; and is treated as ule.
define void @ne_check_in_loop_with_zext(i8* %ptr, i8* %lower, i8* %upper, i8 %n) {
; CHECK-LABEL: @ne_check_in_loop_with_zext(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP_PTR_LOWER:%.*]] = icmp ult i8* [[PTR:%.*]], [[LOWER:%.*]]
; CHECK-NEXT:    br i1 [[CMP_PTR_LOWER]], label [[TRAP:%.*]], label [[PRE:%.*]]
; CHECK:       pre:
; CHECK-NEXT:    [[IDX_EXT:%.*]] = zext i8 [[N:%.*]] to i16
; CHECK-NEXT:    [[ADD_PTR:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i16 [[IDX_EXT]]
; CHECK-NEXT:    [[CMP_PTR_N_UPPER:%.*]] = icmp ult i8* [[ADD_PTR]], [[UPPER:%.*]]
; CHECK-NEXT:    br i1 [[CMP_PTR_N_UPPER]], label [[FOR_COND_PREHEADER:%.*]], label [[TRAP]]
; CHECK:       for.cond.preheader:
; CHECK-NEXT:    br label [[FOR_HEADER:%.*]]
; CHECK:       trap:
; CHECK-NEXT:    ret void
; CHECK:       for.header:
; CHECK-NEXT:    [[IV:%.*]] = phi i16 [ 0, [[FOR_COND_PREHEADER]] ], [ [[IV_NEXT:%.*]], [[FOR_LATCH:%.*]] ]
; CHECK-NEXT:    [[EXITCOND:%.*]] = icmp ne i16 [[IV]], [[IDX_EXT]]
; CHECK-NEXT:    br i1 [[EXITCOND]], label [[FOR_BODY:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[GEP_IV:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i16 [[IV]]
; CHECK-NEXT:    [[CMP_IV_LOWER:%.*]] = icmp ugt i8* [[LOWER]], [[GEP_IV]]
; CHECK-NEXT:    [[CMP_IV_UPPER:%.*]] = icmp ule i8* [[UPPER]], [[GEP_IV]]
; CHECK-NEXT:    [[OR:%.*]] = or i1 [[CMP_IV_LOWER]], [[CMP_IV_UPPER]]
; CHECK-NEXT:    br i1 [[OR]], label [[TRAP]], label [[FOR_BODY_1:%.*]]
; CHECK:       for.body.1:
; CHECK-NEXT:    [[ADD:%.*]] = add nuw nsw i16 [[IV]], 1
; CHECK-NEXT:    [[GEP_IV_1:%.*]] = getelementptr inbounds i8, i8* [[PTR]], i16 [[ADD]]
; CHECK-NEXT:    [[CMP_IV_1_LOWER:%.*]] = icmp ugt i8* [[LOWER]], [[GEP_IV_1]]
; CHECK-NEXT:    [[CMP_IV_1_UPPER:%.*]] = icmp ule i8* [[UPPER]], [[GEP_IV_1]]
; CHECK-NEXT:    [[OR_1:%.*]] = or i1 [[CMP_IV_1_LOWER]], [[CMP_IV_1_UPPER]]
; CHECK-NEXT:    br i1 [[OR_1]], label [[TRAP]], label [[FOR_LATCH]]
; CHECK:       for.latch:
; CHECK-NEXT:    store i8 0, i8* [[GEP_IV]], align 4
; CHECK-NEXT:    [[IV_NEXT]] = add nuw nsw i16 [[IV]], 1
; CHECK-NEXT:    br label [[FOR_HEADER]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp.ptr.lower = icmp ult i8* %ptr, %lower
  br i1 %cmp.ptr.lower, label %trap, label %pre

pre:
  %idx.ext = zext i8 %n to i16
  %add.ptr = getelementptr inbounds i8, i8* %ptr, i16 %idx.ext
  %cmp.ptr.n.upper = icmp ult i8* %add.ptr, %upper
  br i1 %cmp.ptr.n.upper, label %for.cond.preheader, label %trap

for.cond.preheader:
  br label %for.header

trap:
  ret void

for.header:
  %iv = phi i16 [ 0, %for.cond.preheader ], [ %iv.next, %for.latch ]
  %exitcond = icmp ne i16 %iv, %idx.ext
  br i1 %exitcond, label %for.body, label %for.end

for.body:
  %gep.iv = getelementptr inbounds i8, i8* %ptr, i16 %iv
  %cmp.iv.lower = icmp ugt i8* %lower, %gep.iv
  %cmp.iv.upper = icmp ule i8* %upper, %gep.iv
  %or = or i1 %cmp.iv.lower, %cmp.iv.upper
  br i1 %or, label %trap, label %for.body.1

for.body.1:
  %add = add nuw nsw i16 %iv, 1
  %gep.iv.1 = getelementptr inbounds i8, i8* %ptr, i16 %add
  %cmp.iv.1.lower = icmp ugt i8* %lower, %gep.iv.1
  %cmp.iv.1.upper = icmp ule i8* %upper, %gep.iv.1
  %or.1 = or i1 %cmp.iv.1.lower, %cmp.iv.1.upper
  br i1 %or.1, label %trap, label %for.latch

for.latch:
  store i8 0, i8* %gep.iv, align 4
  %iv.next = add nuw nsw i16 %iv, 1
  br label %for.header

for.end:
  ret void
}

define void @test_ptr_need_one_upper_check(i32* readonly %src, i32* %dst, i32 %n) {
; CHECK-LABEL: @test_ptr_need_one_upper_check(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[LOOP_LATCH_2:%.*]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[I_0]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_CHECK_1:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.check.1:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[SRC_UPPER:%.*]] = getelementptr inbounds i32, i32* [[SRC:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[ADD]] = add nuw nsw i32 [[I_0]], 2
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[ADD]] to i64
; CHECK-NEXT:    [[SRC_IDX:%.*]] = getelementptr inbounds i32, i32* [[SRC]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[CMP_SRC_IDX_UPPER:%.*]] = icmp ult i32* [[SRC_IDX]], [[SRC_UPPER]]
; CHECK-NEXT:    call void @use(i1 [[CMP_SRC_IDX_UPPER]])
; CHECK-NEXT:    br i1 [[CMP_SRC_IDX_UPPER]], label [[LOOP_LATCH:%.*]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[DST_UPPER:%.*]] = getelementptr inbounds i32, i32* [[DST:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[DST_IDX:%.*]] = getelementptr inbounds i32, i32* [[DST]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[CMP_DST_IDX_UPPER:%.*]] = icmp ult i32* [[DST_IDX]], [[DST_UPPER]]
; CHECK-NEXT:    call void @use(i1 true)
; CHECK-NEXT:    br i1 true, label [[LOOP_LATCH_2]], label [[EXIT]]
; CHECK:       loop.latch.2:
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %i.0 = phi i32 [ 0, %entry ], [ %add, %loop.latch.2 ]
  %cmp = icmp ult i32 %i.0, %n
  br i1 %cmp, label %loop.check.1, label %exit

loop.check.1:
  %0 = zext i32 %n to i64
  %src.upper = getelementptr inbounds i32, i32* %src, i64 %0
  %add = add nuw nsw i32 %i.0, 2
  %idxprom = zext i32 %add to i64
  %src.idx = getelementptr inbounds i32, i32* %src, i64 %idxprom
  %cmp.src.idx.upper = icmp ult i32* %src.idx, %src.upper
  call void @use(i1 %cmp.src.idx.upper)
  br i1 %cmp.src.idx.upper, label %loop.latch, label %exit

loop.latch:
  %dst.upper = getelementptr inbounds i32, i32* %dst, i64 %0
  %dst.idx = getelementptr inbounds i32, i32* %dst, i64 %idxprom
  %cmp.dst.idx.upper = icmp ult i32* %dst.idx, %dst.upper
  call void @use(i1 %cmp.dst.idx.upper)
  br i1 %cmp.dst.idx.upper, label %loop.latch.2, label %exit

loop.latch.2:
  br label %loop.header

exit:
  ret void
}

; Same as test_ptr_need_one_upper_check, but without inbounds GEP.
define void @test_ptr_need_one_upper_check_no_inbounds(i32* readonly %src, i32* %dst, i32 %n) {
; CHECK-LABEL: @test_ptr_need_one_upper_check_no_inbounds(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP_HEADER:%.*]]
; CHECK:       loop.header:
; CHECK-NEXT:    [[I_0:%.*]] = phi i32 [ 0, [[ENTRY:%.*]] ], [ [[ADD:%.*]], [[LOOP_LATCH_2:%.*]] ]
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult i32 [[I_0]], [[N:%.*]]
; CHECK-NEXT:    br i1 [[CMP]], label [[LOOP_CHECK_1:%.*]], label [[EXIT:%.*]]
; CHECK:       loop.check.1:
; CHECK-NEXT:    [[TMP0:%.*]] = zext i32 [[N]] to i64
; CHECK-NEXT:    [[SRC_UPPER:%.*]] = getelementptr i32, i32* [[SRC:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[ADD]] = add nuw nsw i32 [[I_0]], 2
; CHECK-NEXT:    [[IDXPROM:%.*]] = zext i32 [[ADD]] to i64
; CHECK-NEXT:    [[SRC_IDX:%.*]] = getelementptr inbounds i32, i32* [[SRC]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[CMP_SRC_IDX_UPPER:%.*]] = icmp ult i32* [[SRC_IDX]], [[SRC_UPPER]]
; CHECK-NEXT:    call void @use(i1 [[CMP_SRC_IDX_UPPER]])
; CHECK-NEXT:    br i1 [[CMP_SRC_IDX_UPPER]], label [[LOOP_LATCH:%.*]], label [[EXIT]]
; CHECK:       loop.latch:
; CHECK-NEXT:    [[DST_UPPER:%.*]] = getelementptr i32, i32* [[DST:%.*]], i64 [[TMP0]]
; CHECK-NEXT:    [[DST_IDX:%.*]] = getelementptr inbounds i32, i32* [[DST]], i64 [[IDXPROM]]
; CHECK-NEXT:    [[CMP_DST_IDX_UPPER:%.*]] = icmp ult i32* [[DST_IDX]], [[DST_UPPER]]
; CHECK-NEXT:    call void @use(i1 [[CMP_DST_IDX_UPPER]])
; CHECK-NEXT:    br i1 [[CMP_DST_IDX_UPPER]], label [[LOOP_LATCH_2]], label [[EXIT]]
; CHECK:       loop.latch.2:
; CHECK-NEXT:    br label [[LOOP_HEADER]]
; CHECK:       exit:
; CHECK-NEXT:    ret void
;
entry:
  br label %loop.header

loop.header:
  %i.0 = phi i32 [ 0, %entry ], [ %add, %loop.latch.2 ]
  %cmp = icmp ult i32 %i.0, %n
  br i1 %cmp, label %loop.check.1, label %exit

loop.check.1:
  %0 = zext i32 %n to i64
  %src.upper = getelementptr i32, i32* %src, i64 %0
  %add = add nuw nsw i32 %i.0, 2
  %idxprom = zext i32 %add to i64
  %src.idx = getelementptr inbounds i32, i32* %src, i64 %idxprom
  %cmp.src.idx.upper = icmp ult i32* %src.idx, %src.upper
  call void @use(i1 %cmp.src.idx.upper)
  br i1 %cmp.src.idx.upper, label %loop.latch, label %exit

loop.latch:
  %dst.upper = getelementptr i32, i32* %dst, i64 %0
  %dst.idx = getelementptr inbounds i32, i32* %dst, i64 %idxprom
  %cmp.dst.idx.upper = icmp ult i32* %dst.idx, %dst.upper
  call void @use(i1 %cmp.dst.idx.upper)
  br i1 %cmp.dst.idx.upper, label %loop.latch.2, label %exit

loop.latch.2:
  br label %loop.header

exit:
  ret void
}
