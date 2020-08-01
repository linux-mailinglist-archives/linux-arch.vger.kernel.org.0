Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF33F234F15
	for <lists+linux-arch@lfdr.de>; Sat,  1 Aug 2020 03:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgHABOy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 31 Jul 2020 21:14:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbgHABOw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 31 Jul 2020 21:14:52 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8989820888;
        Sat,  1 Aug 2020 01:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596244491;
        bh=4ZAPfFdFLJXSKhIy3OtLRcj/wu7VijkufexJeGKSC+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Du44Bvgg7byUBuBlmIVqFDJxiRExx4rSK2HjU3uQrikE6gV21bLoGZJ11MvhsL3su
         adabAjZ9icqqcLvd/eeYMAbyuklDUFibk3h0KsbAAs156qTWOFVcrFSpR4m1HLOiWZ
         aPGRI616ZbZGayK+N2WXmTXgXVaIcBJUiFuL7Hqo=
From:   guoren@kernel.org
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 07/13] csky: Optimize the trap processing flow
Date:   Sat,  1 Aug 2020 01:14:07 +0000
Message-Id: <1596244453-98575-8-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

 - Seperate different trap functions
 - Add trap_no()
 - Remove panic code print
 - Redesign die_if_kerenl to die with riscv's
 - Print exact trap info for app segment fault

[   17.389321] gzip[126]: unhandled signal 11 code 0x3 at 0x0007835a in busybox[8000+d4000]
[   17.393882]
[   17.393882] CURRENT PROCESS:
[   17.393882]
[   17.394309] COMM=gzip PID=126
[   17.394513] TEXT=00008000-000db2e4 DATA=000dcf14-000dd1ad BSS=000dd1ad-000ff000
[   17.395499] USER-STACK=7f888e50  KERNEL-STACK=bf130300
[   17.395499]
[   17.396801] PC: 0x0007835a (0x7835a)
[   17.397048] LR: 0x000058b4 (0x58b4)
[   17.397285] SP: 0xbe519f68
[   17.397555] orig_a0: 0x00002852
[   17.397886] PSR: 0x00020341
[   17.398356]  a0: 0x00002852   a1: 0x000f2f5a   a2: 0x0000d7ae   a3: 0x0000005d
[   17.399289]  r4: 0x000de150   r5: 0x00000002   r6: 0x00000102   r7: 0x00007efa
[   17.399800]  r8: 0x7f888bc4   r9: 0x00000001  r10: 0x000002eb  r11: 0x0000aac1
[   17.400166] r12: 0x00002ef2  r13: 0x00000007  r15: 0x000058b4
[   17.400531] r16: 0x0000004c  r17: 0x00000031  r18: 0x000f5816  r19: 0x000e8068
[   17.401006] r20: 0x000f5818  r21: 0x000e8068  r22: 0x000f5918  r23: 0x90000000
[   17.401721] r24: 0x00000031  r25: 0x000000c8  r26: 0x00000000  r27: 0x00000000
[   17.402199] r28: 0x2ac2a000  r29: 0x00000000  r30: 0x00000000  tls: 0x2aadbaa8
[   17.402686]  hi: 0x00120340   lo: 0x7f888bec
/etc/init.ci/ntfs3g_run: line 61:   126 Segmentation fault      gzip -c -9 /mnt/test.bin > /mnt/test_bin.gz

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/bug.h    |   3 +-
 arch/csky/include/asm/ptrace.h |   1 +
 arch/csky/kernel/ptrace.c      |  29 +-----
 arch/csky/kernel/traps.c       | 223 +++++++++++++++++++++++++++--------------
 arch/csky/mm/fault.c           |  10 +-
 5 files changed, 157 insertions(+), 109 deletions(-)

diff --git a/arch/csky/include/asm/bug.h b/arch/csky/include/asm/bug.h
index bd7b323..33ebd16 100644
--- a/arch/csky/include/asm/bug.h
+++ b/arch/csky/include/asm/bug.h
@@ -20,7 +20,8 @@ do {					\
 
 struct pt_regs;
 
-void die_if_kernel(char *str, struct pt_regs *regs, int nr);
+void die(struct pt_regs *regs, const char *str);
 void show_regs(struct pt_regs *regs);
+void show_code(struct pt_regs *regs);
 
 #endif /* __ASM_CSKY_BUG_H */
diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
index 82da5e0..91ceb1b 100644
--- a/arch/csky/include/asm/ptrace.h
+++ b/arch/csky/include/asm/ptrace.h
@@ -24,6 +24,7 @@
 #define user_mode(regs) (!((regs)->sr & PS_S))
 #define instruction_pointer(regs) ((regs)->pc)
 #define profile_pc(regs) instruction_pointer(regs)
+#define trap_no(regs) ((regs->sr >> 16) & 0xff)
 
 static inline void instruction_pointer_set(struct pt_regs *regs,
 					   unsigned long val)
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 0de10f7..b06612c 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -347,13 +347,8 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 }
 
