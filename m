Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 294131961F6
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgC0XbW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35942 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgC0XbV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRb-004KLI-TR; Fri, 27 Mar 2020 23:31:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 14/14] take the dummy csum_and_copy_from_user() into net/checksum.h
Date:   Fri, 27 Mar 2020 23:31:17 +0000
Message-Id: <20200327233117.1031393-14-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
 <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

now that can be done conveniently - all non-trivial cases have
_HAVE_ARCH_COPY_AND_CSUM_FROM_USER defined, so the fallback in
net/checksum.h is used only for dummy (copy_from_user, then
csum_partial) implementation.  Allowing us to get rid of all
dummy instances, both of csum_and_copy_from_user() and
csum_partial_copy_from_user().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/c6x/lib/checksum.c            | 22 ----------------------
 arch/ia64/include/asm/checksum.h   | 11 -----------
 arch/ia64/lib/csum_partial_copy.c  | 18 ------------------
 arch/nios2/include/asm/checksum.h  |  2 --
 arch/parisc/include/asm/checksum.h |  8 --------
 arch/parisc/lib/checksum.c         | 14 --------------
 arch/s390/include/asm/checksum.h   | 19 -------------------
 arch/x86/um/asm/checksum.h         | 20 --------------------
 include/asm-generic/checksum.h     |  9 ---------
 include/net/checksum.h             |  8 ++------
 lib/checksum.c                     | 20 --------------------
 11 files changed, 2 insertions(+), 149 deletions(-)

diff --git a/arch/c6x/lib/checksum.c b/arch/c6x/lib/checksum.c
index 46940844c553..335ca4900808 100644
--- a/arch/c6x/lib/checksum.c
+++ b/arch/c6x/lib/checksum.c
@@ -4,28 +4,6 @@
 #include <linux/module.h>
 #include <net/checksum.h>
 
-#include <asm/byteorder.h>
-
-/*
- * copy from fs while checksumming, otherwise like csum_partial
- */
-__wsum
-csum_partial_copy_from_user(const void __user *src, void *dst, int len,
-			    __wsum sum, int *csum_err)
-{
-	int missing;
-
-	missing = __copy_from_user(dst, src, len);
-	if (missing) {
-		memset(dst + len - missing, 0, missing);
-		*csum_err = -EFAULT;
-	} else
-		*csum_err = 0;
-
-	return csum_partial(dst, len, sum);
-}
-EXPORT_SYMBOL(csum_partial_copy_from_user);
-
 /* These are from csum_64plus.S */
 EXPORT_SYMBOL(csum_partial);
 EXPORT_SYMBOL(csum_partial_copy);
diff --git a/arch/ia64/include/asm/checksum.h b/arch/ia64/include/asm/checksum.h
index 279ea4dcee79..2a1c64629cdc 100644
--- a/arch/ia64/include/asm/checksum.h
+++ b/arch/ia64/include/asm/checksum.h
@@ -37,17 +37,6 @@ extern __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
-/*
- * Same as csum_partial, but copies from src while it checksums.
- *
- * Here it is even more important to align src and dst on a 32-bit (or
- * even better 64-bit) boundary.
- */
-extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
-						 int len, __wsum sum,
-						 int *errp);
-
 extern __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 					       int len, __wsum sum);
 
diff --git a/arch/ia64/lib/csum_partial_copy.c b/arch/ia64/lib/csum_partial_copy.c
index ab59eb399900..5d147a33d648 100644
--- a/arch/ia64/lib/csum_partial_copy.c
+++ b/arch/ia64/lib/csum_partial_copy.c
@@ -104,24 +104,6 @@ unsigned long do_csum_c(const unsigned char * buff, int len, unsigned int psum)
  * But it's very tricky to get right even in C.
  */
 __wsum
-csum_and_copy_from_user(const void __user *src, void *dst,
-				int len, __wsum psum, int *errp)
-{
-	/* XXX Fixme
-	 * for now we separate the copy from checksum for obvious
-	 * alignment difficulties. Look at the Alpha code and you'll be
-	 * scared.
-	 */
-
-	if (copy_from_user(dst, src, len))
-		*errp = -EFAULT;
-
-	return csum_partial(dst, len, psum);
-}
-
-EXPORT_SYMBOL(csum_and_copy_from_user);
-
-__wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 {
 	memcpy(dst, src, len);
diff --git a/arch/nios2/include/asm/checksum.h b/arch/nios2/include/asm/checksum.h
index 703c5ee63421..ec39698d3bea 100644
--- a/arch/nios2/include/asm/checksum.h
+++ b/arch/nios2/include/asm/checksum.h
@@ -14,8 +14,6 @@
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 extern __wsum csum_partial_copy(const void *src, void *dst, int len,
 				__wsum sum);
-extern __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
-					int len, __wsum sum, int *csum_err);
 #define csum_partial_copy_nocheck(src, dst, len, sum)	\
 	csum_partial_copy((src), (dst), (len), (sum))
 
diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index 7c69ce9634c7..fe8c63b2d2c3 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -26,14 +26,6 @@ extern __wsum csum_partial(const void *, int, __wsum);
  */
 extern __wsum csum_partial_copy_nocheck(const void *, void *, int, __wsum);
 
