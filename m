Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E426019620A
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgC0XcA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:32:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35902 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgC0XbT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:19 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRa-004KKH-C5; Fri, 27 Mar 2020 23:31:18 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 04/14] x86: switch 32bit csum_and_copy_to_user() to user_access_{begin,end}()
Date:   Fri, 27 Mar 2020 23:31:07 +0000
Message-Id: <20200327233117.1031393-4-viro@ZenIV.linux.org.uk>
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

consolidate HAVE_CSUM_COPY_USER for 32bit and 64bit, while are at it

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/include/asm/checksum.h    | 1 +
 arch/x86/include/asm/checksum_32.h | 6 ++----
 arch/x86/include/asm/checksum_64.h | 3 ---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/checksum.h b/arch/x86/include/asm/checksum.h
index 1ab9572ae4c2..0ada98d5d09f 100644
--- a/arch/x86/include/asm/checksum.h
+++ b/arch/x86/include/asm/checksum.h
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #define  _HAVE_ARCH_COPY_AND_CSUM_FROM_USER 1
+#define HAVE_CSUM_COPY_USER
 #ifdef CONFIG_X86_32
 # include <asm/checksum_32.h>
 #else
diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
index 2487b7fc2d24..11624c8a9d8d 100644
--- a/arch/x86/include/asm/checksum_32.h
+++ b/arch/x86/include/asm/checksum_32.h
@@ -176,7 +176,6 @@ static inline __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 /*
  *	Copy and checksum to user
  */
-#define HAVE_CSUM_COPY_USER
 static inline __wsum csum_and_copy_to_user(const void *src,
 					   void __user *dst,
 					   int len, __wsum sum,
@@ -185,11 +184,10 @@ static inline __wsum csum_and_copy_to_user(const void *src,
 	__wsum ret;
 
 	might_sleep();
-	if (access_ok(dst, len)) {
-		stac();
+	if (user_access_begin(dst, len)) {
 		ret = csum_partial_copy_generic(src, (__force void *)dst,
 						len, sum, NULL, err_ptr);
-		clac();
+		user_access_end();
 		return ret;
 	}
 
diff --git a/arch/x86/include/asm/checksum_64.h b/arch/x86/include/asm/checksum_64.h
index 2f8435542376..0a289b87e872 100644
--- a/arch/x86/include/asm/checksum_64.h
+++ b/arch/x86/include/asm/checksum_64.h
@@ -129,9 +129,6 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr,
  */
 extern __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-#define HAVE_CSUM_COPY_USER 1
-
-
 /* Do not call this directly. Use the wrappers below */
 extern __visible __wsum csum_partial_copy_generic(const void *src, const void *dst,
 					int len, __wsum sum,
-- 
2.11.0

