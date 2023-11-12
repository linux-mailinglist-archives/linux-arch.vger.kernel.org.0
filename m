Return-Path: <linux-arch+bounces-141-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E7B7E8E8B
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E9A1F20EF5
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E113440E;
	Sun, 12 Nov 2023 06:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b53s08La"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E0440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21AA0C433CB;
	Sun, 12 Nov 2023 06:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769757;
	bh=XpUd4fnRtkvkgeq3GEpwNa3eOjoCC/fgMtEHTFs7iQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b53s08LaY2s8JDp3okKYnrU4Mv3y6oiqRbwSmKtfYC6PGgDsKHomDFswG6XilGAB9
	 i2ZHEjTGokwuqB5C6ZWyqjHti4EPgj5O23G8cMJ2hHA9jnkNadseJdXEwx9czWciTv
	 NlLxoDPPFuqQm2+zh60dZo9SnKyaFQ57eGpZfgVpzhlY4F+SO4BtcaHjaBC4AKchJu
	 SoAWitasUakDYe1AF1gOZvQOmqoY74p3qjPJl8+fx3ar5OrIJUVPl8lobVtkXDxukk
	 KznCc8rChOmNBqMvEMsb0IOQBUQNk1P83yM/IhKkQg10eJ6VYey/U1g/69goMlooKC
	 xE1HG33YlubVQ==
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
Subject: [RFC PATCH V2 05/38] riscv: u64ilp32: Adjust vDSO kernel flow for 64ilp32 abi
Date: Sun, 12 Nov 2023 01:14:41 -0500
Message-Id: <20231112061514.2306187-6-guoren@kernel.org>
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

The 64ilp32 vDSO brings another new abi into riscv, and it needs to
adjust the current vDSO flow to enable it. This patch separates the
VDSO32 (32ILP32), VDSO64 (64LP64), and VDSO64ILP32 more clearly, and
enable VDSO64ILP32 as need.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/vdso.h   | 18 +++---
 arch/riscv/kernel/alternative.c | 15 ++++-
 arch/riscv/kernel/signal.c      | 23 ++++++--
 arch/riscv/kernel/vdso.c        | 98 +++++++++++++++++++++++++++------
 4 files changed, 121 insertions(+), 33 deletions(-)

diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index 305ddc6de21c..77015edb1488 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -38,15 +38,15 @@ extern char vdso32_start[], vdso32_end[];
 
 #endif /* CONFIG_VDSO32 */
 
-#ifdef CONFIG_64BIT
-#define vdso_start	vdso64_start
-#define vdso_end	vdso64_end
-#define VDSO_SYMBOL	VDSO64_SYMBOL
-#else /* CONFIG_64BIT */
-#define vdso_start	vdso32_start
-#define vdso_end	vdso32_end
-#define VDSO_SYMBOL	VDSO32_SYMBOL
-#endif /* CONFIG_64BIT */
+#ifdef CONFIG_VDSO64ILP32
+#include <generated/vdso64ilp32-offsets.h>
+
+#define VDSO64ILP32_SYMBOL(base, name)					\
+	(void __user *)((unsigned long)(base) + rv64ilp32__vdso_##name##_offset)
+
+extern char vdso64ilp32_start[], vdso64ilp32_end[];
+
+#endif /* CONFIG_VDSO64ILP32 */
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 6b75788c18e6..73a2d7533806 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -182,7 +182,7 @@ static void __init_or_module _apply_alternatives(struct alt_entry *begin,
 }
 
 #ifdef CONFIG_MMU
-static void __init apply_vdso_alternatives(void)
+static void __init apply_vdso_alternatives(void *vdso_start)
 {
 	const Elf_Ehdr *hdr;
 	const Elf_Shdr *shdr;
@@ -203,7 +203,7 @@ static void __init apply_vdso_alternatives(void)
 			    RISCV_ALTERNATIVES_BOOT);
 }
 #else
-static void __init apply_vdso_alternatives(void) { }
+static void __init apply_vdso_alternatives(void *vdso_start) { }
 #endif
 
 void __init apply_boot_alternatives(void)
