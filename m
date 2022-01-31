Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4464A3DE3
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 07:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357792AbiAaGtz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 01:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347965AbiAaGtw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jan 2022 01:49:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB7BC06173D;
        Sun, 30 Jan 2022 22:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=b+N+a7z4e4+IG2zz5LD0H6U61/ismic1My/Y7GI1FR8=; b=mhhqkt8MuYVjE3884SXEUGgAjU
        LBxWLRLo7NvlNFvMPPqBabxurpv1cDybny9ZW6wCmFJZZC3pz9UBbs+mJbofyk0IuCkq/OczVKQeb
        mvzWGeZNRCJU3Ud3rKI7QstMY/Vi842ur+xAmBmZkvyiUJhSBc1vbkeZONHAcL+cPdwqpmmnTzVYR
        HhFsIbqnTiCxI+LczP3lT0cyvUrsItjMG2dSkhIuHAZTEQJFT9V5vfggGSuBmHA5u9yfTnQUP25E7
        zp6zDRM8cnnpMpEec0GIPpllXNcwKWnTCm97Z+opP6CTNpHNtWicxJNlgWR7HIitDe3fFzZQxYII5
        +e8yhUjg==;
Received: from [2001:4bb8:191:327d:13f5:1d0a:e266:6974] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEQVS-008AV6-M6; Mon, 31 Jan 2022 06:49:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/5] uapi: simplify __ARCH_FLOCK{,64}_PAD a little
Date:   Mon, 31 Jan 2022 07:49:30 +0100
Message-Id: <20220131064933.3780271-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220131064933.3780271-1-hch@lst.de>
References: <20220131064933.3780271-1-hch@lst.de>
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

