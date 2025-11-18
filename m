Return-Path: <linux-arch+bounces-14860-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F419C69136
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 12:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA1D43535D1
	for <lists+linux-arch@lfdr.de>; Tue, 18 Nov 2025 11:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF233350A1E;
	Tue, 18 Nov 2025 11:28:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC53340263;
	Tue, 18 Nov 2025 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763465317; cv=none; b=Anz6U6t4Mm1rj2bd5xlLBCDxy28EklwvqC18JBMDo6CbxOdxdYqGz2OHVZhYIV8TgtqVs+muSuVGnDrpibzJtqDTeXsC0Vh1qiN3v8AQeIqaRZf7UsrMD2tLT2hGx5d1eozLwm4Ng/LwaE6FgCmUqYivIgD8qGE07IDbUSqqq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763465317; c=relaxed/simple;
	bh=NVO10+zOf9P9Se85AMYZskyH0gjHtJWdn9zl7SBfvNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ul/myA3MF3JmeBi5lKiShW1oRvJKarBOX2f2mVoix3H3JOtV2HMstcBmzRc3rAFE2Oys1JmjJ6PuhDPH6BlYuv9czmsc3tiChihPKBXrjzLF/v1BzQOwKdeUmIu5rCRLxxtk81MST64/jpZu2oBeufPG46Sw6pF//8Mn+DLFNQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F40C19423;
	Tue, 18 Nov 2025 11:28:34 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V2 03/14] LoongArch: Adjust common macro definitions for 32BIT/64BIT
Date: Tue, 18 Nov 2025 19:27:17 +0800
Message-ID: <20251118112728.571869-4-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118112728.571869-1-chenhuacai@loongson.cn>
References: <20251118112728.571869-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most common macros are defined in asm.h, asmmacro.h and stackframe.h.
Adjust these macros for both 32BIT and 64BIT.

Add SETUP_TWINS (Setup Trampoline Windows) and SETUP_MODES (Setup CRMD/
PRMD/EUEN) which will be used later.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/include/asm/asm.h        |  77 ++++++++++++----
 arch/loongarch/include/asm/asmmacro.h   | 117 ++++++++++++++++++------
 arch/loongarch/include/asm/stackframe.h |  34 +++++--
 3 files changed, 173 insertions(+), 55 deletions(-)

diff --git a/arch/loongarch/include/asm/asm.h b/arch/loongarch/include/asm/asm.h
index f018d26fc995..719cab1a0ad8 100644
--- a/arch/loongarch/include/asm/asm.h
+++ b/arch/loongarch/include/asm/asm.h
@@ -72,11 +72,11 @@
 #define INT_SUB		sub.w
 #define INT_L		ld.w
 #define INT_S		st.w
-#define INT_SLL		slli.w
+#define INT_SLLI	slli.w
 #define INT_SLLV	sll.w
-#define INT_SRL		srli.w
+#define INT_SRLI	srli.w
 #define INT_SRLV	srl.w
-#define INT_SRA		srai.w
+#define INT_SRAI	srai.w
 #define INT_SRAV	sra.w
 #endif
 
@@ -86,11 +86,11 @@
 #define INT_SUB		sub.d
 #define INT_L		ld.d
 #define INT_S		st.d
-#define INT_SLL		slli.d
+#define INT_SLLI	slli.d
 #define INT_SLLV	sll.d
-#define INT_SRL		srli.d
+#define INT_SRLI	srli.d
 #define INT_SRLV	srl.d
-#define INT_SRA		srai.d
+#define INT_SRAI	srai.d
 #define INT_SRAV	sra.d
 #endif
 
@@ -100,15 +100,23 @@
 #if (__SIZEOF_LONG__ == 4)
 #define LONG_ADD	add.w
 #define LONG_ADDI	addi.w
+#define LONG_ALSL	alsl.w
+#define LONG_BSTRINS	bstrins.w
+#define LONG_BSTRPICK	bstrpick.w
 #define LONG_SUB	sub.w
 #define LONG_L		ld.w
+#define LONG_LI		li.w
+#define LONG_LPTR	ld.w
 #define LONG_S		st.w
-#define LONG_SLL	slli.w
+#define LONG_SPTR	st.w
+#define LONG_SLLI	slli.w
 #define LONG_SLLV	sll.w
