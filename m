Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5181B22BB62
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgGXBZy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgGXBZx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:53 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1E5C0619E3;
        Thu, 23 Jul 2020 18:25:53 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT6-001Gdm-PS; Fri, 24 Jul 2020 01:25:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 18/20] sparc64: propagate the calling convention changes down to __csum_partial_copy_...()
Date:   Fri, 24 Jul 2020 02:25:44 +0100
Message-Id: <20200724012546.302155-18-viro@ZenIV.linux.org.uk>
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

... and rename them into csum_and_copy_...() - the wrappers become pointless.
[braino fixed]

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/checksum.h    |  1 +
 arch/sparc/include/asm/checksum_32.h |  2 --
 arch/sparc/include/asm/checksum_64.h | 41 +++---------------------------------
 arch/sparc/lib/csum_copy.S           |  5 +++--
 arch/sparc/lib/csum_copy_from_user.S |  4 ++--
 arch/sparc/lib/csum_copy_to_user.S   |  4 ++--
 6 files changed, 11 insertions(+), 46 deletions(-)

diff --git a/arch/sparc/include/asm/checksum.h b/arch/sparc/include/asm/checksum.h
index deb4fe5aeafd..f2ac13323b6d 100644
--- a/arch/sparc/include/asm/checksum.h
+++ b/arch/sparc/include/asm/checksum.h
@@ -3,6 +3,7 @@
 #define ___ASM_SPARC_CHECKSUM_H
 #define _HAVE_ARCH_CSUM_AND_COPY
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+#define HAVE_CSUM_COPY_USER
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/checksum_64.h>
 #else
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index d55e480172a6..ce11e0ad80c7 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -67,8 +67,6 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len)
 	return csum_partial_copy_nocheck((__force void *)src, dst, len);
 }
 
-#define HAVE_CSUM_COPY_USER
-
 static inline __wsum
 csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/checksum_64.h
index 4d0bbff43e62..d6b59461e064 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -38,44 +38,9 @@ __wsum csum_partial(const void * buff, int len, __wsum sum);
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-__wsum __csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
-
-static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
-{
-	return __csum_partial_copy_nocheck(src, dst, len, 0);
-}
-
-long __csum_partial_copy_from_user(const void __user *src,
-				   void *dst, int len,
-				   __wsum sum);
-
-static inline __wsum
-csum_and_copy_from_user(const void __user *src,
-			    void *dst, int len)
-{
-	long ret = __csum_partial_copy_from_user(src, dst, len, ~0U);
-	if (ret < 0)
-		return 0;
-	return (__force __wsum) ret;
-}
-
-/*
- *	Copy and checksum to user
- */
-#define HAVE_CSUM_COPY_USER
-long __csum_partial_copy_to_user(const void *src,
-				 void __user *dst, int len,
-				 __wsum sum);
-
-static inline __wsum
-csum_and_copy_to_user(const void *src,
-		      void __user *dst, int len)
-{
-	long ret = __csum_partial_copy_to_user(src, dst, len, ~0U);
-	if (ret < 0)
-		return 0;
-	return (__force __wsum) ret;
-}
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
+__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
+__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len);
 
 /* ihl is always 5 or greater, almost always is 5, and iph is word aligned
  * the majority of the time.
diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index 72c900d21b12..0c0268e77155 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -33,7 +33,7 @@
 #endif
 
 #ifndef FUNC_NAME
-#define FUNC_NAME	__csum_partial_copy_nocheck
+#define FUNC_NAME	csum_partial_copy_nocheck
 #endif
 
 	.register	%g2, #scratch
@@ -68,9 +68,10 @@
 	.globl		FUNC_NAME
 	.type		FUNC_NAME,#function
 	EXPORT_SYMBOL(FUNC_NAME)
-FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len, %o3=sum */
+FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len */
 	LOAD(prefetch, %o0 + 0x000, #n_reads)
 	xor		%o0, %o1, %g1
+	mov		1, %o3
 	clr		%o4
 	andcc		%g1, 0x3, %g0
 	bne,pn		%icc, 95f
diff --git a/arch/sparc/lib/csum_copy_from_user.S b/arch/sparc/lib/csum_copy_from_user.S
index d20b9594f0c7..b0ba8d4dd439 100644
--- a/arch/sparc/lib/csum_copy_from_user.S
+++ b/arch/sparc/lib/csum_copy_from_user.S
@@ -9,14 +9,14 @@
 	.section .fixup, "ax";	\
 	.align 4;		\
 99:	retl;			\
-	 mov	-1, %o0;	\
+	 mov	0, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
 	.word 98b, 99b;		\
 	.text;			\
 	.align 4;
 
-#define FUNC_NAME		__csum_partial_copy_from_user
+#define FUNC_NAME		csum_and_copy_from_user
 #define LOAD(type,addr,dest)	type##a [addr] %asi, dest
 
 #include "csum_copy.S"
diff --git a/arch/sparc/lib/csum_copy_to_user.S b/arch/sparc/lib/csum_copy_to_user.S
index d71c0c81e8ab..91ba36dbf7d2 100644
--- a/arch/sparc/lib/csum_copy_to_user.S
+++ b/arch/sparc/lib/csum_copy_to_user.S
@@ -9,14 +9,14 @@
 	.section .fixup,"ax";	\
 	.align 4;		\
 99:	retl;			\
-	 mov	-1, %o0;	\
+	 mov	0, %o0;		\
 	.section __ex_table,"a";\
 	.align 4;		\
 	.word 98b, 99b;		\
 	.text;			\
 	.align 4;
 
-#define FUNC_NAME		__csum_partial_copy_to_user
+#define FUNC_NAME		csum_and_copy_to_user
 #define STORE(type,src,addr)	type##a src, [addr] %asi
 
 #include "csum_copy.S"
-- 
2.11.0

