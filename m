Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5652289C7
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgGUUZy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730886AbgGUUZx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:25:53 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834D6C0619E1;
        Tue, 21 Jul 2020 13:25:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxypj-00HPpi-84; Tue, 21 Jul 2020 20:25:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 15/18] xtensa: propagate the calling conventions change down into csum_partial_copy_generic()
Date:   Tue, 21 Jul 2020 21:25:46 +0100
Message-Id: <20200721202549.4150745-15-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

turn the exception handlers into returning 0.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/xtensa/include/asm/checksum.h | 20 +++---------
 arch/xtensa/lib/checksum.S         | 67 +++++++++-----------------------------
 2 files changed, 19 insertions(+), 68 deletions(-)

diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index 7958b18a5804..23b3e7c7ff73 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -37,9 +37,7 @@ asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
-					    int len, __wsum sum,
-					    int *src_err_ptr, int *dst_err_ptr);
+asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
 
 /*
  *	Note: when you get a NULL pointer exception here this means someone
@@ -48,7 +46,7 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
 static inline
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len, 0, NULL, NULL);
+	return csum_partial_copy_generic(src, dst, len);
 }
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
@@ -56,14 +54,9 @@ static inline
 __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 				   int len)
 {
-	int err = 0;
-
 	if (!access_ok(dst, len))
 		return 0;
-
-	sum = csum_partial_copy_generic((__force const void *)src, dst,
-					len, ~0U, &err, NULL);
-	return err ? 0 : sum;
+	return csum_partial_copy_generic((__force const void *)src, dst, len);
 }
 
 /*
@@ -246,13 +239,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 static __inline__ __wsum csum_and_copy_to_user(const void *src,
 					       void __user *dst, int len)
 {
-	int err = 0;
-	__wsum sum = ~0U;
-
 	if (!access_ok(dst, len))
 		return 0;
-
-	sum = csum_partial_copy_generic(src,dst,len,sum,NULL,&err);
-	return err ? 0 : sum;
+	return csum_partial_copy_generic(src, (__force void *)dst, len);
 }
 #endif
diff --git a/arch/xtensa/lib/checksum.S b/arch/xtensa/lib/checksum.S
index 4cb9ca58d9ad..cf1bed1a5bd6 100644
--- a/arch/xtensa/lib/checksum.S
+++ b/arch/xtensa/lib/checksum.S
@@ -175,19 +175,14 @@ ENDPROC(csum_partial)
  */
 
 /*
-unsigned int csum_partial_copy_generic (const char *src, char *dst, int len,
-					int sum, int *src_err_ptr, int *dst_err_ptr)
+unsigned int csum_partial_copy_generic (const char *src, char *dst, int len)
 	a2  = src
 	a3  = dst
 	a4  = len
 	a5  = sum
-	a6  = src_err_ptr
-	a7  = dst_err_ptr
 	a8  = temp
 	a9  = temp
 	a10 = temp
-	a11 = original len for exception handling
-	a12 = original dst for exception handling
 
     This function is optimized for 4-byte aligned addresses.  Other
     alignments work, but not nearly as efficiently.
@@ -196,8 +191,7 @@ unsigned int csum_partial_copy_generic (const char *src, char *dst, int len,
 ENTRY(csum_partial_copy_generic)
 
 	abi_entry_default
-	mov	a12, a3
-	mov	a11, a4
+	movi	a5, -1
 	or	a10, a2, a3
 
 	/* We optimize the following alignment tests for the 4-byte
@@ -228,26 +222,26 @@ ENTRY(csum_partial_copy_generic)
 #endif
 EX(10f)	l32i	a9, a2, 0
 EX(10f)	l32i	a8, a2, 4
-EX(11f)	s32i	a9, a3, 0
-EX(11f)	s32i	a8, a3, 4
+EX(10f)	s32i	a9, a3, 0
+EX(10f)	s32i	a8, a3, 4
 	ONES_ADD(a5, a9)
 	ONES_ADD(a5, a8)
 EX(10f)	l32i	a9, a2, 8
 EX(10f)	l32i	a8, a2, 12
-EX(11f)	s32i	a9, a3, 8
-EX(11f)	s32i	a8, a3, 12
+EX(10f)	s32i	a9, a3, 8
+EX(10f)	s32i	a8, a3, 12
 	ONES_ADD(a5, a9)
 	ONES_ADD(a5, a8)
 EX(10f)	l32i	a9, a2, 16
 EX(10f)	l32i	a8, a2, 20
-EX(11f)	s32i	a9, a3, 16
-EX(11f)	s32i	a8, a3, 20
+EX(10f)	s32i	a9, a3, 16
+EX(10f)	s32i	a8, a3, 20
 	ONES_ADD(a5, a9)
 	ONES_ADD(a5, a8)
 EX(10f)	l32i	a9, a2, 24
 EX(10f)	l32i	a8, a2, 28
-EX(11f)	s32i	a9, a3, 24
-EX(11f)	s32i	a8, a3, 28
+EX(10f)	s32i	a9, a3, 24
+EX(10f)	s32i	a8, a3, 28
 	ONES_ADD(a5, a9)
 	ONES_ADD(a5, a8)
 	addi	a2, a2, 32
@@ -267,7 +261,7 @@ EX(11f)	s32i	a8, a3, 28
 .Loop6:
 #endif
 EX(10f)	l32i	a9, a2, 0
-EX(11f)	s32i	a9, a3, 0
+EX(10f)	s32i	a9, a3, 0
 	ONES_ADD(a5, a9)
 	addi	a2, a2, 4
 	addi	a3, a3, 4
@@ -298,7 +292,7 @@ EX(11f)	s32i	a9, a3, 0
 .Loop7:
 #endif
 EX(10f)	l16ui	a9, a2, 0
-EX(11f)	s16i	a9, a3, 0
+EX(10f)	s16i	a9, a3, 0
 	ONES_ADD(a5, a9)
 	addi	a2, a2, 2
 	addi	a3, a3, 2
@@ -309,7 +303,7 @@ EX(11f)	s16i	a9, a3, 0
 	/* This section processes a possible trailing odd byte. */
 	_bbci.l	a4, 0, 8f	/* 1-byte chunk */
 EX(10f)	l8ui	a9, a2, 0
