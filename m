Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8F22BB77
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgGXB0k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgGXBZs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A24C0619D3;
        Thu, 23 Jul 2020 18:25:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT4-001GcN-PK; Fri, 24 Jul 2020 01:25:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 04/20] unify generic instances of csum_partial_copy_nocheck()
Date:   Fri, 24 Jul 2020 02:25:30 +0100
Message-Id: <20200724012546.302155-4-viro@ZenIV.linux.org.uk>
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

quite a few architectures have the same csum_partial_copy_nocheck() -
simply memcpy() the data and then return the csum of the copy.

hexagon, parisc, ia64, s390, um: explicitly spelled out that way.

arc, arm64, csky, h8300, m68k/nommu, microblaze, mips/GENERIC_CSUM, nds32,
nios2, openrisc, riscv, unicore32: end up picking the same thing spelled
out in lib/checksum.h (with varying amounts of perversions along the way).

everybody else (alpha, arm, c6x, m68k/mmu, mips/!GENERIC_CSUM, powerpc,
sh, sparc, x86, xtensa) have non-generic variants.  For all except c6x
the declaration is in their asm/checksum.h.  c6x uses the wrapper
from asm-generic/checksum.h that would normally lead to the lib/checksum.h
instance, but in case of c6x we end up using an asm function from arch/c6x
instead.

Screw that mess - have architectures with private instances define
_HAVE_ARCH_CSUM_AND_COPY in their asm/checksum.h and have the default
one right in net/checksum.h conditional on _HAVE_ARCH_CSUM_AND_COPY
*not* defined.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/checksum.h   |  1 +
 arch/arm/include/asm/checksum.h     |  1 +
 arch/c6x/include/asm/checksum.h     |  6 ++++++
 arch/hexagon/include/asm/checksum.h | 11 -----------
 arch/hexagon/lib/checksum.c         | 11 -----------
 arch/ia64/include/asm/checksum.h    |  3 ---
 arch/ia64/lib/csum_partial_copy.c   | 15 ---------------
 arch/m68k/include/asm/checksum.h    |  1 +
 arch/mips/include/asm/checksum.h    |  2 +-
 arch/nios2/include/asm/checksum.h   |  5 -----
 arch/parisc/include/asm/checksum.h  |  8 --------
 arch/parisc/lib/checksum.c          | 17 -----------------
 arch/powerpc/include/asm/checksum.h |  1 +
 arch/s390/include/asm/checksum.h    |  7 -------
 arch/sh/include/asm/checksum_32.h   |  1 +
 arch/sparc/include/asm/checksum.h   |  1 +
 arch/x86/include/asm/checksum.h     |  1 +
 arch/x86/um/asm/checksum.h          | 16 ----------------
 arch/xtensa/include/asm/checksum.h  |  1 +
 include/asm-generic/checksum.h      | 14 --------------
 include/net/checksum.h              |  9 +++++++++
 lib/checksum.c                      | 11 -----------
 22 files changed, 24 insertions(+), 119 deletions(-)

diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
index 0eac81624d01..7e8e4fa4362d 100644
--- a/arch/alpha/include/asm/checksum.h
+++ b/arch/alpha/include/asm/checksum.h
@@ -42,6 +42,7 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+#define _HAVE_ARCH_CSUM_AND_COPY
 __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *errp);
 
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index ed6073fee338..53f769508540 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -41,6 +41,7 @@ __wsum
 csum_partial_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *err_ptr);
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+#define _HAVE_ARCH_CSUM_AND_COPY
 static inline
 __wsum csum_and_copy_from_user (const void __user *src, void *dst,
 				      int len, __wsum sum, int *err_ptr)
diff --git a/arch/c6x/include/asm/checksum.h b/arch/c6x/include/asm/checksum.h
index 36770b8308d9..facdd636af85 100644
--- a/arch/c6x/include/asm/checksum.h
+++ b/arch/c6x/include/asm/checksum.h
@@ -26,6 +26,12 @@ csum_tcpudp_nofold(__be32 saddr, __be32 daddr, __u32 len,
 }
 #define csum_tcpudp_nofold csum_tcpudp_nofold
 
+extern __wsum csum_partial_copy(const void *src, void *dst, int len, __wsum sum);
+
+#define _HAVE_ARCH_CSUM_AND_COPY
+#define csum_partial_copy_nocheck(src, dst, len, sum)  \
+	csum_partial_copy((src), (dst), (len), (sum))
+
 #include <asm-generic/checksum.h>
 
 #endif /* _ASM_C6X_CHECKSUM_H */
diff --git a/arch/hexagon/include/asm/checksum.h b/arch/hexagon/include/asm/checksum.h
index a5c42f4614c1..4bc6ad96c4c5 100644
--- a/arch/hexagon/include/asm/checksum.h
+++ b/arch/hexagon/include/asm/checksum.h
@@ -10,17 +10,6 @@
 unsigned int do_csum(const void *voidptr, int len);
 
 /*
- * the same as csum_partial, but copies from src while it
- * checksums
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- */
-#define csum_partial_copy_nocheck csum_partial_copy_nocheck
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-					int len, __wsum sum);
-
-/*
  * computes the checksum of the TCP/UDP pseudo-header
  * returns a 16-bit checksum, already complemented
  */
