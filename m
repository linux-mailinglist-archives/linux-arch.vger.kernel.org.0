Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654E0196204
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgC0Xbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35922 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgC0XbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRa-004KKm-UV; Fri, 27 Mar 2020 23:31:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 09/14] sparc: switch to providing csum_and_copy_from_user()
Date:   Fri, 27 Mar 2020 23:31:12 +0000
Message-Id: <20200327233117.1031393-9-viro@ZenIV.linux.org.uk>
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

sparc64 already is equivalent to that (trivial access_ok());
add it into sparc32 csum_partial_copy_from_user() and we can
rename both to csum_and_copy_fromUser() and be done with that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/sparc/include/asm/checksum.h    | 1 +
 arch/sparc/include/asm/checksum_32.h | 8 +++++++-
 arch/sparc/include/asm/checksum_64.h | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/checksum.h b/arch/sparc/include/asm/checksum.h
index c3be56e2e768..a6256cb6fc5c 100644
--- a/arch/sparc/include/asm/checksum.h
+++ b/arch/sparc/include/asm/checksum.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_CHECKSUM_H
 #define ___ASM_SPARC_CHECKSUM_H
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/checksum_64.h>
 #else
diff --git a/arch/sparc/include/asm/checksum_32.h b/arch/sparc/include/asm/checksum_32.h
index 450ddfb444c8..479a0b812af5 100644
--- a/arch/sparc/include/asm/checksum_32.h
+++ b/arch/sparc/include/asm/checksum_32.h
@@ -60,7 +60,7 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum)
 }
 
 static inline __wsum
-csum_partial_copy_from_user(const void __user *src, void *dst, int len,
+csum_and_copy_from_user(const void __user *src, void *dst, int len,
 			    __wsum sum, int *err)
   {
 	register unsigned long ret asm("o0") = (unsigned long)src;
@@ -68,6 +68,12 @@ csum_partial_copy_from_user(const void __user *src, void *dst, int len,
 	register int l asm("g1") = len;
 	register __wsum s asm("g7") = sum;
 
+	if (unlikely(!access_ok(src, len))) {
+		if (len)
+			*err = -EFAULT;
+		return sum;
+	}
+
 	__asm__ __volatile__ (
 	".section __ex_table,#alloc\n\t"
 	".align 4\n\t"
diff --git a/arch/sparc/include/asm/checksum_64.h b/arch/sparc/include/asm/checksum_64.h
index e52450930e4e..0fa4433f5662 100644
--- a/arch/sparc/include/asm/checksum_64.h
+++ b/arch/sparc/include/asm/checksum_64.h
@@ -46,7 +46,7 @@ long __csum_partial_copy_from_user(const void __user *src,
 				   __wsum sum);
 
 static inline __wsum
-csum_partial_copy_from_user(const void __user *src,
+csum_and_copy_from_user(const void __user *src,
 			    void *dst, int len,
 			    __wsum sum, int *err)
 {
-- 
2.11.0