-extern void show_stack(struct task_struct *task, unsigned long *stack, const char *loglvl);
 void show_regs(struct pt_regs *fp)
 {
-	unsigned long   *sp;
-	unsigned char   *tp;
-	int	i;
-
 	pr_info("\nCURRENT PROCESS:\n\n");
 	pr_info("COMM=%s PID=%d\n", current->comm, current->pid);
 
@@ -400,29 +395,9 @@ void show_regs(struct pt_regs *fp)
 		fp->regs[0], fp->regs[1], fp->regs[2], fp->regs[3]);
 	pr_info("r10: 0x%08lx  r11: 0x%08lx  r12: 0x%08lx  r13: 0x%08lx\n",
 		fp->regs[4], fp->regs[5], fp->regs[6], fp->regs[7]);
-	pr_info("r14: 0x%08lx   r1: 0x%08lx  r15: 0x%08lx\n",
-		fp->regs[8], fp->regs[9], fp->lr);
+	pr_info("r14: 0x%08lx   r1: 0x%08lx\n",
+		fp->regs[8], fp->regs[9]);
 #endif
 
-	pr_info("\nCODE:");
-	tp = ((unsigned char *) fp->pc) - 0x20;
-	tp += ((int)tp % 4) ? 2 : 0;
-	for (sp = (unsigned long *) tp, i = 0; (i < 0x40);  i += 4) {
-		if ((i % 0x10) == 0)
-			pr_cont("\n%08x: ", (int) (tp + i));
-		pr_cont("%08x ", (int) *sp++);
-	}
-	pr_cont("\n");
-
-	pr_info("\nKERNEL STACK:");
-	tp = ((unsigned char *) fp) - 0x40;
-	for (sp = (unsigned long *) tp, i = 0; (i < 0xc0); i += 4) {
-		if ((i % 0x10) == 0)
-			pr_cont("\n%08x: ", (int) (tp + i));
-		pr_cont("%08x ", (int) *sp++);
-	}
-	pr_cont("\n");
-
-	show_stack(NULL, (unsigned long *)fp->regs[4], KERN_INFO);
 	return;
 }
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index fcc3a69..959a917 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -15,6 +15,8 @@
 #include <linux/rtc.h>
 #include <linux/uaccess.h>
 #include <linux/kprobes.h>
+#include <linux/kdebug.h>
+#include <linux/sched/debug.h>
 
 #include <asm/setup.h>
 #include <asm/traps.h>
@@ -27,6 +29,8 @@
 #include <abi/fpu.h>
 #endif
 
+int show_unhandled_signals = 1;
+
 /* Defined in entry.S */
 asmlinkage void csky_trap(void);
 
@@ -77,117 +81,184 @@ void __init trap_init(void)
 #endif
 }
 
-void die_if_kernel(char *str, struct pt_regs *regs, int nr)
+static DEFINE_SPINLOCK(die_lock);
+
+void die(struct pt_regs *regs, const char *str)
 {
-	if (user_mode(regs))
-		return;
+	static int die_counter;
+	int ret;
 
+	oops_enter();
+
+	spin_lock_irq(&die_lock);
 	console_verbose();
-	pr_err("%s: %08x\n", str, nr);
+	bust_spinlocks(1);
+
+	pr_emerg("%s [#%d]\n", str, ++die_counter);
+	print_modules();
 	show_regs(regs);
+	show_stack(current, (unsigned long *)regs->regs[4], KERN_INFO);
+
+	ret = notify_die(DIE_OOPS, str, regs, 0, trap_no(regs), SIGSEGV);
+
+	bust_spinlocks(0);
 	add_taint(TAINT_DIE, LOCKDEP_NOW_UNRELIABLE);
-	do_exit(SIGSEGV);
+	spin_unlock_irq(&die_lock);
+	oops_exit();
+
+	if (in_interrupt())
+		panic("Fatal exception in interrupt");
+	if (panic_on_oops)
+		panic("Fatal exception");
+	if (ret != NOTIFY_STOP)
+		do_exit(SIGSEGV);
 }
 
