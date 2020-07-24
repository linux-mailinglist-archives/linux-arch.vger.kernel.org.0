Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770AA22BB74
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGXBZt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgGXBZs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60871C0619E3;
        Thu, 23 Jul 2020 18:25:48 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT5-001Gcg-0e; Fri, 24 Jul 2020 01:25:47 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 07/20] saner calling conventions for csum_and_copy_..._user()
Date:   Fri, 24 Jul 2020 02:25:33 +0100
Message-Id: <20200724012546.302155-7-viro@ZenIV.linux.org.uk>
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

All callers of these primitives will
	* discard anything we might've copied in case of error
	* ignore the csum value in case of error
	* always pass 0xffffffff as the initial sum, so the
resulting csum value (in case of success, that is) will never be 0.
	* always pass a positive length.

That suggest the following calling conventions:
	* don't pass err_ptr - just return 0 on error.
	* don't bother with zeroing destination, etc. in case of error
	* don't pass the initial sum - just use 0xffffffff.

This commit does the minimal conversion in the instances of csum_and_copy_...();
the changes of actual asm code behind them are done later in the series.
Note that this asm code is often shared with csum_partial_copy_nocheck();
the difference is that csum_partial_copy_nocheck() passes 0 for initial
sum while csum_and_copy_..._user() pass 0xffffffff.  Fortunately, we are
free to pass 0xffffffff in all cases and subsequent patches will use that
freedom without any special comments.

A part that could be split off: parisc and uml/i386 claimed to have
csum_and_copy_to_user() instances of their own, but those were identical
to the generic one, so we simply drop them.  Not sure if it's worth
a separate commit...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/checksum.h    |  2 +-
 arch/alpha/lib/csum_partial_copy.c   | 25 ++++++-------
 arch/arm/include/asm/checksum.h      | 13 ++++---
 arch/m68k/include/asm/checksum.h     |  3 +-
 arch/m68k/lib/checksum.c             |  8 ++---
 arch/mips/include/asm/checksum.h     | 46 ++++++++++++------------
 arch/parisc/include/asm/checksum.h   | 20 -----------
 arch/powerpc/include/asm/checksum.h  |  4 +--
 arch/powerpc/lib/checksum_wrappers.c | 68 +++++++++++-------------------------
 arch/sh/include/asm/checksum_32.h    | 36 +++++++++----------
 arch/sparc/include/asm/checksum_32.h | 65 ++++++++++++++++------------------
 arch/sparc/include/asm/checksum_64.h | 14 ++++----
 arch/x86/include/asm/checksum_32.h   | 35 ++++++++-----------
 arch/x86/include/asm/checksum_64.h   |  6 ++--
 arch/x86/lib/csum-wrappers_64.c      | 38 +++++++++-----------
 arch/x86/um/asm/checksum_32.h        | 23 ------------
 arch/xtensa/include/asm/checksum.h   | 30 ++++++++--------
 include/net/checksum.h               | 15 ++++----
 lib/iov_iter.c                       | 19 +++++-----
 19 files changed, 183 insertions(+), 287 deletions(-)

diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
index 84f9faea864a..99d631e146b2 100644
--- a/arch/alpha/include/asm/checksum.h
+++ b/arch/alpha/include/asm/checksum.h
@@ -43,7 +43,7 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
  */
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
-__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *errp);
+__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
 
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
diff --git a/arch/alpha/lib/csum_partial_copy.c b/arch/alpha/lib/csum_partial_copy.c
index f363dc89fcbe..3c0e89c39ddb 100644
--- a/arch/alpha/lib/csum_partial_copy.c
+++ b/arch/alpha/lib/csum_partial_copy.c
@@ -325,30 +325,27 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 }
 
 __wsum
-csum_and_copy_from_user(const void __user *src, void *dst, int len,
-			       __wsum sum, int *errp)
+csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	unsigned long checksum = (__force u32) sum;
+	unsigned long checksum = ~0U;
 	unsigned long soff = 7 & (unsigned long) src;
 	unsigned long doff = 7 & (unsigned long) dst;
