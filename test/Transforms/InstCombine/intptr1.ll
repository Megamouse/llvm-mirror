; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s  -instcombine  -S | FileCheck %s

define void @test1(float* %a, float* readnone %a_end, i64* %b.i64) {
; CHECK-LABEL: @test1(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult float* [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i64* [[B_I64:%.*]] to float**
; CHECK-NEXT:    [[B1:%.*]] = load float*, float** [[TMP0]], align 8
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi float* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02_PTR:%.*]] = phi float* [ [[ADD:%.*]], [[FOR_BODY]] ], [ [[B1]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[B_ADDR_02_PTR]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[TMP1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], float* [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD]] = getelementptr inbounds float, float* [[B_ADDR_02_PTR]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, float* [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult float* [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult float* %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b = load i64, i64* %b.i64, align 8
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi float* [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %for.body ], [ %b, %for.body.preheader ]


  %tmp = inttoptr i64 %b.addr.02 to float*
  %tmp1 = load float, float* %tmp, align 4
  %mul.i = fmul float %tmp1, 4.200000e+01
  store float %mul.i, float* %a.addr.03, align 4
  %add = getelementptr inbounds float, float* %tmp, i64 1
  %add.int = ptrtoint float* %add to i64
  %incdec.ptr = getelementptr inbounds float, float* %a.addr.03, i64 1
  %cmp = icmp ult float* %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}

define void @test1_neg(float* %a, float* readnone %a_end, i64* %b.i64) {
; CHECK-LABEL: @test1_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult float* [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B:%.*]] = load i64, i64* [[B_I64:%.*]], align 8
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi float* [ [[INCDEC_PTR:%.*]], [[BB:%.*]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02:%.*]] = phi i64 [ [[ADD_INT:%.*]], [[BB]] ], [ [[B]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP:%.*]] = inttoptr i64 [[B_ADDR_02]] to float*
; CHECK-NEXT:    [[PTRCMP:%.*]] = icmp ult float* [[TMP]], [[A_END]]
; CHECK-NEXT:    br i1 [[PTRCMP]], label [[FOR_END]], label [[BB]]
; CHECK:       bb:
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[A]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[TMP1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], float* [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD:%.*]] = getelementptr inbounds float, float* [[A]], i64 1
; CHECK-NEXT:    [[ADD_INT]] = ptrtoint float* [[ADD]] to i64
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, float* [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult float* [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult float* %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b = load i64, i64* %b.i64, align 8
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi float* [ %incdec.ptr, %bb ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %bb ], [ %b, %for.body.preheader ]


  %tmp = inttoptr i64 %b.addr.02 to float*
  %ptrcmp = icmp ult float* %tmp, %a_end
  br i1 %ptrcmp, label %for.end, label %bb

bb:
  %tmp1 = load float, float* %a, align 4
  %mul.i = fmul float %tmp1, 4.200000e+01
  store float %mul.i, float* %a.addr.03, align 4
  %add = getelementptr inbounds float, float* %a, i64 1
  %add.int = ptrtoint float* %add to i64
  %incdec.ptr = getelementptr inbounds float, float* %a.addr.03, i64 1
  %cmp = icmp ult float* %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}


define void @test2(float* %a, float* readnone %a_end, float** %b.float) {
; CHECK-LABEL: @test2(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult float* [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B1:%.*]] = load float*, float** [[B_FLOAT:%.*]], align 8
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi float* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02_PTR:%.*]] = phi float* [ [[ADD:%.*]], [[FOR_BODY]] ], [ [[B1]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[B_ADDR_02_PTR]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[TMP1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], float* [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD]] = getelementptr inbounds float, float* [[B_ADDR_02_PTR]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, float* [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult float* [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult float* %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b.i64 = bitcast float** %b.float to i64*
  %b = load i64, i64* %b.i64, align 8
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi float* [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %for.body ], [ %b, %for.body.preheader ]


  %tmp = inttoptr i64 %b.addr.02 to float*
  %tmp1 = load float, float* %tmp, align 4
  %mul.i = fmul float %tmp1, 4.200000e+01
  store float %mul.i, float* %a.addr.03, align 4
  %add = getelementptr inbounds float, float* %tmp, i64 1
  %add.int = ptrtoint float* %add to i64
  %incdec.ptr = getelementptr inbounds float, float* %a.addr.03, i64 1
  %cmp = icmp ult float* %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}


define void @test3(float* %a, float* readnone %a_end, i8** %b.i8p) {
; CHECK-LABEL: @test3(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult float* [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[TMP0:%.*]] = bitcast i8** [[B_I8P:%.*]] to float**
; CHECK-NEXT:    [[B1:%.*]] = load float*, float** [[TMP0]], align 8
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi float* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02_PTR:%.*]] = phi float* [ [[ADD:%.*]], [[FOR_BODY]] ], [ [[B1]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[B_ADDR_02_PTR]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[TMP1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], float* [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD]] = getelementptr inbounds float, float* [[B_ADDR_02_PTR]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, float* [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult float* [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult float* %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b.i64 = bitcast i8** %b.i8p to i64*
  %b = load i64, i64* %b.i64, align 8
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi float* [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %for.body ], [ %b, %for.body.preheader ]


  %tmp = inttoptr i64 %b.addr.02 to float*
  %tmp1 = load float, float* %tmp, align 4
  %mul.i = fmul float %tmp1, 4.200000e+01
  store float %mul.i, float* %a.addr.03, align 4
  %add = getelementptr inbounds float, float* %tmp, i64 1
  %add.int = ptrtoint float* %add to i64
  %incdec.ptr = getelementptr inbounds float, float* %a.addr.03, i64 1
  %cmp = icmp ult float* %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}


define void @test4(float* %a, float* readnone %a_end, float** %b.float) {
; CHECK-LABEL: @test4(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[CMP1:%.*]] = icmp ult float* [[A:%.*]], [[A_END:%.*]]
; CHECK-NEXT:    br i1 [[CMP1]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_END:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    [[B_F12:%.*]] = load float*, float** [[B_FLOAT:%.*]], align 8
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.body:
; CHECK-NEXT:    [[A_ADDR_03:%.*]] = phi float* [ [[INCDEC_PTR:%.*]], [[FOR_BODY]] ], [ [[A]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[B_ADDR_02_PTR:%.*]] = phi float* [ [[ADD:%.*]], [[FOR_BODY]] ], [ [[B_F12]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP1:%.*]] = load float, float* [[B_ADDR_02_PTR]], align 4
; CHECK-NEXT:    [[MUL_I:%.*]] = fmul float [[TMP1]], 4.200000e+01
; CHECK-NEXT:    store float [[MUL_I]], float* [[A_ADDR_03]], align 4
; CHECK-NEXT:    [[ADD]] = getelementptr inbounds float, float* [[B_ADDR_02_PTR]], i64 1
; CHECK-NEXT:    [[INCDEC_PTR]] = getelementptr inbounds float, float* [[A_ADDR_03]], i64 1
; CHECK-NEXT:    [[CMP:%.*]] = icmp ult float* [[INCDEC_PTR]], [[A_END]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_END]]
; CHECK:       for.end:
; CHECK-NEXT:    ret void
;
entry:
  %cmp1 = icmp ult float* %a, %a_end
  br i1 %cmp1, label %for.body.preheader, label %for.end

for.body.preheader:                               ; preds = %entry
  %b.f = load float*, float** %b.float, align 8
  %b = ptrtoint float* %b.f to i64
  br label %for.body

for.body:                                         ; preds = %for.body, %for.body.preheader
  %a.addr.03 = phi float* [ %incdec.ptr, %for.body ], [ %a, %for.body.preheader ]
  %b.addr.02 = phi i64 [ %add.int, %for.body ], [ %b, %for.body.preheader ]
  %tmp = inttoptr i64 %b.addr.02 to float*
  %tmp1 = load float, float* %tmp, align 4
  %mul.i = fmul float %tmp1, 4.200000e+01
  store float %mul.i, float* %a.addr.03, align 4
  %add = getelementptr inbounds float, float* %tmp, i64 1
  %add.int = ptrtoint float* %add to i64
  %incdec.ptr = getelementptr inbounds float, float* %a.addr.03, i64 1
  %cmp = icmp ult float* %incdec.ptr, %a_end
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body, %entry
  ret void
}
