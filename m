Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C5936D81D
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 15:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239644AbhD1NPK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 09:15:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235630AbhD1NPJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 09:15:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7ED77613C2;
        Wed, 28 Apr 2021 13:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619615664;
        bh=MGSS51GM+v6m8tGxKM9ytGa9x493SHJshrc5zppKrVo=;
        h=From:To:Cc:Subject:Date:From;
        b=Quj/tJ5Otuiex2eqtg32D+gajujc+DHWij62kGtmgkkO1PJh40WvIulKrpMb3rKYn
         a5GK2JbO83RWS71SREUTPgBpIdy1P3Wyl9EeQ2Bf0eg4/Drx7/mmjIqtR2TNGgM43/
         dyft5Srp1ftdw5Hx1D6xCYeZ8nVn1QtwhwSfUd+ZpB91ris7ZG6h9nqIsHhy06DpcL
         eqCWjzY/nHhpjVjeAD2Or+9jzcv6O8VF4HbzahAJlvIQLY9tz+1+OualonrX3mpdqZ
         jqGLQXemyKP63OiVXu8ren6w2ThEa2lGQnv/9+3/mo0RcrDzKg0PkQa+nUfp0FHZZq
         0TdPEYmLEYHjg==
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v2] csky: uaccess.h: Coding convention with asm generic
Date:   Wed, 28 Apr 2021 13:13:35 +0000
Message-Id: <1619615615-10214-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Using asm-generic/uaccess.h to prevent duplicated code:
 - Add user_addr_max which mentioned in generic uaccess.h
 - Remove custom definitions of KERNEL/USER_DS, get/set_fs,
   uaccess_kerenl
 - Using generic extable.h instead of custom definitions in
   uaccess.h

Change v2:
 - Fixup tinyconfig compile error, "__put_user_bad"
 - Add __get_user_asm_64

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Link: https://lore.kernel.org/linux-csky/CAK8P3a1DvsXSEDoovLk11hzNHyJi7vqNoToU+n5aFi2viZO_Uw@mail.gmail.com/T/#mbcd58a0e3450e5598974116b607589afa16a3ab7
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/Kbuild    |   1 +
 arch/csky/include/asm/segment.h |   7 -
 arch/csky/include/asm/uaccess.h | 452 ++++++++++++----------------------------
 arch/csky/lib/usercopy.c        | 364 ++++++++++++++++++--------------
 arch/csky/mm/fault.c            |   2 +-
 5 files changed, 345 insertions(+), 481 deletions(-)

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index cc24bb8..904a18a 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += asm-offsets.h
+generic-y += extable.h
 generic-y += gpio.h
 generic-y += kvm_para.h
 generic-y += qrwlock.h
diff --git a/arch/csky/include/asm/segment.h b/arch/csky/include/asm/segment.h
index 589e832..5bc1cc62 100644
--- a/arch/csky/include/asm/segment.h
+++ b/arch/csky/include/asm/segment.h
@@ -7,11 +7,4 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
-#define KERNEL_DS		((mm_segment_t) { 0xFFFFFFFF })
-
-#define USER_DS			((mm_segment_t) { PAGE_OFFSET })
-#define get_fs()		(current_thread_info()->addr_limit)
-#define set_fs(x)		(current_thread_info()->addr_limit = (x))
-#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
-
 #endif /* __ASM_CSKY_SEGMENT_H */
diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
index 3dec272..ac83823 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -3,122 +3,26 @@
 #ifndef __ASM_CSKY_UACCESS_H
 #define __ASM_CSKY_UACCESS_H
 
-/*
- * User space memory access functions
- */
-#include <linux/compiler.h>
-#include <linux/errno.h>
-#include <linux/types.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include <linux/version.h>
-#include <asm/segment.h>
+#define user_addr_max() \
+	(uaccess_kernel() ? KERNEL_DS.seg : get_fs().seg)
 
-static inline int access_ok(const void *addr, unsigned long size)
+static inline int __access_ok(unsigned long addr, unsigned long size)
 {
 	unsigned long limit = current_thread_info()->addr_limit.seg;
 
-	return (((unsigned long)addr < limit) &&
-		((unsigned long)(addr + size) < limit));
+	return ((addr < limit) && ((addr + size) < limit));
 }
-
-#define __addr_ok(addr) (access_ok(addr, 0))
-
-extern int __put_user_bad(void);
+#define __access_ok __access_ok
 
 /*
- * Tell gcc we read from memory instead of writing: this is because
- * we do not write to any memory gcc knows about, so there are no
- * aliasing issues.
+ * __put_user_fn
  */
+extern int __put_user_bad(void);
 
