Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E679A22BB5F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGXBZy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgGXBZx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:53 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE86C0619D3;
        Thu, 23 Jul 2020 18:25:53 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT7-001Gdy-2u; Fri, 24 Jul 2020 01:25:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 20/20] ppc: propagate the calling conventions change down to csum_partial_copy_generic()
Date:   Fri, 24 Jul 2020 02:25:46 +0100
Message-Id: <20200724012546.302155-20-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
References: <20200724012512.GK2786714@ZenIV.linux.org.uk>
 <20200724012546.302155-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and get rid of the pointless fallback in the wrappers.  On error it used
to zero the unwritten area and calculate the csum of the entire thing.  Not
wanting to do it in assembler part had been very reasonable; doing that in
the first place, OTOH...  In case of an error the caller discards the data
we'd copied, along with whatever checksum it might've had.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/include/asm/checksum.h  |  6 +--
 arch/powerpc/lib/checksum_32.S       | 74 +++++++++++++-----------------------
 arch/powerpc/lib/checksum_64.S       | 37 ++++++------------
 arch/powerpc/lib/checksum_wrappers.c | 32 +++-------------
 4 files changed, 46 insertions(+), 103 deletions(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index dba685d984c0..82f099ba2411 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -18,9 +18,7 @@
  * Like csum_partial, this must be called with even lengths,
  * except for the last fragment.
  */
-extern __wsum csum_partial_copy_generic(const void *src, void *dst,
-					      int len, __wsum sum,
-					      int *src_err, int *dst_err);
+extern __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
@@ -31,7 +29,7 @@ extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 #define csum_partial_copy_nocheck(src, dst, len)   \
-        csum_partial_copy_generic((src), (dst), (len), 0, NULL, NULL)
+        csum_partial_copy_generic((src), (dst), (len))
 
 
 /*
diff --git a/arch/powerpc/lib/checksum_32.S b/arch/powerpc/lib/checksum_32.S
index ecd150dc3ed9..ec5cd2dede35 100644
--- a/arch/powerpc/lib/checksum_32.S
+++ b/arch/powerpc/lib/checksum_32.S
@@ -78,12 +78,10 @@ EXPORT_SYMBOL(__csum_partial)
 
 /*
  * Computes the checksum of a memory block at src, length len,
- * and adds in "sum" (32-bit), while copying the block to dst.
- * If an access exception occurs on src or dst, it stores -EFAULT
- * to *src_err or *dst_err respectively, and (for an error on
- * src) zeroes the rest of dst.
+ * and adds in 0xffffffff, while copying the block to dst.
+ * If an access exception occurs it returns zero.
  *
- * csum_partial_copy_generic(src, dst, len, sum, src_err, dst_err)
+ * csum_partial_copy_generic(src, dst, len)
  */
 #define CSUM_COPY_16_BYTES_WITHEX(n)	\
 8 ## n ## 0:			\
@@ -108,14 +106,14 @@ EXPORT_SYMBOL(__csum_partial)
 	adde	r12,r12,r10
 
 #define CSUM_COPY_16_BYTES_EXCODE(n)		\
-	EX_TABLE(8 ## n ## 0b, src_error);	\
-	EX_TABLE(8 ## n ## 1b, src_error);	\
-	EX_TABLE(8 ## n ## 2b, src_error);	\
-	EX_TABLE(8 ## n ## 3b, src_error);	\
-	EX_TABLE(8 ## n ## 4b, dst_error);	\
-	EX_TABLE(8 ## n ## 5b, dst_error);	\
-	EX_TABLE(8 ## n ## 6b, dst_error);	\
-	EX_TABLE(8 ## n ## 7b, dst_error);
+	EX_TABLE(8 ## n ## 0b, fault);	\
+	EX_TABLE(8 ## n ## 1b, fault);	\
+	EX_TABLE(8 ## n ## 2b, fault);	\
+	EX_TABLE(8 ## n ## 3b, fault);	\
+	EX_TABLE(8 ## n ## 4b, fault);	\
+	EX_TABLE(8 ## n ## 5b, fault);	\
+	EX_TABLE(8 ## n ## 6b, fault);	\
+	EX_TABLE(8 ## n ## 7b, fault);
 
 	.text
 	.stabs	"arch/powerpc/lib/",N_SO,0,0,0f
@@ -127,11 +125,8 @@ LG_CACHELINE_BYTES = L1_CACHE_SHIFT
 CACHELINE_MASK = (L1_CACHE_BYTES-1)
 
 _GLOBAL(csum_partial_copy_generic)
-	stwu	r1,-16(r1)
-	stw	r7,12(r1)
-	stw	r8,8(r1)
-
-	addic	r12,r6,0
+	li	r12,-1
+	addic	r0,r0,0			/* clear carry */
 	addi	r6,r4,-4
 	neg	r0,r4
 	addi	r4,r3,-4
@@ -246,34 +241,19 @@ _GLOBAL(csum_partial_copy_generic)
 	rlwinm	r3,r3,8,0,31	/* odd destination address: rotate one byte */
 	blr
 
-/* read fault */
-src_error:
-	lwz	r7,12(r1)
-	addi	r1,r1,16
-	cmpwi	cr0,r7,0
-	beqlr
-	li	r0,-EFAULT
-	stw	r0,0(r7)
-	blr
-/* write fault */
-dst_error:
-	lwz	r8,8(r1)
-	addi	r1,r1,16
-	cmpwi	cr0,r8,0
-	beqlr
-	li	r0,-EFAULT
-	stw	r0,0(r8)
+fault:
+	li	r3,0
 	blr
 
-	EX_TABLE(70b, src_error);
-	EX_TABLE(71b, dst_error);
-	EX_TABLE(72b, src_error);
-	EX_TABLE(73b, dst_error);
-	EX_TABLE(54b, dst_error);
+	EX_TABLE(70b, fault);
+	EX_TABLE(71b, fault);
+	EX_TABLE(72b, fault);
+	EX_TABLE(73b, fault);
+	EX_TABLE(54b, fault);
 
 /*
  * this stuff handles faults in the cacheline loop and branches to either
- * src_error (if in read part) or dst_error (if in write part)
+ * fault (if in read part) or fault (if in write part)
  */
 	CSUM_COPY_16_BYTES_EXCODE(0)
 #if L1_CACHE_BYTES >= 32
@@ -290,12 +270,12 @@ dst_error:
 #endif
 #endif
 
-	EX_TABLE(30b, src_error);
-	EX_TABLE(31b, dst_error);
-	EX_TABLE(40b, src_error);
-	EX_TABLE(41b, dst_error);
-	EX_TABLE(50b, src_error);
-	EX_TABLE(51b, dst_error);
+	EX_TABLE(30b, fault);
+	EX_TABLE(31b, fault);
+	EX_TABLE(40b, fault);
+	EX_TABLE(41b, fault);
+	EX_TABLE(50b, fault);
+	EX_TABLE(51b, fault);
 
 EXPORT_SYMBOL(csum_partial_copy_generic)
 
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 514978f908d4..98ff51bd2f7d 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -182,34 +182,33 @@ EXPORT_SYMBOL(__csum_partial)
 
 	.macro srcnr
 100:
-	EX_TABLE(100b,.Lsrc_error_nr)
+	EX_TABLE(100b,.Lerror_nr)
 	.endm
 
 	.macro source
 150:
-	EX_TABLE(150b,.Lsrc_error)
+	EX_TABLE(150b,.Lerror)
 	.endm
 
 	.macro dstnr
 200:
-	EX_TABLE(200b,.Ldest_error_nr)
+	EX_TABLE(200b,.Lerror_nr)
 	.endm
 
 	.macro dest
 250:
-	EX_TABLE(250b,.Ldest_error)
+	EX_TABLE(250b,.Lerror)
 	.endm
 
 /*
  * Computes the checksum of a memory block at src, length len,
- * and adds in "sum" (32-bit), while copying the block to dst.
- * If an access exception occurs on src or dst, it stores -EFAULT
- * to *src_err or *dst_err respectively. The caller must take any action
- * required in this case (zeroing memory, recalculating partial checksum etc).
+ * and adds in 0xffffffff (32-bit), while copying the block to dst.
+ * If an access exception occurs, it returns 0.
  *
- * csum_partial_copy_generic(r3=src, r4=dst, r5=len, r6=sum, r7=src_err, r8=dst_err)
+ * csum_partial_copy_generic(r3=src, r4=dst, r5=len)
  */
 _GLOBAL(csum_partial_copy_generic)
+	li	r6,-1
 	addic	r0,r6,0			/* clear carry */
 
 	srdi.	r6,r5,3			/* less than 8 bytes? */
@@ -401,29 +400,15 @@ dstnr;	stb	r6,0(r4)
 	srdi	r3,r3,32
 	blr
 
-.Lsrc_error:
+.Lerror:
 	ld	r14,STK_REG(R14)(r1)
 	ld	r15,STK_REG(R15)(r1)
 	ld	r16,STK_REG(R16)(r1)
 	addi	r1,r1,STACKFRAMESIZE
-.Lsrc_error_nr:
-	cmpdi	0,r7,0
-	beqlr
-	li	r6,-EFAULT
-	stw	r6,0(r7)
+.Lerror_nr:
+	li	r3,0
 	blr
 
-.Ldest_error:
-	ld	r14,STK_REG(R14)(r1)
-	ld	r15,STK_REG(R15)(r1)
-	ld	r16,STK_REG(R16)(r1)
-	addi	r1,r1,STACKFRAMESIZE
-.Ldest_error_nr:
-	cmpdi	0,r8,0
-	beqlr
-	li	r6,-EFAULT
-	stw	r6,0(r8)
-	blr
 EXPORT_SYMBOL(csum_partial_copy_generic)
 
 /*
diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
index b1faa82dd8af..b895166afc82 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -14,8 +14,7 @@
 __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 			       int len)
 {
-	unsigned int csum;
-	int err = 0;
+	__wsum csum;
 
 	might_sleep();
 
@@ -24,27 +23,16 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 
 	allow_read_from_user(src, len);
 
-	csum = csum_partial_copy_generic((void __force *)src, dst,
-					 len, ~0U, &err, NULL);
-
-	if (unlikely(err)) {
-		int missing = __copy_from_user(dst, src, len);
-
-		if (missing)
-			csum = 0;
-		else
-			csum = csum_partial(dst, len, ~0U);
-	}
+	csum = csum_partial_copy_generic((void __force *)src, dst, len);
 
 	prevent_read_from_user(src, len);
-	return (__force __wsum)csum;
+	return csum;
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
 
 __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	unsigned int csum;
-	int err = 0;
+	__wsum csum;
 
 	might_sleep();
 	if (unlikely(!access_ok(dst, len)))
@@ -52,17 +40,9 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
 
 	allow_write_to_user(dst, len);
 
-	csum = csum_partial_copy_generic(src, (void __force *)dst,
-					 len, ~0U, NULL, &err);
-
-	if (unlikely(err)) {
-		csum = csum_partial(src, len, ~0U);
-
-		if (copy_to_user(dst, src, len))
-			csum = 0;
-	}
+	csum = csum_partial_copy_generic(src, (void __force *)dst, len);
 
 	prevent_write_to_user(dst, len);
-	return (__force __wsum)csum;
+	return csum;
 }
 EXPORT_SYMBOL(csum_and_copy_to_user);
-- 
2.11.0