-void buserr(struct pt_regs *regs)
+void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
-#ifdef CONFIG_CPU_CK810
-	static unsigned long prev_pc;
+	struct task_struct *tsk = current;
 
-	if ((regs->pc == prev_pc) && prev_pc != 0) {
-		prev_pc = 0;
-	} else {
-		prev_pc = regs->pc;
-		return;
+	if (show_unhandled_signals && unhandled_signal(tsk, signo)
+	    && printk_ratelimit()) {
+		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x%08lx",
+			tsk->comm, task_pid_nr(tsk), signo, code, addr);
+		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
+		pr_cont("\n");
+		show_regs(regs);
 	}
-#endif
 
-	die_if_kernel("Kernel mode BUS error", regs, 0);
+	force_sig_fault(signo, code, (void __user *)addr);
+}
 
-	pr_err("User mode Bus Error\n");
-	show_regs(regs);
+static void do_trap_error(struct pt_regs *regs, int signo, int code,
+	unsigned long addr, const char *str)
+{
+	current->thread.trap_no = trap_no(regs);
 
-	force_sig_fault(SIGSEGV, 0, (void __user *)regs->pc);
+	if (user_mode(regs)) {
+		do_trap(regs, signo, code, addr);
+	} else {
+		if (!fixup_exception(regs))
+			die(regs, str);
+	}
 }
 