-EX(11f)	s8i	a9, a3, 0
+EX(10f)	s8i	a9, a3, 0
 #ifdef __XTENSA_EB__
 	slli	a9, a9, 8	/* shift byte to bits 8..15 */
 #endif
@@ -334,8 +328,8 @@ EX(11f)	s8i	a9, a3, 0
 #endif
 EX(10f)	l8ui	a9, a2, 0
 EX(10f)	l8ui	a8, a2, 1
-EX(11f)	s8i	a9, a3, 0
-EX(11f)	s8i	a8, a3, 1
+EX(10f)	s8i	a9, a3, 0
+EX(10f)	s8i	a8, a3, 1
 #ifdef __XTENSA_EB__
 	slli	a9, a9, 8	/* combine into a single 16-bit value */
 #else				/* for checksum computation */
@@ -356,38 +350,7 @@ ENDPROC(csum_partial_copy_generic)
 
 # Exception handler:
 .section .fixup, "ax"
-/*
-	a6  = src_err_ptr
-	a7  = dst_err_ptr
-	a11 = original len for exception handling
-	a12 = original dst for exception handling
-*/
-
 10:
-	_movi	a2, -EFAULT
-	s32i	a2, a6, 0	/* src_err_ptr */
-
-	# clear the complete destination - computing the rest
-	# is too much work
-	movi	a2, 0
-#if XCHAL_HAVE_LOOPS
-	loopgtz	a11, 2f
-#else
-	beqz	a11, 2f
-	add	a11, a11, a12	/* a11 = ending address */
-.Leloop:
-#endif
-	s8i	a2, a12, 0
-	addi	a12, a12, 1
-#if !XCHAL_HAVE_LOOPS
-	blt	a12, a11, .Leloop
-#endif
-2:
-	abi_ret_default
-
-11:
-	movi	a2, -EFAULT
-	s32i	a2, a7, 0	/* dst_err_ptr */
 	movi	a2, 0
 	abi_ret_default
 
-- 
2.11.0

