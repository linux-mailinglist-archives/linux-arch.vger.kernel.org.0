Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A182289E5
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgGUU0p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbgGUUZv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:25:51 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBD7C0619DB;
        Tue, 21 Jul 2020 13:25:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxyph-00HPoU-KN; Tue, 21 Jul 2020 20:25:49 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 03/18] csum_partial_copy_nocheck(): drop the last argument
Date:   Tue, 21 Jul 2020 21:25:34 +0100
Message-Id: <20200721202549.4150745-3-viro@ZenIV.linux.org.uk>
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

It's always 0.  Note that we could use ~0U as well - result
will be the same modulo 0xffff; later we'll make use of that
whenever convenient.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/checksum.h    | 2 +-
 arch/alpha/lib/csum_partial_copy.c   | 4 ++--
 arch/arm/include/asm/checksum.h      | 2 +-
 arch/arm/lib/csumpartialcopy.S       | 5 +++--
 arch/hexagon/include/asm/checksum.h  | 3 +--
 arch/hexagon/lib/checksum.c          | 4 ++--
 arch/ia64/include/asm/checksum.h     | 3 +--
 arch/ia64/lib/csum_partial_copy.c    | 4 ++--
 arch/m68k/include/asm/checksum.h     | 3 +--
 arch/m68k/lib/checksum.c             | 3 ++-
 arch/mips/include/asm/checksum.h     | 7 +++++--
 arch/mips/lib/csum_partial.S         | 4 ++--
 arch/nios2/include/asm/checksum.h    | 4 ++--
 arch/parisc/include/asm/checksum.h   | 2 +-
 arch/parisc/lib/checksum.c           | 7 ++-----
 arch/powerpc/include/asm/checksum.h  | 4 ++--
 arch/s390/include/asm/checksum.h     | 4 ++--
 arch/sh/include/asm/checksum_32.h    | 5 ++---
 arch/sparc/include/asm/checksum_32.h | 4 ++--
 arch/sparc/include/asm/checksum_64.h | 8 ++++++--
 arch/sparc/lib/csum_copy.S           | 2 +-
 arch/x86/include/asm/checksum_32.h   | 5 ++---
 arch/x86/include/asm/checksum_64.h   | 3 +--
 arch/x86/lib/csum-wrappers_64.c      | 4 ++--
 arch/x86/um/asm/checksum.h           | 5 ++---
 arch/xtensa/include/asm/checksum.h   | 5 ++---
 drivers/net/ethernet/3com/typhoon.c  | 3 +--
 include/asm-generic/checksum.h       | 4 ++--
 lib/iov_iter.c                       | 2 +-
 net/core/skbuff.c                    | 4 ++--
 net/ipv4/icmp.c                      | 2 +-
 net/ipv4/ip_output.c                 | 2 +-
 net/ipv4/raw.c                       | 2 +-
 net/ipv6/raw.c                       | 2 +-
 34 files changed, 62 insertions(+), 65 deletions(-)

diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
index 0eac81624d01..fdb301fd819b 100644
--- a/arch/alpha/include/asm/checksum.h
+++ b/arch/alpha/include/asm/checksum.h
@@ -44,7 +44,7 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *errp);
 
-__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 
 /*
diff --git a/arch/alpha/lib/csum_partial_copy.c b/arch/alpha/lib/csum_partial_copy.c
index af1dad74e933..f363dc89fcbe 100644
--- a/arch/alpha/lib/csum_partial_copy.c
+++ b/arch/alpha/lib/csum_partial_copy.c
@@ -372,13 +372,13 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len,
 EXPORT_SYMBOL(csum_and_copy_from_user);
 
 __wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
+csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
 	__wsum checksum;
 	mm_segment_t oldfs = get_fs();
 	set_fs(KERNEL_DS);
 	checksum = csum_and_copy_from_user((__force const void __user *)src,
-						dst, len, sum, NULL);
+						dst, len, 0, NULL);
 	set_fs(oldfs);
 	return checksum;
 }
diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index ed6073fee338..1156b9a9a43b 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -35,7 +35,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
  */
 
 __wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
+csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 __wsum
 csum_partial_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *err_ptr);
