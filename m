Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE62289DB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 22:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgGUU0Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 16:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730818AbgGUUZw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 16:25:52 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45436C0619DE;
        Tue, 21 Jul 2020 13:25:52 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxypi-00HPpV-Vu; Tue, 21 Jul 2020 20:25:51 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 13/18] mips: __csum_partial_copy_kernel() has no users left
Date:   Tue, 21 Jul 2020 21:25:44 +0100
Message-Id: <20200721202549.4150745-13-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
References: <20200721202425.GA2786714@ZenIV.linux.org.uk>
 <20200721202549.4150745-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/mips/include/asm/checksum.h | 3 ---
 arch/mips/lib/csum_partial.S     | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/mips/include/asm/checksum.h b/arch/mips/include/asm/checksum.h
index 7a5c97c5d705..bf02d2d3869f 100644
--- a/arch/mips/include/asm/checksum.h
+++ b/arch/mips/include/asm/checksum.h
@@ -34,9 +34,6 @@
  */
 __wsum csum_partial(const void *buff, int len, __wsum sum);
 
-__wsum __csum_partial_copy_kernel(const void *src, void *dst,
-				  int len, __wsum sum, int *err_ptr);
-
 __wsum __csum_partial_copy_from_user(const void *src, void *dst,
 				     int len, __wsum sum, int *err_ptr);
 __wsum __csum_partial_copy_to_user(const void *src, void *dst,
diff --git a/arch/mips/lib/csum_partial.S b/arch/mips/lib/csum_partial.S
index 8d70855b0914..983e909c2052 100644
--- a/arch/mips/lib/csum_partial.S
+++ b/arch/mips/lib/csum_partial.S
@@ -827,8 +827,6 @@ EXPORT_SYMBOL(csum_partial)
 	.set	pop
 	.endm
 
-LEAF(__csum_partial_copy_kernel)
-EXPORT_SYMBOL(__csum_partial_copy_kernel)
 #ifndef CONFIG_EVA
 FEXPORT(__csum_partial_copy_to_user)
 EXPORT_SYMBOL(__csum_partial_copy_to_user)
@@ -836,7 +834,6 @@ FEXPORT(__csum_partial_copy_from_user)
 EXPORT_SYMBOL(__csum_partial_copy_from_user)
 #endif
 __BUILD_CSUM_PARTIAL_COPY_USER LEGACY_MODE USEROP USEROP 1
-END(__csum_partial_copy_kernel)
 
 #ifdef CONFIG_EVA
 LEAF(__csum_partial_copy_to_user)
-- 
2.11.0

