Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD3335BEE6
	for <lists+linux-arch@lfdr.de>; Mon, 12 Apr 2021 11:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhDLJCT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Apr 2021 05:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbhDLI7A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Apr 2021 04:59:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420AAC06135D;
        Mon, 12 Apr 2021 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jWmjzQUHpJ1xkkWfcaQONup4Uc7cZh1Z29idzzFHs4A=; b=W+HyDjO59Vez0n1rF5+OJJbAa6
        2tcXS7iHtWltbW6Dj69LRjZ2Mh1pEMgUsG+iN9rTU8+8JJKWnRtYmmWU3hVA0cLA8GI0HzM5dv6xz
        BrmU5+adMGjiW7juH0PTiEGZZr2cmTlE9f6XKF82TqeIMLmCRZkrPPcxNeleLCnNb+URi3Thx8ABG
        zhYl8xIGuii9kbtVjxSm1kTb1O3qk5UQEMRKua5qG3EXA82zFtEhU6StAJkiqzokTrKtHa3uS0Hl6
        mTe+1kbZNAmCLwoS3/PO5+SSx/fjeifXHsFcNPdsTthiU3nfkBtmTqkyy4vLqc/RmFvU28MVCvRpY
        sd4hyvUg==;
Received: from [2001:4bb8:199:e2bd:3218:1918:85d1:2852] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVsMT-0060Fm-2x; Mon, 12 Apr 2021 08:56:01 +0000
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
Subject: [PATCH 5/5] compat: consolidate the compat_flock{,64} definition
Date:   Mon, 12 Apr 2021 10:55:45 +0200
Message-Id: <20210412085545.2595431-6-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210412085545.2595431-1-hch@lst.de>
References: <20210412085545.2595431-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provide a single common definition for the compat_flock and
compat_flock64 structures using the same tricks as for the native
variants.  An extra define is added for the packing required on x86.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/compat.h   | 16 ----------------
 arch/mips/include/asm/compat.h    | 19 ++-----------------
 arch/parisc/include/asm/compat.h  | 16 ----------------
 arch/powerpc/include/asm/compat.h | 16 ----------------
 arch/s390/include/asm/compat.h    | 16 ----------------
 arch/sparc/include/asm/compat.h   | 18 +-----------------
 arch/x86/include/asm/compat.h     | 20 +++-----------------
 include/linux/compat.h            | 31 +++++++++++++++++++++++++++++++
 8 files changed, 37 insertions(+), 115 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index a5fe4558a6ecc0..6f0908606b2b51 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -66,22 +66,6 @@ struct compat_stat {
 	compat_ulong_t	__unused4[2];
 };
 