diff --git a/arch/hexagon/lib/checksum.c b/arch/hexagon/lib/checksum.c
index c4a6b72d97de..ba50822a0800 100644
--- a/arch/hexagon/lib/checksum.c
+++ b/arch/hexagon/lib/checksum.c
@@ -176,14 +176,3 @@ unsigned int do_csum(const void *voidptr, int len)
 
 	return 0xFFFF & sum0;
 }
-
-/*
- * copy from ds while checksumming, otherwise like csum_partial
- */
-__wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
-{
-	memcpy(dst, src, len);
-	return csum_partial(dst, len, sum);
-}
-EXPORT_SYMBOL(csum_partial_copy_nocheck);
diff --git a/arch/ia64/include/asm/checksum.h b/arch/ia64/include/asm/checksum.h
index 2a1c64629cdc..f3026213aa32 100644
--- a/arch/ia64/include/asm/checksum.h
+++ b/arch/ia64/include/asm/checksum.h
@@ -37,9 +37,6 @@ extern __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-extern __wsum csum_partial_copy_nocheck(const void *src, void *dst,
-					       int len, __wsum sum);
-
 /*
  * This routine is used for miscellaneous IP-like checksums, mainly in
  * icmp.c
diff --git a/arch/ia64/lib/csum_partial_copy.c b/arch/ia64/lib/csum_partial_copy.c
index 6e82e0be8040..917e3138b277 100644
--- a/arch/ia64/lib/csum_partial_copy.c
+++ b/arch/ia64/lib/csum_partial_copy.c
@@ -96,18 +96,3 @@ unsigned long do_csum_c(const unsigned char * buff, int len, unsigned int psum)
 out:
 	return result;
 }
-
-/*
- * XXX Fixme
- *
- * This is very ugly but temporary. THIS NEEDS SERIOUS ENHANCEMENTS.
- * But it's very tricky to get right even in C.
- */
-__wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
-{
-	memcpy(dst, src, len);
-	return csum_partial(dst, len, sum);
-}
-
-EXPORT_SYMBOL(csum_partial_copy_nocheck);
diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index 3f2c15d6f18c..ab16881d84cb 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -31,6 +31,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
  */
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+#define _HAVE_ARCH_CSUM_AND_COPY
 extern __wsum csum_and_copy_from_user(const void __user *src,
 						void *dst,
 						int len, __wsum sum,
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index dcebaaf8c862..b771621ec3c5 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -101,9 +101,9 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
  * the same as csum_partial, but copies from user space (but on MIPS
  * we have just one address space, so this is identical to the above)
  */
+#define _HAVE_ARCH_CSUM_AND_COPY
 __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 				       int len, __wsum sum);
-#define csum_partial_copy_nocheck csum_partial_copy_nocheck
 
 /*
  *	Fold a partial checksum without adding pseudo headers
diff --git a/arch/nios2/include/asm/checksum.h b/arch/nios2/include/asm/checksum.h
index ec39698d3bea..69004e07a1ba 100644
--- a/arch/nios2/include/asm/checksum.h
+++ b/arch/nios2/include/asm/checksum.h
@@ -12,11 +12,6 @@
 
 /* Take these from lib/checksum.c */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
-extern __wsum csum_partial_copy(const void *src, void *dst, int len,
-				__wsum sum);
-#define csum_partial_copy_nocheck(src, dst, len, sum)	\
-	csum_partial_copy((src), (dst), (len), (sum))
-
 extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 extern __sum16 ip_compute_csum(const void *buff, int len);
 
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index fe8c63b2d2c3..522cd574c068 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -19,14 +19,6 @@
 extern __wsum csum_partial(const void *, int, __wsum);
 
 /*
- * The same as csum_partial, but copies from src while it checksums.
- *
- * Here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- */
-extern __wsum csum_partial_copy_nocheck(const void *, void *, int, __wsum);
-
-/*
  *	Optimized for IP headers, which always checksum on 4 octet boundaries.
  *
  *	Written by Randolph Chung <tausq@debian.org>, and then mucked with by
diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
index c6f161583549..4818f3db84a5 100644
--- a/arch/parisc/lib/checksum.c
+++ b/arch/parisc/lib/checksum.c
@@ -106,20 +106,3 @@ __wsum csum_partial(const void *buff, int len, __wsum sum)
 }
 
 EXPORT_SYMBOL(csum_partial);
-
-/*
- * copy while checksumming, otherwise like csum_partial
- */
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-				       int len, __wsum sum)
-{
-	/*
-	 * It's 2:30 am and I don't feel like doing it real ...
-	 * This is lots slower than the real thing (tm)
-	 */
-	sum = csum_partial(src, len, sum);
-	memcpy(dst, src, len);
-
-	return sum;
-}
-EXPORT_SYMBOL(csum_partial_copy_nocheck);
diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 9cce06194dcc..d75fc5bf8f37 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -29,6 +29,7 @@ extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
 				    int len, __wsum sum, int *err_ptr);
 