@@ -216,7 +216,16 @@ void __init apply_boot_alternatives(void)
 			    (struct alt_entry *)__alt_end,
 			    RISCV_ALTERNATIVES_BOOT);
 
-	apply_vdso_alternatives();
+#ifdef CONFIG_VDSO64
+	apply_vdso_alternatives(vdso64_start);
+#endif
+#ifdef CONFIG_VDSO32
+	apply_vdso_alternatives(vdso32_start);
+#endif
+#ifdef CONFIG_VDSO64ILP32
+	apply_vdso_alternatives(vdso64ilp32_start);
+#endif
+
 }
 
 /*
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 180d951d3624..95c4a8d8a3f5 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -345,10 +345,25 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		return -EFAULT;
 
 	/* Set up to return from userspace. */
-#ifdef CONFIG_MMU
-	regs->ra = (unsigned long)VDSO_SYMBOL(
-		current->mm->context.vdso, rt_sigreturn);
-#else
+#ifdef CONFIG_VDSO64
+	if (!test_thread_flag(TIF_32BIT))
+		regs->ra = (unsigned long)VDSO64_SYMBOL(
+			current->mm->context.vdso, rt_sigreturn);
+#endif /* CONFIG_VDSO64 */
+
+#ifdef CONFIG_VDSO32
+	if (test_thread_flag(TIF_32BIT) && !test_thread_flag(TIF_64ILP32))
+		regs->ra = (unsigned long)VDSO32_SYMBOL(
+			current->mm->context.vdso, rt_sigreturn);
+#endif /* CONFIG_VDSO32 */
+
+#ifdef CONFIG_VDSO64ILP32
+	if (test_thread_flag(TIF_32BIT) && test_thread_flag(TIF_64ILP32))
+		regs->ra = (unsigned long)VDSO64ILP32_SYMBOL(
+			current->mm->context.vdso, rt_sigreturn);
+#endif /* CONFIG_VDSO64ILP32 */
+
+#ifndef CONFIG_MMU
 	/*
 	 * For the nommu case we don't have a VDSO.  Instead we push two
 	 * instructions to call the rt_sigreturn syscall onto the user stack.
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index dc03393bf900..6b5cfb7ddbae 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -50,9 +50,14 @@ struct __vdso_info {
 	struct vm_special_mapping *cm;
 };
 
-static struct __vdso_info vdso_info;
-#ifdef CONFIG_COMPAT
-static struct __vdso_info compat_vdso_info;
+#ifdef CONFIG_VDSO64
+static struct __vdso_info vdso64_info;
+#endif
+#ifdef CONFIG_VDSO32
+static struct __vdso_info vdso32_info;
+#endif
+#ifdef CONFIG_VDSO64ILP32
+static struct __vdso_info vdso64ilp32_info;
 #endif
 
 static int vdso_mremap(const struct vm_special_mapping *sm,
@@ -114,10 +119,16 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 	mmap_read_lock(mm);
 
 	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, vdso_info.dm))
+#ifdef CONFIG_VDSO64
+		if (vma_is_special_mapping(vma, vdso64_info.dm))
 			zap_vma_pages(vma);
-#ifdef CONFIG_COMPAT
-		if (vma_is_special_mapping(vma, compat_vdso_info.dm))
+#endif
+#ifdef CONFIG_VDSO32
+		if (vma_is_special_mapping(vma, vdso32_info.dm))
+			zap_vma_pages(vma);
+#endif
+#ifdef CONFIG_VDSO64ILP32
+		if (vma_is_special_mapping(vma, vdso64ilp32_info.dm))
 			zap_vma_pages(vma);
 #endif
 	}
@@ -172,13 +183,15 @@ static struct vm_special_mapping rv_vdso_maps[] __ro_after_init = {
 	},
 };
 
-static struct __vdso_info vdso_info __ro_after_init = {
+#ifdef CONFIG_VDSO64
+static struct __vdso_info vdso64_info __ro_after_init = {
 	.name = "vdso",
-	.vdso_code_start = vdso_start,
-	.vdso_code_end = vdso_end,
+	.vdso_code_start = vdso64_start,
+	.vdso_code_end = vdso64_end,
 	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
 	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
 };
+#endif
 
 #ifdef CONFIG_COMPAT
 static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
@@ -191,21 +204,48 @@ static struct vm_special_mapping rv_compat_vdso_maps[] __ro_after_init = {
 		.mremap = vdso_mremap,
 	},
 };
+#endif
 
-static struct __vdso_info compat_vdso_info __ro_after_init = {
-	.name = "compat_vdso",
+#ifdef CONFIG_VDSO32
+static struct __vdso_info vdso32_info __ro_after_init = {
+	.name = "vdso32",
 	.vdso_code_start = vdso32_start,
 	.vdso_code_end = vdso32_end,
+#ifdef CONFIG_64BIT
 	.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
 	.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
+#else
+	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
+	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
+#endif
+};
+#endif
+
+#ifdef CONFIG_VDSO64ILP32
+static struct __vdso_info vdso64ilp32_info __ro_after_init = {
+	.name = "vdso64ilp32",
+	.vdso_code_start = vdso64ilp32_start,
+	.vdso_code_end = vdso64ilp32_end,
+#ifdef CONFIG_64BIT
+	.dm = &rv_compat_vdso_maps[RV_VDSO_MAP_VVAR],
+	.cm = &rv_compat_vdso_maps[RV_VDSO_MAP_VDSO],
+#else
+	.dm = &rv_vdso_maps[RV_VDSO_MAP_VVAR],
+	.cm = &rv_vdso_maps[RV_VDSO_MAP_VDSO],
+#endif
 };
 #endif
 
 static int __init vdso_init(void)
 {
-	__vdso_init(&vdso_info);
-#ifdef CONFIG_COMPAT
-	__vdso_init(&compat_vdso_info);
+#ifdef CONFIG_VDSO64
+	__vdso_init(&vdso64_info);
+#endif
+#ifdef CONFIG_VDSO32
+	__vdso_init(&vdso32_info);
+#endif
+#ifdef CONFIG_VDSO64ILP32
+	__vdso_init(&vdso64ilp32_info);
 #endif
 
 	return 0;
@@ -265,8 +305,18 @@ int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = __setup_additional_pages(mm, bprm, uses_interp,
-							&compat_vdso_info);
+#ifdef CONFIG_VDSO32
+	if (test_thread_flag(TIF_32BIT) && !test_thread_flag(TIF_64ILP32))
+		ret = __setup_additional_pages(mm, bprm, uses_interp,
+							&vdso32_info);
+#endif
+
+#ifdef CONFIG_VDSO64ILP32
+	if (test_thread_flag(TIF_32BIT) && test_thread_flag(TIF_64ILP32))
+		ret = __setup_additional_pages(mm, bprm, uses_interp,
+							&vdso64ilp32_info);
+#endif
+
 	mmap_write_unlock(mm);
 
 	return ret;
@@ -281,7 +331,21 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
-	ret = __setup_additional_pages(mm, bprm, uses_interp, &vdso_info);
+#ifdef CONFIG_VDSO64
+	if (!test_thread_flag(TIF_32BIT))
+		ret = __setup_additional_pages(mm, bprm, uses_interp, &vdso64_info);
+#endif
+
+#ifdef CONFIG_VDSO32
+	if (test_thread_flag(TIF_32BIT) && !test_thread_flag(TIF_64ILP32))
+		ret = __setup_additional_pages(mm, bprm, uses_interp, &vdso32_info);
+#endif
+
+#ifdef CONFIG_VDSO64ILP32
+	if (test_thread_flag(TIF_32BIT) && test_thread_flag(TIF_64ILP32))
+		ret = __setup_additional_pages(mm, bprm, uses_interp, &vdso64ilp32_info);
+#endif
+
 	mmap_write_unlock(mm);
 
 	return ret;
-- 
2.36.1


