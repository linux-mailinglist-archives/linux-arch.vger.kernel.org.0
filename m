Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAABF22BB6A
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jul 2020 03:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgGXB0S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jul 2020 21:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbgGXBZw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jul 2020 21:25:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A174C0619E4;
        Thu, 23 Jul 2020 18:25:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jymT6-001GdN-5z; Fri, 24 Jul 2020 01:25:48 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 14/20] mips: csum_and_copy_{to,from}_user() are never called under KERNEL_DS
Date:   Fri, 24 Jul 2020 02:25:40 +0100
Message-Id: <20200724012546.302155-14-viro@ZenIV.linux.org.uk>
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

they are only called for iovec-backed iov_iter and under KERNEL_DS an
attempt to create such a beast will yield a kvec-backed one.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/include/asm/checksum.h | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index b882cacea3ee..5cf4ce11c821 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -41,22 +41,6 @@ __wsum __csum_partial_copy_from_user(const void *src, void *dst,
 				     int len, __wsum sum, int *err_ptr);
 __wsum __csum_partial_copy_to_user(const void *src, void *dst,
 				   int len, __wsum sum, int *err_ptr);
-/*
- * this is a new version of the above that records errors it finds in *errp,
- * but continues and zeros the rest of the buffer.
- */
-static inline
-__wsum csum_partial_copy_from_user(const void __user *src, void *dst, int len,
-				   __wsum sum, int *err_ptr)
-{
-	might_fault();
-	if (uaccess_kernel())
-		return __csum_partial_copy_kernel((__force void *)src, dst,
-						  len, sum, err_ptr);
-	else
-		return __csum_partial_copy_from_user((__force void *)src, dst,
-						     len, sum, err_ptr);
-}
 
 #define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
@@ -65,9 +49,12 @@ __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
 	__wsum sum = ~0U;
 	int err = 0;
 
+	might_fault();
+
 	if (!access_ok(src, len))
 		return 0;
-	sum = csum_partial_copy_from_user(src, dst, len, sum, &err);
+	sum = __csum_partial_copy_from_user((__force void *)src, dst,
+						     len, sum, &err);
 	return err ? 0 : sum;
 }
 
@@ -84,14 +71,9 @@ __wsum csum_and_copy_to_user(const void *src, void __user *dst, int len)
 	might_fault();
 	if (!access_ok(dst, len))
 		return 0;
-	if (uaccess_kernel())
-		sum = __csum_partial_copy_kernel(src,
-						  (__force void *)dst,
-						  len, sum, &err);
-	else
-		sum = __csum_partial_copy_to_user(src,
-						   (__force void *)dst,
-						   len, sum, &err);
+	sum = __csum_partial_copy_to_user(src,
+					   (__force void *)dst,
+					   len, sum, &err);
 	return err ? 0 : sum;
 }
 
-- 
2.11.0

