Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD44A5F10
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 16:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiBAPGb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 10:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239783AbiBAPGZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 10:06:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9AC061714;
        Tue,  1 Feb 2022 07:06:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2BB661672;
        Tue,  1 Feb 2022 15:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A77C340EB;
        Tue,  1 Feb 2022 15:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643727984;
        bh=vVOYAfOfRsBaLKmx9ygXmNXla/T1wGlU5of5at4ZrRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWnyfSBhWLZqMIg7UPbH74RfMY4Ron/cN6wwOPhvVBSFW8CXVCQ9GyAlHag9VgS9+
         VKviK8eiZ+yXmHmnf3g3UKXk4SeHixnLC7Gpf3T7s+YS0usXzvrGOjIoaJf0Th8dXu
         alNiqWFJ1JE0B3xS/iH4DN4XO5hOhcbaIlLJyqnui41rK6r1EdwjBwOGjw7YD+oV84
         G6iHuDTi4baVGV4WYtthjFdmg+r7pppMQGPAzHrTSO3MB34bmIwRIhzUUgpoo7FZMT
         4PYnYdXCnfXR0lg5n4TclJP+OJ0OoXJrZ2iNEyy98QJCS4r6Mf1vARmgqhNbLLUcB9
         jdk+kWMI24dsQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org
Subject: [PATCH V5 03/21] compat: consolidate the compat_flock{,64} definition
Date:   Tue,  1 Feb 2022 23:05:27 +0800
Message-Id: <20220201150545.1512822-4-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201150545.1512822-1-guoren@kernel.org>
References: <20220201150545.1512822-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