diff --git a/arch/arm/lib/csumpartialcopy.S b/arch/arm/lib/csumpartialcopy.S
index 184d97254a7a..aab914fbc86b 100644
--- a/arch/arm/lib/csumpartialcopy.S
+++ b/arch/arm/lib/csumpartialcopy.S
@@ -9,13 +9,14 @@
 
 		.text
 
-/* Function: __u32 csum_partial_copy_nocheck(const char *src, char *dst, int len, __u32 sum)
- * Params  : r0 = src, r1 = dst, r2 = len, r3 = checksum
+/* Function: __u32 csum_partial_copy_nocheck(const char *src, char *dst, int len)
+ * Params  : r0 = src, r1 = dst, r2 = len
  * Returns : r0 = new checksum
  */
 
 		.macro	save_regs
 		stmfd	sp!, {r1, r4 - r8, lr}
+		mov	r3, #0
 		.endm
 
 		.macro	load_regs
diff --git a/arch/hexagon/include/asm/checksum.h b/arch/hexagon/include/asm/checksum.h
index a5c42f4614c1..282e82010b9a 100644
--- a/arch/hexagon/include/asm/checksum.h
+++ b/arch/hexagon/include/asm/checksum.h
@@ -17,8 +17,7 @@ unsigned int do_csum(const void *voidptr, int len);
  * better 64-bit) boundary
  */
 #define csum_partial_copy_nocheck csum_partial_copy_nocheck
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-					int len, __wsum sum);
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 /*
  * computes the checksum of the TCP/UDP pseudo-header
diff --git a/arch/hexagon/lib/checksum.c b/arch/hexagon/lib/checksum.c
index c4a6b72d97de..4d2628bbc987 100644
--- a/arch/hexagon/lib/checksum.c
+++ b/arch/hexagon/lib/checksum.c
@@ -181,9 +181,9 @@ unsigned int do_csum(const void *voidptr, int len)
  * copy from ds while checksumming, otherwise like csum_partial
  */
 __wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
+csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
 	memcpy(dst, src, len);
-	return csum_partial(dst, len, sum);
+	return csum_partial(dst, len, 0);
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
diff --git a/arch/ia64/include/asm/checksum.h b/arch/ia64/include/asm/checksum.h
index 2a1c64629cdc..7e526bde617a 100644
--- a/arch/ia64/include/asm/checksum.h
+++ b/arch/ia64/include/asm/checksum.h
@@ -37,8 +37,7 @@ extern __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-extern __wsum csum_partial_copy_nocheck(const void *src, void *dst,
-					       int len, __wsum sum);
+extern __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 /*
  * This routine is used for miscellaneous IP-like checksums, mainly in
diff --git a/arch/ia64/lib/csum_partial_copy.c b/arch/ia64/lib/csum_partial_copy.c
index 6e82e0be8040..87c39ef108e1 100644
--- a/arch/ia64/lib/csum_partial_copy.c
+++ b/arch/ia64/lib/csum_partial_copy.c
@@ -104,10 +104,10 @@ unsigned long do_csum_c(const unsigned char * buff, int len, unsigned int psum)
  * But it's very tricky to get right even in C.
  */
 __wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
+csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
 	memcpy(dst, src, len);
-	return csum_partial(dst, len, sum);
+	return csum_partial(dst, len, 0);
 }
 
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index 3f2c15d6f18c..77c61473ee0f 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -37,8 +37,7 @@ extern __wsum csum_and_copy_from_user(const void __user *src,
 						int *csum_err);
 
 extern __wsum csum_partial_copy_nocheck(const void *src,
-					      void *dst, int len,
-					      __wsum sum);
+					      void *dst, int len);
 
 /*
  *	This is a version of ip_fast_csum() optimized for IP headers,
diff --git a/arch/m68k/lib/checksum.c b/arch/m68k/lib/checksum.c
index 31797be9a3dc..86ddd2ee187d 100644
--- a/arch/m68k/lib/checksum.c
+++ b/arch/m68k/lib/checksum.c
@@ -324,9 +324,10 @@ EXPORT_SYMBOL(csum_and_copy_from_user);
  */
 
 __wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
+csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
 	unsigned long tmp1, tmp2;