+	int err = 0;
 
 	if (len) {
-		if (!access_ok(src, len)) {
-			if (errp) *errp = -EFAULT;
-			memset(dst, 0, len);
-			return sum;
-		}
+		if (!access_ok(src, len))
+			return 0;
 		if (!doff) {
 			if (!soff)
 				checksum = csum_partial_cfu_aligned(
 					(const unsigned long __user *) src,
 					(unsigned long *) dst,
-					len-8, checksum, errp);
+					len-8, checksum, &err);
 			else
 				checksum = csum_partial_cfu_dest_aligned(
 					(const unsigned long __user *) src,
 					(unsigned long *) dst,
-					soff, len-8, checksum, errp);
+					soff, len-8, checksum, &err);
 		} else {
 			unsigned long partial_dest;
 			ldq_u(partial_dest, dst);
@@ -357,15 +354,15 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len,
 					(const unsigned long __user *) src,
 					(unsigned long *) dst,
 					doff, len-8, checksum,
-					partial_dest, errp);
+					partial_dest, &err);
 			else
 				checksum = csum_partial_cfu_unaligned(
 					(const unsigned long __user *) src,
 					(unsigned long *) dst,
 					soff, doff, len-8, checksum,
-					partial_dest, errp);
+					partial_dest, &err);
 		}
-		checksum = from64to16 (checksum);
+		checksum = err ? 0 : from64to16 (checksum);
 	}
 	return (__force __wsum)checksum;
 }
@@ -378,7 +375,7 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 	mm_segment_t oldfs = get_fs();
 	set_fs(KERNEL_DS);
 	checksum = csum_and_copy_from_user((__force const void __user *)src,
-						dst, len, 0, NULL);
+						dst, len);
 	set_fs(oldfs);
 	return checksum;
 }
diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index 7612b2bd4e9b..1601c132b064 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -43,16 +43,15 @@ csum_partial_copy_from_user(const void __user *src, void *dst, int len, __wsum s
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #define _HAVE_ARCH_CSUM_AND_COPY
 static inline
-__wsum csum_and_copy_from_user (const void __user *src, void *dst,
-				      int len, __wsum sum, int *err_ptr)
+__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	if (access_ok(src, len))
-		return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
+	int err = 0;
 
-	if (len)
-		*err_ptr = -EFAULT;
+	if (!access_ok(src, len))
+		return 0;
 
-	return sum;
+	sum = csum_partial_copy_from_user(src, dst, len, ~0U, &err);
+	return err ? 0 : sum;
 }
 
 /*
diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index d5e74c64b6cd..692e7b6cc042 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -34,8 +34,7 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
 #define _HAVE_ARCH_CSUM_AND_COPY
 extern __wsum csum_and_copy_from_user(const void __user *src,
 						void *dst,
-						int len, __wsum sum,
-						int *csum_err);
+						int len);
 
 extern __wsum csum_partial_copy_nocheck(const void *src,
 					      void *dst, int len);
diff --git a/arch/m68k/lib/checksum.c b/arch/m68k/lib/checksum.c
index 86ddd2ee187d..3aeca261f622 100644
--- a/arch/m68k/lib/checksum.c
+++ b/arch/m68k/lib/checksum.c
@@ -129,8 +129,7 @@ EXPORT_SYMBOL(csum_partial);
  */
 
 __wsum
-csum_and_copy_from_user(const void __user *src, void *dst,
-			    int len, __wsum sum, int *csum_err)
+csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
 	/*
 	 * GCC doesn't like more than 10 operands for the asm
@@ -138,6 +137,7 @@ csum_and_copy_from_user(const void __user *src, void *dst,
 	 * code.
 	 */
 	unsigned long tmp1, tmp2;
