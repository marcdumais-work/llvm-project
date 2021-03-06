; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=poison-checking -S -poison-checking-function-local < %s | FileCheck %s

; This file contains tests to exercise the custom flag validation rules

define i32 @add_noflags(i32 %a, i32 %b) {
; CHECK-LABEL: @add_noflags(
; CHECK-NEXT:    [[RES:%.*]] = add i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = add i32 %a, %b
  ret i32 %res
}

define i32 @add_nsw(i32 %a, i32 %b) {
; CHECK-LABEL: @add_nsw(
; CHECK-NEXT:    [[TMP1:%.*]] = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { i32, i1 } [[TMP1]], 1
; CHECK-NEXT:    [[RES:%.*]] = add nsw i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i1 [[TMP2]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP3]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = add nsw i32 %a, %b
  ret i32 %res
}

define i32 @add_nuw(i32 %a, i32 %b) {
; CHECK-LABEL: @add_nuw(
; CHECK-NEXT:    [[TMP1:%.*]] = call { i32, i1 } @llvm.uadd.with.overflow.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { i32, i1 } [[TMP1]], 1
; CHECK-NEXT:    [[RES:%.*]] = add nuw i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i1 [[TMP2]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP3]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = add nuw i32 %a, %b
  ret i32 %res
}

define i32 @add_nsw_nuw(i32 %a, i32 %b) {
; CHECK-LABEL: @add_nsw_nuw(
; CHECK-NEXT:    [[TMP1:%.*]] = call { i32, i1 } @llvm.sadd.with.overflow.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { i32, i1 } [[TMP1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = call { i32, i1 } @llvm.uadd.with.overflow.i32(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { i32, i1 } [[TMP3]], 1
; CHECK-NEXT:    [[TMP5:%.*]] = or i1 [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[RES:%.*]] = add nuw nsw i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP6:%.*]] = xor i1 [[TMP5]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP6]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = add nsw nuw i32 %a, %b
  ret i32 %res
}

define i32 @sub_noflags(i32 %a, i32 %b) {
; CHECK-LABEL: @sub_noflags(
; CHECK-NEXT:    [[RES:%.*]] = sub i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = sub i32 %a, %b
  ret i32 %res
}

define i32 @sub_nsw(i32 %a, i32 %b) {
; CHECK-LABEL: @sub_nsw(
; CHECK-NEXT:    [[TMP1:%.*]] = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { i32, i1 } [[TMP1]], 1
; CHECK-NEXT:    [[RES:%.*]] = sub nsw i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i1 [[TMP2]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP3]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = sub nsw i32 %a, %b
  ret i32 %res
}

define i32 @sub_nuw(i32 %a, i32 %b) {
; CHECK-LABEL: @sub_nuw(
; CHECK-NEXT:    [[TMP1:%.*]] = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { i32, i1 } [[TMP1]], 1
; CHECK-NEXT:    [[RES:%.*]] = sub nuw i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i1 [[TMP2]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP3]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = sub nuw i32 %a, %b
  ret i32 %res
}

define i32 @sub_nsw_nuw(i32 %a, i32 %b) {
; CHECK-LABEL: @sub_nsw_nuw(
; CHECK-NEXT:    [[TMP1:%.*]] = call { i32, i1 } @llvm.ssub.with.overflow.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { i32, i1 } [[TMP1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = call { i32, i1 } @llvm.usub.with.overflow.i32(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { i32, i1 } [[TMP3]], 1
; CHECK-NEXT:    [[TMP5:%.*]] = or i1 [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[RES:%.*]] = sub nuw nsw i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP6:%.*]] = xor i1 [[TMP5]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP6]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = sub nsw nuw i32 %a, %b
  ret i32 %res
}

define i32 @mul_noflags(i32 %a, i32 %b) {
; CHECK-LABEL: @mul_noflags(
; CHECK-NEXT:    [[RES:%.*]] = mul i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = mul i32 %a, %b
  ret i32 %res
}

define i32 @mul_nsw(i32 %a, i32 %b) {
; CHECK-LABEL: @mul_nsw(
; CHECK-NEXT:    [[TMP1:%.*]] = call { i32, i1 } @llvm.smul.with.overflow.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { i32, i1 } [[TMP1]], 1
; CHECK-NEXT:    [[RES:%.*]] = mul nsw i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i1 [[TMP2]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP3]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = mul nsw i32 %a, %b
  ret i32 %res
}

define i32 @mul_nuw(i32 %a, i32 %b) {
; CHECK-LABEL: @mul_nuw(
; CHECK-NEXT:    [[TMP1:%.*]] = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { i32, i1 } [[TMP1]], 1
; CHECK-NEXT:    [[RES:%.*]] = mul nuw i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i1 [[TMP2]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP3]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = mul nuw i32 %a, %b
  ret i32 %res
}

define i32 @mul_nsw_nuw(i32 %a, i32 %b) {
; CHECK-LABEL: @mul_nsw_nuw(
; CHECK-NEXT:    [[TMP1:%.*]] = call { i32, i1 } @llvm.smul.with.overflow.i32(i32 [[A:%.*]], i32 [[B:%.*]])
; CHECK-NEXT:    [[TMP2:%.*]] = extractvalue { i32, i1 } [[TMP1]], 1
; CHECK-NEXT:    [[TMP3:%.*]] = call { i32, i1 } @llvm.umul.with.overflow.i32(i32 [[A]], i32 [[B]])
; CHECK-NEXT:    [[TMP4:%.*]] = extractvalue { i32, i1 } [[TMP3]], 1
; CHECK-NEXT:    [[TMP5:%.*]] = or i1 [[TMP2]], [[TMP4]]
; CHECK-NEXT:    [[RES:%.*]] = mul nuw nsw i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP6:%.*]] = xor i1 [[TMP5]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP6]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = mul nsw nuw i32 %a, %b
  ret i32 %res
}

define i32 @sdiv_noflags(i32 %a, i32 %b) {
; CHECK-LABEL: @sdiv_noflags(
; CHECK-NEXT:    [[RES:%.*]] = sdiv i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = sdiv i32 %a, %b
  ret i32 %res
}

define i32 @sdiv_exact(i32 %a, i32 %b) {
; CHECK-LABEL: @sdiv_exact(
; CHECK-NEXT:    [[TMP1:%.*]] = srem i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[TMP1]], 0
; CHECK-NEXT:    [[RES:%.*]] = sdiv exact i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i1 [[TMP2]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP3]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = sdiv exact i32 %a, %b
  ret i32 %res
}

define i32 @udiv_noflags(i32 %a, i32 %b) {
; CHECK-LABEL: @udiv_noflags(
; CHECK-NEXT:    [[RES:%.*]] = udiv i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = udiv i32 %a, %b
  ret i32 %res
}

define i32 @udiv_exact(i32 %a, i32 %b) {
; CHECK-LABEL: @udiv_exact(
; CHECK-NEXT:    [[TMP1:%.*]] = urem i32 [[A:%.*]], [[B:%.*]]
; CHECK-NEXT:    [[TMP2:%.*]] = icmp ne i32 [[TMP1]], 0
; CHECK-NEXT:    [[RES:%.*]] = udiv exact i32 [[A]], [[B]]
; CHECK-NEXT:    [[TMP3:%.*]] = xor i1 [[TMP2]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP3]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = udiv exact i32 %a, %b
  ret i32 %res
}

define i32 @ashr_noflags(i32 %a, i32 %b) {
; CHECK-LABEL: @ashr_noflags(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[B:%.*]], 32
; CHECK-NEXT:    [[RES:%.*]] = ashr i32 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = ashr i32 %a, %b
  ret i32 %res
}

define i32 @ashr_exact(i32 %a, i32 %b) {
; CHECK-LABEL: @ashr_exact(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[B:%.*]], 32
; CHECK-NEXT:    [[RES:%.*]] = ashr exact i32 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = ashr exact i32 %a, %b
  ret i32 %res
}

define i32 @lshr_noflags(i32 %a, i32 %b) {
; CHECK-LABEL: @lshr_noflags(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[B:%.*]], 32
; CHECK-NEXT:    [[RES:%.*]] = lshr i32 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = lshr i32 %a, %b
  ret i32 %res
}

define i32 @lshr_exact(i32 %a, i32 %b) {
; CHECK-LABEL: @lshr_exact(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[B:%.*]], 32
; CHECK-NEXT:    [[RES:%.*]] = lshr exact i32 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = lshr exact i32 %a, %b
  ret i32 %res
}

define i32 @shl_noflags(i32 %a, i32 %b) {
; CHECK-LABEL: @shl_noflags(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[B:%.*]], 32
; CHECK-NEXT:    [[RES:%.*]] = shl i32 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = shl i32 %a, %b
  ret i32 %res
}

define i32 @shl_nsw(i32 %a, i32 %b) {
; CHECK-LABEL: @shl_nsw(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[B:%.*]], 32
; CHECK-NEXT:    [[RES:%.*]] = shl nsw i32 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = shl nsw i32 %a, %b
  ret i32 %res
}

define i32 @shl_nuw(i32 %a, i32 %b) {
; CHECK-LABEL: @shl_nuw(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[B:%.*]], 32
; CHECK-NEXT:    [[RES:%.*]] = shl nuw i32 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = shl nuw i32 %a, %b
  ret i32 %res
}

define i32 @shl_nsw_nuw(i32 %a, i32 %b) {
; CHECK-LABEL: @shl_nsw_nuw(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[B:%.*]], 32
; CHECK-NEXT:    [[RES:%.*]] = shl nuw nsw i32 [[A:%.*]], [[B]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = shl nsw nuw i32 %a, %b
  ret i32 %res
}

define i32 @extractelement(<4 x i32> %v, i32 %idx) {
; CHECK-LABEL: @extractelement(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[IDX:%.*]], 4
; CHECK-NEXT:    [[RES:%.*]] = extractelement <4 x i32> [[V:%.*]], i32 [[IDX]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret i32 [[RES]]
;
  %res = extractelement <4 x i32> %v, i32 %idx
  ret i32 %res
}

define <4 x i32> @insertelement(<4 x i32> %v, i32 %idx, i32 %val) {
; CHECK-LABEL: @insertelement(
; CHECK-NEXT:    [[TMP1:%.*]] = icmp uge i32 [[IDX:%.*]], 4
; CHECK-NEXT:    [[RES:%.*]] = insertelement <4 x i32> [[V:%.*]], i32 [[VAL:%.*]], i32 [[IDX]]
; CHECK-NEXT:    [[TMP2:%.*]] = xor i1 [[TMP1]], true
; CHECK-NEXT:    call void @__poison_checker_assert(i1 [[TMP2]])
; CHECK-NEXT:    ret <4 x i32> [[RES]]
;
  %res = insertelement <4 x i32> %v, i32 %val, i32 %idx
  ret <4 x i32> %res
}

