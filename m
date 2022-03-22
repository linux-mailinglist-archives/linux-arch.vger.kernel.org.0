Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFBA4E4210
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 15:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbiCVOnw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiCVOnl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 10:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7C585BE3;
        Tue, 22 Mar 2022 07:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B15FA616B4;
        Tue, 22 Mar 2022 14:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AA4C340F0;
        Tue, 22 Mar 2022 14:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647960128;
        bh=gwexS5cDOjG6yPTnK5UPDkjABFJAJgKWUEeKQb6lmUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRnK+LISwdmBZavEQwkxpPR7JIB8X2mj6IRRGKZozd7OFdRpinTGc4j6e1KyjFGWW
         NKdsTKfjTNb8L45kirPqpIXb2P/saL6F0RCSVo2E9K7CTHx40rwIAOIrena4WdLKXQ
         fILabcjr2FgKAK83HfiCvXkXvSBz776W3jz1m1BMMN2tMofRp3F0Gukx/NbJAy3iJd
         DccfDa5TFJh7FUtFPHM6rIfQubS1IFoMtg3MJQsgX/6Mpu58ImibGE5418zB7m/++F
         AH37pIanimkfbuOFVeMgvFQSpJdcO/l70CIxVCixC1JcisLOA0wylblxQe4Q0hlyKH
         rtDi7/M1Ydx9w==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, hch@lst.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, heiko@sntech.de,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V9 18/20] riscv: compat: signal: Add rt_frame implementation
Date:   Tue, 22 Mar 2022 22:40:01 +0800
Message-Id: <20220322144003.2357128-19-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220322144003.2357128-1-guoren@kernel.org>
References: <20220322144003.2357128-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement compat_setup_rt_frame for sigcontext save & restore. The
main process is the same with signal, but the rv32 pt_regs' size
is different from rv64's, so we needs convert them.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Tested-by: Heiko Stuebner <heiko@sntech.de>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/compat_signal.c | 243 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/signal.c        |  13 +-
 3 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/compat_signal.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 6365f382d2fd..2712a5925515 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -69,4 +69,5 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
 obj-$(CONFIG_EFI)		+= efi.o
 obj-$(CONFIG_COMPAT)		+= compat_syscall_table.o
+obj-$(CONFIG_COMPAT)		+= compat_signal.o
 obj-$(CONFIG_COMPAT)		+= compat_vdso/
