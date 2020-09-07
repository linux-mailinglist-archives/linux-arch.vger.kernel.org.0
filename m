Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E123125F2D7
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 07:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgIGF6l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 01:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIGF6i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 01:58:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93287C0613ED;
        Sun,  6 Sep 2020 22:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z6FrPI5pfWglKEe2pj/imUUyPmjDs6Ef6TL0vmFolDw=; b=kCQDKGOhnzEX3Lqr+WuZ9tRDnu
        nJiOwdiVKMlnBKkhkx6ILCqbbhqOy59Leyk6m2FwicRZK/H7X02AnRGgkVXMOa74PXMBrFrtpn3Th
        HVVwPpCFP4HtCu4CDBYMcgmkdvdNzK+urn9ptmyD6UsJIjZxrS+i4C/M8MVgkT79vfretteoindST
        PpJ7XjQ+2YRbYuh2K39KbPN7eLbbEAWlnB3OPugGxzeKavL6+Mrbnp81PRPAQWoQhTKmoXGV9ckaU
        BO9bBj8IYbarT4ErU66dAJ3sRlwGIRhF4O7cw0QF+MgC2v2ZJMdlnWL/V4Z01IdC6LLvu5ng3Fzus
        39C1taFg==;
Received: from [2001:4bb8:184:af1:e178:97b2:ac6b:4e16] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFAAk-00036G-7a; Mon, 07 Sep 2020 05:58:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 6/8] riscv: refactor __get_user and __put_user
Date:   Mon,  7 Sep 2020 07:58:23 +0200
Message-Id: <20200907055825.1917151-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907055825.1917151-1-hch@lst.de>
References: <20200907055825.1917151-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add new __get_user_nocheck and __put_user_nocheck that switch on the size
and call the actual inline assembly helpers, and move the uaccess enable
/ disable into the actual __get_user and __put_user.  This prepares for
natively implementing __get_kernel_nofault and __put_kernel_nofault.

Also don't bother with the deprecated register keyword for the error
return.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/uaccess.h | 94 ++++++++++++++++++--------------
 1 file changed, 52 insertions(+), 42 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index e8eedf22e90747..b67d1c616ec348 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -107,7 +107,6 @@ static inline int __access_ok(unsigned long addr, unsigned long size)
 do {								\
 	uintptr_t __tmp;					\
 	__typeof__(x) __x;					\
-	__enable_user_access();					\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
 		"	" insn " %1, %3\n"			\
@@ -125,7 +124,6 @@ do {								\
 		"	.previous"				\
 		: "+r" (err), "=&r" (__x), "=r" (__tmp)		\
 		: "m" (*(ptr)), "i" (-EFAULT));			\
-	__disable_user_access();				\
 	(x) = __x;						\
 } while (0)
 
@@ -138,7 +136,6 @@ do {								\
 	u32 __user *__ptr = (u32 __user *)(ptr);		\
 	u32 __lo, __hi;						\
 	uintptr_t __tmp;					\
-	__enable_user_access();					\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
 		"	lw %1, %4\n"				\
@@ -162,12 +159,30 @@ do {								\
 			"=r" (__tmp)				\
 		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW]),	\
 			"i" (-EFAULT));				\
-	__disable_user_access();				\
 	(x) = (__typeof__(x))((__typeof__((x)-(x)))(		\
 		(((u64)__hi << 32) | __lo)));			\
 } while (0)
 #endif /* CONFIG_64BIT */
 