-#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
-/*
- * this is a new version of the above that records errors it finds in *errp,
- * but continues and zeros the rest of the buffer.
- */
-extern __wsum csum_and_copy_from_user(const void __user *src,
-		void *dst, int len, __wsum sum, int *errp);
-
 /*
  *	Optimized for IP headers, which always checksum on 4 octet boundaries.
  *
diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
index 4e47c2ff2bcd..c6f161583549 100644
--- a/arch/parisc/lib/checksum.c
+++ b/arch/parisc/lib/checksum.c
@@ -123,17 +123,3 @@ __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 	return sum;
 }
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
-
-/*
- * Copy from userspace and compute checksum.  If we catch an exception
- * then zero the rest of the buffer.
- */
-__wsum csum_and_copy_from_user(const void __user *src,
-					void *dst, int len,
-					__wsum sum, int *err_ptr)
-{
-	if (copy_from_user(dst, src, len))
-		*err_ptr = -EFAULT;
-	return csum_partial(dst, len, sum);
-}
-EXPORT_SYMBOL(csum_and_copy_from_user);
diff --git a/arch/s390/include/asm/checksum.h b/arch/s390/include/asm/checksum.h
index 91e376b0d28c..6d01c96aeb5c 100644
--- a/arch/s390/include/asm/checksum.h
+++ b/arch/s390/include/asm/checksum.h
@@ -39,25 +39,6 @@ csum_partial(const void *buff, int len, __wsum sum)
 	return sum;
 }
 
-/*
- * the same as csum_partial_copy, but copies from user space.
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- *
- * Copy from userspace and compute checksum.
- */
-static inline __wsum
-csum_partial_copy_from_user(const void __user *src, void *dst,
-                                          int len, __wsum sum,
-                                          int *err_ptr)
-{
-	if (unlikely(copy_from_user(dst, src, len)))
-		*err_ptr = -EFAULT;
-	return csum_partial(dst, len, sum);
-}
-
-
 static inline __wsum
 csum_partial_copy_nocheck (const void *src, void *dst, int len, __wsum sum)
 {
diff --git a/arch/x86/um/asm/checksum.h b/arch/x86/um/asm/checksum.h
index 2a56cac64687..ff6bba2c8ab6 100644
--- a/arch/x86/um/asm/checksum.h
+++ b/arch/x86/um/asm/checksum.h
@@ -36,26 +36,6 @@ __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 	return csum_partial(dst, len, sum);
 }
 
-/*
- * the same as csum_partial, but copies from src while it
- * checksums, and handles user-space pointer exceptions correctly, when needed.
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- */
-
-static __inline__
-__wsum csum_partial_copy_from_user(const void __user *src, void *dst,
-					 int len, __wsum sum, int *err_ptr)
-{
-	if (copy_from_user(dst, src, len)) {
-		*err_ptr = -EFAULT;
-		return (__force __wsum)-1;
-	}
-
-	return csum_partial(dst, len, sum);
-}
-
 /**
  * csum_fold - Fold and invert a 32bit checksum.
  * sum: 32bit unfolded sum
diff --git a/include/asm-generic/checksum.h b/include/asm-generic/checksum.h
index 34785c0f57b0..5a80f8e54300 100644
--- a/include/asm-generic/checksum.h
+++ b/include/asm-generic/checksum.h
@@ -25,15 +25,6 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
  */
 extern __wsum csum_partial_copy(const void *src, void *dst, int len, __wsum sum);
 
-/*
- * the same as csum_partial_copy, but copies from user space.
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- */
-extern __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
-					int len, __wsum sum, int *csum_err);
-
 #ifndef csum_partial_copy_nocheck
 #define csum_partial_copy_nocheck(src, dst, len, sum)	\
 	csum_partial_copy((src), (dst), (len), (sum))
diff --git a/include/net/checksum.h b/include/net/checksum.h
index 97bf4885a962..5f9c73c0eeb9 100644
--- a/include/net/checksum.h
+++ b/include/net/checksum.h
@@ -26,13 +26,9 @@ static inline
 __wsum csum_and_copy_from_user (const void __user *src, void *dst,
 				      int len, __wsum sum, int *err_ptr)
 {
-	if (access_ok(src, len))
-		return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
-
-	if (len)
+	if (copy_from_user(dst, src, len))
 		*err_ptr = -EFAULT;
-
-	return sum;
+	return csum_partial(dst, len, sum);
 }
 #endif
 
diff --git a/lib/checksum.c b/lib/checksum.c
index de032ad96f4a..7ac65a0000ff 100644
--- a/lib/checksum.c
+++ b/lib/checksum.c
@@ -146,26 +146,6 @@ __sum16 ip_compute_csum(const void *buff, int len)
 EXPORT_SYMBOL(ip_compute_csum);
 
 /*
- * copy from fs while checksumming, otherwise like csum_partial
- */
-__wsum
-csum_partial_copy_from_user(const void __user *src, void *dst, int len,
-						__wsum sum, int *csum_err)
-{
-	int missing;
-
-	missing = __copy_from_user(dst, src, len);
-	if (missing) {
-		memset(dst + len - missing, 0, missing);
-		*csum_err = -EFAULT;
-	} else
-		*csum_err = 0;
-
-	return csum_partial(dst, len, sum);
-}
-EXPORT_SYMBOL(csum_partial_copy_from_user);
-
-/*
  * copy from ds while checksumming, otherwise like csum_partial
  */
 __wsum
-- 
2.11.0