-asmlinkage void trap_c(struct pt_regs *regs)
-{
-	int sig;
-	unsigned long vector;
-	siginfo_t info;
-	struct task_struct *tsk = current;
+#define DO_ERROR_INFO(name, signo, code, str)				\
+asmlinkage __visible void name(struct pt_regs *regs)			\
+{									\
+	do_trap_error(regs, signo, code, regs->pc, "Oops - " str);	\
+}
 
-	vector = (regs->sr >> 16) & 0xff;
+DO_ERROR_INFO(do_trap_unknown,
+	SIGILL, ILL_ILLTRP, "unknown exception");
+DO_ERROR_INFO(do_trap_zdiv,
+	SIGFPE, FPE_INTDIV, "error zero div exception");
+DO_ERROR_INFO(do_trap_buserr,
+	SIGSEGV, ILL_ILLADR, "error bus error exception");
 
-	switch (vector) {
-	case VEC_ZERODIV:
-		die_if_kernel("Kernel mode ZERO DIV", regs, vector);
-		sig = SIGFPE;
-		break;
-	/* ptrace */
-	case VEC_TRACE:
+asmlinkage void do_trap_misaligned(struct pt_regs *regs)
+{
+#ifdef CONFIG_CPU_NEED_SOFTALIGN
+	csky_alignment(regs);
+#else
+	current->thread.trap_no = trap_no(regs);
+	do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->pc,
+		      "Oops - load/store address misaligned");
+#endif
+}
+
+asmlinkage void do_trap_bkpt(struct pt_regs *regs)
+{
 #ifdef CONFIG_KPROBES
-		if (kprobe_single_step_handler(regs))
-			return;
+	if (kprobe_single_step_handler(regs))
+		return;
 #endif
 #ifdef CONFIG_UPROBES
-		if (uprobe_single_step_handler(regs))
-			return;
+	if (uprobe_single_step_handler(regs))
+		return;
 #endif
-		info.si_code = TRAP_TRACE;
-		sig = SIGTRAP;
-		break;
-	case VEC_ILLEGAL:
-		tsk->thread.trap_no = vector;
+	if (user_mode(regs)) {
+		send_sig(SIGTRAP, current, 0);
+		return;
+	}
+
+	do_trap_error(regs, SIGILL, ILL_ILLTRP, regs->pc,
+		      "Oops - illegal trap exception");
+}
+
+asmlinkage void do_trap_illinsn(struct pt_regs *regs)
+{
+	current->thread.trap_no = trap_no(regs);
+
 #ifdef CONFIG_KPROBES
-		if (kprobe_breakpoint_handler(regs))
-			return;
+	if (kprobe_breakpoint_handler(regs))
+		return;
 #endif
 #ifdef CONFIG_UPROBES
-		if (uprobe_breakpoint_handler(regs))
-			return;
+	if (uprobe_breakpoint_handler(regs))
+		return;
 #endif
-		die_if_kernel("Kernel mode ILLEGAL", regs, vector);
 #ifndef CONFIG_CPU_NO_USER_BKPT
-		if (*(uint16_t *)instruction_pointer(regs) != USR_BKPT)
+	if (*(uint16_t *)instruction_pointer(regs) != USR_BKPT) {
+		send_sig(SIGTRAP, current, 0);
+		return;
+	}
 #endif
-		{
-			sig = SIGILL;
-			break;
-		}
-	/* gdbserver  breakpoint */
+
+	do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->pc,
+		      "Oops - illegal instruction exception");
+}
+
+asmlinkage void do_trap_fpe(struct pt_regs *regs)
+{
+#ifdef CONFIG_CPU_HAS_FP
+	return fpu_fpe(regs);
+#else
+	do_trap_error(regs, SIGILL, ILL_ILLOPC, regs->pc,
+		      "Oops - fpu instruction exception");
+#endif
+}
+
+asmlinkage void do_trap_priv(struct pt_regs *regs)
+{
+#ifdef CONFIG_CPU_HAS_FP
+	if (user_mode(regs) && fpu_libc_helper(regs))
+		return;
+#endif
+	do_trap_error(regs, SIGILL, ILL_PRVOPC, regs->pc,
+		      "Oops - illegal privileged exception");
+}
+
+asmlinkage void trap_c(struct pt_regs *regs)
+{
+	switch (trap_no(regs)) {
+	case VEC_ZERODIV:
+		do_trap_zdiv(regs);
+		break;
+	case VEC_TRACE:
+		do_trap_bkpt(regs);
+		break;
+	case VEC_ILLEGAL:
+		do_trap_illinsn(regs);
+		break;
 	case VEC_TRAP1:
-	/* jtagserver breakpoint */
 	case VEC_BREAKPOINT:
-		die_if_kernel("Kernel mode BKPT", regs, vector);
-		info.si_code = TRAP_BRKPT;
-		sig = SIGTRAP;
+		do_trap_bkpt(regs);
 		break;
 	case VEC_ACCESS:
-		tsk->thread.trap_no = vector;
-		return buserr(regs);
-#ifdef CONFIG_CPU_NEED_SOFTALIGN
+		do_trap_buserr(regs);
+		break;
 	case VEC_ALIGN:
-		tsk->thread.trap_no = vector;
-		return csky_alignment(regs);
-#endif
-#ifdef CONFIG_CPU_HAS_FPU
+		do_trap_misaligned(regs);
+		break;
 	case VEC_FPE:
-		tsk->thread.trap_no = vector;
-		die_if_kernel("Kernel mode FPE", regs, vector);
-		return fpu_fpe(regs);
+		do_trap_fpe(regs);
+		break;
 	case VEC_PRIV:
-		tsk->thread.trap_no = vector;
-		die_if_kernel("Kernel mode PRIV", regs, vector);
-		if (fpu_libc_helper(regs))
-			return;
-#endif
+		do_trap_priv(regs);
+		break;
 	default:
-		sig = SIGSEGV;
+		do_trap_unknown(regs);
 		break;
 	}
-
-	tsk->thread.trap_no = vector;
-
-	send_sig(sig, current, 0);
 }
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 0b9cbf2..b1dce9f 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -183,13 +183,13 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 bad_area_nosemaphore:
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs)) {
-		tsk->thread.trap_no = (regs->sr >> 16) & 0xff;
+		tsk->thread.trap_no = trap_no(regs);
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 		return;
 	}
 
 no_context:
-	tsk->thread.trap_no = (regs->sr >> 16) & 0xff;
+	tsk->thread.trap_no = trap_no(regs);
 
 	/* Are we prepared to handle this kernel fault? */
 	if (fixup_exception(regs))
@@ -202,10 +202,10 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	bust_spinlocks(1);
 	pr_alert("Unable to handle kernel paging request at virtual "
 		 "address 0x%08lx, pc: 0x%08lx\n", address, regs->pc);
-	die_if_kernel("Oops", regs, write);
+	die(regs, "Oops");
 
 out_of_memory:
-	tsk->thread.trap_no = (regs->sr >> 16) & 0xff;
+	tsk->thread.trap_no = trap_no(regs);
 
 	/*
 	 * We ran out of memory, call the OOM killer, and return the userspace
@@ -215,7 +215,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	return;
 
 do_sigbus:
-	tsk->thread.trap_no = (regs->sr >> 16) & 0xff;
+	tsk->thread.trap_no = trap_no(regs);
 
 	mmap_read_unlock(mm);
 
-- 
2.7.4

