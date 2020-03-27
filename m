Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 595AA196206
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgC0Xbu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35914 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbgC0XbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRa-004KKa-Ld; Fri, 27 Mar 2020 23:31:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 07/14] alpha: turn csum_partial_copy_from_user() into csum_and_copy_from_user()
Date:   Fri, 27 Mar 2020 23:31:10 +0000
Message-Id: <20200327233117.1031393-7-viro@ZenIV.linux.org.uk>
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

It's already doing the right thing - it does access_ok() and the wrapper
in net/checksum.h is pointless here.  Just rename it and be done with that...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/alpha/include/asm/checksum.h  | 3 ++-
 arch/alpha/lib/csum_partial_copy.c | 6 +++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/checksum.h b/arch/alpha/include/asm/checksum.h
index 473e6ccb65a3..0eac81624d01 100644
--- a/arch/alpha/include/asm/checksum.h
+++ b/arch/alpha/include/asm/checksum.h
@@ -41,7 +41,8 @@ extern __wsum csum_partial(const void *buff, int len, __wsum sum);
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-__wsum csum_partial_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *errp);
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+__wsum csum_and_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *errp);
 
 __wsum csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
 
diff --git a/arch/alpha/lib/csum_partial_copy.c b/arch/alpha/lib/csum_partial_copy.c
index e53f96e8aa6d..af1dad74e933 100644
--- a/arch/alpha/lib/csum_partial_copy.c
+++ b/arch/alpha/lib/csum_partial_copy.c
@@ -325,7 +325,7 @@ csum_partial_cfu_unaligned(const unsigned long __user * src,
 }
 
 __wsum
-csum_partial_copy_from_user(const void __user *src, void *dst, int len,
+csum_and_copy_from_user(const void __user *src, void *dst, int len,
 			       __wsum sum, int *errp)
 {
 	unsigned long checksum = (__force u32) sum;
@@ -369,7 +369,7 @@ csum_partial_copy_from_user(const void __user *src, void *dst, int len,
 	}
 	return (__force __wsum)checksum;
 }
-EXPORT_SYMBOL(csum_partial_copy_from_user);
+EXPORT_SYMBOL(csum_and_copy_from_user);
 
 __wsum
 csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
@@ -377,7 +377,7 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 	__wsum checksum;
 	mm_segment_t oldfs = get_fs();
 	set_fs(KERNEL_DS);
-	checksum = csum_partial_copy_from_user((__force const void __user *)src,
+	checksum = csum_and_copy_from_user((__force const void __user *)src,
 						dst, len, sum, NULL);
 	set_fs(oldfs);
 	return checksum;
-- 
2.11.0

