Return-Path: <linux-arch+bounces-167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BC37E8EBC
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE35D1F20F63
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE7B5394;
	Sun, 12 Nov 2023 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cib6Q1ZU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9208B5386
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2612FC433D9;
	Sun, 12 Nov 2023 06:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769916;
	bh=Yd1se3YAvTpm3f6jR2T3YyxOy5a1aI13dnazTuxGpzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cib6Q1ZUgS2FaDH4BWH6sy+4T4ju7sE9ZqI/4WjqXf+/9wNUzo1g8Lh7AhURej2Dh
	 ds3OmIJ7NuwdMMJsmhVV83diwJFb4ycXr8DHEmtqAnEscuSNMaLmi6COUnDsGdvZNC
	 48epOdk0lVec54vwPX4+oawPbEHxi7LHNgplAYP+u7R6EFMpgZlqI1hKTTZyPAKqH+
	 FbHpWR6QnaaAFEwD1RB2SVt5Cs4BLe56fLDphnZjefH6nFyOwP6hZcQCB4hlMpIXU1
	 RPi2nAz7rtuiPBvt9l9ks0tz4U2y6cbPVa68u0jPbUIJk397571LXKTfGGugR1SMPJ
	 X+3T30N4ldZ7A==
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
Subject: [RFC PATCH V2 31/38] riscv: s64ilp32: Add u32ilp32 signal support
Date: Sun, 12 Nov 2023 01:15:07 -0500
Message-Id: <20231112061514.2306187-32-guoren@kernel.org>
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

The u32ilp32 uses the compat_pt_regs instead of the native pt_regs, so
we borrow the compat code to support the u32ilp32 signal procedure in
the s64ilp32 kernel.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/signal32.h |  2 +-
 arch/riscv/kernel/Makefile        |  1 +
 arch/riscv/kernel/signal.c        |  5 ++++-
 kernel/signal.c                   | 24 ++++++++++++++----------
 4 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/include/asm/signal32.h b/arch/riscv/include/asm/signal32.h
index cda62d7eb0a5..e47bb739e61a 100644
--- a/arch/riscv/include/asm/signal32.h
+++ b/arch/riscv/include/asm/signal32.h
@@ -3,7 +3,7 @@
 #ifndef __ASM_SIGNAL32_H
 #define __ASM_SIGNAL32_H
 
-#if IS_ENABLED(CONFIG_COMPAT)
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_RV64ILP32)
 int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs);
 long __riscv_compat_rt_sigreturn(void);
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index a4583a29b28b..e8af95298e98 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
 obj-$(CONFIG_COMPAT)		+= compat_signal.o
+obj-$(CONFIG_ARCH_RV64ILP32)	+= compat_signal.o
 
 obj-$(CONFIG_64BIT)		+= pi/
 obj-$(CONFIG_ACPI)		+= acpi.o
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 1c51a6783c98..95512af927dd 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -277,7 +277,10 @@ static long __riscv_rt_sigreturn(void)
 
 SYSCALL_DEFINE0(rt_sigreturn)
 {
-	return __riscv_rt_sigreturn();
+	if (test_thread_flag(TIF_32BIT) && !test_thread_flag(TIF_64ILP32))
+		return __riscv_compat_rt_sigreturn();
+	else
+		return __riscv_rt_sigreturn();
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/kernel/signal.c b/kernel/signal.c
index b5370fe5c198..3ac7fa4f1761 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3390,7 +3390,7 @@ int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from)
 	return post_copy_siginfo_from_user(to, from);
 }
 
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_RV64ILP32)
 /**
  * copy_siginfo_to_external32 - copy a kernel siginfo into a compat user siginfo
  * @to: compat siginfo destination
@@ -3556,6 +3556,7 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
 static int __copy_siginfo_from_user32(int signo, struct kernel_siginfo *to,
 				      const struct compat_siginfo __user *ufrom)
 {
@@ -3567,6 +3568,7 @@ static int __copy_siginfo_from_user32(int signo, struct kernel_siginfo *to,
 	from.si_signo = signo;
 	return post_copy_siginfo_from_user32(to, &from);
 }
+#endif /* CONFIG_COMPAT */
 
 int copy_siginfo_from_user32(struct kernel_siginfo *to,
 			     const struct compat_siginfo __user *ufrom)
@@ -3578,7 +3580,7 @@ int copy_siginfo_from_user32(struct kernel_siginfo *to,
 
 	return post_copy_siginfo_from_user32(to, &from);
 }
-#endif /* CONFIG_COMPAT */
+#endif
 
 /**
  *  do_sigtimedwait - wait for queued signals specified in @which
@@ -4279,7 +4281,7 @@ int __save_altstack(stack_t __user *uss, unsigned long sp)
 	return err;
 }
 
-#ifdef CONFIG_COMPAT
+#if IS_ENABLED(CONFIG_COMPAT) || IS_ENABLED(CONFIG_ARCH_HAS_64ILP32_KERNEL)
 static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
 				 compat_stack_t __user *uoss_ptr)
 {
@@ -4309,13 +4311,6 @@ static int do_compat_sigaltstack(const compat_stack_t __user *uss_ptr,
 	return ret;
 }
 
-COMPAT_SYSCALL_DEFINE2(sigaltstack,
-			const compat_stack_t __user *, uss_ptr,
-			compat_stack_t __user *, uoss_ptr)
-{
-	return do_compat_sigaltstack(uss_ptr, uoss_ptr);
-}
-
 int compat_restore_altstack(const compat_stack_t __user *uss)
 {
 	int err = do_compat_sigaltstack(uss, NULL);
@@ -4335,6 +4330,15 @@ int __compat_save_altstack(compat_stack_t __user *uss, unsigned long sp)
 }
 #endif
 
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE2(sigaltstack,
+			const compat_stack_t __user *, uss_ptr,
+			compat_stack_t __user *, uoss_ptr)
+{
+	return do_compat_sigaltstack(uss_ptr, uoss_ptr);
+}
+#endif
+
 #ifdef __ARCH_WANT_SYS_SIGPENDING
 
 /**
-- 
2.36.1


