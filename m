Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C01171961F7
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgC0XbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35918 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgC0XbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRa-004KKg-QQ; Fri, 27 Mar 2020 23:31:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 08/14] parisc: turn csum_partial_copy_from_user() into csum_and_copy_from_user()
Date:   Fri, 27 Mar 2020 23:31:11 +0000
Message-Id: <20200327233117.1031393-8-viro@ZenIV.linux.org.uk>
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

Already has the right semantics.  Incidentally. failing copy_from_user()
zeroes the tail of destination - no need to repeat that manually

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/parisc/include/asm/checksum.h |  3 ++-
 arch/parisc/lib/checksum.c         | 12 +++---------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index c1c22819a04d..7c69ce9634c7 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -26,11 +26,12 @@ extern __wsum csum_partial(const void *, int, __wsum);
  */
 extern __wsum csum_partial_copy_nocheck(const void *, void *, int, __wsum);
 
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 /*
  * this is a new version of the above that records errors it finds in *errp,
  * but continues and zeros the rest of the buffer.
  */
-extern __wsum csum_partial_copy_from_user(const void __user *src,
+extern __wsum csum_and_copy_from_user(const void __user *src,
 		void *dst, int len, __wsum sum, int *errp);
 
 /*
diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
index 256322c7b648..4e47c2ff2bcd 100644
--- a/arch/parisc/lib/checksum.c
+++ b/arch/parisc/lib/checksum.c
@@ -128,18 +128,12 @@ EXPORT_SYMBOL(csum_partial_copy_nocheck);
  * Copy from userspace and compute checksum.  If we catch an exception
  * then zero the rest of the buffer.
  */
-__wsum csum_partial_copy_from_user(const void __user *src,
+__wsum csum_and_copy_from_user(const void __user *src,
 					void *dst, int len,
 					__wsum sum, int *err_ptr)
 {
-	int missing;
-
-	missing = copy_from_user(dst, src, len);
-	if (missing) {
-		memset(dst + len - missing, 0, missing);
+	if (copy_from_user(dst, src, len))
 		*err_ptr = -EFAULT;
-	}
-		
 	return csum_partial(dst, len, sum);
 }
-EXPORT_SYMBOL(csum_partial_copy_from_user);
+EXPORT_SYMBOL(csum_and_copy_from_user);
-- 
2.11.0