+	__wsum sum = ~0U;
 
 	__asm__("movel %2,%4\n\t"
 		"btst #1,%4\n\t"	/* Check alignment */
@@ -311,9 +311,7 @@ csum_and_copy_from_user(const void __user *src, void *dst,
 		: "0" (sum), "1" (len), "2" (src), "3" (dst)
 	    );
 
-	*csum_err = tmp2;
-
-	return(sum);
+	return tmp2 ? 0 : sum;
 }
 
 EXPORT_SYMBOL(csum_and_copy_from_user);
diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 63dfe08262b1..b882cacea3ee 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -60,16 +60,15 @@ __wsum csum_partial_copy_from_user(const void __user *src, void *dst, int len,
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst,
-			       int len, __wsum sum, int *err_ptr)
+__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	if (access_ok(src, len))
-		return csum_partial_copy_from_user(src, dst, len, sum,
-						   err_ptr);
-	if (len)
-		*err_ptr = -EFAULT;
+	__wsum sum = ~0U;
+	int err = 0;
 
-	return sum;
+	if (!access_ok(src, len))
+		return 0;
+	sum = csum_partial_copy_from_user(src, dst, len, sum, &err);
+	return err ? 0 : sum;
 }
 
 /*
@@ -77,24 +76,23 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst,
  */
 #define HAVE_CSUM_COPY_USER
 static inline
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
-			     __wsum sum, int *err_ptr)
+__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
+	int err = 0;
+	__wsum sum = ~0U;
+
 	might_fault();
-	if (access_ok(dst, len)) {
-		if (uaccess_kernel())
-			return __csum_partial_copy_kernel(src,
-							  (__force void *)dst,
-							  len, sum, err_ptr);
-		else
-			return __csum_partial_copy_to_user(src,
-							   (__force void *)dst,
-							   len, sum, err_ptr);
-	}
-	if (len)
-		*err_ptr = -EFAULT;
-
-	return (__force __wsum)-1; /* invalid checksum */
+	if (!access_ok(dst, len))
+		return 0;
+	if (uaccess_kernel())
+		sum = __csum_partial_copy_kernel(src,
+						  (__force void *)dst,
+						  len, sum, &err);
+	else
+		sum = __csum_partial_copy_to_user(src,
+						   (__force void *)dst,
+						   len, sum, &err);
+	return err ? 0 : sum;
 }
 
 /*
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 522cd574c068..3c43baca7b39 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -173,25 +173,5 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold(sum);
 }
 
-/* 
- *	Copy and checksum to user
- */
-#define HAVE_CSUM_COPY_USER
-static __inline__ __wsum csum_and_copy_to_user(const void *src,
-						      void __user *dst,
-						      int len, __wsum sum,
-						      int *err_ptr)
-{
-	/* code stolen from include/asm-mips64 */
-	sum = csum_partial(src, len, sum);
-	 
-	if (copy_to_user(dst, src, len)) {
-		*err_ptr = -EFAULT;
-		return (__force __wsum)-1;
-	}
-
-	return sum;
-}
-
 #endif
 
diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 64299785f639..dba685d984c0 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -24,10 +24,10 @@ extern __wsum csum_partial_copy_generic(const void *src, void *dst,
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
-				      int len, __wsum sum, int *err_ptr);
+				      int len);
 #define HAVE_CSUM_COPY_USER
 extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
-				    int len, __wsum sum, int *err_ptr);
+				    int len);
 
 #define _HAVE_ARCH_CSUM_AND_COPY
 #define csum_partial_copy_nocheck(src, dst, len)   \
diff --git a/arch/powerpc/lib/checksum_wrappers.c b/arch/powerpc/lib/checksum_wrappers.c
index fabe4db28726..b1faa82dd8af 100644
--- a/arch/powerpc/lib/checksum_wrappers.c
+++ b/arch/powerpc/lib/checksum_wrappers.c
@@ -12,82 +12,56 @@
 #include <linux/uaccess.h>
 
 __wsum csum_and_copy_from_user(const void __user *src, void *dst,
-			       int len, __wsum sum, int *err_ptr)
+			       int len)
 {
 	unsigned int csum;
+	int err = 0;
 
 	might_sleep();
-	allow_read_from_user(src, len);
-
-	*err_ptr = 0;
 
-	if (!len) {
-		csum = 0;
-		goto out;
-	}
+	if (unlikely(!access_ok(src, len)))
+		return 0;
 
-	if (unlikely((len < 0) || !access_ok(src, len))) {
-		*err_ptr = -EFAULT;
-		csum = (__force unsigned int)sum;
-		goto out;
-	}
+	allow_read_from_user(src, len);
 
 	csum = csum_partial_copy_generic((void __force *)src, dst,
-					 len, sum, err_ptr, NULL);
+					 len, ~0U, &err, NULL);
 
