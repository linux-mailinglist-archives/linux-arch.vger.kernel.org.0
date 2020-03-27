Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85EC6196208
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgC0Xb4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35910 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgC0XbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRa-004KKU-JK; Fri, 27 Mar 2020 23:31:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 06/14] ia64: turn csum_partial_copy_from_user() into csum_and_copy_from_user()
Date:   Fri, 27 Mar 2020 23:31:09 +0000
Message-Id: <20200327233117.1031393-6-viro@ZenIV.linux.org.uk>
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

Just use copy_from_user() there, rather than relying upon the wrapper
to have done access_ok()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/ia64/include/asm/checksum.h  |  3 ++-
 arch/ia64/lib/csum_partial_copy.c | 18 ++++--------------
 2 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/ia64/include/asm/checksum.h b/arch/ia64/include/asm/checksum.h
index 0ed18bc3f6cf..279ea4dcee79 100644
--- a/arch/ia64/include/asm/checksum.h
+++ b/arch/ia64/include/asm/checksum.h
@@ -37,13 +37,14 @@ extern __wsum csum_tcpudp_nofold(__be32 saddr, __be32 daddr,
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 /*
  * Same as csum_partial, but copies from src while it checksums.
  *
  * Here it is even more important to align src and dst on a 32-bit (or
  * even better 64-bit) boundary.
  */
-extern __wsum csum_partial_copy_from_user(const void __user *src, void *dst,
+extern __wsum csum_and_copy_from_user(const void __user *src, void *dst,
 						 int len, __wsum sum,
 						 int *errp);
 
diff --git a/arch/ia64/lib/csum_partial_copy.c b/arch/ia64/lib/csum_partial_copy.c
index 9ab570d0f756..ab59eb399900 100644
--- a/arch/ia64/lib/csum_partial_copy.c
+++ b/arch/ia64/lib/csum_partial_copy.c
@@ -103,33 +103,23 @@ unsigned long do_csum_c(const unsigned char * buff, int len, unsigned int psum)
  * This is very ugly but temporary. THIS NEEDS SERIOUS ENHANCEMENTS.
  * But it's very tricky to get right even in C.
  */
-extern unsigned long do_csum(const unsigned char *, long);
-
 __wsum
-csum_partial_copy_from_user(const void __user *src, void *dst,
+csum_and_copy_from_user(const void __user *src, void *dst,
 				int len, __wsum psum, int *errp)
 {
-	unsigned long result;
-
 	/* XXX Fixme
 	 * for now we separate the copy from checksum for obvious
 	 * alignment difficulties. Look at the Alpha code and you'll be
 	 * scared.
 	 */
 
-	if (__copy_from_user(dst, src, len) != 0 && errp)
+	if (copy_from_user(dst, src, len))
 		*errp = -EFAULT;
 
-	result = do_csum(dst, len);
-
-	/* add in old sum, and carry.. */
-	result += (__force u32)psum;
-	/* 32+c bits -> 32 bits */
-	result = (result & 0xffffffff) + (result >> 32);
-	return (__force __wsum)result;
+	return csum_partial(dst, len, psum);
 }
 
-EXPORT_SYMBOL(csum_partial_copy_from_user);
+EXPORT_SYMBOL(csum_and_copy_from_user);
 
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
-- 
2.11.0

