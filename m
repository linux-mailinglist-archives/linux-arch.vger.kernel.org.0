Return-Path: <linux-arch+bounces-166-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD77E8EBA
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96288280CF9
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02396525A;
	Sun, 12 Nov 2023 06:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUqY1I7x"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A735253
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EF7C4339A;
	Sun, 12 Nov 2023 06:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769910;
	bh=OjrCcl0rfmfc64pY2XcaTipAjTIetFz7lqlGwLAdI1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUqY1I7x2IBpSxSUqW/7Q6OGxQiYKOlhpkgEMuIXaegTBhYxQabZ9nWdjM3gZ1HA9
	 PlNm0fMrqtlmHvJ+jn4V8Ren7NlYCmwAiTI8y5M/k9k/16h+Ii0SRuzEgvYc1u3EJq
	 whpJwHxfxSih6gKdXEktmiq5plDVz7/YlAQzH8C7aBOT3HiqHjulOxuCgkBg7WPlH/
	 f0NmXgtgbDRUMTm9HiQr8f4uKme+8Sdo5Sh8zYj+XRX1VD270xGtNAxCrjmwn0v60m
	 rOVTaDeFOqKNkyQ/yEOWKFz2Qc0ijC27b9+L+CfEBAR0obCEuxoEuHL9jnL5Tdj5S6
	 BYGwuFwOZw69Q==
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
Subject: [RFC PATCH V2 30/38] riscv: s64ilp32: Add u32ilp32 ptrace support
Date: Sun, 12 Nov 2023 01:15:06 -0500
Message-Id: <20231112061514.2306187-31-guoren@kernel.org>
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

The s64ilp32 supports both u64ilp32 and u32ilp32 ABIs, and their pt_regs
differ. So introduce the compat feature to help u32ilp32 ABI. Now
u64ilp32 and u32ilp32 applications could work with the s64ilp32 Linux
ptrace concurrently.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/elf.h | 2 +-
 arch/riscv/kernel/ptrace.c   | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 5b2bf1a7cb59..58c2e5ef2b7a 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -143,13 +143,13 @@ do {    if ((ex).e_ident[EI_CLASS] == ELFCLASS32)		\
 			(current->personality & (~PER_MASK)));	\
 } while (0)
 
-#ifdef CONFIG_COMPAT
 #define COMPAT_ELF_ET_DYN_BASE		((TASK_SIZE_32 / 3) * 2)
 
 /* rv32 registers */
 typedef compat_ulong_t			compat_elf_greg_t;
 typedef compat_elf_greg_t		compat_elf_gregset_t[ELF_NGREG];
 
+#ifdef CONFIG_COMPAT
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 					      int uses_interp);
 #define compat_arch_setup_additional_pages \
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 5471b12127da..1078c0f454c1 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -295,7 +295,7 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_RV64ILP32)
 static int compat_riscv_gpr_get(struct task_struct *target,
 				const struct user_regset *regset,
 				struct membuf to)
@@ -350,7 +350,9 @@ static const struct user_regset_view compat_riscv_user_native_view = {
 	.regsets = compat_riscv_user_regset,
 	.n = ARRAY_SIZE(compat_riscv_user_regset),
 };
+#endif
 
+#ifdef CONFIG_COMPAT
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
@@ -368,7 +370,7 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 
 const struct user_regset_view *task_user_regset_view(struct task_struct *task)
 {
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_RV64ILP32)
 	if (test_tsk_thread_flag(task, TIF_32BIT) &&
 	   !test_tsk_thread_flag(task, TIF_64ILP32))
 		return &compat_riscv_user_native_view;
-- 
2.36.1


