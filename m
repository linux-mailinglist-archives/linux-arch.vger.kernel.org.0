Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FEF22BB76
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGXB0k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGXBZt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:49 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1300C0619E7;
        Thu, 23 Jul 2020 18:25:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT5-001Gcs-C8; Fri, 24 Jul 2020 01:25:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 09/20] arm: propagate the calling convention changes down to csum_partial_copy_from_user()
Date:   Fri, 24 Jul 2020 02:25:35 +0100
Message-Id: <20200724012546.302155-9-viro@ZenIV.linux.org.uk>
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

... and get rid of the "clean the destination on error" crap.
Simplifies the fault handlers and the function itself...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/include/asm/checksum.h       |  7 ++-----
 arch/arm/lib/csumpartialcopy.S        |  1 -
 arch/arm/lib/csumpartialcopygeneric.S |  1 +
 arch/arm/lib/csumpartialcopyuser.S    | 26 ++++++--------------------
 4 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index 1601c132b064..f0f54aef3724 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -38,20 +38,17 @@ __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 __wsum
-csum_partial_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *err_ptr);
+csum_partial_copy_from_user(const void __user *src, void *dst, int len);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
 static inline
 __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	int err = 0;
-
 	if (!access_ok(src, len))
 		return 0;
 
-	sum = csum_partial_copy_from_user(src, dst, len, ~0U, &err);
-	return err ? 0 : sum;
+	return csum_partial_copy_from_user(src, dst, len);
 }
 
 /*
diff --git a/arch/arm/lib/csumpartialcopy.S b/arch/arm/lib/csumpartialcopy.S
index aab914fbc86b..1ca6aadd649c 100644
--- a/arch/arm/lib/csumpartialcopy.S
+++ b/arch/arm/lib/csumpartialcopy.S
@@ -16,7 +16,6 @@
 
 		.macro	save_regs
 		stmfd	sp!, {r1, r4 - r8, lr}
-		mov	r3, #0
 		.endm
 
 		.macro	load_regs
diff --git a/arch/arm/lib/csumpartialcopygeneric.S b/arch/arm/lib/csumpartialcopygeneric.S
index 0b706a39a677..0fd5c10e90a7 100644
--- a/arch/arm/lib/csumpartialcopygeneric.S
+++ b/arch/arm/lib/csumpartialcopygeneric.S
@@ -86,6 +86,7 @@ sum	.req	r3
 
 FN_ENTRY
 		save_regs
+		mov	sum, #-1
 
 		cmp	len, #8			@ Ensure that we have at least
 		blo	.Lless8			@ 8 bytes to copy.
diff --git a/arch/arm/lib/csumpartialcopyuser.S b/arch/arm/lib/csumpartialcopyuser.S
index 6bd3a93eaa3c..6928781e6bee 100644
--- a/arch/arm/lib/csumpartialcopyuser.S
+++ b/arch/arm/lib/csumpartialcopyuser.S
@@ -62,9 +62,9 @@
 
 /*
  * unsigned int
- * csum_partial_copy_from_user(const char *src, char *dst, int len, int sum, int *err_ptr)
- *  r0 = src, r1 = dst, r2 = len, r3 = sum, [sp] = *err_ptr
- *  Returns : r0 = checksum, [[sp, #0], #0] = 0 or -EFAULT
+ * csum_partial_copy_from_user(const char *src, char *dst, int len)
+ *  r0 = src, r1 = dst, r2 = len
+ *  Returns : r0 = checksum or 0
  */
 
 #define FN_ENTRY	ENTRY(csum_partial_copy_from_user)
@@ -73,25 +73,11 @@
 #include "csumpartialcopygeneric.S"
 
 /*
- * FIXME: minor buglet here
- * We don't return the checksum for the data present in the buffer.  To do
- * so properly, we would have to add in whatever registers were loaded before
- * the fault, which, with the current asm above is not predictable.
+ * We report fault by returning 0 csum - impossible in normal case, since
+ * we start with 0xffffffff for initial sum.
  */
 		.pushsection .text.fixup,"ax"
 		.align	4
-9001:		mov	r4, #-EFAULT
-#ifdef CONFIG_CPU_SW_DOMAIN_PAN
-		ldr	r5, [sp, #9*4]		@ *err_ptr
-#else
-		ldr	r5, [sp, #8*4]		@ *err_ptr
-#endif
-		str	r4, [r5]
-		ldmia	sp, {r1, r2}		@ retrieve dst, len
-		add	r2, r2, r1
-		mov	r0, #0			@ zero the buffer
-9002:		teq	r2, r1
-		strbne	r0, [r1], #1
-		bne	9002b
+9001:		mov	r0, #0
 		load_regs
 		.popsection
-- 
2.11.0