-#define LONG_SRL	srli.w
+#define LONG_SRLI	srli.w
 #define LONG_SRLV	srl.w
-#define LONG_SRA	srai.w
+#define LONG_SRAI	srai.w
 #define LONG_SRAV	sra.w
+#define LONG_ROTR	rotr.w
+#define LONG_ROTRI	rotri.w
 
 #ifdef __ASSEMBLER__
 #define LONG		.word
@@ -121,15 +129,23 @@
 #if (__SIZEOF_LONG__ == 8)
 #define LONG_ADD	add.d
 #define LONG_ADDI	addi.d
+#define LONG_ALSL	alsl.d
+#define LONG_BSTRINS	bstrins.d
+#define LONG_BSTRPICK	bstrpick.d
 #define LONG_SUB	sub.d
 #define LONG_L		ld.d
+#define LONG_LI		li.d
+#define LONG_LPTR	ldptr.d
 #define LONG_S		st.d
-#define LONG_SLL	slli.d
+#define LONG_SPTR	stptr.d
+#define LONG_SLLI	slli.d
 #define LONG_SLLV	sll.d
-#define LONG_SRL	srli.d
+#define LONG_SRLI	srli.d
 #define LONG_SRLV	srl.d
-#define LONG_SRA	srai.d
+#define LONG_SRAI	srai.d
 #define LONG_SRAV	sra.d
+#define LONG_ROTR	rotr.d
+#define LONG_ROTRI	rotri.d
 
 #ifdef __ASSEMBLER__
 #define LONG		.dword
@@ -145,16 +161,23 @@
 #if (__SIZEOF_POINTER__ == 4)
 #define PTR_ADD		add.w
 #define PTR_ADDI	addi.w
+#define PTR_ALSL	alsl.w
+#define PTR_BSTRINS	bstrins.w
+#define PTR_BSTRPICK	bstrpick.w
 #define PTR_SUB		sub.w
 #define PTR_L		ld.w
-#define PTR_S		st.w
 #define PTR_LI		li.w
-#define PTR_SLL		slli.w
+#define PTR_LPTR	ld.w
+#define PTR_S		st.w
+#define PTR_SPTR	st.w
+#define PTR_SLLI	slli.w
 #define PTR_SLLV	sll.w
-#define PTR_SRL		srli.w
+#define PTR_SRLI	srli.w
 #define PTR_SRLV	srl.w
-#define PTR_SRA		srai.w
+#define PTR_SRAI	srai.w
 #define PTR_SRAV	sra.w
+#define PTR_ROTR	rotr.w
+#define PTR_ROTRI	rotri.w
 
 #define PTR_SCALESHIFT	2
 
@@ -168,16 +191,23 @@
 #if (__SIZEOF_POINTER__ == 8)
 #define PTR_ADD		add.d
 #define PTR_ADDI	addi.d
+#define PTR_ALSL	alsl.d
+#define PTR_BSTRINS	bstrins.d
+#define PTR_BSTRPICK	bstrpick.d
 #define PTR_SUB		sub.d
 #define PTR_L		ld.d
-#define PTR_S		st.d
 #define PTR_LI		li.d
-#define PTR_SLL		slli.d
+#define PTR_LPTR	ldptr.d
+#define PTR_S		st.d
+#define PTR_SPTR	stptr.d
+#define PTR_SLLI	slli.d
 #define PTR_SLLV	sll.d
-#define PTR_SRL		srli.d
+#define PTR_SRLI	srli.d
 #define PTR_SRLV	srl.d
-#define PTR_SRA		srai.d
+#define PTR_SRAI	srai.d
 #define PTR_SRAV	sra.d
+#define PTR_ROTR	rotr.d
+#define PTR_ROTRI	rotri.d
 
 #define PTR_SCALESHIFT	3
 
@@ -190,10 +220,17 @@
 
 /* Annotate a function as being unsuitable for kprobes. */
 #ifdef CONFIG_KPROBES
+#ifdef CONFIG_32BIT
+#define _ASM_NOKPROBE(name)				\
+	.pushsection "_kprobe_blacklist", "aw";		\
+	.long	name;					\
+	.popsection
+#else
 #define _ASM_NOKPROBE(name)				\
 	.pushsection "_kprobe_blacklist", "aw";		\
 	.quad	name;					\
 	.popsection