+	__wsum sum = 0;
 	__asm__("movel %2,%4\n\t"
 		"btst #1,%4\n\t"	/* Check alignment */
 		"jeq 2f\n\t"
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index dcebaaf8c862..1dcdd7755793 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -101,8 +101,11 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
  * the same as csum_partial, but copies from user space (but on MIPS
  * we have just one address space, so this is identical to the above)
  */
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-				       int len, __wsum sum);
+__wsum __csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
+static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
+{
+	return __csum_partial_copy_nocheck(src, dst, len, 0);
+}
 #define csum_partial_copy_nocheck csum_partial_copy_nocheck
 
 /*
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 87fda0713b84..8d70855b0914 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -462,8 +462,8 @@ EXPORT_SYMBOL(csum_partial)
 	lw	errptr, 16(sp)
 #endif
 	.if \__nocheck == 1
-	FEXPORT(csum_partial_copy_nocheck)
-	EXPORT_SYMBOL(csum_partial_copy_nocheck)
+	FEXPORT(__csum_partial_copy_nocheck)
+	EXPORT_SYMBOL(__csum_partial_copy_nocheck)
 	.endif
 	move	sum, zero
 	move	odd, zero
diff --git a/arch/nios2/include/asm/checksum.h b/arch/nios2/include/asm/checksum.h
index ec39698d3bea..d3641a70844b 100644
--- a/arch/nios2/include/asm/checksum.h
+++ b/arch/nios2/include/asm/checksum.h
@@ -14,8 +14,8 @@
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 extern __wsum csum_partial_copy(const void *src, void *dst, int len,
 				__wsum sum);
-#define csum_partial_copy_nocheck(src, dst, len, sum)	\
-	csum_partial_copy((src), (dst), (len), (sum))
+#define csum_partial_copy_nocheck(src, dst, len)	\
+	csum_partial_copy((src), (dst), (len), 0)
 
 extern __sum16 ip_fast_csum(const void *iph, unsigned int ihl);
 extern __sum16 ip_compute_csum(const void *buff, int len);
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index fe8c63b2d2c3..b412e3a1bd14 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -24,7 +24,7 @@ extern __wsum csum_partial(const void *, int, __wsum);
  * Here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-extern __wsum csum_partial_copy_nocheck(const void *, void *, int, __wsum);
+extern __wsum csum_partial_copy_nocheck(const void *, void *, int);
 
 /*
  *	Optimized for IP headers, which always checksum on 4 octet boundaries.
diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
index c6f161583549..de1c6942b493 100644
--- a/arch/parisc/lib/checksum.c
+++ b/arch/parisc/lib/checksum.c
@@ -110,16 +110,13 @@ EXPORT_SYMBOL(csum_partial);
 /*
  * copy while checksumming, otherwise like csum_partial
  */
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-				       int len, __wsum sum)
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
 	/*
 	 * It's 2:30 am and I don't feel like doing it real ...
 	 * This is lots slower than the real thing (tm)
 	 */
-	sum = csum_partial(src, len, sum);
 	memcpy(dst, src, len);
-
-	return sum;
+	return csum_partial(src, len, 0);
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 9cce06194dcc..40540b7242a3 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -29,8 +29,8 @@ extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
 				    int len, __wsum sum, int *err_ptr);
 
-#define csum_partial_copy_nocheck(src, dst, len, sum)   \
-        csum_partial_copy_generic((src), (dst), (len), (sum), NULL, NULL)
+#define csum_partial_copy_nocheck(src, dst, len)   \
+        csum_partial_copy_generic((src), (dst), (len), 0, NULL, NULL)
 
 
 /*
diff --git a/arch/s390/include/asm/checksum.h b/arch/s390/include/asm/checksum.h
index 6d01c96aeb5c..b3a6ae3af9e9 100644
--- a/arch/s390/include/asm/checksum.h
+++ b/arch/s390/include/asm/checksum.h
@@ -40,10 +40,10 @@ csum_partial(const void *buff, int len, __wsum sum)
 }
 
 static inline __wsum
-csum_partial_copy_nocheck (const void *src, void *dst, int len, __wsum sum)
+csum_partial_copy_nocheck (const void *src, void *dst, int len)
 {
         memcpy(dst,src,len);
-	return csum_partial(dst, len, sum);
+	return csum_partial(dst, len, 0);
 }
 
 /*
diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index 91571a42e44e..682f88ebb7de 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -42,10 +42,9 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
  *	access_ok().
  */
 static inline
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-				 int len, __wsum sum)
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len, sum, NULL, NULL);
+	return csum_partial_copy_generic(src, dst, len, 0, NULL, NULL);
 }
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index 479a0b812af5..d21d114436ba 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -42,7 +42,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
 unsigned int __csum_partial_copy_sparc_generic (const unsigned char *, unsigned char *);
 
 static inline __wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
+csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
 	register unsigned int ret asm("o0") = (unsigned int)src;
 	register char *d asm("o1") = dst;
@@ -52,7 +52,7 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 		"call __csum_partial_copy_sparc_generic\n\t"
 		" mov %6, %%g7\n"
 	: "=&r" (ret), "=&r" (d), "=&r" (l)
-	: "0" (ret), "1" (d), "2" (l), "r" (sum)
+	: "0" (ret), "1" (d), "2" (l), "r" (0)
 	: "o2", "o3", "o4", "o5", "o7",
 	  "g2", "g3", "g4", "g5", "g7",
 	  "memory", "cc");
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/checksum_64.h
index 0fa4433f5662..7aebdbe3ac96 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -38,8 +38,12 @@ __wsum csum_partial(const void * buff, int len, __wsum sum);
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-				 int len, __wsum sum);
+__wsum __csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
+
+static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
+{
+	return __csum_partial_copy_nocheck(src, dst, len, 0);
+}
 
 long __csum_partial_copy_from_user(const void __user *src,
 				   void *dst, int len,
diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index 26c644ba3ecb..72c900d21b12 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -33,7 +33,7 @@
 #endif
 
 #ifndef FUNC_NAME
-#define FUNC_NAME	csum_partial_copy_nocheck
+#define FUNC_NAME	__csum_partial_copy_nocheck
 #endif
 
 	.register	%g2, #scratch
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 11624c8a9d8d..137a3033edcc 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -38,10 +38,9 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
  *	If you use these functions directly please don't forget the
  *	access_ok().
  */
-static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst,
-					       int len, __wsum sum)
+static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len, sum, NULL, NULL);
+	return csum_partial_copy_generic(src, dst, len, 0, NULL, NULL);
 }
 
 static inline __wsum csum_and_copy_from_user(const void __user *src,
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 0a289b87e872..5339f5dfc776 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -139,8 +139,7 @@ extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 					  int len, __wsum isum, int *errp);
 extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
 					int len, __wsum isum, int *errp);
-extern __wsum csum_partial_copy_nocheck(const void *src, void *dst,
-					int len, __wsum sum);
+extern __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 /**
  * ip_compute_csum - Compute an 16bit IP checksum.
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index ee63d7576fd2..245f929a1c2c 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -129,9 +129,9 @@ EXPORT_SYMBOL(csum_and_copy_to_user);
  * Returns an 32bit unfolded checksum of the buffer.
  */
 __wsum
-csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
+csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len, sum, NULL, NULL);
+	return csum_partial_copy_generic(src, dst, len, 0, NULL, NULL);
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index ff6bba2c8ab6..452e4442ec3f 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -29,11 +29,10 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
  */
 
 static __inline__
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-				       int len, __wsum sum)
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
 	memcpy(dst, src, len);
-	return csum_partial(dst, len, sum);
+	return csum_partial(dst, len, 0);
 }
 
 /**
diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index d8292cc9ebdf..84e6a36fee6d 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -46,10 +46,9 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
  *	passed in an incorrect kernel address to one of these functions.
  */
 static inline
