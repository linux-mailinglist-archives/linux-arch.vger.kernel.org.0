Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CCA48A983
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 09:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349003AbiAKIfc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 03:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348966AbiAKIf1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 03:35:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395E8C06173F;
        Tue, 11 Jan 2022 00:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=b+N+a7z4e4+IG2zz5LD0H6U61/ismic1My/Y7GI1FR8=; b=ZK9HJZnqUwAUuw811T2b/ogyWQ
        tDOALlyI7uFe3XT1I3N2s4AkD2GdDWIH+/O3YOxhUbTw4xoWVaPG0N5OS9gGKCoUGAcPAnYstY0oV
        zHU4O9QuzrfoxIbNpfoVtlU2dqFcuNaiSdXzccjtImFunx3qBawihuA1oaVeVkoDwPiWTgiaakY1d
        JZ4cZgfznnudctfXNEZPT1QLltk0nFNtU4NPqX/fZEDysO4ylE97C+dYd9+S4ZCEDTL10b7mx/k6g
        OeJ7mo3c0J3UqOHbKH6gEdWOV/gMNlXi4tO7nS/3xt2/W+LwME+E5fs/dljFydP52h5GMgtEKiDzr
        uPuFpOdw==;
Received: from [2001:4bb8:18c:6af6:82da:93cd:da5b:aa3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7Ccl-00FKrA-MP; Tue, 11 Jan 2022 08:35:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/5] uapi: simplify __ARCH_FLOCK{,64}_PAD a little
Date:   Tue, 11 Jan 2022 09:35:12 +0100
Message-Id: <20220111083515.502308-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220111083515.502308-1-hch@lst.de>
References: <20220111083515.502308-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Don't bother to define the symbols empty, just don't use them.  That
makes the intent a little more clear.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/asm-generic/fcntl.h       | 12 ++++--------
 tools/include/uapi/asm-generic/fcntl.h | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index caa482e3b01af..c53897ca5d402 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -193,22 +193,16 @@ struct f_owner_ex {
 #define F_LINUX_SPECIFIC_BASE	1024
 
 #ifndef HAVE_ARCH_STRUCT_FLOCK
-#ifndef __ARCH_FLOCK_PAD
-#define __ARCH_FLOCK_PAD
-#endif
-
 struct flock {
 	short	l_type;
 	short	l_whence;
 	__kernel_off_t	l_start;
 	__kernel_off_t	l_len;
 	__kernel_pid_t	l_pid;
+#ifdef __ARCH_FLOCK_PAD
 	__ARCH_FLOCK_PAD
-};
 #endif
-
-#ifndef __ARCH_FLOCK64_PAD
-#define __ARCH_FLOCK64_PAD
+};
 #endif
 
 struct flock64 {
@@ -217,7 +211,9 @@ struct flock64 {
 	__kernel_loff_t l_start;
 	__kernel_loff_t l_len;
 	__kernel_pid_t  l_pid;
+#ifdef __ARCH_FLOCK64_PAD
 	__ARCH_FLOCK64_PAD
+#endif
 };
 
 #endif /* _ASM_GENERIC_FCNTL_H */
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index 4a49d33ca4d55..82054502b9748 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -188,22 +188,16 @@ struct f_owner_ex {
 #define F_LINUX_SPECIFIC_BASE	1024
 
 #ifndef HAVE_ARCH_STRUCT_FLOCK
-#ifndef __ARCH_FLOCK_PAD
-#define __ARCH_FLOCK_PAD
-#endif
-
 struct flock {
 	short	l_type;
 	short	l_whence;
 	__kernel_off_t	l_start;
 	__kernel_off_t	l_len;
 	__kernel_pid_t	l_pid;
+#ifdef __ARCH_FLOCK_PAD
 	__ARCH_FLOCK_PAD
-};
 #endif
-
-#ifndef __ARCH_FLOCK64_PAD
-#define __ARCH_FLOCK64_PAD
+};
 #endif
 
 struct flock64 {
@@ -212,7 +206,9 @@ struct flock64 {
 	__kernel_loff_t l_start;
 	__kernel_loff_t l_len;
 	__kernel_pid_t  l_pid;
+#ifdef __ARCH_FLOCK64_PAD
 	__ARCH_FLOCK64_PAD
+#endif
 };
 
 #endif /* _ASM_GENERIC_FCNTL_H */
-- 
2.30.2