-struct compat_flock {
-	short		l_type;
-	short		l_whence;
-	compat_off_t	l_start;
-	compat_off_t	l_len;
-	compat_pid_t	l_pid;
-};
-
-struct compat_flock64 {
-	short		l_type;
-	short		l_whence;
-	compat_loff_t	l_start;
-	compat_loff_t	l_len;
-	compat_pid_t	l_pid;
-};
-
 struct compat_statfs {
 	int		f_type;
 	int		f_bsize;
diff --git a/arch/mips/include/asm/compat.h b/arch/mips/include/asm/compat.h
index a13436e91c3938..7df384e445de06 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -50,23 +50,8 @@ struct compat_stat {
 	s32		st_pad4[14];
 };
 
-struct compat_flock {
-	short		l_type;
-	short		l_whence;
-	compat_off_t	l_start;
-	compat_off_t	l_len;
-	s32		l_sysid;
-	compat_pid_t	l_pid;
-	s32		pad[4];
-};
-
-struct compat_flock64 {
-	short		l_type;
-	short		l_whence;
-	compat_loff_t	l_start;
-	compat_loff_t	l_len;
-	compat_pid_t	l_pid;
-};
+#define __ARCH_COMPAT_FLOCK_EXTRA_SYSID		s32 l_sysid;
+#define __ARCH_COMPAT_FLOCK_PAD			s32 pad[4];
 
 struct compat_statfs {
 	int		f_type;
diff --git a/arch/parisc/include/asm/compat.h b/arch/parisc/include/asm/compat.h
index 1a609d38f6678e..972bf8911d1126 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -54,22 +54,6 @@ struct compat_stat {
 	u32			st_spare4[3];
 };
 
-struct compat_flock {
-	short			l_type;
-	short			l_whence;
-	compat_off_t		l_start;
-	compat_off_t		l_len;
-	compat_pid_t		l_pid;
-};
-
-struct compat_flock64 {
-	short			l_type;
-	short			l_whence;
-	compat_loff_t		l_start;
-	compat_loff_t		l_len;
-	compat_pid_t		l_pid;
-};
-
 struct compat_statfs {
 	s32		f_type;
 	s32		f_bsize;
diff --git a/arch/powerpc/include/asm/compat.h b/arch/powerpc/include/asm/compat.h
index b0f2c3f7fe45a5..e9d433bd561725 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -48,22 +48,6 @@ struct compat_stat {
 	u32		__unused4[2];
 };
 
-struct compat_flock {
-	short		l_type;
-	short		l_whence;
-	compat_off_t	l_start;
-	compat_off_t	l_len;
-	compat_pid_t	l_pid;
-};
-
-struct compat_flock64 {
-	short		l_type;
-	short		l_whence;
-	compat_loff_t	l_start;
-	compat_loff_t	l_len;
-	compat_pid_t	l_pid;
-};
-
 struct compat_statfs {
 	int		f_type;
 	int		f_bsize;
diff --git a/arch/s390/include/asm/compat.h b/arch/s390/include/asm/compat.h
index e0896758779da4..5578607913b847 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -103,22 +103,6 @@ struct compat_stat {
 	u32		__unused5;
 };
 
-struct compat_flock {
-	short		l_type;
-	short		l_whence;
-	compat_off_t	l_start;
-	compat_off_t	l_len;
-	compat_pid_t	l_pid;
-};
-
-struct compat_flock64 {
-	short		l_type;
-	short		l_whence;
-	compat_loff_t	l_start;
-	compat_loff_t	l_len;
-	compat_pid_t	l_pid;
-};
-
 struct compat_statfs {
 	u32		f_type;
 	u32		f_bsize;
diff --git a/arch/sparc/include/asm/compat.h b/arch/sparc/include/asm/compat.h
index 4524997424043f..16fa333f28c274 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -76,23 +76,7 @@ struct compat_stat64 {
 	unsigned int	__unused5;
 };
 
-struct compat_flock {
-	short		l_type;
-	short		l_whence;
-	compat_off_t	l_start;
-	compat_off_t	l_len;
-	compat_pid_t	l_pid;
-	short		__unused;
-};
-
-struct compat_flock64 {
-	short		l_type;
-	short		l_whence;
-	compat_loff_t	l_start;
-	compat_loff_t	l_len;
-	compat_pid_t	l_pid;
-	short		__unused;
-};
+#define __ARCH_COMPAT_FLOCK_PAD		short __unused;
 
 struct compat_statfs {
 	int		f_type;
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index b1691cf148be10..d8e01bf51e7a26 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -51,25 +51,11 @@ struct compat_stat {
 	u32		__unused5;
 };
 
-struct compat_flock {
-	short		l_type;
-	short		l_whence;
-	compat_off_t	l_start;
-	compat_off_t	l_len;
-	compat_pid_t	l_pid;
-};
-
 /*
- * IA32 uses 4 byte alignment for 64 bit quantities,
- * so we need to pack this structure.
+ * IA32 uses 4 byte alignment for 64 bit quantities, so we need to pack the
+ * compat flock64 structure.
  */
-struct compat_flock64 {
-	short		l_type;
-	short		l_whence;
-	compat_loff_t	l_start;
-	compat_loff_t	l_len;
-	compat_pid_t	l_pid;
-} __attribute__((packed));
+#define __ARCH_NEED_COMPAT_FLOCK64_PACKED
 
 struct compat_statfs {
 	int		f_type;
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6e65be75360321..9d196f8a94d5ea 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -258,6 +258,37 @@ struct compat_rlimit {
 	compat_ulong_t	rlim_max;
 };
 
+#ifdef __ARCH_NEED_COMPAT_FLOCK64_PACKED
+#define __ARCH_COMPAT_FLOCK64_PACK	__attribute__((packed))
+#else
+#define __ARCH_COMPAT_FLOCK64_PACK
+#endif
+
+struct compat_flock {
+	short			l_type;
+	short			l_whence;
+	compat_off_t		l_start;
+	compat_off_t		l_len;
+#ifdef __ARCH_COMPAT_FLOCK_EXTRA_SYSID
+	__ARCH_COMPAT_FLOCK_EXTRA_SYSID
+#endif
+	compat_pid_t		l_pid;
+#ifdef __ARCH_COMPAT_FLOCK_PAD
+	__ARCH_COMPAT_FLOCK_PAD
+#endif
+};
+
+struct compat_flock64 {
+	short		l_type;
+	short		l_whence;
+	compat_loff_t	l_start;
+	compat_loff_t	l_len;
+	compat_pid_t	l_pid;
+#ifdef __ARCH_COMPAT_FLOCK64_PAD
+	__ARCH_COMPAT_FLOCK64_PAD
+#endif
+} __ARCH_COMPAT_FLOCK64_PACK;
+
 struct compat_rusage {
 	struct old_timeval32 ru_utime;
 	struct old_timeval32 ru_stime;
-- 
2.30.1