-	if (unlikely(*err_ptr)) {
+	if (unlikely(err)) {
 		int missing = __copy_from_user(dst, src, len);
 
-		if (missing) {
-			memset(dst + len - missing, 0, missing);
-			*err_ptr = -EFAULT;
-		} else {
-			*err_ptr = 0;
-		}
-
-		csum = csum_partial(dst, len, sum);
+		if (missing)
+			csum = 0;
+		else
+			csum = csum_partial(dst, len, ~0U);
 	}
 
-out:
 	prevent_read_from_user(src, len);
 	return (__force __wsum)csum;
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
 
-__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len,
-			     __wsum sum, int *err_ptr)
+__wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
 	unsigned int csum;
+	int err = 0;
 
 	might_sleep();
-	allow_write_to_user(dst, len);
-
-	*err_ptr = 0;
-
-	if (!len) {
-		csum = 0;
-		goto out;
-	}
+	if (unlikely(!access_ok(dst, len)))
+		return 0;
 
-	if (unlikely((len < 0) || !access_ok(dst, len))) {
-		*err_ptr = -EFAULT;
-		csum = -1; /* invalid checksum */
-		goto out;
-	}
+	allow_write_to_user(dst, len);
 
 	csum = csum_partial_copy_generic(src, (void __force *)dst,
-					 len, sum, NULL, err_ptr);
+					 len, ~0U, NULL, &err);
 
-	if (unlikely(*err_ptr)) {
-		csum = csum_partial(src, len, sum);
+	if (unlikely(err)) {
+		csum = csum_partial(src, len, ~0U);
 
-		if (copy_to_user(dst, src, len)) {
-			*err_ptr = -EFAULT;
-			csum = -1; /* invalid checksum */
-		}
+		if (copy_to_user(dst, src, len))
+			csum = 0;
 	}
 
-out:
 	prevent_write_to_user(dst, len);
 	return (__force __wsum)csum;
 }
diff --git a/arch/sh/include/asm/checksum_32.h b/arch/sh/include/asm/checksum_32.h
index e8bf84d3b843..a08e8eb924ed 100644
--- a/arch/sh/include/asm/checksum_32.h
+++ b/arch/sh/include/asm/checksum_32.h
@@ -50,15 +50,16 @@ __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
-__wsum csum_and_copy_from_user(const void __user *src, void *dst,
-				   int len, __wsum sum, int *err_ptr)
+__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
 {
-	if (access_ok(src, len))
-		return csum_partial_copy_generic((__force const void *)src, dst,
-					len, sum, err_ptr, NULL);
-	if (len)
-		*err_ptr = -EFAULT;
-	return sum;
+	int err = 0;
+	__wsum sum = ~0U;
+
+	if (!access_ok(src, len))
+		return 0;
+	sum = csum_partial_copy_generic((__force const void *)src, dst,
+					len, sum, &err, NULL);
+	return err ? 0 : sum;
 }
 
 /*
@@ -199,16 +200,15 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 #define HAVE_CSUM_COPY_USER
 static inline __wsum csum_and_copy_to_user(const void *src,
 					   void __user *dst,
-					   int len, __wsum sum,
-					   int *err_ptr)
+					   int len)
 {
-	if (access_ok(dst, len))
-		return csum_partial_copy_generic((__force const void *)src,
-						dst, len, sum, NULL, err_ptr);
-
-	if (len)
-		*err_ptr = -EFAULT;
-
-	return (__force __wsum)-1; /* invalid checksum */
+	int err = 0;
+	__wsum sum = ~0U;
+
+	if (!access_ok(dst, len))
+		return 0;
+	sum = csum_partial_copy_generic((__force const void *)src,
+						dst, len, sum, NULL, &err);
+	return err ? 0 : sum;
 }
 #endif /* __ASM_SH_CHECKSUM_H */
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index d21d114436ba..b5873b7b7bf0 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -60,19 +60,16 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len)
 }
 
 static inline __wsum