-__wsum csum_partial_copy_nocheck(const void *src, void *dst,
-					int len, __wsum sum)
+__wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 {
-	return csum_partial_copy_generic(src, dst, len, sum, NULL, NULL);
+	return csum_partial_copy_generic(src, dst, len, 0, NULL, NULL);
 }
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
diff --git a/drivers/net/ethernet/3com/typhoon.c b/drivers/net/ethernet/3com/typhoon.c
index 5ed33c2c4742..00c2e7143555 100644
--- a/drivers/net/ethernet/3com/typhoon.c
+++ b/drivers/net/ethernet/3com/typhoon.c
@@ -1419,8 +1419,7 @@ typhoon_download_firmware(struct typhoon *tp)
 			 * the checksum, we can do this once, at the end.
 			 */
 			csum = csum_fold(csum_partial_copy_nocheck(image_data,
-								   dpage, len,
-								   0));
+								   dpage, len));
 
 			iowrite32(len, ioaddr + TYPHOON_REG_BOOT_LENGTH);
 			iowrite32(le16_to_cpu((__force __le16)csum),
diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 5a80f8e54300..85e5abc1c79c 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -26,8 +26,8 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 extern __wsum csum_partial_copy(const void *src, void *dst, int len, __wsum sum);
 
 #ifndef csum_partial_copy_nocheck
-#define csum_partial_copy_nocheck(src, dst, len, sum)	\
-	csum_partial_copy((src), (dst), (len), (sum))
+#define csum_partial_copy_nocheck(src, dst, len)	\
+	csum_partial_copy((src), (dst), (len), 0)
 #endif
 
 #ifndef ip_fast_csum
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index bf538c2bec77..7405922caaec 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -580,7 +580,7 @@ static size_t copy_pipe_to_iter(const void *addr, size_t bytes,
 static __wsum csum_and_memcpy(void *to, const void *from, size_t len,
 			      __wsum sum, size_t off)
 {
-	__wsum next = csum_partial_copy_nocheck(from, to, len, 0);
+	__wsum next = csum_partial_copy_nocheck(from, to, len);
 	return csum_block_add(sum, next, off);
 }
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 9c0918651445..6d51fb4312cd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2736,7 +2736,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 		if (copy > len)
 			copy = len;
 		csum = csum_partial_copy_nocheck(skb->data + offset, to,
-						 copy, 0);
+						 copy);
 		if ((len -= copy) == 0)
 			return csum;
 		offset += copy;
@@ -2766,7 +2766,7 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 				vaddr = kmap_atomic(p);
 				csum2 = csum_partial_copy_nocheck(vaddr + p_off,
 								  to + copied,
-								  p_len, 0);
+								  p_len);
 				kunmap_atomic(vaddr);
 				csum = csum_block_add(csum, csum2, pos);
 				pos += p_len;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index f93317157549..47a46279ae4c 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -381,7 +381,7 @@ static void icmp_push_reply(struct icmp_bxm *icmp_param,
 
 		csum = csum_partial_copy_nocheck((void *)&icmp_param->data,
 						 (char *)icmph,
-						 icmp_param->head_len, 0);
+						 icmp_param->head_len);
 		skb_queue_walk(&sk->sk_write_queue, skb1) {
 			csum = csum_add(csum, skb1->csum);
 		}
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 7fd164754519..f835136b8727 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1642,7 +1642,7 @@ static int ip_reply_glue_bits(void *dptr, char *to, int offset,
 {
 	__wsum csum;
 
-	csum = csum_partial_copy_nocheck(dptr+offset, to, len, 0);
+	csum = csum_partial_copy_nocheck(dptr+offset, to, len);
 	skb->csum = csum_block_add(skb->csum, csum, odd);
 	return 0;
 }
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 47665919048f..112f983f85fa 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -478,7 +478,7 @@ static int raw_getfrag(void *from, char *to, int offset, int len, int odd,
 			skb->csum = csum_block_add(
 				skb->csum,
 				csum_partial_copy_nocheck(rfv->hdr.c + offset,
-							  to, copy, 0),
+							  to, copy),
 				odd);
 
 		odd = 0;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 8ef5a7b30524..b1df7e5fb0a8 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -746,7 +746,7 @@ static int raw6_getfrag(void *from, char *to, int offset, int len, int odd,
 			skb->csum = csum_block_add(
 				skb->csum,
 				csum_partial_copy_nocheck(rfv->c + offset,
-							  to, copy, 0),
+							  to, copy),
 				odd);
 
 		odd = 0;
-- 
2.11.0