+#endif
 #else
 #define _ASM_NOKPROBE(name)
 #endif
diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/include/asm/asmmacro.h
index 8d7f501b0a12..33becf3f987d 100644
--- a/arch/loongarch/include/asm/asmmacro.h
+++ b/arch/loongarch/include/asm/asmmacro.h
@@ -5,43 +5,54 @@
 #ifndef _ASM_ASMMACRO_H
 #define _ASM_ASMMACRO_H
 
+#include <linux/sizes.h>
 #include <asm/asm-offsets.h>
 #include <asm/regdef.h>
 #include <asm/fpregdef.h>
 #include <asm/loongarch.h>
 
+#ifdef CONFIG_64BIT
+#define TASK_STRUCT_OFFSET 0
+#else
+#define TASK_STRUCT_OFFSET SZ_1K
+#endif
+
 	.macro	cpu_save_nonscratch thread
-	stptr.d	s0, \thread, THREAD_REG23
-	stptr.d	s1, \thread, THREAD_REG24
-	stptr.d	s2, \thread, THREAD_REG25
-	stptr.d	s3, \thread, THREAD_REG26
-	stptr.d	s4, \thread, THREAD_REG27
-	stptr.d	s5, \thread, THREAD_REG28
-	stptr.d	s6, \thread, THREAD_REG29
-	stptr.d	s7, \thread, THREAD_REG30
-	stptr.d	s8, \thread, THREAD_REG31
-	stptr.d	sp, \thread, THREAD_REG03
-	stptr.d	fp, \thread, THREAD_REG22
+	LONG_SPTR	s0, \thread, (THREAD_REG23 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	s1, \thread, (THREAD_REG24 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	s2, \thread, (THREAD_REG25 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	s3, \thread, (THREAD_REG26 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	s4, \thread, (THREAD_REG27 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	s5, \thread, (THREAD_REG28 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	s6, \thread, (THREAD_REG29 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	s7, \thread, (THREAD_REG30 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	s8, \thread, (THREAD_REG31 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	sp, \thread, (THREAD_REG03 - TASK_STRUCT_OFFSET)
+	LONG_SPTR	fp, \thread, (THREAD_REG22 - TASK_STRUCT_OFFSET)
 	.endm
 
 	.macro	cpu_restore_nonscratch thread
-	ldptr.d	s0, \thread, THREAD_REG23
-	ldptr.d	s1, \thread, THREAD_REG24
-	ldptr.d	s2, \thread, THREAD_REG25
-	ldptr.d	s3, \thread, THREAD_REG26
-	ldptr.d	s4, \thread, THREAD_REG27
-	ldptr.d	s5, \thread, THREAD_REG28
-	ldptr.d	s6, \thread, THREAD_REG29
-	ldptr.d	s7, \thread, THREAD_REG30
-	ldptr.d	s8, \thread, THREAD_REG31
-	ldptr.d	ra, \thread, THREAD_REG01
-	ldptr.d	sp, \thread, THREAD_REG03
-	ldptr.d	fp, \thread, THREAD_REG22
+	LONG_LPTR	s0, \thread, (THREAD_REG23 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	s1, \thread, (THREAD_REG24 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	s2, \thread, (THREAD_REG25 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	s3, \thread, (THREAD_REG26 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	s4, \thread, (THREAD_REG27 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	s5, \thread, (THREAD_REG28 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	s6, \thread, (THREAD_REG29 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	s7, \thread, (THREAD_REG30 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	s8, \thread, (THREAD_REG31 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	ra, \thread, (THREAD_REG01 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	sp, \thread, (THREAD_REG03 - TASK_STRUCT_OFFSET)
+	LONG_LPTR	fp, \thread, (THREAD_REG22 - TASK_STRUCT_OFFSET)
 	.endm
 
 	.macro fpu_save_csr thread tmp
 	movfcsr2gr	\tmp, fcsr0
+#ifdef CONFIG_32BIT
+	st.w		\tmp, \thread, THREAD_FCSR
+#else
 	stptr.w		\tmp, \thread, THREAD_FCSR
+#endif
 #ifdef CONFIG_CPU_HAS_LBT
 	/* TM bit is always 0 if LBT not supported */
 	andi		\tmp, \tmp, FPU_CSR_TM
@@ -56,7 +67,11 @@
 	.endm
 
 	.macro fpu_restore_csr thread tmp0 tmp1
+#ifdef CONFIG_32BIT
+	ld.w		\tmp0, \thread, THREAD_FCSR
+#else
 	ldptr.w		\tmp0, \thread, THREAD_FCSR
+#endif
 	movgr2fcsr	fcsr0, \tmp0
 #ifdef CONFIG_CPU_HAS_LBT
 	/* TM bit is always 0 if LBT not supported */
@@ -88,9 +103,52 @@
 #endif
 	.endm
 
+#ifdef CONFIG_32BIT
 	.macro fpu_save_cc thread tmp0 tmp1
 	movcf2gr	\tmp0, $fcc0
-	move	\tmp1, \tmp0
+	move		\tmp1, \tmp0
+	movcf2gr	\tmp0, $fcc1
+	bstrins.w	\tmp1, \tmp0, 15, 8
+	movcf2gr	\tmp0, $fcc2
+	bstrins.w	\tmp1, \tmp0, 23, 16
+	movcf2gr	\tmp0, $fcc3
+	bstrins.w	\tmp1, \tmp0, 31, 24
+	st.w		\tmp1, \thread, THREAD_FCC
+	movcf2gr	\tmp0, $fcc4
+	move		\tmp1, \tmp0
+	movcf2gr	\tmp0, $fcc5
+	bstrins.w	\tmp1, \tmp0, 15, 8
+	movcf2gr	\tmp0, $fcc6
+	bstrins.w	\tmp1, \tmp0, 23, 16
+	movcf2gr	\tmp0, $fcc7
+	bstrins.w	\tmp1, \tmp0, 31, 24
+	st.w		\tmp1, \thread, (THREAD_FCC + 4)
+	.endm
+
+	.macro fpu_restore_cc thread tmp0 tmp1
+	ld.w		\tmp0, \thread, THREAD_FCC
+	bstrpick.w	\tmp1, \tmp0, 7, 0
+	movgr2cf	$fcc0, \tmp1
+	bstrpick.w	\tmp1, \tmp0, 15, 8
+	movgr2cf	$fcc1, \tmp1
+	bstrpick.w	\tmp1, \tmp0, 23, 16
+	movgr2cf	$fcc2, \tmp1
+	bstrpick.w	\tmp1, \tmp0, 31, 24
+	movgr2cf	$fcc3, \tmp1
+	ld.w		\tmp0, \thread, (THREAD_FCC + 4)
+	bstrpick.w	\tmp1, \tmp0, 7, 0
+	movgr2cf	$fcc4, \tmp1
+	bstrpick.w	\tmp1, \tmp0, 15, 8
+	movgr2cf	$fcc5, \tmp1
+	bstrpick.w	\tmp1, \tmp0, 23, 16
+	movgr2cf	$fcc6, \tmp1
+	bstrpick.w	\tmp1, \tmp0, 31, 24
+	movgr2cf	$fcc7, \tmp1
+	.endm
+#else
+	.macro fpu_save_cc thread tmp0 tmp1
+	movcf2gr	\tmp0, $fcc0
+	move		\tmp1, \tmp0
 	movcf2gr	\tmp0, $fcc1
 	bstrins.d	\tmp1, \tmp0, 15, 8
 	movcf2gr	\tmp0, $fcc2
@@ -109,7 +167,7 @@
 	.endm
 
 	.macro fpu_restore_cc thread tmp0 tmp1
-	ldptr.d	\tmp0, \thread, THREAD_FCC
+	ldptr.d		\tmp0, \thread, THREAD_FCC
 	bstrpick.d	\tmp1, \tmp0, 7, 0
 	movgr2cf	$fcc0, \tmp1
 	bstrpick.d	\tmp1, \tmp0, 15, 8
@@ -127,6 +185,7 @@
 	bstrpick.d	\tmp1, \tmp0, 63, 56
 	movgr2cf	$fcc7, \tmp1
 	.endm
+#endif
 
 	.macro	fpu_save_double thread tmp
 	li.w	\tmp, THREAD_FPR0
@@ -606,12 +665,14 @@
 	766:
 	lu12i.w	\reg, 0
 	ori	\reg, \reg, 0
+#ifdef CONFIG_64BIT
 	lu32i.d	\reg, 0
 	lu52i.d	\reg, \reg, 0
+#endif
 	.pushsection ".la_abs", "aw", %progbits
-	.p2align 3
-	.dword	766b
-	.dword	\sym
+	.p2align PTRLOG
+	PTR	766b
+	PTR	\sym
 	.popsection
 #endif
 .endm
diff --git a/arch/loongarch/include/asm/stackframe.h b/arch/loongarch/include/asm/stackframe.h
index 5cb568a60cf8..b44930fbb675 100644
--- a/arch/loongarch/include/asm/stackframe.h
+++ b/arch/loongarch/include/asm/stackframe.h
@@ -38,22 +38,42 @@
 	cfi_restore \reg \offset \docfi
 	.endm
 
+	.macro SETUP_TWINS temp
+	pcaddi	t0, 0
+	PTR_LI	t1, ~TO_PHYS_MASK
+	and	t0, t0, t1
+	ori	t0, t0, (1 << 4 | 1)
+	csrwr	t0, LOONGARCH_CSR_DMWIN0
+	PTR_LI	t0, CSR_DMW1_INIT
+	csrwr	t0, LOONGARCH_CSR_DMWIN1
+	.endm
+
+	.macro SETUP_MODES temp
+	/* Enable PG */
+	li.w	\temp, 0xb0		# PLV=0, IE=0, PG=1
+	csrwr	\temp, LOONGARCH_CSR_CRMD
+	li.w	\temp, 0x04		# PLV=0, PIE=1, PWE=0
+	csrwr	\temp, LOONGARCH_CSR_PRMD
+	li.w	\temp, 0x00		# FPE=0, SXE=0, ASXE=0, BTE=0
+	csrwr	\temp, LOONGARCH_CSR_EUEN
+	.endm
+
 	.macro SETUP_DMWINS temp
-	li.d	\temp, CSR_DMW0_INIT	# WUC, PLV0, 0x8000 xxxx xxxx xxxx
+	PTR_LI	\temp, CSR_DMW0_INIT	# WUC, PLV0, 0x8000 xxxx xxxx xxxx
 	csrwr	\temp, LOONGARCH_CSR_DMWIN0
-	li.d	\temp, CSR_DMW1_INIT	# CAC, PLV0, 0x9000 xxxx xxxx xxxx
+	PTR_LI	\temp, CSR_DMW1_INIT	# CAC, PLV0, 0x9000 xxxx xxxx xxxx
 	csrwr	\temp, LOONGARCH_CSR_DMWIN1
-	li.d	\temp, CSR_DMW2_INIT	# WUC, PLV0, 0xa000 xxxx xxxx xxxx
+	PTR_LI	\temp, CSR_DMW2_INIT	# WUC, PLV0, 0xa000 xxxx xxxx xxxx
 	csrwr	\temp, LOONGARCH_CSR_DMWIN2
-	li.d	\temp, CSR_DMW3_INIT	# 0x0, unused
+	PTR_LI	\temp, CSR_DMW3_INIT	# 0x0, unused
 	csrwr	\temp, LOONGARCH_CSR_DMWIN3
 	.endm
 
 /* Jump to the runtime virtual address. */
 	.macro JUMP_VIRT_ADDR temp1 temp2
-	li.d	\temp1, CACHE_BASE
+	PTR_LI	\temp1, CACHE_BASE
 	pcaddi	\temp2, 0
-	bstrins.d  \temp1, \temp2, (DMW_PABITS - 1), 0
+	PTR_BSTRINS  \temp1, \temp2, (DMW_PABITS - 1), 0
 	jirl	zero, \temp1, 0xc
 	.endm
 
@@ -171,7 +191,7 @@
 	andi	t0, t0, 0x3	/* extract pplv bit */
 	beqz	t0, 9f
 
-	li.d	tp, ~_THREAD_MASK
+	LONG_LI	tp, ~_THREAD_MASK
 	and	tp, tp, sp
 	cfi_st  u0, PT_R21, \docfi
 	csrrd	u0, PERCPU_BASE_KS
-- 
2.47.3