-csum_and_copy_from_user(const void __user *src, void *dst, int len,
-			    __wsum sum, int *err)
+csum_and_copy_from_user(const void __user *src, void *dst, int len)
   {
 	register unsigned long ret asm("o0") = (unsigned long)src;
 	register char *d asm("o1") = dst;
 	register int l asm("g1") = len;
-	register __wsum s asm("g7") = sum;
+	register __wsum s asm("g7") = ~0U;
+	int err = 0;
 
-	if (unlikely(!access_ok(src, len))) {
-		if (len)
-			*err = -EFAULT;
-		return sum;
-	}
+	if (unlikely(!access_ok(src, len)))
+		return 0;
 
 	__asm__ __volatile__ (
 	".section __ex_table,#alloc\n\t"
@@ -83,42 +80,40 @@ csum_and_copy_from_user(const void __user *src, void *dst, int len,
 	"call __csum_partial_copy_sparc_generic\n\t"
 	" st %8, [%%sp + 64]\n"
 	: "=&r" (ret), "=&r" (d), "=&r" (l), "=&r" (s)
-	: "0" (ret), "1" (d), "2" (l), "3" (s), "r" (err)
+	: "0" (ret), "1" (d), "2" (l), "3" (s), "r" (&err)
 	: "o2", "o3", "o4", "o5", "o7", "g2", "g3", "g4", "g5",
 	  "cc", "memory");
-	return (__force __wsum)ret;
+	return err ? 0 : (__force __wsum)ret;
 }
 
 #define HAVE_CSUM_COPY_USER
 
 static inline __wsum
-csum_and_copy_to_user(const void *src, void __user *dst, int len,
-			  __wsum sum, int *err)
+csum_and_copy_to_user(const void *src, void __user *dst, int len)
 {
-	if (!access_ok(dst, len)) {
-		*err = -EFAULT;
-		return sum;
-	} else {
-		register unsigned long ret asm("o0") = (unsigned long)src;
-		register char __user *d asm("o1") = dst;
-		register int l asm("g1") = len;
-		register __wsum s asm("g7") = sum;
+	register unsigned long ret asm("o0") = (unsigned long)src;
+	register char __user *d asm("o1") = dst;
+	register int l asm("g1") = len;
+	register __wsum s asm("g7") = ~0U;
+	int err = 0;
 
-		__asm__ __volatile__ (
-		".section __ex_table,#alloc\n\t"
-		".align 4\n\t"
-		".word 1f,1\n\t"
-		".previous\n"
-		"1:\n\t"
-		"call __csum_partial_copy_sparc_generic\n\t"
-		" st %8, [%%sp + 64]\n"
-		: "=&r" (ret), "=&r" (d), "=&r" (l), "=&r" (s)
-		: "0" (ret), "1" (d), "2" (l), "3" (s), "r" (err)
-		: "o2", "o3", "o4", "o5", "o7",
-		  "g2", "g3", "g4", "g5",
-		  "cc", "memory");
-		return (__force __wsum)ret;
-	}
+	if (!access_ok(dst, len))
+		return 0;
+
+	__asm__ __volatile__ (
+	".section __ex_table,#alloc\n\t"
+	".align 4\n\t"
+	".word 1f,1\n\t"
+	".previous\n"
+	"1:\n\t"
+	"call __csum_partial_copy_sparc_generic\n\t"
+	" st %8, [%%sp + 64]\n"
+	: "=&r" (ret), "=&r" (d), "=&r" (l), "=&r" (s)
+	: "0" (ret), "1" (d), "2" (l), "3" (s), "r" (&err)
+	: "o2", "o3", "o4", "o5", "o7",
+	  "g2", "g3", "g4", "g5",
+	  "cc", "memory");
+	return err ? 0 : (__force __wsum)ret;
 }
 
 /* ihl is always 5 or greater, almost always is 5, and iph is word aligned
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/checksum_64.h
index 7aebdbe3ac96..4d0bbff43e62 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -51,12 +51,11 @@ long __csum_partial_copy_from_user(const void __user *src,
 
 static inline __wsum
 csum_and_copy_from_user(const void __user *src,
-			    void *dst, int len,
-			    __wsum sum, int *err)
+			    void *dst, int len)
 {
-	long ret = __csum_partial_copy_from_user(src, dst, len, sum);
+	long ret = __csum_partial_copy_from_user(src, dst, len, ~0U);
 	if (ret < 0)
-		*err = -EFAULT;
+		return 0;
 	return (__force __wsum) ret;
 }
 
@@ -70,12 +69,11 @@ long __csum_partial_copy_to_user(const void *src,
 
 static inline __wsum
 csum_and_copy_to_user(const void *src,
-		      void __user *dst, int len,
-		      __wsum sum, int *err)
+		      void __user *dst, int len)
 {
-	long ret = __csum_partial_copy_to_user(src, dst, len, sum);
+	long ret = __csum_partial_copy_to_user(src, dst, len, ~0U);
 	if (ret < 0)
-		*err = -EFAULT;
+		return 0;
 	return (__force __wsum) ret;
 }
 
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 137a3033edcc..5948cde9e4ad 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -44,22 +44,19 @@ static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst, int l
 }
 
 static inline __wsum csum_and_copy_from_user(const void __user *src,
-					     void *dst, int len,
-					     __wsum sum, int *err_ptr)
+					     void *dst, int len)
 {
 	__wsum ret;
+	int err = 0;
 
 	might_sleep();
-	if (!user_access_begin(src, len)) {
-		if (len)
-			*err_ptr = -EFAULT;
-		return sum;
-	}
+	if (!user_access_begin(src, len))
+		return 0;
 	ret = csum_partial_copy_generic((__force void *)src, dst,
-					len, sum, err_ptr, NULL);
+					len, ~0U, &err, NULL);
 	user_access_end();
 
-	return ret;
+	return err ? 0 : ret;
 }
 
 /*
@@ -177,23 +174,19 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  */
 static inline __wsum csum_and_copy_to_user(const void *src,
 					   void __user *dst,
-					   int len, __wsum sum,
-					   int *err_ptr)
+					   int len)
 {
 	__wsum ret;
+	int err = 0;
 
 	might_sleep();
-	if (user_access_begin(dst, len)) {
-		ret = csum_partial_copy_generic(src, (__force void *)dst,
-						len, sum, NULL, err_ptr);
-		user_access_end();
-		return ret;
-	}
+	if (!user_access_begin(dst, len))
+		return 0;
 
-	if (len)
-		*err_ptr = -EFAULT;
-
-	return (__force __wsum)-1; /* invalid checksum */
+	ret = csum_partial_copy_generic(src, (__force void *)dst,
+					len, ~0U, NULL, &err);
+	user_access_end();
+	return err ? 0 : ret;
 }
 
 #endif /* _ASM_X86_CHECKSUM_32_H */
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 5339f5dfc776..9af3aed54c6b 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -135,10 +135,8 @@ extern __visible __wsum csum_partial_copy_generic(const void *src, const void *d
 					int *src_err_ptr, int *dst_err_ptr);
 
 
-extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
-					  int len, __wsum isum, int *errp);
-extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
-					int len, __wsum isum, int *errp);
+extern __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len);
+extern __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len);
 extern __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len);
 
 /**
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 245f929a1c2c..ae2fb87e2274 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -22,13 +22,15 @@
  */
 __wsum
 csum_and_copy_from_user(const void __user *src, void *dst,
-			    int len, __wsum isum, int *errp)
+			    int len)
 {
+	int err = 0;
+	__wsum isum = ~0U;
+
 	might_sleep();
-	*errp = 0;
 
 	if (!user_access_begin(src, len))
-		goto out_err;
+		return 0;
 
 	/*
 	 * Why 6, not 7? To handle odd addresses aligned we
@@ -53,20 +55,15 @@ csum_and_copy_from_user(const void __user *src, void *dst,
 		}
 	}
 	isum = csum_partial_copy_generic((__force const void *)src,
-				dst, len, isum, errp, NULL);
+				dst, len, isum, &err, NULL);
 	user_access_end();
-	if (unlikely(*errp))
-		goto out_err;
-
+	if (unlikely(err))
+		isum = 0;
 	return isum;
 
 out:
 	user_access_end();
-out_err:
-	*errp = -EFAULT;
-	memset(dst, 0, len);
-
-	return isum;
+	return 0;
 }
 EXPORT_SYMBOL(csum_and_copy_from_user);
 
@@ -83,16 +80,15 @@ EXPORT_SYMBOL(csum_and_copy_from_user);
  */
 __wsum
 csum_and_copy_to_user(const void *src, void __user *dst,
-			  int len, __wsum isum, int *errp)
+			  int len)
 {
-	__wsum ret;
+	__wsum ret, isum = ~0U;
+	int err = 0;
 
 	might_sleep();
 
-	if (!user_access_begin(dst, len)) {
-		*errp = -EFAULT;
+	if (!user_access_begin(dst, len))
 		return 0;
-	}
 
 	if (unlikely((unsigned long)dst & 6)) {
 		while (((unsigned long)dst & 6) && len >= 2) {
@@ -107,15 +103,13 @@ csum_and_copy_to_user(const void *src, void __user *dst,
 		}
 	}
 
-	*errp = 0;
 	ret = csum_partial_copy_generic(src, (void __force *)dst,
-					len, isum, NULL, errp);
+					len, isum, NULL, &err);
 	user_access_end();
-	return ret;
+	return err ? 0 : ret;
 out:
 	user_access_end();
-	*errp = -EFAULT;
-	return isum;
+	return 0;
 }
 EXPORT_SYMBOL(csum_and_copy_to_user);
 
