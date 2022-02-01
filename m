Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B94A5F79
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 16:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbiBAPHw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 10:07:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59872 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240141AbiBAPHu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 10:07:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD01EB82E8D;
        Tue,  1 Feb 2022 15:07:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD91EC340ED;
        Tue,  1 Feb 2022 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643728067;
        bh=c5b0OtGYsiLuv8HExBqo/wHQpxjCxbIXMomdAS0MufI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcyO060lWBqbUfENkqf0dfk2O/QCl4egOUHUfQmopjKKK6U5q630wA9XOvgsA6QWd
         bY+ceU4mZyCWY96736qo9s9M1/hxSLTieup/2H1ydVnd2M8ffO2w+sbIIGgyxD7H0i
         NeQ25e6c80O2qXOhkSciGe+qRM1ts/bcQ/syjLa0HfTiCg4ag6sFIcnUtKpfICLSzf
         9TBbVfFY51J6EixJ+7Z8b19PJrR8aCSOi4/tciQIL08AGKhuzp33u/1fmb0VYElc+s
         6B0DnUTHe48QEz+5wCX0Shul7Kjfw/nWOcboloyqzyxOI+OITeLKlFaPebUKhieTzo
         kmRVaQ+/YrmMg==
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
        x86@kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 18/21] riscv: compat: signal: Add rt_frame implementation
Date:   Tue,  1 Feb 2022 23:05:42 +0800
Message-Id: <20220201150545.1512822-19-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220201150545.1512822-1-guoren@kernel.org>
References: <20220201150545.1512822-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement compat_setup_rt_frame for sigcontext save & restore. The
main process is the same with signal, but the rv32 pt_regs' size
is different from rv64's, so we needs convert them.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/kernel/Makefile        |   1 +
 arch/riscv/kernel/compat_signal.c | 243 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/signal.c        |  13 +-
 3 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 arch/riscv/kernel/compat_signal.c

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 88e79f481c21..a46f9807c59e 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -67,4 +67,5 @@ obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
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

