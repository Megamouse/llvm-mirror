; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -loop-unroll -unroll-runtime -unroll-runtime-multi-exit < %s | FileCheck %s

; This loop has a known trip count on the non-latch exit. When performing
; runtime unrolling (at least when using a prologue rather than epilogue) we
; should not fold that exit based on known trip count information prior to
; prologue insertion, as that may change the trip count for the modified loop.

define void @test(i32 %s, i32 %n) {
; CHECK-LABEL: @test(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[N2:%.*]] = add i32 [[S:%.*]], 123
; CHECK-NEXT:    [[TMP0:%.*]] = add i32 [[N:%.*]], 1
; CHECK-NEXT:    [[TMP1:%.*]] = sub i32 [[TMP0]], [[S]]
; CHECK-NEXT:    [[TMP2:%.*]] = sub i32 [[N]], [[S]]
; CHECK-NEXT:    [[XTRAITER:%.*]] = and i32 [[TMP1]], 7
; CHECK-NEXT:    [[LCMP_MOD:%.*]] = icmp ne i32 [[XTRAITER]], 0
; CHECK-NEXT:    br i1 [[LCMP_MOD]], label [[LOOP_PROL_PREHEADER:%.*]], label [[LOOP_PROL_LOOPEXIT:%.*]]
; CHECK:       loop.prol.preheader:
; CHECK-NEXT:    br label [[LOOP_PROL:%.*]]
; CHECK:       loop.prol:
; CHECK-NEXT:    [[I_PROL:%.*]] = phi i32 [ [[S]], [[LOOP_PROL_PREHEADER]] ], [ [[I_INC_PROL:%.*]], [[LATCH_PROL:%.*]] ]
; CHECK-NEXT:    [[PROL_ITER:%.*]] = phi i32 [ [[XTRAITER]], [[LOOP_PROL_PREHEADER]] ], [ [[PROL_ITER_SUB:%.*]], [[LATCH_PROL]] ]
; CHECK-NEXT:    [[C1_PROL:%.*]] = icmp eq i32 [[I_PROL]], [[N2]]
; CHECK-NEXT:    br i1 [[C1_PROL]], label [[EXIT1_LOOPEXIT1:%.*]], label [[LATCH_PROL]]
; CHECK:       latch.prol:
; CHECK-NEXT:    [[C2_PROL:%.*]] = icmp eq i32 [[I_PROL]], [[N]]
; CHECK-NEXT:    [[I_INC_PROL]] = add i32 [[I_PROL]], 1
; CHECK-NEXT:    [[PROL_ITER_SUB]] = sub i32 [[PROL_ITER]], 1
; CHECK-NEXT:    [[PROL_ITER_CMP:%.*]] = icmp ne i32 [[PROL_ITER_SUB]], 0
; CHECK-NEXT:    br i1 [[PROL_ITER_CMP]], label [[LOOP_PROL]], label [[LOOP_PROL_LOOPEXIT_UNR_LCSSA:%.*]], !llvm.loop [[LOOP0:![0-9]+]]
; CHECK:       loop.prol.loopexit.unr-lcssa:
; CHECK-NEXT:    [[I_UNR_PH:%.*]] = phi i32 [ [[I_INC_PROL]], [[LATCH_PROL]] ]
; CHECK-NEXT:    br label [[LOOP_PROL_LOOPEXIT]]
; CHECK:       loop.prol.loopexit:
; CHECK-NEXT:    [[I_UNR:%.*]] = phi i32 [ [[S]], [[ENTRY:%.*]] ], [ [[I_UNR_PH]], [[LOOP_PROL_LOOPEXIT_UNR_LCSSA]] ]
; CHECK-NEXT:    [[TMP3:%.*]] = icmp ult i32 [[TMP2]], 7
; CHECK-NEXT:    br i1 [[TMP3]], label [[EXIT2:%.*]], label [[ENTRY_NEW:%.*]]
; CHECK:       entry.new:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[I:%.*]] = phi i32 [ [[I_UNR]], [[ENTRY_NEW]] ], [ [[I_INC_7:%.*]], [[LATCH_7:%.*]] ]
; CHECK-NEXT:    [[C1:%.*]] = icmp eq i32 [[I]], [[N2]]
; CHECK-NEXT:    br i1 [[C1]], label [[EXIT1_LOOPEXIT:%.*]], label [[LATCH:%.*]]
; CHECK:       latch:
; CHECK-NEXT:    [[I_INC:%.*]] = add i32 [[I]], 1
; CHECK-NEXT:    [[C1_1:%.*]] = icmp eq i32 [[I_INC]], [[N2]]
; CHECK-NEXT:    br i1 [[C1_1]], label [[EXIT1_LOOPEXIT]], label [[LATCH_1:%.*]]
; CHECK:       exit1.loopexit:
; CHECK-NEXT:    br label [[EXIT1:%.*]]
; CHECK:       exit1.loopexit1:
; CHECK-NEXT:    br label [[EXIT1]]
; CHECK:       exit1:
; CHECK-NEXT:    ret void
; CHECK:       exit2.unr-lcssa:
; CHECK-NEXT:    br label [[EXIT2]]
; CHECK:       exit2:
; CHECK-NEXT:    ret void
; CHECK:       latch.1:
; CHECK-NEXT:    [[I_INC_1:%.*]] = add i32 [[I_INC]], 1
; CHECK-NEXT:    [[C1_2:%.*]] = icmp eq i32 [[I_INC_1]], [[N2]]
; CHECK-NEXT:    br i1 [[C1_2]], label [[EXIT1_LOOPEXIT]], label [[LATCH_2:%.*]]
; CHECK:       latch.2:
; CHECK-NEXT:    [[I_INC_2:%.*]] = add i32 [[I_INC_1]], 1
; CHECK-NEXT:    [[C1_3:%.*]] = icmp eq i32 [[I_INC_2]], [[N2]]
; CHECK-NEXT:    br i1 [[C1_3]], label [[EXIT1_LOOPEXIT]], label [[LATCH_3:%.*]]
; CHECK:       latch.3:
; CHECK-NEXT:    [[I_INC_3:%.*]] = add i32 [[I_INC_2]], 1
; CHECK-NEXT:    [[C1_4:%.*]] = icmp eq i32 [[I_INC_3]], [[N2]]
; CHECK-NEXT:    br i1 [[C1_4]], label [[EXIT1_LOOPEXIT]], label [[LATCH_4:%.*]]
; CHECK:       latch.4:
; CHECK-NEXT:    [[I_INC_4:%.*]] = add i32 [[I_INC_3]], 1
; CHECK-NEXT:    [[C1_5:%.*]] = icmp eq i32 [[I_INC_4]], [[N2]]
; CHECK-NEXT:    br i1 [[C1_5]], label [[EXIT1_LOOPEXIT]], label [[LATCH_5:%.*]]
; CHECK:       latch.5:
; CHECK-NEXT:    [[I_INC_5:%.*]] = add i32 [[I_INC_4]], 1
; CHECK-NEXT:    [[C1_6:%.*]] = icmp eq i32 [[I_INC_5]], [[N2]]
; CHECK-NEXT:    br i1 [[C1_6]], label [[EXIT1_LOOPEXIT]], label [[LATCH_6:%.*]]
; CHECK:       latch.6:
; CHECK-NEXT:    [[I_INC_6:%.*]] = add i32 [[I_INC_5]], 1
; CHECK-NEXT:    [[C1_7:%.*]] = icmp eq i32 [[I_INC_6]], [[N2]]
; CHECK-NEXT:    br i1 [[C1_7]], label [[EXIT1_LOOPEXIT]], label [[LATCH_7]]
; CHECK:       latch.7:
; CHECK-NEXT:    [[C2_7:%.*]] = icmp eq i32 [[I_INC_6]], [[N]]
; CHECK-NEXT:    [[I_INC_7]] = add i32 [[I_INC_6]], 1
; CHECK-NEXT:    br i1 [[C2_7]], label [[EXIT2_UNR_LCSSA:%.*]], label [[LOOP]]
;
entry:
  %n2 = add i32 %s, 123
  br label %loop

loop:
  %i = phi i32 [ %s, %entry], [ %i.inc, %latch ]
  %c1 = icmp eq i32 %i, %n2
  br i1 %c1, label %exit1, label %latch

latch:
  %c2 = icmp eq i32 %i, %n
  %i.inc = add i32 %i, 1
  br i1 %c2, label %exit2, label %loop

exit1:
  ret void

exit2:
  ret void
}
