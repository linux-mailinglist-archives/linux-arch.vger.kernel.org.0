Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44C622BB6E
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgGXB0X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgGXBZw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34195C0619D3;
        Thu, 23 Jul 2020 18:25:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT5-001Gd5-Ql; Fri, 24 Jul 2020 01:25:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 11/20] sh: propage the calling conventions change down to csum_partial_copy_generic()
Date:   Fri, 24 Jul 2020 02:25:37 +0100
Message-Id: <20200724012546.302155-11-viro@ZenIV.linux.org.uk>
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

... and get rid of zeroing destination on error there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sh/include/asm/checksum_32.h |  20 ++-----
 arch/sh/lib/checksum.S            | 119 +++++++++++---------------------------
 2 files changed, 39 insertions(+), 100 deletions(-)

diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index a08e8eb924ed..1a391e3a7659 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -30,9 +30,7 @@ asmlinkage __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
-					    int len, __wsum sum,
-					    int *src_err_ptr, int *dst_err_ptr);
+asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst, int len);
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 /*
@@ -45,21 +43,16 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
 static inline
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len, 0, NULL, NULL);
+	return csum_partial_copy_generic(src, dst, len);
 }
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
 __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	int err = 0;
-	__wsum sum = ~0U;
-
 	if (!access_ok(src, len))
 		return 0;
-	sum = csum_partial_copy_generic((__force const void *)src, dst,
-					len, sum, &err, NULL);
-	return err ? 0 : sum;
+	return csum_partial_copy_generic((__force const void *)src, dst, len);
 }
 
 /*
@@ -202,13 +195,8 @@ static inline __wsum csum_and_copy_to_user(const void *src,
 					   void __user *dst,
 					   int len)
 {
-	int err = 0;
-	__wsum sum = ~0U;
-
 	if (!access_ok(dst, len))
 		return 0;
-	sum = csum_partial_copy_generic((__force const void *)src,
-						dst, len, sum, NULL, &err);
-	return err ? 0 : sum;
+	return csum_partial_copy_generic((__force const void *)src, dst, len);
 }
 #endif /* __ASM_SH_CHECKSUM_H */
diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 97b5c2d9fec4..3e07074e0098 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -173,47 +173,27 @@ ENTRY(csum_partial)
 	 mov	r6, r0
 
 /*
-unsigned int csum_partial_copy_generic (const char *src, char *dst, int len, 
-					int sum, int *src_err_ptr, int *dst_err_ptr)
+unsigned int csum_partial_copy_generic (const char *src, char *dst, int len)
  */ 
 
 /*
- * Copy from ds while checksumming, otherwise like csum_partial
- *
- * The macros SRC and DST specify the type of access for the instruction.
- * thus we can call a custom exception handler for all access types.
- *
- * FIXME: could someone double-check whether I haven't mixed up some SRC and
- *	  DST definitions? It's damn hard to trigger all cases.  I hope I got
- *	  them all but there's no guarantee.
+ * Copy from ds while checksumming, otherwise like csum_partial with initial
+ * sum being ~0U
  */
 
-#define SRC(...)			\
+#define EXC(...)			\
 	9999: __VA_ARGS__ ;		\
 	.section __ex_table, "a";	\
 	.long 9999b, 6001f	;	\
 	.previous
 
-#define DST(...)			\
-	9999: __VA_ARGS__ ;		\
-	.section __ex_table, "a";	\
-	.long 9999b, 6002f	;	\
-	.previous
-
 !
 ! r4:	const char *SRC
 ! r5:	char *DST
 ! r6:	int LEN
-! r7:	int SUM
-!
-! on stack:
-! int *SRC_ERR_PTR
-! int *DST_ERR_PTR
 !
 ENTRY(csum_partial_copy_generic)
-	mov.l	r5,@-r15
-	mov.l	r6,@-r15
-
+	mov	#-1,r7
 	mov	#3,r0		! Check src and dest are equally aligned
 	mov	r4,r1
 	and	r0,r1
@@ -243,11 +223,11 @@ ENTRY(csum_partial_copy_generic)
 	clrt
 	.align	2
 5:
-SRC(	mov.b	@r4+,r1 	)
-SRC(	mov.b	@r4+,r0		)
+EXC(	mov.b	@r4+,r1 	)
+EXC(	mov.b	@r4+,r0		)
 	extu.b	r1,r1
-DST(	mov.b	r1,@r5		)
-DST(	mov.b	r0,@(1,r5)	)
+EXC(	mov.b	r1,@r5		)
+EXC(	mov.b	r0,@(1,r5)	)
 	extu.b	r0,r0
 	add	#2,r5
 
@@ -276,8 +256,8 @@ DST(	mov.b	r0,@(1,r5)	)
 	! Handle first two bytes as a special case
 	.align	2
 1:	
-SRC(	mov.w	@r4+,r0		)
-DST(	mov.w	r0,@r5		)
+EXC(	mov.w	@r4+,r0		)
+EXC(	mov.w	r0,@r5		)
 	add	#2,r5
 	extu.w	r0,r0
 	addc	r0,r7
