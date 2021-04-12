Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111A635BEDC
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238792AbhDLJCO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 05:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238799AbhDLI7A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 04:59:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C107C061357;
        Mon, 12 Apr 2021 01:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2i9k3XnPRqvmbHX7dvelQqL0adEzvQYNCM38u+lMXro=; b=RS/E5cUeXPW58MpDtNE/QxGjun
        IlLHXJ5FINhY8bwvOHzpCY/lZPTxBNnPotxjtFD5UtSX5qtfJ2IkT5EN4cWxNKNS80SuvLGHS8Wrt
        XUEatITql0aChxpiGvL4a39jU9XOPZJEL687v5P6Xzxtb47r46fd8xqcOy23mlcmAOK0GIQUjDPXL
        Suy9otxF9ewgxNYkzyyrHYpXdtgc4lu95Yi9zyOGnSEhLCa2LV51x4ycZ+WixvreJwaa12LgPKocp
        0W/6FKcEqL4idUEu89STvrmRIbtMe2l3MKRKHyBaptpL2EoINsT3RbOqPkiCbvi3s2W6tmHHQvfXN
        G/uqREwQ==;
Received: from [2001:4bb8:199:e2bd:3218:1918:85d1:2852] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVsMK-0060Dt-T7; Mon, 12 Apr 2021 08:55:53 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 2/5] uapi: simplify __ARCH_FLOCK{,64}_PAD a little
Date:   Mon, 12 Apr 2021 10:55:42 +0200
Message-Id: <20210412085545.2595431-3-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210412085545.2595431-1-hch@lst.de>
References: <20210412085545.2595431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Don't bother to define emtpty versions of the macros if the architecture
doesn't define them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/uapi/asm-generic/fcntl.h       | 12 ++++--------
 tools/include/uapi/asm-generic/fcntl.h | 12 ++++--------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index fb454bb629d114..df7ad6962dff71 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -189,22 +189,16 @@ struct f_owner_ex {
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
@@ -213,7 +207,9 @@ struct flock64 {
 	__kernel_loff_t l_start;
 	__kernel_loff_t l_len;
 	__kernel_pid_t  l_pid;
+#ifdef __ARCH_FLOCK64_PAD
 	__ARCH_FLOCK64_PAD
+#endif
 };
 
 #endif /* _ASM_GENERIC_FCNTL_H */
diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index 4a49d33ca4d55d..82054502b9748d 100644
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
2.30.1

