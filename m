Return-Path: <linux-arch+bounces-152-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53087E8EA1
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37D31C20752
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128914410;
	Sun, 12 Nov 2023 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV45f/Jg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F91440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82818C43395;
	Sun, 12 Nov 2023 06:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769824;
	bh=DWYO8HfbmOxkQ7VOjim84D6teiWTnlk7kC8va8cLcv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bV45f/JgIiGFRTg5S0AN/PHrCkBHhftZm7i/2pzQT6PrA1mtuK9niI57Wbnc6hZNn
	 DNzPjVhb5yf9WJ05jumRT1MgJqhv47bGnaa52/ecG1CgPF8f8YeLsAV98KQIT5dwC+
	 MGGcsA+XhgKzrpJ6Oso3SNMf0ULjY8bi9H11DoxDFBgmkKzjGdjYU/zzmNa7MCiQRe
	 qQG1C3hL5jhotJdWO7GMu/BYzaq71+gd6+1JnjZcgJajOqu4vfN1mXj0KLdubPqbUx
	 +1aElC/nIN0Np8bwNn60bYFGYominKepff/ED6pMd5X1zz48wOyfhkEmq5dqPVOxRO
	 2DRwStoq9f/xA==
From: guoren@kernel.org
To: arnd@arndb.de,
	guoren@kernel.org,
	palmer@rivosinc.com,
	tglx@linutronix.de,
	conor.dooley@microchip.com,
	heiko@sntech.de,
	apatel@ventanamicro.com,
	atishp@atishpatra.org,
	bjorn@kernel.org,
	paul.walmsley@sifive.com,
	anup@brainfault.org,
	jiawei@iscas.ac.cn,
	liweiwei@iscas.ac.cn,
	wefu@redhat.com,
	U2FsdGVkX1@gmail.com,
	wangjunqiang@iscas.ac.cn,
	kito.cheng@sifive.com,
	andy.chiu@sifive.com,
	vincent.chen@sifive.com,
	greentime.hu@sifive.com,
	wuwei2016@iscas.ac.cn,
	jrtc27@jrtc27.com,
	luto@kernel.org,
	fweimer@redhat.com,
	catalin.marinas@arm.com,
	hjl.tools@gmail.com
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 16/38] riscv: s64ilp32: Introduce PTR_L and PTR_S
Date: Sun, 12 Nov 2023 01:14:52 -0500
Message-Id: <20231112061514.2306187-17-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guo Ren <guoren@linux.alibaba.com>

REG_L and REG_S can't satisfy s64ilp32 situation, because its
__SIZEOF_POINTER__*8 != __riscv_xlen. So we introduce new PTR_L
and PTR_S macro to help head.S and entry.S deal with the pointer
data type and replace all REG_L/S by PTR_L/S to fit the current
algorithm in memcpy, memove, memset, strcmp, strlen and strncmp.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/asm.h |  5 +++++
 arch/riscv/kernel/entry.S    | 24 ++++++++++++------------
 arch/riscv/kernel/head.S     |  8 ++++----
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 114bbadaef41..1cf20027bdbd 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -38,6 +38,7 @@
 #define RISCV_SZPTR		"8"
 #define RISCV_LGPTR		"3"
 #endif
+#define __PTR_SEL(a, b)		__ASM_STR(a)
 #elif __SIZEOF_POINTER__ == 4
 #ifdef __ASSEMBLY__
 #define RISCV_PTR		.word
@@ -48,10 +49,14 @@
 #define RISCV_SZPTR		"4"
 #define RISCV_LGPTR		"2"
 #endif
+#define __PTR_SEL(a, b)		__ASM_STR(b)
 #else
 #error "Unexpected __SIZEOF_POINTER__"
 #endif
 
+#define PTR_L		__PTR_SEL(ld, lw)
+#define PTR_S		__PTR_SEL(sd, sw)
+
 #if (__SIZEOF_INT__ == 4)
 #define RISCV_INT		__ASM_STR(.word)
 #define RISCV_SZINT		__ASM_STR(4)
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 143a2bb3e697..7dc7603a86ba 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -25,19 +25,19 @@ SYM_CODE_START(handle_exception)
 
 _restore_kernel_tpsp:
 	csrr tp, CSR_SCRATCH
-	REG_S sp, TASK_TI_KERNEL_SP(tp)
+	PTR_S sp, TASK_TI_KERNEL_SP(tp)
 
 #ifdef CONFIG_VMAP_STACK
 	addi sp, sp, -(PT_SIZE_ON_STACK)
 	srli sp, sp, THREAD_SHIFT
 	andi sp, sp, 0x1
 	bnez sp, handle_kernel_stack_overflow