diff --git a/arch/x86/um/asm/checksum_32.h b/arch/x86/um/asm/checksum_32.h
index b9ac7c9eb72c..0b13c2947ad1 100644
--- a/arch/x86/um/asm/checksum_32.h
+++ b/arch/x86/um/asm/checksum_32.h
@@ -35,27 +35,4 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	return csum_fold(sum);
 }
 
-/*
- *	Copy and checksum to user
- */
-#define HAVE_CSUM_COPY_USER
-static __inline__ __wsum csum_and_copy_to_user(const void *src,
-						     void __user *dst,
-						     int len, __wsum sum, int *err_ptr)
-{
-	if (access_ok(dst, len)) {
-		if (copy_to_user(dst, src, len)) {
-			*err_ptr = -EFAULT;
-			return (__force __wsum)-1;
-		}
-
-		return csum_partial(src, len, sum);
-	}
-
-	if (len)
-		*err_ptr = -EFAULT;
-
-	return (__force __wsum)-1; /* invalid checksum */
-}
-
 #endif
diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index dc09448935bf..fe78fba7bd64 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -55,14 +55,16 @@ __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len)
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
 __wsum csum_and_copy_from_user(const void __user *src, void *dst,
-				   int len, __wsum sum, int *err_ptr)
+				   int len)
 {
-	if (access_ok(src, len))
-		return csum_partial_copy_generic((__force const void *)src, dst,
-					len, sum, err_ptr, NULL);
-	if (len)
-		*err_ptr = -EFAULT;
-	return sum;
+	int err = 0;
+
+	if (!access_ok(src, len))
+		return 0;
+
+	sum = csum_partial_copy_generic((__force const void *)src, dst,
+					len, ~0U, &err, NULL);
+	return err ? 0 : sum;
 }
 
 /*
@@ -243,15 +245,15 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
  */
 #define HAVE_CSUM_COPY_USER
 static __inline__ __wsum csum_and_copy_to_user(const void *src,
-					       void __user *dst, int len,
-					       __wsum sum, int *err_ptr)
+					       void __user *dst, int len)
 {
-	if (access_ok(dst, len))
-		return csum_partial_copy_generic(src,dst,len,sum,NULL,err_ptr);
+	int err = 0;
+	__wsum sum = ~0U;
 
-	if (len)
-		*err_ptr = -EFAULT;
+	if (!access_ok(dst, len))
+		return 0;
 
-	return (__force __wsum)-1; /* invalid checksum */
+	sum = csum_partial_copy_generic(src,dst,len,sum,NULL,&err);
+	return err ? 0 : sum;
 }
 #endif
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 1029191986e3..0d05b9e8690b 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -24,26 +24,23 @@
 #ifndef _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
 __wsum csum_and_copy_from_user (const void __user *src, void *dst,
-				      int len, __wsum sum, int *err_ptr)
+				      int len)
 {
 	if (copy_from_user(dst, src, len))
-		*err_ptr = -EFAULT;
-	return csum_partial(dst, len, sum);
+		return 0;
+	return csum_partial(dst, len, ~0U);
 }
 #endif
 
 #ifndef HAVE_CSUM_COPY_USER
 static __inline__ __wsum csum_and_copy_to_user
