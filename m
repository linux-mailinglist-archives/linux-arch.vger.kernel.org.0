Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832111961F4
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgC0XbX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:23 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35926 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgC0XbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRb-004KKs-1R; Fri, 27 Mar 2020 23:31:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 10/14] xtensa: switch to providing csum_and_copy_from_user()
Date:   Fri, 27 Mar 2020 23:31:13 +0000
Message-Id: <20200327233117.1031393-10-viro@ZenIV.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/xtensa/include/asm/checksum.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/include/asm/checksum.h b/arch/xtensa/include/asm/checksum.h
index 8b687176ad72..d8292cc9ebdf 100644
--- a/arch/xtensa/include/asm/checksum.h
+++ b/arch/xtensa/include/asm/checksum.h
@@ -44,8 +44,6 @@ asmlinkage __wsum csum_partial_copy_generic(const void *src, void *dst,
 /*
  *	Note: when you get a NULL pointer exception here this means someone
  *	passed in an incorrect kernel address to one of these functions.
- *
- *	If you use these functions directly please don't forget the access_ok().
  */
 static inline
 __wsum csum_partial_copy_nocheck(const void *src, void *dst,
@@ -54,12 +52,17 @@ __wsum csum_partial_copy_nocheck(const void *src, void *dst,
 	return csum_partial_copy_generic(src, dst, len, sum, NULL, NULL);
 }
 
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 static inline
-__wsum csum_partial_copy_from_user(const void __user *src, void *dst,
+__wsum csum_and_copy_from_user(const void __user *src, void *dst,
 				   int len, __wsum sum, int *err_ptr)
 {
-	return csum_partial_copy_generic((__force const void *)src, dst,
+	if (access_ok(dst, len))
+		return csum_partial_copy_generic((__force const void *)src, dst,
 					len, sum, err_ptr, NULL);
+	if (len)
+		*err_ptr = -EFAULT;
+	return sum;
 }
 
 /*
-- 
2.11.0

