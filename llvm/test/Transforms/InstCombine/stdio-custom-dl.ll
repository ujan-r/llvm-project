; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -passes=instcombine -S -mtriple=x86_64-unknown-linux-gnu | FileCheck %s

target datalayout = "e-m:o-p:40:64:64:32-i64:64-f80:128-n8:16:32:64-S128"
%struct._IO_FILE = type { i32, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i32, i32, i64, i16, i8, [1 x i8], ptr, i64, ptr, ptr, ptr, ptr, i64, i32, [20 x i8] }
%struct._IO_marker = type { ptr, ptr, i32 }
@.str = private unnamed_addr constant [5 x i8] c"file\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"str\00", align 1

;; Check fwrite is generated with arguments of index size, not ptr size

define internal void @fputs_test_custom_dl() {
; CHECK-LABEL: @fputs_test_custom_dl(
; CHECK-NEXT:    [[CALL:%.*]] = call ptr @fopen(ptr nonnull @.str, ptr nonnull @.str.1)
; CHECK-NEXT:    [[TMP1:%.*]] = call i32 @fwrite(ptr nonnull @.str.2, i32 3, i32 1, ptr %call)
; CHECK-NEXT:    ret void
;
  %call = call ptr @fopen(ptr @.str, ptr @.str.1)
  %call1 = call i32 @fputs(ptr @.str.2, ptr %call)
  ret void
}

declare ptr @fopen(ptr, ptr)
declare i32 @fputs(ptr nocapture readonly, ptr nocapture)