-(const void *src, void __user *dst, int len, __wsum sum, int *err_ptr)
+(const void *src, void __user *dst, int len)
 {
-	sum = csum_partial(src, len, sum);
+	__wsum sum = csum_partial(src, len, ~0U);
 
 	if (copy_to_user(dst, src, len) == 0)
 		return sum;
-	if (len)
-		*err_ptr = -EFAULT;
-
-	return (__force __wsum)-1; /* invalid checksum */
+	return 0;
 }
 #endif
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index d5b7e204fea6..eccb0fe5a498 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1448,15 +1448,14 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 		return 0;
 	}
 	iterate_and_advance(i, bytes, v, ({
-		int err = 0;
 		next = csum_and_copy_from_user(v.iov_base,
 					       (to += v.iov_len) - v.iov_len,
-					       v.iov_len, ~0U, &err);
-		if (!err) {
+					       v.iov_len);
+		if (next) {
 			sum = csum_block_add(sum, next, off);
 			off += v.iov_len;
 		}
-		err ? v.iov_len : 0;
+		next ? 0 : v.iov_len;
 	}), ({
 		char *p = kmap_atomic(v.bv_page);
 		sum = csum_and_memcpy((to += v.bv_len) - v.bv_len,
@@ -1490,11 +1489,10 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 	if (unlikely(i->count < bytes))
 		return false;
 	iterate_all_kinds(i, bytes, v, ({
-		int err = 0;
 		next = csum_and_copy_from_user(v.iov_base,
 					       (to += v.iov_len) - v.iov_len,
-					       v.iov_len, ~0U, &err);
-		if (err)
+					       v.iov_len);
+		if (!next)
 			return false;
 		sum = csum_block_add(sum, next, off);
 		off += v.iov_len;
@@ -1536,15 +1534,14 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 		return 0;
 	}
 	iterate_and_advance(i, bytes, v, ({
-		int err = 0;
 		next = csum_and_copy_to_user((from += v.iov_len) - v.iov_len,
 					     v.iov_base,
-					     v.iov_len, ~0U, &err);
-		if (!err) {
+					     v.iov_len);
+		if (next) {
 			sum = csum_block_add(sum, next, off);
 			off += v.iov_len;
 		}
-		err ? v.iov_len : 0;
+		next ? 0 : v.iov_len;
 	}), ({
 		char *p = kmap_atomic(v.bv_page);
 		sum = csum_and_memcpy(p + v.bv_offset,
-- 
2.11.0

