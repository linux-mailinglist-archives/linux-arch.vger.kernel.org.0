Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE1B48A98B
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 09:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348983AbiAKIfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 03:35:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348994AbiAKIfb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 03:35:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC389C061756;
        Tue, 11 Jan 2022 00:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3xq9j8U8ub/MMOrNpWwtn1DKjO93OQwBeHPFOi4XKTU=; b=zs9+E0ZEQFTmWdmktY+FwPX+4C
        ZQ61Ptx722EMI6xoxP4DIMwoxNtyfAN6FTNO38bX2SxUOeTNBSvQ7qALYFmzsRZvrIH/V5HYZ2WzX
        o41j4BWhUImMPGVZND2cb7vVHPT/j85Ul9voASNgMWDg9ygMPkJ4EO+nlKO2Mz20odEifOpZNBmr5
        0qKK/wNi9/7UIITha//a7QWfZTK6uucEkQrp3V7pOjwEjctTQC2m/6cMcla+FU3KcEFXArifDVc1H
        QtXUzk1jPYT0RAvgcy/W4TG0Yat9G9R4SiAk/f8xJ365ABfQw6UilyU+KLw+sChYsZQ2M39Y8bgdS
        Gr0ufM/A==;
Received: from [2001:4bb8:18c:6af6:82da:93cd:da5b:aa3a] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n7Cco-00FKsU-Rv; Tue, 11 Jan 2022 08:35:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 3/5] uapi: merge the 32-bit mips struct flock into the generic one
Date:   Tue, 11 Jan 2022 09:35:13 +0100
Message-Id: <20220111083515.502308-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220111083515.502308-1-hch@lst.de>
References: <20220111083515.502308-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a new __ARCH_FLOCK_EXTRA_SYSID macro following the style of
__ARCH_FLOCK_PAD to avoid having a separate definition just for one
architecture.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/uapi/asm/fcntl.h     | 26 +++-----------------------
 include/uapi/asm-generic/fcntl.h       |  5 +++--
 tools/include/uapi/asm-generic/fcntl.h |  5 +++--
 3 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/arch/mips/include/uapi/asm/fcntl.h b/arch/mips/include/uapi/asm/fcntl.h
index 42e13dead5431..9e44ac810db94 100644
--- a/arch/mips/include/uapi/asm/fcntl.h
+++ b/arch/mips/include/uapi/asm/fcntl.h
@@ -50,30 +50,10 @@
 #define F_SETLKW64	35
 #endif
 
-/*
- * The flavours of struct flock.  "struct flock" is the ABI compliant
- * variant.  Finally struct flock64 is the LFS variant of struct flock.	 As
- * a historic accident and inconsistence with the ABI definition it doesn't
- * contain all the same fields as struct flock.
- */
-
 #if _MIPS_SIM != _MIPS_SIM_ABI64
-
-#include <linux/types.h>
-
-struct flock {
-	short	l_type;
-	short	l_whence;
-	__kernel_off_t	l_start;
-	__kernel_off_t	l_len;
-	long	l_sysid;
-	__kernel_pid_t l_pid;
-	long	pad[4];
-};
-
-#define HAVE_ARCH_STRUCT_FLOCK
-
-#endif /* _MIPS_SIM == _MIPS_SIM_ABI32 */
+#define __ARCH_FLOCK_EXTRA_SYSID	long l_sysid;
+#define __ARCH_FLOCK_PAD		long pad[4];
+#endif
 
 #include <asm-generic/fcntl.h>
 
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index c53897ca5d402..98f4ff165b776 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -192,18 +192,19 @@ struct f_owner_ex {
 
 #define F_LINUX_SPECIFIC_BASE	1024
 
-#ifndef HAVE_ARCH_STRUCT_FLOCK
 struct flock {
 	short	l_type;
 	short	l_whence;
 	__kernel_off_t	l_start;
 	__kernel_off_t	l_len;
+#ifdef __ARCH_FLOCK_EXTRA_SYSID
+	__ARCH_FLOCK_EXTRA_SYSID
+#endif
 	__kernel_pid_t	l_pid;
 #ifdef __ARCH_FLOCK_PAD
 	__ARCH_FLOCK_PAD
 #endif
 };
-#endif
 
 struct flock64 {
 	short  l_type;
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index 82054502b9748..bf961a71802e0 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -187,18 +187,19 @@ struct f_owner_ex {
 
 #define F_LINUX_SPECIFIC_BASE	1024
 
-#ifndef HAVE_ARCH_STRUCT_FLOCK
 struct flock {
 	short	l_type;
 	short	l_whence;
 	__kernel_off_t	l_start;
 	__kernel_off_t	l_len;
+#ifdef __ARCH_FLOCK_EXTRA_SYSID
+	__ARCH_FLOCK_EXTRA_SYSID
+#endif
 	__kernel_pid_t	l_pid;
 #ifdef __ARCH_FLOCK_PAD
 	__ARCH_FLOCK_PAD
 #endif
 };
-#endif
 
 struct flock64 {
 	short  l_type;
-- 
2.30.2