diff --git a/arch/riscv/kernel/compat_signal.c b/arch/riscv/kernel/compat_signal.c
new file mode 100644
index 000000000000..7041742ded08
--- /dev/null
+++ b/arch/riscv/kernel/compat_signal.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/compat.h>
+#include <linux/signal.h>
+#include <linux/uaccess.h>
+#include <linux/syscalls.h>
+#include <linux/tracehook.h>
+#include <linux/linkage.h>
+
+#include <asm/ucontext.h>
+#include <asm/vdso.h>
+#include <asm/switch_to.h>
+#include <asm/csr.h>
+
+#define COMPAT_DEBUG_SIG 0
+
+struct compat_sigcontext {
+	struct compat_user_regs_struct sc_regs;
+	union __riscv_fp_state sc_fpregs;
+};
+
+struct compat_ucontext {
+	compat_ulong_t		uc_flags;
+	struct compat_ucontext	*uc_link;
+	compat_stack_t		uc_stack;
+	sigset_t		uc_sigmask;
+	/* There's some padding here to allow sigset_t to be expanded in the
+	 * future.  Though this is unlikely, other architectures put uc_sigmask
+	 * at the end of this structure and explicitly state it can be
+	 * expanded, so we didn't want to box ourselves in here. */
+	__u8		  __unused[1024 / 8 - sizeof(sigset_t)];
+	/* We can't put uc_sigmask at the end of this structure because we need
+	 * to be able to expand sigcontext in the future.  For example, the
+	 * vector ISA extension will almost certainly add ISA state.  We want
+	 * to ensure all user-visible ISA state can be saved and restored via a
+	 * ucontext, so we're putting this at the end in order to allow for
+	 * infinite extensibility.  Since we know this will be extended and we
+	 * assume sigset_t won't be extended an extreme amount, we're
+	 * prioritizing this. */
+	struct compat_sigcontext uc_mcontext;
+};
+
+struct compat_rt_sigframe {
+	struct compat_siginfo info;
+	struct compat_ucontext uc;
+};
+
+#ifdef CONFIG_FPU
+static long compat_restore_fp_state(struct pt_regs *regs,
+	union __riscv_fp_state __user *sc_fpregs)
+{
+	long err;
+	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
+	size_t i;
+
+	err = __copy_from_user(&current->thread.fstate, state, sizeof(*state));
+	if (unlikely(err))
+		return err;
+
+	fstate_restore(current, regs);
+
+	/* We support no other extension state at this time. */
+	for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
+		u32 value;
+
+		err = __get_user(value, &sc_fpregs->q.reserved[i]);
+		if (unlikely(err))
+			break;
+		if (value != 0)
+			return -EINVAL;
+	}
+
+	return err;
+}
+
+static long compat_save_fp_state(struct pt_regs *regs,
+			  union __riscv_fp_state __user *sc_fpregs)
+{
+	long err;
+	struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
+	size_t i;
+
+	fstate_save(current, regs);
+	err = __copy_to_user(state, &current->thread.fstate, sizeof(*state));
+	if (unlikely(err))
+		return err;
+
+	/* We support no other extension state at this time. */
+	for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
+		err = __put_user(0, &sc_fpregs->q.reserved[i]);
+		if (unlikely(err))
+			break;
+	}
+
+	return err;
+}
+#else
+#define compat_save_fp_state(task, regs) (0)
+#define compat_restore_fp_state(task, regs) (0)
+#endif
+
+static long compat_restore_sigcontext(struct pt_regs *regs,
+	struct compat_sigcontext __user *sc)
+{
+	long err;
+	struct compat_user_regs_struct cregs;
+
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_from_user(&cregs, &sc->sc_regs, sizeof(sc->sc_regs));
+
+	cregs_to_regs(&cregs, regs);
+
+	/* Restore the floating-point state. */
+	if (has_fpu())
+		err |= compat_restore_fp_state(regs, &sc->sc_fpregs);
+	return err;
+}
+
+COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
+{
+	struct pt_regs *regs = current_pt_regs();
+	struct compat_rt_sigframe __user *frame;
+	struct task_struct *task;
+	sigset_t set;
+
+	/* Always make any pending restarted system calls return -EINTR */
+	current->restart_block.fn = do_no_restart_syscall;
+
+	frame = (struct compat_rt_sigframe __user *)regs->sp;
+
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+
+	if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
+		goto badframe;
+
+	set_current_blocked(&set);
+
+	if (compat_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+		goto badframe;
+
+	if (compat_restore_altstack(&frame->uc.uc_stack))
+		goto badframe;
+
+	return regs->a0;
+
+badframe:
+	task = current;
+	if (show_unhandled_signals) {
+		pr_info_ratelimited(
+			"%s[%d]: bad frame in %s: frame=%p pc=%p sp=%p\n",
+			task->comm, task_pid_nr(task), __func__,
+			frame, (void *)regs->epc, (void *)regs->sp);
+	}
+	force_sig(SIGSEGV);
+	return 0;
+}
+
+static long compat_setup_sigcontext(struct compat_rt_sigframe __user *frame,
+	struct pt_regs *regs)
+{
+	struct compat_sigcontext __user *sc = &frame->uc.uc_mcontext;
+	struct compat_user_regs_struct cregs;
+	long err;
+
+	regs_to_cregs(&cregs, regs);
+
+	/* sc_regs is structured the same as the start of pt_regs */
+	err = __copy_to_user(&sc->sc_regs, &cregs, sizeof(sc->sc_regs));
+	/* Save the floating-point state. */
+	if (has_fpu())
+		err |= compat_save_fp_state(regs, &sc->sc_fpregs);
+	return err;
+}
+
+static inline void __user *compat_get_sigframe(struct ksignal *ksig,
+	struct pt_regs *regs, size_t framesize)
+{
+	unsigned long sp;
+	/* Default to using normal stack */
+	sp = regs->sp;
+
+	/*
+	 * If we are on the alternate signal stack and would overflow it, don't.
+	 * Return an always-bogus address instead so we will die with SIGSEGV.
+	 */
+	if (on_sig_stack(sp) && !likely(on_sig_stack(sp - framesize)))
+		return (void __user __force *)(-1UL);
+
+	/* This is the X/Open sanctioned signal stack switching. */
+	sp = sigsp(sp, ksig) - framesize;
+
+	/* Align the stack frame. */
+	sp &= ~0xfUL;
+
+	return (void __user *)sp;
+}
+
+int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+	struct pt_regs *regs)
+{
+	struct compat_rt_sigframe __user *frame;
+	long err = 0;
+
+	frame = compat_get_sigframe(ksig, regs, sizeof(*frame));
+	if (!access_ok(frame, sizeof(*frame)))
+		return -EFAULT;
+
+	err |= copy_siginfo_to_user32(&frame->info, &ksig->info);
+
+	/* Create the ucontext. */
+	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(NULL, &frame->uc.uc_link);
+	err |= __compat_save_altstack(&frame->uc.uc_stack, regs->sp);
+	err |= compat_setup_sigcontext(frame, regs);
+	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
+	if (err)
+		return -EFAULT;
+
+	regs->ra = (unsigned long)COMPAT_VDSO_SYMBOL(
+			current->mm->context.vdso, rt_sigreturn);
+
+	/*
+	 * Set up registers for signal handler.
+	 * Registers that we don't modify keep the value they had from
+	 * user-space at the time we took the signal.
+	 * We always pass siginfo and mcontext, regardless of SA_SIGINFO,
+	 * since some things rely on this (e.g. glibc's debug/segfault.c).
+	 */
+	regs->epc = (unsigned long)ksig->ka.sa.sa_handler;
+	regs->sp = (unsigned long)frame;
+	regs->a0 = ksig->sig;                     /* a0: signal number */
+	regs->a1 = (unsigned long)(&frame->info); /* a1: siginfo pointer */
+	regs->a2 = (unsigned long)(&frame->uc);   /* a2: ucontext pointer */
+
+#if COMPAT_DEBUG_SIG
+	pr_info("SIG deliver (%s:%d): sig=%d pc=%p ra=%p sp=%p\n",
+		current->comm, task_pid_nr(current), ksig->sig,
+		(void *)regs->epc, (void *)regs->ra, frame);
+#endif
+
+	return 0;
+}
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index c2d5ecbe5526..27d8f39228c4 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <linux/compat.h>
 #include <linux/signal.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -229,6 +230,11 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+extern int compat_setup_rt_frame(struct ksignal *ksig, sigset_t *set,
+				 struct pt_regs *regs);
+#endif
+
 static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	sigset_t *oldset = sigmask_to_save();
@@ -258,8 +264,13 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		}
 	}
 
+#ifdef CONFIG_COMPAT
 	/* Set up the stack frame */
-	ret = setup_rt_frame(ksig, oldset, regs);
+	if (is_compat_task())
+		ret = compat_setup_rt_frame(ksig, oldset, regs);
+	else
+#endif
+		ret = setup_rt_frame(ksig, oldset, regs);
 
 	signal_setup_done(ret, ksig, 0);
 }
-- 
2.25.1