-	REG_L sp, TASK_TI_KERNEL_SP(tp)
+	PTR_L sp, TASK_TI_KERNEL_SP(tp)
 #endif
 
 _save_context:
-	REG_S sp, TASK_TI_USER_SP(tp)
-	REG_L sp, TASK_TI_KERNEL_SP(tp)
+	PTR_S sp, TASK_TI_USER_SP(tp)
+	PTR_L sp, TASK_TI_KERNEL_SP(tp)
 	addi sp, sp, -(PT_SIZE_ON_STACK)
 	REG_S x1,  PT_RA(sp)
 	REG_S x3,  PT_GP(sp)
@@ -53,7 +53,7 @@ _save_context:
 	 */
 	li t0, SR_SUM | SR_FS_VS
 
-	REG_L s0, TASK_TI_USER_SP(tp)
+	PTR_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
@@ -96,7 +96,7 @@ _save_context:
 	add t0, t1, t0
 	/* Check if exception code lies within bounds */
 	bgeu t0, t2, 1f
-	REG_L t0, 0(t0)
+	PTR_L t0, 0(t0)
 	jr t0
 1:
 	tail do_trap_unknown
@@ -121,7 +121,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 
 	/* Save unwound kernel stack pointer in thread_info */
 	addi s0, sp, PT_SIZE_ON_STACK
-	REG_S s0, TASK_TI_KERNEL_SP(tp)
+	PTR_S s0, TASK_TI_KERNEL_SP(tp)
 
 	/*
 	 * Save TP into the scratch register , so we can find the kernel data
@@ -239,7 +239,7 @@ restore_caller_reg:
 	REG_S x5,  PT_T0(sp)
 	save_from_x6_to_x31
 
-	REG_L s0, TASK_TI_KERNEL_SP(tp)
+	PTR_L s0, TASK_TI_KERNEL_SP(tp)
 	csrr s1, CSR_STATUS
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
@@ -283,8 +283,8 @@ SYM_FUNC_START(__switch_to)
 	li    a4,  TASK_THREAD_RA
 	add   a3, a0, a4
 	add   a4, a1, a4
-	REG_S ra,  TASK_THREAD_RA_RA(a3)
-	REG_S sp,  TASK_THREAD_SP_RA(a3)
+	PTR_S ra,  TASK_THREAD_RA_RA(a3)
+	PTR_S sp,  TASK_THREAD_SP_RA(a3)
 	REG_S s0,  TASK_THREAD_S0_RA(a3)
 	REG_S s1,  TASK_THREAD_S1_RA(a3)
 	REG_S s2,  TASK_THREAD_S2_RA(a3)
@@ -298,8 +298,8 @@ SYM_FUNC_START(__switch_to)
 	REG_S s10, TASK_THREAD_S10_RA(a3)
 	REG_S s11, TASK_THREAD_S11_RA(a3)
 	/* Restore context from next->thread */
-	REG_L ra,  TASK_THREAD_RA_RA(a4)
-	REG_L sp,  TASK_THREAD_SP_RA(a4)
+	PTR_L ra,  TASK_THREAD_RA_RA(a4)
+	PTR_L sp,  TASK_THREAD_SP_RA(a4)
 	REG_L s0,  TASK_THREAD_S0_RA(a4)
 	REG_L s1,  TASK_THREAD_S1_RA(a4)
 	REG_L s2,  TASK_THREAD_S2_RA(a4)
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 11c3b94c4534..bff21ad7f077 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -42,7 +42,7 @@ ENTRY(_start)
 	/* Image load offset (0MB) from start of RAM for M-mode */
 	.dword 0
 #else
-#if __riscv_xlen == 64
+#ifdef CONFIG_64BIT
 	/* Image load offset(2MB) from start of RAM */
 	.dword 0x200000
 #else
@@ -75,7 +75,7 @@ relocate_enable_mmu:
 	/* Relocate return address */
 	la a1, kernel_map
 	XIP_FIXUP_OFFSET a1
-	REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)
+	PTR_L a1, KERNEL_MAP_VIRT_ADDR(a1)
 	la a2, _start
 	sub a1, a1, a2
 	add ra, ra, a1
@@ -348,8 +348,8 @@ clear_bss_done:
 	 */
 .Lwait_for_cpu_up:
 	/* FIXME: We should WFI to save some energy here. */
-	REG_L sp, (a1)
-	REG_L tp, (a2)
+	PTR_L sp, (a1)
+	PTR_L tp, (a2)
 	beqz sp, .Lwait_for_cpu_up
 	beqz tp, .Lwait_for_cpu_up
 	fence
-- 
2.36.1