+#define __get_user_nocheck(x, __gu_ptr, __gu_err)		\
+do {								\
+	switch (sizeof(*__gu_ptr)) {				\
+	case 1:							\
+		__get_user_asm("lb", (x), __gu_ptr, __gu_err);	\
+		break;						\
+	case 2:							\
+		__get_user_asm("lh", (x), __gu_ptr, __gu_err);	\
+		break;						\
+	case 4:							\
+		__get_user_asm("lw", (x), __gu_ptr, __gu_err);	\
+		break;						\
+	case 8:							\
+		__get_user_8((x), __gu_ptr, __gu_err);	\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+	}							\
+} while (0)
 
 /**
  * __get_user: - Get a simple variable from user space, with less checking.
@@ -191,25 +206,15 @@ do {								\
  */
 #define __get_user(x, ptr)					\
 ({								\
-	register long __gu_err = 0;				\
 	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
+	long __gu_err = 0;					\
+								\
 	__chk_user_ptr(__gu_ptr);				\
-	switch (sizeof(*__gu_ptr)) {				\
-	case 1:							\
-		__get_user_asm("lb", (x), __gu_ptr, __gu_err);	\
-		break;						\
-	case 2:							\
-		__get_user_asm("lh", (x), __gu_ptr, __gu_err);	\
-		break;						\
-	case 4:							\
-		__get_user_asm("lw", (x), __gu_ptr, __gu_err);	\
-		break;						\
-	case 8:							\
-		__get_user_8((x), __gu_ptr, __gu_err);	\
-		break;						\
-	default:						\
-		BUILD_BUG();					\
-	}							\
+								\
+	__enable_user_access();					\
+	__get_user_nocheck(x, __gu_ptr, __gu_err);		\
+	__disable_user_access();				\
+								\
 	__gu_err;						\
 })
 
@@ -243,7 +248,6 @@ do {								\
 do {								\
 	uintptr_t __tmp;					\
 	__typeof__(*(ptr)) __x = x;				\
-	__enable_user_access();					\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
 		"	" insn " %z3, %2\n"			\
@@ -260,7 +264,6 @@ do {								\
 		"	.previous"				\
 		: "+r" (err), "=r" (__tmp), "=m" (*(ptr))	\
 		: "rJ" (__x), "i" (-EFAULT));			\
-	__disable_user_access();				\
 } while (0)
 
 #ifdef CONFIG_64BIT
@@ -272,7 +275,6 @@ do {								\
 	u32 __user *__ptr = (u32 __user *)(ptr);		\
 	u64 __x = (__typeof__((x)-(x)))(x);			\
 	uintptr_t __tmp;					\
-	__enable_user_access();					\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
 		"	sw %z4, %2\n"				\
@@ -294,10 +296,28 @@ do {								\
 			"=m" (__ptr[__LSW]),			\
 			"=m" (__ptr[__MSW])			\
 		: "rJ" (__x), "rJ" (__x >> 32), "i" (-EFAULT));	\
-	__disable_user_access();				\
 } while (0)
 #endif /* CONFIG_64BIT */
 
+#define __put_user_nocheck(x, __gu_ptr, __pu_err)					\
+do {								\
+	switch (sizeof(*__gu_ptr)) {				\
+	case 1:							\
+		__put_user_asm("sb", (x), __gu_ptr, __pu_err);	\
+		break;						\
+	case 2:							\
+		__put_user_asm("sh", (x), __gu_ptr, __pu_err);	\
+		break;						\
+	case 4:							\
+		__put_user_asm("sw", (x), __gu_ptr, __pu_err);	\
+		break;						\
+	case 8:							\
+		__put_user_8((x), __gu_ptr, __pu_err);	\
+		break;						\
+	default:						\
+		BUILD_BUG();					\
+	}							\
+} while (0)
 
 /**
  * __put_user: - Write a simple value into user space, with less checking.
@@ -320,25 +340,15 @@ do {								\
  */
 #define __put_user(x, ptr)					\
 ({								\
-	register long __pu_err = 0;				\
 	__typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
+	long __pu_err = 0;					\
+								\
 	__chk_user_ptr(__gu_ptr);				\
-	switch (sizeof(*__gu_ptr)) {				\
-	case 1:							\
-		__put_user_asm("sb", (x), __gu_ptr, __pu_err);	\
-		break;						\
-	case 2:							\
-		__put_user_asm("sh", (x), __gu_ptr, __pu_err);	\
-		break;						\
-	case 4:							\
-		__put_user_asm("sw", (x), __gu_ptr, __pu_err);	\
-		break;						\
-	case 8:							\
-		__put_user_8((x), __gu_ptr, __pu_err);	\
-		break;						\
-	default:						\
-		BUILD_BUG();					\
-	}							\
+								\
+	__enable_user_access();					\
+	__put_user_nocheck(x, __gu_ptr, __pu_err);		\
+	__disable_user_access();				\
+								\
 	__pu_err;						\
 })
 
-- 
2.28.0

