Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9A43196205
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgC0Xbi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35930 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgC0XbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRb-004KKz-7G; Fri, 27 Mar 2020 23:31:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 11/14] m68k: convert to csum_and_copy_from_user()
Date:   Fri, 27 Mar 2020 23:31:14 +0000
Message-Id: <20200327233117.1031393-11-viro@ZenIV.linux.org.uk>
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

trivial access_ok() there...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/include/asm/checksum.h | 3 ++-
 arch/m68k/lib/checksum.c         | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index f9b94e4b94f9..3f2c15d6f18c 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -30,7 +30,8 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-extern __wsum csum_partial_copy_from_user(const void __user *src,
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+extern __wsum csum_and_copy_from_user(const void __user *src,
 						void *dst,
 						int len, __wsum sum,
 						int *csum_err);
diff --git a/arch/m68k/lib/checksum.c b/arch/m68k/lib/checksum.c
index 5fa3d392e181..31797be9a3dc 100644
--- a/arch/m68k/lib/checksum.c
+++ b/arch/m68k/lib/checksum.c
@@ -129,7 +129,7 @@ EXPORT_SYMBOL(csum_partial);
  */
 
 __wsum
-csum_partial_copy_from_user(const void __user *src, void *dst,
+csum_and_copy_from_user(const void __user *src, void *dst,
 			    int len, __wsum sum, int *csum_err)
 {
 	/*
@@ -316,7 +316,7 @@ csum_partial_copy_from_user(const void __user *src, void *dst,
 	return(sum);
 }
 
-EXPORT_SYMBOL(csum_partial_copy_from_user);
+EXPORT_SYMBOL(csum_and_copy_from_user);
 
 
 /*
-- 
2.11.0

