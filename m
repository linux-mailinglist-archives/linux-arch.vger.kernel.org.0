Return-Path: <linux-arch+bounces-142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C65B7E8E8F
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 07:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08611F20F6B
	for <lists+linux-arch@lfdr.de>; Sun, 12 Nov 2023 06:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8282440E;
	Sun, 12 Nov 2023 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LijSfjXM"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F6440A
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 06:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BFBC433D9;
	Sun, 12 Nov 2023 06:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699769763;
	bh=VEdgkasnG6WV+UwznjmxtCe/+1EnOyvijw2TTDpGzls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LijSfjXMXwZ7v68ahlqw4zv5xx9HIG5ohVA/+6HsSiQeE6I7KIp+zAYxquYYx/Rki
	 ORMbca9Aps4wycU1ZctklwUJXamKPqduNqusNNGaelIfaYzuWcHUkxeSos9v3CrfTW
	 SW46dQcdrj4xifPGeNtBTOo6OxlfB+gEmMnxGTBvxp/3JO3dMkdjCJkn7KUmrexuLh
	 U4yZFJ6UfL0ORGcYa4dE0dXoPXbtBFfYyeJW9eWh1G/n26IPfND3rjkIzIStV2kaNe
	 dFApL15ryILb9lETfRSDUR+68KH4ZPQWqsi6v5T8LmZBfloe0pJOno4PcqrQCNPhTJ
	 SWU0cH/7PPD0g==
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
Subject: [RFC PATCH V2 06/38] riscv: u64ilp32: Add signal support for compat
Date: Sun, 12 Nov 2023 01:14:42 -0500
Message-Id: <20231112061514.2306187-7-guoren@kernel.org>
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

The u64ilp32 reuses compat mode on the 64-bit Linux kernel, but the
signal context is the same as the native 64-bit, not u32ilp32. So use
the native signal procedure for u64ilp32 applications.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/include/asm/signal32.h |  9 ++++++
 arch/riscv/kernel/compat_signal.c | 21 ++++--------
 arch/riscv/kernel/signal.c        | 53 ++++++++++++++++++++++---------
 3 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/arch/riscv/include/asm/signal32.h b/arch/riscv/include/asm/signal32.h
index 96dc56932e76..cda62d7eb0a5 100644
--- a/arch/riscv/include/asm/signal32.h
+++ b/arch/riscv/include/asm/signal32.h
@@ -6,6 +6,7 @@
 #if IS_ENABLED(CONFIG_COMPAT)
 int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 			  struct pt_regs *regs);
+long __riscv_compat_rt_sigreturn(void);
 #else
 static inline
 int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
@@ -13,6 +14,14 @@ int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 {
 	return -1;
 }
+
+static inline
+long __riscv_compat_rt_sigreturn(void)
+{
+	return -1;
+}
 #endif
 
+void __riscv_rt_sigreturn_badframe(void);
+
 #endif
diff --git a/arch/riscv/kernel/compat_signal.c b/arch/riscv/kernel/compat_signal.c
index 8dea2012836e..955a638da2a4 100644
--- a/arch/riscv/kernel/compat_signal.c
+++ b/arch/riscv/kernel/compat_signal.c
@@ -116,18 +116,16 @@ static long compat_restore_sigcontext(struct pt_regs *regs,
 	return err;
 }
 
-COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
+long __riscv_compat_rt_sigreturn(void)
 {
-	struct pt_regs *regs = current_pt_regs();
-	struct compat_rt_sigframe __user *frame;
-	struct task_struct *task;
 	sigset_t set;
+	struct pt_regs *regs = current_pt_regs();
+	struct compat_rt_sigframe __user *frame =
+		(struct compat_rt_sigframe __user *)kernel_stack_pointer(regs);
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	frame = (struct compat_rt_sigframe __user *)regs->sp;
-
 	if (!access_ok(frame, sizeof(*frame)))
 		goto badframe;
 
@@ -142,17 +140,12 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 	if (compat_restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+	regs->cause = -1UL;
+
 	return regs->a0;
 
 badframe:
-	task = current;
-	if (show_unhandled_signals) {
-		pr_info_ratelimited(
-			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
-			task->comm, task_pid_nr(task), __func__,
-			frame, (void *)regs->epc, (void *)regs->sp);
-	}
-	force_sig(SIGSEGV);
+	__riscv_rt_sigreturn_badframe();
 	return 0;
 }
 
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 95c4a8d8a3f5..1c51a6783c98 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -224,19 +224,34 @@ static size_t get_rt_frame_size(bool cal_all)
 	return frame_size;
 }
 
-SYSCALL_DEFINE0(rt_sigreturn)
+void __riscv_rt_sigreturn_badframe(void)
+{
+	struct task_struct *task = current;
+	struct pt_regs *regs = task_pt_regs(task);
+
+	if (show_unhandled_signals) {
+		pr_info_ratelimited(
+			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
+			task->comm, task_pid_nr(task), __func__,
+			(void *)kernel_stack_pointer(regs),
+			(void *)instruction_pointer(regs),
+			(void *)kernel_stack_pointer(regs));
+	}
+
+	force_sig(SIGSEGV);
+}
+
+static long __riscv_rt_sigreturn(void)
 {
-	struct pt_regs *regs = current_pt_regs();
-	struct rt_sigframe __user *frame;
-	struct task_struct *task;
 	sigset_t set;
 	size_t frame_size = get_rt_frame_size(false);
+	struct pt_regs *regs = current_pt_regs();
+	struct rt_sigframe __user *frame =
+		(struct rt_sigframe __user *)kernel_stack_pointer(regs);
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
 
-	frame = (struct rt_sigframe __user *)regs->sp;
-
 	if (!access_ok(frame, frame_size))
 		goto badframe;
 
@@ -256,17 +271,25 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return regs->a0;
 
 badframe:
-	task = current;
-	if (show_unhandled_signals) {
-		pr_info_ratelimited(
-			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
-			task->comm, task_pid_nr(task), __func__,
-			frame, (void *)regs->epc, (void *)regs->sp);
-	}
-	force_sig(SIGSEGV);
+	__riscv_rt_sigreturn_badframe();
 	return 0;
 }
 
+SYSCALL_DEFINE0(rt_sigreturn)
+{
+	return __riscv_rt_sigreturn();
+}
+
+#ifdef CONFIG_COMPAT
+COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
+{
+	if (test_thread_flag(TIF_32BIT) && !test_thread_flag(TIF_64ILP32))
+		return __riscv_compat_rt_sigreturn();
+	else
+		return __riscv_rt_sigreturn();
+}
+#endif
+
 static long setup_sigcontext(struct rt_sigframe __user *frame,
 	struct pt_regs *regs)
 {
@@ -433,7 +456,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	rseq_signal_deliver(ksig, regs);
 
 	/* Set up the stack frame */
-	if (is_compat_task())
+	if (test_thread_flag(TIF_32BIT) && !test_thread_flag(TIF_64ILP32))
 		ret = compat_setup_rt_frame(ksig, oldset, regs);
 	else
 		ret = setup_rt_frame(ksig, oldset, regs);
-- 
2.36.1