-/*
- * These are the main single-value transfer routines.  They automatically
- * use the right size if we just have the right pointer type.
- *
- * This gets kind of ugly. We want to return _two_ values in "get_user()"
- * and yet we don't want to do any pointers, because that is too much
- * of a performance impact. Thus we have a few rather ugly macros here,
- * and hide all the ugliness from the user.
- *
- * The "__xxx" versions of the user access functions are versions that
- * do not verify the address space, that must have been done previously
- * with a separate "access_ok()" call (this is used when we do multiple
- * accesses to the same area of user memory).
- *
- * As we use the same address space for kernel and user data on
- * Ckcore, we can just do these as direct assignments.  (Of course, the
- * exception handling means that it's no longer "just"...)
- */
-
-#define put_user(x, ptr) \
-	__put_user_check((x), (ptr), sizeof(*(ptr)))
-
-#define __put_user(x, ptr) \
-	__put_user_nocheck((x), (ptr), sizeof(*(ptr)))
-
-#define __ptr(x) ((unsigned long *)(x))
-
-#define get_user(x, ptr) \
-	__get_user_check((x), (ptr), sizeof(*(ptr)))
-
-#define __get_user(x, ptr) \
-	__get_user_nocheck((x), (ptr), sizeof(*(ptr)))
-
-#define __put_user_nocheck(x, ptr, size)				\
-({									\
-	long __pu_err = 0;						\
-	typeof(*(ptr)) *__pu_addr = (ptr);				\
-	typeof(*(ptr)) __pu_val = (typeof(*(ptr)))(x);			\
-	if (__pu_addr)							\
-		__put_user_size(__pu_val, (__pu_addr), (size),		\
-				__pu_err);				\
-	__pu_err;							\
-})
-
-#define __put_user_check(x, ptr, size)					\
-({									\
-	long __pu_err = -EFAULT;					\
-	typeof(*(ptr)) *__pu_addr = (ptr);				\
-	typeof(*(ptr)) __pu_val = (typeof(*(ptr)))(x);			\
-	if (access_ok(__pu_addr, size) && __pu_addr)	\
-		__put_user_size(__pu_val, __pu_addr, (size), __pu_err);	\
-	__pu_err;							\
-})
-
-#define __put_user_size(x, ptr, size, retval)		\
-do {							\
-	retval = 0;					\
-	switch (size) {                                 \
-	case 1:						\
-		__put_user_asm_b(x, ptr, retval);	\
-		break;					\
-	case 2:						\
-		__put_user_asm_h(x, ptr, retval);	\
-		break;					\
-	case 4:						\
-		__put_user_asm_w(x, ptr, retval);	\
-		break;					\
-	case 8:						\
-		__put_user_asm_64(x, ptr, retval);	\
-		break;					\
-	default:					\
-		__put_user_bad();			\
-	}	                                        \
-} while (0)
-
-/*
- * We don't tell gcc that we are accessing memory, but this is OK
- * because we do not write to any memory gcc knows about, so there
- * are no aliasing issues.
- *
- * Note that PC at a fault is the address *after* the faulting
- * instruction.
- */
 #define __put_user_asm_b(x, ptr, err)			\
 do {							\
 	int errcode;					\
-	asm volatile(					\
+	__asm__ __volatile__(				\
 	"1:     stb   %1, (%2,0)	\n"		\
 	"       br    3f		\n"		\
 	"2:     mov   %0, %3		\n"		\
@@ -136,7 +40,7 @@ do {							\
 #define __put_user_asm_h(x, ptr, err)			\
 do {							\
 	int errcode;					\
-	asm volatile(					\
+	__asm__ __volatile__(				\
 	"1:     sth   %1, (%2,0)	\n"		\
 	"       br    3f		\n"		\
 	"2:     mov   %0, %3		\n"		\
@@ -154,7 +58,7 @@ do {							\
 #define __put_user_asm_w(x, ptr, err)			\
 do {							\
 	int errcode;					\
-	asm volatile(					\
+	__asm__ __volatile__(				\
 	"1:     stw   %1, (%2,0)	\n"		\
 	"       br    3f		\n"		\
 	"2:     mov   %0, %3		\n"		\
@@ -169,241 +73,149 @@ do {							\
 	: "memory");					\
 } while (0)
 
-#define __put_user_asm_64(x, ptr, err)				\
-do {								\
-	int tmp;						\
-	int errcode;						\
-	typeof(*(ptr))src = (typeof(*(ptr)))x;			\
-	typeof(*(ptr))*psrc = &src;				\
-								\
-	asm volatile(						\
-	"     ldw     %3, (%1, 0)     \n"			\
-	"1:   stw     %3, (%2, 0)     \n"			\
-	"     ldw     %3, (%1, 4)     \n"			\
-	"2:   stw     %3, (%2, 4)     \n"			\
-	"     br      4f              \n"			\
-	"3:   mov     %0, %4          \n"			\
-	"     br      4f              \n"			\
-	".section __ex_table, \"a\"   \n"			\
-	".align   2                   \n"			\
-	".long    1b, 3b              \n"			\
-	".long    2b, 3b              \n"			\
-	".previous                    \n"			\
-	"4:                           \n"			\
-	: "=r"(err), "=r"(psrc), "=r"(ptr),			\
-	  "=r"(tmp), "=r"(errcode)				\
-	: "0"(err), "1"(psrc), "2"(ptr), "3"(0), "4"(-EFAULT)	\
-	: "memory");						\
-} while (0)
-
-#define __get_user_nocheck(x, ptr, size)			\
-({								\
-	long  __gu_err;						\
-	__get_user_size(x, (ptr), (size), __gu_err);		\
-	__gu_err;						\
-})
-
-#define __get_user_check(x, ptr, size)				\
-({								\
-	int __gu_err = -EFAULT;					\
-	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
-	if (access_ok(__gu_ptr, size) && __gu_ptr)	\
-		__get_user_size(x, __gu_ptr, size, __gu_err);	\
-	__gu_err;						\
-})
-
-#define __get_user_size(x, ptr, size, retval)			\
-do {								\
-	switch (size) {						\
-	case 1:							\
-		__get_user_asm_common((x), ptr, "ldb", retval);	\
-		break;						\
-	case 2:							\
-		__get_user_asm_common((x), ptr, "ldh", retval);	\
-		break;						\
-	case 4:							\
-		__get_user_asm_common((x), ptr, "ldw", retval);	\
-		break;						\
-	default:						\
-		x = 0;						\
-		(retval) = __get_user_bad();			\
-	}							\
+#define __put_user_asm_64(x, ptr, err)			\
+do {							\
+	int tmp;					\
+	int errcode;					\
+							\
+	__asm__ __volatile__(				\
+	"     ldw     %3, (%1, 0)     \n"		\
+	"1:   stw     %3, (%2, 0)     \n"		\
+	"     ldw     %3, (%1, 4)     \n"		\
+	"2:   stw     %3, (%2, 4)     \n"		\
+	"     br      4f              \n"		\
+	"3:   mov     %0, %4          \n"		\
+	"     br      4f              \n"		\
+	".section __ex_table, \"a\"   \n"		\
+	".align   2                   \n"		\
+	".long    1b, 3b              \n"		\
+	".long    2b, 3b              \n"		\
+	".previous                    \n"		\
+	"4:                           \n"		\
+	: "=r"(err), "=r"(x), "=r"(ptr),		\
+	  "=r"(tmp), "=r"(errcode)			\
+	: "0"(err), "1"(x), "2"(ptr), "3"(0),		\
+	  "4"(-EFAULT)					\
+	: "memory");					\
 } while (0)
 
-#define __get_user_asm_common(x, ptr, ins, err)			\
-do {								\
-	int errcode;						\
-	asm volatile(						\
-	"1:   " ins " %1, (%4,0)	\n"			\
-	"       br    3f		\n"			\
-	/* Fix up codes */					\
-	"2:     mov   %0, %2		\n"			\
-	"       movi  %1, 0		\n"			\
-	"       br    3f		\n"			\
-	".section __ex_table,\"a\"      \n"			\
-	".align   2			\n"			\
-	".long    1b, 2b		\n"			\
-	".previous			\n"			\
-	"3:				\n" 			\
-	: "=r"(err), "=r"(x), "=r"(errcode)			\
-	: "0"(0), "r"(ptr), "2"(-EFAULT)			\
-	: "memory");						\
-} while (0)
+static inline int __put_user_fn(size_t size, void __user *ptr, void *x)
+{
+	int retval = 0;
+	u32 tmp;
+
+	switch (size) {
+	case 1:
+		tmp = *(u8 *)x;
+		__put_user_asm_b(tmp, ptr, retval);
+		break;
+	case 2:
+		tmp = *(u16 *)x;
+		__put_user_asm_h(tmp, ptr, retval);
+		break;
+	case 4:
+		tmp = *(u32 *)x;
+		__put_user_asm_w(tmp, ptr, retval);
+		break;
+	case 8:
+		__put_user_asm_64(x, (u64 *)ptr, retval);
+		break;
+	}
+
+	return retval;
+}
+#define __put_user_fn __put_user_fn
 
+/*
+ * __get_user_fn
+ */
 extern int __get_user_bad(void);
 
-#define ___copy_to_user(to, from, n)			\
+#define __get_user_asm_common(x, ptr, ins, err)		\
 do {							\
-	int w0, w1, w2, w3;				\
-	asm volatile(					\
-	"0:     cmpnei  %1, 0           \n"		\
-	"       bf      8f              \n"		\
-	"       mov     %3, %1          \n"		\
-	"       or      %3, %2          \n"		\
-	"       andi    %3, 3           \n"		\
-	"       cmpnei  %3, 0           \n"		\
-	"       bf      1f              \n"		\
-	"       br      5f              \n"		\
-	"1:     cmplti  %0, 16          \n" /* 4W */	\
-	"       bt      3f              \n"		\
-	"       ldw     %3, (%2, 0)     \n"		\
-	"       ldw     %4, (%2, 4)     \n"		\
-	"       ldw     %5, (%2, 8)     \n"		\
-	"       ldw     %6, (%2, 12)    \n"		\
-	"2:     stw     %3, (%1, 0)     \n"		\
-	"9:     stw     %4, (%1, 4)     \n"		\
-	"10:    stw     %5, (%1, 8)     \n"		\
-	"11:    stw     %6, (%1, 12)    \n"		\
-	"       addi    %2, 16          \n"		\
-	"       addi    %1, 16          \n"		\
-	"       subi    %0, 16          \n"		\
-	"       br      1b              \n"		\
-	"3:     cmplti  %0, 4           \n" /* 1W */	\
-	"       bt      5f              \n"		\
-	"       ldw     %3, (%2, 0)     \n"		\
-	"4:     stw     %3, (%1, 0)     \n"		\
-	"       addi    %2, 4           \n"		\
-	"       addi    %1, 4           \n"		\
-	"       subi    %0, 4           \n"		\
-	"       br      3b              \n"		\
-	"5:     cmpnei  %0, 0           \n"  /* 1B */   \
-	"       bf      13f             \n"		\
-	"       ldb     %3, (%2, 0)     \n"		\
-	"6:     stb     %3, (%1, 0)     \n"		\
-	"       addi    %2,  1          \n"		\
-	"       addi    %1,  1          \n"		\
-	"       subi    %0,  1          \n"		\
-	"       br      5b              \n"		\
-	"7:     subi	%0,  4          \n"		\
-	"8:     subi	%0,  4          \n"		\
-	"12:    subi	%0,  4          \n"		\
-	"       br      13f             \n"		\
-	".section __ex_table, \"a\"     \n"		\
-	".align   2                     \n"		\
-	".long    2b, 13f               \n"		\
-	".long    4b, 13f               \n"		\
-	".long    6b, 13f               \n"		\
-	".long    9b, 12b               \n"		\
-	".long   10b, 8b                \n"		\
-	".long   11b, 7b                \n"		\
-	".previous                      \n"		\
-	"13:                            \n"		\
-	: "=r"(n), "=r"(to), "=r"(from), "=r"(w0),	\
-	  "=r"(w1), "=r"(w2), "=r"(w3)			\
-	: "0"(n), "1"(to), "2"(from)			\
+	int errcode;					\
+	__asm__ __volatile__(				\
+	"1:   " ins " %1, (%4, 0)	\n"		\
+	"       br    3f		\n"		\
+	"2:     mov   %0, %2		\n"		\
+	"       movi  %1, 0		\n"		\
+	"       br    3f		\n"		\
+	".section __ex_table,\"a\"      \n"		\
+	".align   2			\n"		\
+	".long    1b, 2b		\n"		\
+	".previous			\n"		\
+	"3:				\n" 		\
+	: "=r"(err), "=r"(x), "=r"(errcode)		\
+	: "0"(0), "r"(ptr), "2"(-EFAULT)		\
 	: "memory");					\
 } while (0)
 
-#define ___copy_from_user(to, from, n)			\
+#define __get_user_asm_64(x, ptr, err)			\
 do {							\
 	int tmp;					\
-	int nsave;					\
-	asm volatile(					\
-	"0:     cmpnei  %1, 0           \n"		\
-	"       bf      7f              \n"		\
-	"       mov     %3, %1          \n"		\
-	"       or      %3, %2          \n"		\
-	"       andi    %3, 3           \n"		\
-	"       cmpnei  %3, 0           \n"		\
-	"       bf      1f              \n"		\
-	"       br      5f              \n"		\
-	"1:     cmplti  %0, 16          \n"		\
-	"       bt      3f              \n"		\
-	"2:     ldw     %3, (%2, 0)     \n"		\
-	"10:    ldw     %4, (%2, 4)     \n"		\
-	"       stw     %3, (%1, 0)     \n"		\
-	"       stw     %4, (%1, 4)     \n"		\
-	"11:    ldw     %3, (%2, 8)     \n"		\
-	"12:    ldw     %4, (%2, 12)    \n"		\
-	"       stw     %3, (%1, 8)     \n"		\
-	"       stw     %4, (%1, 12)    \n"		\
-	"       addi    %2, 16          \n"		\
-	"       addi    %1, 16          \n"		\
-	"       subi    %0, 16          \n"		\
-	"       br      1b              \n"		\
-	"3:     cmplti  %0, 4           \n"		\
-	"       bt      5f              \n"		\
-	"4:     ldw     %3, (%2, 0)     \n"		\
-	"       stw     %3, (%1, 0)     \n"		\
-	"       addi    %2, 4           \n"		\
-	"       addi    %1, 4           \n"		\
-	"       subi    %0, 4           \n"		\
-	"       br      3b              \n"		\
-	"5:     cmpnei  %0, 0           \n"		\
-	"       bf      7f              \n"		\
-	"6:     ldb     %3, (%2, 0)     \n"		\
-	"       stb     %3, (%1, 0)     \n"		\
-	"       addi    %2,  1          \n"		\
-	"       addi    %1,  1          \n"		\
-	"       subi    %0,  1          \n"		\
-	"       br      5b              \n"		\
-	"8:     stw     %3, (%1, 0)     \n"		\
-	"       subi    %0, 4           \n"		\
-	"       bf      7f              \n"		\
-	"9:     subi    %0, 8           \n"		\
-	"       bf      7f              \n"		\
-	"13:    stw     %3, (%1, 8)     \n"		\
-	"       subi    %0, 12          \n"		\
-	"       bf      7f              \n"		\
-	".section __ex_table, \"a\"     \n"		\
-	".align   2                     \n"		\
-	".long    2b, 7f                \n"		\
-	".long    4b, 7f                \n"		\
-	".long    6b, 7f                \n"		\
-	".long   10b, 8b                \n"		\
-	".long   11b, 9b                \n"		\
-	".long   12b,13b                \n"		\
-	".previous                      \n"		\
-	"7:                             \n"		\
-	: "=r"(n), "=r"(to), "=r"(from), "=r"(nsave),	\
-	  "=r"(tmp)					\
-	: "0"(n), "1"(to), "2"(from)			\
+	int errcode;					\
+							\
+	__asm__ __volatile__(				\
+	"1:   ldw     %3, (%2, 0)     \n"		\
+	"     stw     %3, (%1, 0)     \n"		\
+	"2:   ldw     %3, (%2, 4)     \n"		\
+	"     stw     %3, (%1, 4)     \n"		\
+	"     br      4f              \n"		\
+	"3:   mov     %0, %4          \n"		\
+	"     br      4f              \n"		\
+	".section __ex_table, \"a\"   \n"		\
+	".align   2                   \n"		\
+	".long    1b, 3b              \n"		\
+	".long    2b, 3b              \n"		\
+	".previous                    \n"		\
+	"4:                           \n"		\
+	: "=r"(err), "=r"(x), "=r"(ptr),		\
+	  "=r"(tmp), "=r"(errcode)			\
+	: "0"(err), "1"(x), "2"(ptr), "3"(0),		\
+	  "4"(-EFAULT)					\
 	: "memory");					\
 } while (0)
 
+static inline int __get_user_fn(size_t size, const void __user *ptr, void *x)
+{
+	int retval;
+	u32 tmp;
+
+	switch (size) {
+	case 1:
+		__get_user_asm_common(tmp, ptr, "ldb", retval);
+		*(u8 *)x = (u8)tmp;
+		break;
+	case 2:
+		__get_user_asm_common(tmp, ptr, "ldh", retval);
+		*(u16 *)x = (u16)tmp;
+		break;
+	case 4:
+		__get_user_asm_common(tmp, ptr, "ldw", retval);
+		*(u32 *)x = (u32)tmp;
+		break;
+	case 8:
+		__get_user_asm_64(x, ptr, retval);
+		break;
+	}
+
+	return retval;
+}
+#define __get_user_fn __get_user_fn
+
 unsigned long raw_copy_from_user(void *to, const void *from, unsigned long n);
 unsigned long raw_copy_to_user(void *to, const void *from, unsigned long n);
 
-unsigned long clear_user(void *to, unsigned long n);
 unsigned long __clear_user(void __user *to, unsigned long n);
+#define __clear_user __clear_user
 
-long strncpy_from_user(char *dst, const char *src, long count);
 long __strncpy_from_user(char *dst, const char *src, long count);
+#define __strncpy_from_user __strncpy_from_user
 
-/*
- * Return the size of a string (including the ending 0)
- *
- * Return 0 on exception, a value greater than N if too long
- */
-long strnlen_user(const char *src, long n);
-
-#define strlen_user(str) strnlen_user(str, 32767)
-
-struct exception_table_entry {
-	unsigned long insn;
-	unsigned long nextinsn;
-};
+long __strnlen_user(const char *s, long n);
+#define __strnlen_user __strnlen_user
 
-extern int fixup_exception(struct pt_regs *regs);
+#include <asm/segment.h>
+#include <asm-generic/uaccess.h>
 
 #endif /* __ASM_CSKY_UACCESS_H */
diff --git a/arch/csky/lib/usercopy.c b/arch/csky/lib/usercopy.c
index 3c9bd64..a718360 100644
--- a/arch/csky/lib/usercopy.c
+++ b/arch/csky/lib/usercopy.c
@@ -7,7 +7,70 @@
 unsigned long raw_copy_from_user(void *to, const void *from,
 			unsigned long n)
 {
-	___copy_from_user(to, from, n);
+	int tmp, nsave;
+
+	__asm__ __volatile__(
+	"0:     cmpnei  %1, 0           \n"
+	"       bf      7f              \n"
+	"       mov     %3, %1          \n"
+	"       or      %3, %2          \n"
+	"       andi    %3, 3           \n"
+	"       cmpnei  %3, 0           \n"
+	"       bf      1f              \n"
+	"       br      5f              \n"
+	"1:     cmplti  %0, 16          \n"
+	"       bt      3f              \n"
+	"2:     ldw     %3, (%2, 0)     \n"
+	"10:    ldw     %4, (%2, 4)     \n"
+	"       stw     %3, (%1, 0)     \n"
+	"       stw     %4, (%1, 4)     \n"
+	"11:    ldw     %3, (%2, 8)     \n"
+	"12:    ldw     %4, (%2, 12)    \n"
+	"       stw     %3, (%1, 8)     \n"
+	"       stw     %4, (%1, 12)    \n"
+	"       addi    %2, 16          \n"
+	"       addi    %1, 16          \n"
+	"       subi    %0, 16          \n"
+	"       br      1b              \n"
+	"3:     cmplti  %0, 4           \n"
+	"       bt      5f              \n"
+	"4:     ldw     %3, (%2, 0)     \n"
+	"       stw     %3, (%1, 0)     \n"
+	"       addi    %2, 4           \n"
+	"       addi    %1, 4           \n"
+	"       subi    %0, 4           \n"
+	"       br      3b              \n"
+	"5:     cmpnei  %0, 0           \n"
+	"       bf      7f              \n"
+	"6:     ldb     %3, (%2, 0)     \n"
+	"       stb     %3, (%1, 0)     \n"
+	"       addi    %2,  1          \n"
+	"       addi    %1,  1          \n"
+	"       subi    %0,  1          \n"
+	"       br      5b              \n"
+	"8:     stw     %3, (%1, 0)     \n"
+	"       subi    %0, 4           \n"
+	"       bf      7f              \n"
+	"9:     subi    %0, 8           \n"
+	"       bf      7f              \n"
+	"13:    stw     %3, (%1, 8)     \n"
+	"       subi    %0, 12          \n"
+	"       bf      7f              \n"
+	".section __ex_table, \"a\"     \n"
+	".align   2                     \n"
+	".long    2b, 7f                \n"
+	".long    4b, 7f                \n"
+	".long    6b, 7f                \n"
+	".long   10b, 8b                \n"
+	".long   11b, 9b                \n"
+	".long   12b,13b                \n"
+	".previous                      \n"
+	"7:                             \n"
+	: "=r"(n), "=r"(to), "=r"(from), "=r"(nsave),
+	  "=r"(tmp)
+	: "0"(n), "1"(to), "2"(from)
+	: "memory");
+
 	return n;
 }
 EXPORT_SYMBOL(raw_copy_from_user);
@@ -15,48 +78,70 @@ EXPORT_SYMBOL(raw_copy_from_user);
 unsigned long raw_copy_to_user(void *to, const void *from,
 			unsigned long n)
 {
-	___copy_to_user(to, from, n);
+	int w0, w1, w2, w3;
+
+	__asm__ __volatile__(
+	"0:     cmpnei  %1, 0           \n"
+	"       bf      8f              \n"
+	"       mov     %3, %1          \n"
+	"       or      %3, %2          \n"
+	"       andi    %3, 3           \n"
+	"       cmpnei  %3, 0           \n"
+	"       bf      1f              \n"
+	"       br      5f              \n"
+	"1:     cmplti  %0, 16          \n" /* 4W */
+	"       bt      3f              \n"
+	"       ldw     %3, (%2, 0)     \n"
+	"       ldw     %4, (%2, 4)     \n"
+	"       ldw     %5, (%2, 8)     \n"
+	"       ldw     %6, (%2, 12)    \n"
+	"2:     stw     %3, (%1, 0)     \n"
+	"9:     stw     %4, (%1, 4)     \n"
+	"10:    stw     %5, (%1, 8)     \n"
+	"11:    stw     %6, (%1, 12)    \n"
+	"       addi    %2, 16          \n"
+	"       addi    %1, 16          \n"
+	"       subi    %0, 16          \n"
+	"       br      1b              \n"
+	"3:     cmplti  %0, 4           \n" /* 1W */
+	"       bt      5f              \n"
+	"       ldw     %3, (%2, 0)     \n"
+	"4:     stw     %3, (%1, 0)     \n"
+	"       addi    %2, 4           \n"
+	"       addi    %1, 4           \n"
+	"       subi    %0, 4           \n"
+	"       br      3b              \n"
+	"5:     cmpnei  %0, 0           \n"  /* 1B */
+	"       bf      13f             \n"
+	"       ldb     %3, (%2, 0)     \n"
+	"6:     stb     %3, (%1, 0)     \n"
+	"       addi    %2,  1          \n"
+	"       addi    %1,  1          \n"
+	"       subi    %0,  1          \n"
+	"       br      5b              \n"
+	"7:     subi	%0,  4          \n"
+	"8:     subi	%0,  4          \n"
+	"12:    subi	%0,  4          \n"
+	"       br      13f             \n"
+	".section __ex_table, \"a\"     \n"
+	".align   2                     \n"
+	".long    2b, 13f               \n"
+	".long    4b, 13f               \n"
+	".long    6b, 13f               \n"
+	".long    9b, 12b               \n"
+	".long   10b, 8b                \n"
+	".long   11b, 7b                \n"
+	".previous                      \n"
+	"13:                            \n"
+	: "=r"(n), "=r"(to), "=r"(from), "=r"(w0),
+	  "=r"(w1), "=r"(w2), "=r"(w3)
+	: "0"(n), "1"(to), "2"(from)
+	: "memory");
+
 	return n;
 }
 EXPORT_SYMBOL(raw_copy_to_user);
 
-
-/*
- * copy a null terminated string from userspace.
- */
-#define __do_strncpy_from_user(dst, src, count, res)	\
-do {							\
-	int tmp;					\
-	long faultres;					\
-	asm volatile(					\
-	"       cmpnei  %3, 0           \n"		\
-	"       bf      4f              \n"		\
-	"1:     cmpnei  %1, 0          	\n"		\
-	"       bf      5f              \n"		\
-	"2:     ldb     %4, (%3, 0)     \n"		\
-	"       stb     %4, (%2, 0)     \n"		\
-	"       cmpnei  %4, 0           \n"		\
-	"       bf      3f              \n"		\
-	"       addi    %3,  1          \n"		\
-	"       addi    %2,  1          \n"		\
-	"       subi    %1,  1          \n"		\
-	"       br      1b              \n"		\
-	"3:     subu	%0, %1          \n"		\
-	"       br      5f              \n"		\
-	"4:     mov     %0, %5          \n"		\
-	"       br      5f              \n"		\
-	".section __ex_table, \"a\"     \n"		\
-	".align   2                     \n"		\
-	".long    2b, 4b                \n"		\
-	".previous                      \n"		\
-	"5:                             \n"		\
-	: "=r"(res), "=r"(count), "=r"(dst),		\
-	  "=r"(src), "=r"(tmp),   "=r"(faultres)	\
-	: "5"(-EFAULT), "0"(count), "1"(count),		\
-	  "2"(dst), "3"(src)				\
-	: "memory", "cc");				\
-} while (0)
-
 /*
  * __strncpy_from_user: - Copy a NUL terminated string from userspace,
  * with less checking.
@@ -80,40 +165,40 @@ do {							\
  */
 long __strncpy_from_user(char *dst, const char *src, long count)
 {
-	long res;
+	long res, faultres;
+	int tmp;
 
-	__do_strncpy_from_user(dst, src, count, res);
-	return res;
-}
-EXPORT_SYMBOL(__strncpy_from_user);
-
-/*
- * strncpy_from_user: - Copy a NUL terminated string from userspace.
- * @dst:   Destination address, in kernel space.  This buffer must be at
- *         least @count bytes long.
- * @src:   Source address, in user space.
- * @count: Maximum number of bytes to copy, including the trailing NUL.
- *
- * Copies a NUL-terminated string from userspace to kernel space.
- *
- * On success, returns the length of the string (not including the trailing
- * NUL).
- *
- * If access to userspace fails, returns -EFAULT (some data may have been
- * copied).
- *
- * If @count is smaller than the length of the string, copies @count bytes
- * and returns @count.
- */
-long strncpy_from_user(char *dst, const char *src, long count)
-{
-	long res = -EFAULT;
+	__asm__ __volatile__(
+	"       cmpnei  %3, 0           \n"
+	"       bf      4f              \n"
+	"1:     cmpnei  %1, 0          	\n"
+	"       bf      5f              \n"
+	"2:     ldb     %4, (%3, 0)     \n"
+	"       stb     %4, (%2, 0)     \n"
+	"       cmpnei  %4, 0           \n"
+	"       bf      3f              \n"
+	"       addi    %3,  1          \n"
+	"       addi    %2,  1          \n"
+	"       subi    %1,  1          \n"
+	"       br      1b              \n"
+	"3:     subu	%0, %1          \n"
+	"       br      5f              \n"
+	"4:     mov     %0, %5          \n"
+	"       br      5f              \n"
+	".section __ex_table, \"a\"     \n"
+	".align   2                     \n"
+	".long    2b, 4b                \n"
+	".previous                      \n"
+	"5:                             \n"
+	: "=r"(res), "=r"(count), "=r"(dst),
+	  "=r"(src), "=r"(tmp), "=r"(faultres)
+	: "5"(-EFAULT), "0"(count), "1"(count),
+	  "2"(dst), "3"(src)
+	: "memory");
 
-	if (access_ok(src, 1))
-		__do_strncpy_from_user(dst, src, count, res);
 	return res;
 }
-EXPORT_SYMBOL(strncpy_from_user);
+EXPORT_SYMBOL(__strncpy_from_user);
 
 /*
  * strlen_user: - Get the size of a string in user space.
@@ -126,14 +211,11 @@ EXPORT_SYMBOL(strncpy_from_user);
  * On exception, returns 0.
  * If the string is too long, returns a value greater than @n.
  */
-long strnlen_user(const char *s, long n)
+long __strnlen_user(const char *s, long n)
 {
 	unsigned long res, tmp;
 
-	if (s == NULL)
-		return 0;
-
-	asm volatile(
+	__asm__ __volatile__(
 	"       cmpnei  %1, 0           \n"
 	"       bf      3f              \n"
 	"1:     cmpnei  %0, 0           \n"
@@ -156,87 +238,11 @@ long strnlen_user(const char *s, long n)
 	"5:                             \n"
 	: "=r"(n), "=r"(s), "=r"(res), "=r"(tmp)
 	: "0"(n), "1"(s), "2"(n)
-	: "memory", "cc");
+	: "memory");
 
 	return res;
 }
-EXPORT_SYMBOL(strnlen_user);
-
-#define __do_clear_user(addr, size)			\
-do {							\
-	int __d0, zvalue, tmp;				\
-							\
-	asm volatile(					\
-	"0:     cmpnei  %1, 0           \n"		\
-	"       bf      7f              \n"		\
-	"       mov     %3, %1          \n"		\
-	"       andi    %3, 3           \n"		\
-	"       cmpnei  %3, 0           \n"		\
-	"       bf      1f              \n"		\
-	"       br      5f              \n"		\
-	"1:     cmplti  %0, 32          \n" /* 4W */	\
-	"       bt      3f              \n"		\
-	"8:     stw     %2, (%1, 0)     \n"		\
-	"10:    stw     %2, (%1, 4)     \n"		\
-	"11:    stw     %2, (%1, 8)     \n"		\
-	"12:    stw     %2, (%1, 12)    \n"		\
-	"13:    stw     %2, (%1, 16)    \n"		\
-	"14:    stw     %2, (%1, 20)    \n"		\
-	"15:    stw     %2, (%1, 24)    \n"		\
-	"16:    stw     %2, (%1, 28)    \n"		\
-	"       addi    %1, 32          \n"		\
-	"       subi    %0, 32          \n"		\
-	"       br      1b              \n"		\
-	"3:     cmplti  %0, 4           \n" /* 1W */	\
-	"       bt      5f              \n"		\
-	"4:     stw     %2, (%1, 0)     \n"		\
-	"       addi    %1, 4           \n"		\
-	"       subi    %0, 4           \n"		\
-	"       br      3b              \n"		\
-	"5:     cmpnei  %0, 0           \n" /* 1B */	\
-	"9:     bf      7f              \n"		\
-	"6:     stb     %2, (%1, 0)     \n"		\
-	"       addi    %1,  1          \n"		\
-	"       subi    %0,  1          \n"		\
-	"       br      5b              \n"		\
-	".section __ex_table,\"a\"      \n"		\
-	".align   2                     \n"		\
-	".long    8b, 9b                \n"		\
-	".long    10b, 9b               \n"		\
-	".long    11b, 9b               \n"		\
-	".long    12b, 9b               \n"		\
-	".long    13b, 9b               \n"		\
-	".long    14b, 9b               \n"		\
-	".long    15b, 9b               \n"		\
-	".long    16b, 9b               \n"		\
-	".long    4b, 9b                \n"		\
-	".long    6b, 9b                \n"		\
-	".previous                      \n"		\
-	"7:                             \n"		\
-	: "=r"(size), "=r" (__d0),			\
-	  "=r"(zvalue), "=r"(tmp)			\
-	: "0"(size), "1"(addr), "2"(0)			\
-	: "memory", "cc");				\
-} while (0)
-
-/*
- * clear_user: - Zero a block of memory in user space.
- * @to:   Destination address, in user space.
- * @n:    Number of bytes to zero.
- *
- * Zero a block of memory in user space.
- *
- * Returns number of bytes that could not be cleared.
- * On success, this will be zero.
- */
-unsigned long
-clear_user(void __user *to, unsigned long n)
-{
-	if (access_ok(to, n))
-		__do_clear_user(to, n);
-	return n;
-}
-EXPORT_SYMBOL(clear_user);
+EXPORT_SYMBOL(__strnlen_user);
 
 /*
  * __clear_user: - Zero a block of memory in user space, with less checking.
@@ -252,7 +258,59 @@ EXPORT_SYMBOL(clear_user);
 unsigned long
 __clear_user(void __user *to, unsigned long n)
 {
-	__do_clear_user(to, n);
+	int data, value, tmp;
+
+	__asm__ __volatile__(
+	"0:     cmpnei  %1, 0           \n"
+	"       bf      7f              \n"
+	"       mov     %3, %1          \n"
+	"       andi    %3, 3           \n"
+	"       cmpnei  %3, 0           \n"
+	"       bf      1f              \n"
+	"       br      5f              \n"
+	"1:     cmplti  %0, 32          \n" /* 4W */
+	"       bt      3f              \n"
+	"8:     stw     %2, (%1, 0)     \n"
+	"10:    stw     %2, (%1, 4)     \n"
+	"11:    stw     %2, (%1, 8)     \n"
+	"12:    stw     %2, (%1, 12)    \n"
+	"13:    stw     %2, (%1, 16)    \n"
+	"14:    stw     %2, (%1, 20)    \n"
+	"15:    stw     %2, (%1, 24)    \n"
+	"16:    stw     %2, (%1, 28)    \n"
+	"       addi    %1, 32          \n"
+	"       subi    %0, 32          \n"
+	"       br      1b              \n"
+	"3:     cmplti  %0, 4           \n" /* 1W */
+	"       bt      5f              \n"
+	"4:     stw     %2, (%1, 0)     \n"
+	"       addi    %1, 4           \n"
+	"       subi    %0, 4           \n"
+	"       br      3b              \n"
+	"5:     cmpnei  %0, 0           \n" /* 1B */
+	"9:     bf      7f              \n"
+	"6:     stb     %2, (%1, 0)     \n"
+	"       addi    %1,  1          \n"
+	"       subi    %0,  1          \n"
+	"       br      5b              \n"
+	".section __ex_table,\"a\"      \n"
+	".align   2                     \n"
+	".long    8b, 9b                \n"
+	".long    10b, 9b               \n"
+	".long    11b, 9b               \n"
+	".long    12b, 9b               \n"
+	".long    13b, 9b               \n"
+	".long    14b, 9b               \n"
+	".long    15b, 9b               \n"
+	".long    16b, 9b               \n"
+	".long    4b, 9b                \n"
+	".long    6b, 9b                \n"
+	".previous                      \n"
+	"7:                             \n"
+	: "=r"(n), "=r" (data), "=r"(value), "=r"(tmp)
+	: "0"(n), "1"(to), "2"(0)
+	: "memory");
+
 	return n;
 }
 EXPORT_SYMBOL(__clear_user);
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 1482de5..466ad94 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -12,7 +12,7 @@ int fixup_exception(struct pt_regs *regs)
 
 	fixup = search_exception_tables(instruction_pointer(regs));
 	if (fixup) {
-		regs->pc = fixup->nextinsn;
+		regs->pc = fixup->fixup;
 
 		return 1;
 	}
-- 
2.7.4

