Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC8196202
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgC0XbT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35898 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgC0XbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRa-004KKB-9i; Fri, 27 Mar 2020 23:31:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 03/14] x86: switch both 32bit and 64bit to providing csum_and_copy_from_user()
Date:   Fri, 27 Mar 2020 23:31:06 +0000
Message-Id: <20200327233117.1031393-3-viro@ZenIV.linux.org.uk>
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

... rather than messing with the wrapper.  As a side effect,
32bit variant gets access_ok() into it and can be switched to
user_access_begin()/user_access_end()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum.h    |  1 +
 arch/x86/include/asm/checksum_32.h | 15 +++++++++------
 arch/x86/include/asm/checksum_64.h |  5 +----
 arch/x86/lib/csum-wrappers_64.c    |  6 +++---
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index d79d1e622dcf..1ab9572ae4c2 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
 #ifdef CONFIG_X86_32
 # include <asm/checksum_32.h>
 #else
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index f57b94e02c57..2487b7fc2d24 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -44,18 +44,21 @@ static inline __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 	return csum_partial_copy_generic(src, dst, len, sum, NULL, NULL);
 }
 
-static inline __wsum csum_partial_copy_from_user(const void __user *src,
-						 void *dst,
-						 int len, __wsum sum,
-						 int *err_ptr)
+static inline __wsum csum_and_copy_from_user(const void __user *src,
+					     void *dst, int len,
+					     __wsum sum, int *err_ptr)
 {
 	__wsum ret;
 
 	might_sleep();
-	stac();
+	if (!user_access_begin(src, len)) {
+		if (len)
+			*err_ptr = -EFAULT;
+		return sum;
+	}
 	ret = csum_partial_copy_generic((__force void *)src, dst,
 					len, sum, err_ptr, NULL);
-	clac();
+	user_access_end();
 
 	return ret;
 }
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index ac9c06494827..2f8435542376 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -129,7 +129,6 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-#define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
 #define HAVE_CSUM_COPY_USER 1
 
 
@@ -139,15 +138,13 @@ extern __visible __wsum csum_partial_copy_generic(const void *src, const void *d
 					int *src_err_ptr, int *dst_err_ptr);
 
 
-extern __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
+extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 					  int len, __wsum isum, int *errp);
 extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
 					int len, __wsum isum, int *errp);
 extern __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 					int len, __wsum sum);
 
-#define csum_and_copy_from_user csum_partial_copy_from_user
-
 /**
  * ip_compute_csum - Compute an 16bit IP checksum.
  * @buff: buffer address.
diff --git a/arch/x86/lib/csum-wrappers_64.c b/arch/x86/lib/csum-wrappers_64.c
index 90d02c82bb7a..a12b8629206d 100644
--- a/arch/x86/lib/csum-wrappers_64.c
+++ b/arch/x86/lib/csum-wrappers_64.c
@@ -10,7 +10,7 @@
 #include <asm/smap.h>
 
 /**
- * csum_partial_copy_from_user - Copy and checksum from user space.
+ * csum_and_copy_from_user - Copy and checksum from user space.
  * @src: source address (user space)
  * @dst: destination address
  * @len: number of bytes to be copied.
@@ -21,7 +21,7 @@
  * src and dst are best aligned to 64bits.
  */
 __wsum
-csum_partial_copy_from_user(const void __user *src, void *dst,
+csum_and_copy_from_user(const void __user *src, void *dst,
 			    int len, __wsum isum, int *errp)
 {
 	might_sleep();
@@ -68,7 +68,7 @@ csum_partial_copy_from_user(const void __user *src, void *dst,
 
 	return isum;
 }
-EXPORT_SYMBOL(csum_partial_copy_from_user);
+EXPORT_SYMBOL(csum_and_copy_from_user);
 
 /**
  * csum_and_copy_to_user - Copy and checksum to user space.
-- 
2.11.0