@@ -292,32 +272,32 @@ DST(	mov.w	r0,@r5		)
 	 clrt
 	.align	2
 1:	
-SRC(	mov.l	@r4+,r0		)
-SRC(	mov.l	@r4+,r1		)
+EXC(	mov.l	@r4+,r0		)
+EXC(	mov.l	@r4+,r1		)
 	addc	r0,r7
-DST(	mov.l	r0,@r5		)
-DST(	mov.l	r1,@(4,r5)	)
+EXC(	mov.l	r0,@r5		)
+EXC(	mov.l	r1,@(4,r5)	)
 	addc	r1,r7
 
-SRC(	mov.l	@r4+,r0		)
-SRC(	mov.l	@r4+,r1		)
+EXC(	mov.l	@r4+,r0		)
+EXC(	mov.l	@r4+,r1		)
 	addc	r0,r7
-DST(	mov.l	r0,@(8,r5)	)
-DST(	mov.l	r1,@(12,r5)	)
+EXC(	mov.l	r0,@(8,r5)	)
+EXC(	mov.l	r1,@(12,r5)	)
 	addc	r1,r7
 
-SRC(	mov.l	@r4+,r0 	)
-SRC(	mov.l	@r4+,r1		)
+EXC(	mov.l	@r4+,r0 	)
+EXC(	mov.l	@r4+,r1		)
 	addc	r0,r7
-DST(	mov.l	r0,@(16,r5)	)
-DST(	mov.l	r1,@(20,r5)	)
+EXC(	mov.l	r0,@(16,r5)	)
+EXC(	mov.l	r1,@(20,r5)	)
 	addc	r1,r7
 
-SRC(	mov.l	@r4+,r0		)
-SRC(	mov.l	@r4+,r1		)
+EXC(	mov.l	@r4+,r0		)
+EXC(	mov.l	@r4+,r1		)
 	addc	r0,r7
-DST(	mov.l	r0,@(24,r5)	)
-DST(	mov.l	r1,@(28,r5)	)
+EXC(	mov.l	r0,@(24,r5)	)
+EXC(	mov.l	r1,@(28,r5)	)
 	addc	r1,r7
 	add	#32,r5
 	movt	r0
@@ -335,9 +315,9 @@ DST(	mov.l	r1,@(28,r5)	)
 	 clrt
 	shlr2	r6
 3:	
-SRC(	mov.l	@r4+,r0	)
+EXC(	mov.l	@r4+,r0	)
 	addc	r0,r7
-DST(	mov.l	r0,@r5	)
+EXC(	mov.l	r0,@r5	)
 	add	#4,r5
 	movt	r0
 	dt	r6
@@ -353,8 +333,8 @@ DST(	mov.l	r0,@r5	)
 	mov	#2,r1
 	cmp/hs	r1,r6
 	bf	5f
-SRC(	mov.w	@r4+,r0	)
-DST(	mov.w	r0,@r5	)
+EXC(	mov.w	@r4+,r0	)
+EXC(	mov.w	r0,@r5	)
 	extu.w	r0,r0
 	add	#2,r5
 	cmp/eq	r1,r6
@@ -363,8 +343,8 @@ DST(	mov.w	r0,@r5	)
 	shll16	r0
 	addc	r0,r7
 5:	
-SRC(	mov.b	@r4+,r0	)
-DST(	mov.b	r0,@r5	)
+EXC(	mov.b	@r4+,r0	)
+EXC(	mov.b	r0,@r5	)
 	extu.b	r0,r0
 #ifndef	__LITTLE_ENDIAN__
 	shll8	r0
@@ -373,42 +353,13 @@ DST(	mov.b	r0,@r5	)
 	mov	#0,r0
 	addc	r0,r7
 7:
-5000:
 
 # Exception handler:
 .section .fixup, "ax"							
 
 6001:
-	mov.l	@(8,r15),r0			! src_err_ptr
-	mov	#-EFAULT,r1
-	mov.l	r1,@r0
-
-	! zero the complete destination - computing the rest
-	! is too much work 
-	mov.l	@(4,r15),r5		! dst
-	mov.l	@r15,r6			! len
-	mov	#0,r7
-1:	mov.b	r7,@r5
-	dt	r6
-	bf/s	1b
-	 add	#1,r5
-	mov.l	8000f,r0
-	jmp	@r0
-	 nop
-	.align	2
-8000:	.long	5000b
-
-6002:
-	mov.l	@(12,r15),r0			! dst_err_ptr
-	mov	#-EFAULT,r1
-	mov.l	r1,@r0
-	mov.l	8001f,r0
-	jmp	@r0
-	 nop
-	.align	2
-8001:	.long	5000b
-
+	rts
+	 mov	#0,r0
 .previous
-	add	#8,r15
 	rts
 	 mov	r7,r0
-- 
2.11.0