+#define _HAVE_ARCH_CSUM_AND_COPY
 #define csum_partial_copy_nocheck(src, dst, len, sum)   \
         csum_partial_copy_generic((src), (dst), (len), (sum), NULL, NULL)
 
diff --git a/arch/s390/include/asm/checksum.h b/arch/s390/include/asm/checksum.h
index 6d01c96aeb5c..6813bfa1eeb7 100644
--- a/arch/s390/include/asm/checksum.h
+++ b/arch/s390/include/asm/checksum.h
@@ -39,13 +39,6 @@ csum_partial(const void *buff, int len, __wsum sum)
 	return sum;
 }
 
-static inline __wsum
-csum_partial_copy_nocheck (const void *src, void *dst, int len, __wsum sum)
-{
-        memcpy(dst,src,len);
-	return csum_partial(dst, len, sum);
-}
-
 /*
  *      Fold a partial checksum without adding pseudo headers
  */
diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index 91571a42e44e..87269642d78d 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -34,6 +34,7 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
 					    int len, __wsum sum,
 					    int *src_err_ptr, int *dst_err_ptr);
 
+#define _HAVE_ARCH_CSUM_AND_COPY
 /*
  *	Note: when you get a NULL pointer exception here this means someone
  *	passed in an incorrect kernel address to one of these functions.
diff --git a/arch/sparc/include/asm/checksum.h b/arch/sparc/include/asm/checksum.h
index a6256cb6fc5c..deb4fe5aeafd 100644
--- a/arch/sparc/include/asm/checksum.h
+++ b/arch/sparc/include/asm/checksum.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_CHECKSUM_H
 #define ___ASM_SPARC_CHECKSUM_H
+#define _HAVE_ARCH_CSUM_AND_COPY
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/checksum_64.h>
diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index 0ada98d5d09f..bca625a60186 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
 #define HAVE_CSUM_COPY_USER
+#define _HAVE_ARCH_CSUM_AND_COPY
 #ifdef CONFIG_X86_32
 # include <asm/checksum_32.h>
 #else
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index ff6bba2c8ab6..b07824500363 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -20,22 +20,6 @@
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-/*
- *	Note: when you get a NULL pointer exception here this means someone
- *	passed in an incorrect kernel address to one of these functions.
- *
- *	If you use these functions directly please don't forget the
- *	access_ok().
- */
-
-static __inline__
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-				       int len, __wsum sum)
-{
-	memcpy(dst, src, len);
-	return csum_partial(dst, len, sum);
-}
-
 /**
  * csum_fold - Fold and invert a 32bit checksum.
  * sum: 32bit unfolded sum
diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index 243a5fe79d3c..0c879099977f 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -41,6 +41,7 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
 					    int len, __wsum sum,
 					    int *src_err_ptr, int *dst_err_ptr);
 
+#define _HAVE_ARCH_CSUM_AND_COPY
 /*
  *	Note: when you get a NULL pointer exception here this means someone
  *	passed in an incorrect kernel address to one of these functions.
diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 5a80f8e54300..43e18db89c14 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -16,20 +16,6 @@
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-/*
- * the same as csum_partial, but copies from src while it
- * checksums
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- */
-extern __wsum csum_partial_copy(const void *src, void *dst, int len, __wsum sum);
-
-#ifndef csum_partial_copy_nocheck
-#define csum_partial_copy_nocheck(src, dst, len, sum)	\
-	csum_partial_copy((src), (dst), (len), (sum))
-#endif
-
 #ifndef ip_fast_csum
 /*
  * This is a version of ip_compute_csum() optimized for IP headers,
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 46754ba9d7b7..db9d02b5f88a 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -47,6 +47,15 @@ static __inline__ __wsum csum_and_copy_to_user
 }
 #endif
 
+#ifndef _HAVE_ARCH_CSUM_AND_COPY
+static inline __wsum
+csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
+{
+	memcpy(dst, src, len);
+	return csum_partial(dst, len, sum);
+}
+#endif
+
 #ifndef HAVE_ARCH_CSUM_ADD
 static inline __wsum csum_add(__wsum csum, __wsum addend)
 {
diff --git a/lib/checksum.c b/lib/checksum.c
index 7ac65a0000ff..6860d6b05a17 100644
--- a/lib/checksum.c
+++ b/lib/checksum.c
@@ -145,17 +145,6 @@ __sum16 ip_compute_csum(const void *buff, int len)
 }
 EXPORT_SYMBOL(ip_compute_csum);
 
-/*
- * copy from ds while checksumming, otherwise like csum_partial
- */
-__wsum
-csum_partial_copy(const void *src, void *dst, int len, __wsum sum)
-{
-	memcpy(dst, src, len);
-	return csum_partial(dst, len, sum);
-}
-EXPORT_SYMBOL(csum_partial_copy);
-
 #ifndef csum_tcpudp_nofold
 static inline u32 from64to32(u64 x)
 {
-- 
2.11.0

