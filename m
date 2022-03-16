Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6BD4DAB03
	for <lists+linux-arch@lfdr.de>; Wed, 16 Mar 2022 08:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354039AbiCPHFY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Mar 2022 03:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354012AbiCPHFQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Mar 2022 03:05:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C28410AF;
        Wed, 16 Mar 2022 00:04:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3D61B81A45;
        Wed, 16 Mar 2022 07:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AA1C340EE;
        Wed, 16 Mar 2022 07:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647414239;
        bh=eMq4UtGpG7+R27K/rfMw7XL8UOaQ6kkGWD/cshwSYaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XjVkT0ah87HKJ7gEHv0AneKZZYK6zT6MxAsMUkNmBI8trJNts17GcBVNz1NEGNVyy
         R43CnTsmJPAHdd6B6j73qselBnWBBUvfQ4GXoKbFRnKaukJDU9NrKYMbwnwtQVVHsN
         ZDXgeJ19DeJcNDJjZYSq/8SbM72N5Kfs5dI1d2jQYpt/uUY0BKbfGOTx5D+h5fQ48m
         ac6ObU+aTttx76j2eNLeIVQvxh4zGrNonrJvgJbbYrJga3MRtSLjS7RSYcJWEfR02u
         oeifdt1PdOnpIHInIeKyumoxjPkDlkCUUot2ogC13hyL+4vhyirZA6Gqp6fPmk4rN/
         r+Bimc5ar7jBQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de
Subject: [PATCH V8 03/20] compat: consolidate the compat_flock{,64} definition
Date:   Wed, 16 Mar 2022 15:03:00 +0800
Message-Id: <20220316070317.1864279-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220316070317.1864279-1-guoren@kernel.org>
References: <20220316070317.1864279-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Provide a single common definition for the compat_flock and
compat_flock64 structures using the same tricks as for the native
variants.  Another extra define is added for the packing required on
x86.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>
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
index 276328765408..e0faec1984a1 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -65,22 +65,6 @@ struct compat_stat {
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
index 6a350c1f70d7..6d6e5a451f4d 100644
--- a/arch/mips/include/asm/compat.h
+++ b/arch/mips/include/asm/compat.h
@@ -55,23 +55,8 @@ struct compat_stat {
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
index c04f5a637c39..a1e4534d8050 100644
--- a/arch/parisc/include/asm/compat.h
+++ b/arch/parisc/include/asm/compat.h
@@ -53,22 +53,6 @@ struct compat_stat {
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
index 83d8f70779cb..5ef3c7c83c34 100644
--- a/arch/powerpc/include/asm/compat.h
+++ b/arch/powerpc/include/asm/compat.h
@@ -44,22 +44,6 @@ struct compat_stat {
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
index 0f14b3188b1b..07f04d37068b 100644
--- a/arch/s390/include/asm/compat.h
+++ b/arch/s390/include/asm/compat.h
@@ -102,22 +102,6 @@ struct compat_stat {
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
index 108078751bb5..d78fb44942e0 100644
--- a/arch/sparc/include/asm/compat.h
+++ b/arch/sparc/include/asm/compat.h
@@ -75,23 +75,7 @@ struct compat_stat64 {
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
index 8d19a212f4f2..de794d895866 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -50,25 +50,11 @@ struct compat_stat {
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
index 1c758b0e0359..a0481fe6c5d5 100644
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
2.25.1

