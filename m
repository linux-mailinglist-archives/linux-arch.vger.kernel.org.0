Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48D8C1961F3
	for <lists+linux-arch@lfdr.de>; Sat, 28 Mar 2020 00:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgC0XbW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 19:31:22 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35938 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgC0XbV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:21 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHyRb-004KLC-PI; Fri, 27 Mar 2020 23:31:19 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 13/14] arm: switch to csum_and_copy_from_user()
Date:   Fri, 27 Mar 2020 23:31:16 +0000
Message-Id: <20200327233117.1031393-13-viro@ZenIV.linux.org.uk>
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

Note that csum_partial_copy_from_user() is in assembler here,
so I'm leaving it alone and just providing the wrapper for
it.  When/if we go for switching arm to user_access_{begin,end}()
(doing domain switches in those), somebody well need to look
into that one.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/arm/include/asm/checksum.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/include/asm/checksum.h b/arch/arm/include/asm/checksum.h
index 20043e0ebb07..ed6073fee338 100644
--- a/arch/arm/include/asm/checksum.h
+++ b/arch/arm/include/asm/checksum.h
@@ -40,6 +40,20 @@ csum_partial_copy_nocheck(const void *src, void *dst, int len, __wsum sum);
 __wsum
 csum_partial_copy_from_user(const void __user *src, void *dst, int len, __wsum sum, int *err_ptr);
 
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+static inline
+__wsum csum_and_copy_from_user (const void __user *src, void *dst,
+				      int len, __wsum sum, int *err_ptr)
+{
+	if (access_ok(src, len))
+		return csum_partial_copy_from_user(src, dst, len, sum, err_ptr);
+
+	if (len)
+		*err_ptr = -EFAULT;
+
+	return sum;
+}
+
 /*
  * 	Fold a partial checksum without adding pseudo headers
  */
-- 
2.11.0

