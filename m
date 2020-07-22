Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5785A22A1D5
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jul 2020 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733149AbgGVWLh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 18:11:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52590 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbgGVWLe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 18:11:34 -0400
Message-Id: <20200722220520.051234096@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595455891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aKx6tej9oRmsucONvWU9/xX6N6KtXdfi47wl7vLEZ6U=;
        b=w01Khsmd36kZOqhTG38BTmbwR3K86z1pLUnTTBi6exdgx9iU5t8lPC2ee2w1GGMcDtmhrs
        kCHQrWijMYMU6WieZmIMysAaRDi7xb43pdxYMi+ry2MF8ff/qM5GpBQh6ATBq8V1D3BMvI
        kdox9IyWomiAt4OFrKb9/YTjKceh0J2saX9HgeB4oZxKMXdsAeqHY3Ndf/vQcQTRbHM9Up
        rs87ikI/1LA9y+7FrHbUxQA5AG5fd8TVdvBS4UvjKZnVC5y7ipSWWm3POyuN2Q1j7crhSD
        0HHQ8H5vAkW+Vy7vcHgRPcgLaEWGKhxid6F9IAnJ5pmmA0NX4ORuE0/0QFVzrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595455891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=aKx6tej9oRmsucONvWU9/xX6N6KtXdfi47wl7vLEZ6U=;
        b=nC6RtjZ14dBc09JbwN+vDS7xmMLC1tQ3FmG2MViz4xGOzNLTtA16XIUfIIIE6qES6mZ0pE
        2BKzybwoZZ0g7BDw==
Date:   Thu, 23 Jul 2020 00:00:01 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [patch V5 07/15] x86/entry: Consolidate 32/64 bit syscall entry
References: <20200722215954.464281930@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

64bit and 32bit entry code have the same open coded syscall entry handling
after the bitwidth specific bits.

Move it to a helper function and share the code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/entry/common.c |   93 +++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 52 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -366,8 +366,7 @@ static void __syscall_return_slowpath(st
 	exit_to_user_mode();
 }
 
-#ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+static noinstr long syscall_enter(struct pt_regs *regs, unsigned long nr)
 {
 	struct thread_info *ti;
 
@@ -379,6 +378,16 @@ static void __syscall_return_slowpath(st
 	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY)
 		nr = syscall_trace_enter(regs);
 
+	instrumentation_end();
+	return nr;
+}
+
+#ifdef CONFIG_X86_64
+__visible noinstr void do_syscall_64(unsigned long nr, struct pt_regs *regs)
+{
+	nr = syscall_enter(regs, nr);
+
+	instrumentation_begin();
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
 		regs->ax = sys_call_table[nr](regs);
@@ -390,64 +399,53 @@ static void __syscall_return_slowpath(st
 		regs->ax = x32_sys_call_table[nr](regs);
 #endif
 	}
-	__syscall_return_slowpath(regs);
-
 	instrumentation_end();
-	exit_to_user_mode();
+	syscall_return_slowpath(regs);
 }
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
+{
+	if (IS_ENABLED(CONFIG_IA32_EMULATION))
+		current_thread_info()->status |= TS_COMPAT;
+	/*
+	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
+	 * orig_ax, the unsigned int return value truncates it.  This may
+	 * or may not be necessary, but it matches the old asm behavior.
+	 */
+	return syscall_enter(regs, (unsigned int)regs->orig_ax);
+}
+
 /*
- * Does a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.  Does
- * all entry and exit work and returns with IRQs off.  This function is
- * extremely hot in workloads that use it, and it's usually called from
- * do_fast_syscall_32, so forcibly inline it to improve performance.
+ * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
-static void do_syscall_32_irqs_on(struct pt_regs *regs)
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
+						  unsigned int nr)
 {
-	struct thread_info *ti = current_thread_info();
-	unsigned int nr = (unsigned int)regs->orig_ax;
-
-#ifdef CONFIG_IA32_EMULATION
-	ti->status |= TS_COMPAT;
-#endif
-
-	if (READ_ONCE(ti->flags) & _TIF_WORK_SYSCALL_ENTRY) {
-		/*
-		 * Subtlety here: if ptrace pokes something larger than
-		 * 2^32-1 into orig_ax, this truncates it.  This may or
-		 * may not be necessary, but it matches the old asm
-		 * behavior.
-		 */
-		nr = syscall_trace_enter(regs);
-	}
-
 	if (likely(nr < IA32_NR_syscalls)) {
+		instrumentation_begin();
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[nr](regs);
+		instrumentation_end();
 	}
-
-	__syscall_return_slowpath(regs);
 }
 
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	local_irq_enable();
-	do_syscall_32_irqs_on(regs);
+	unsigned int nr = syscall_32_enter(regs);
 
-	instrumentation_end();
-	exit_to_user_mode();
+	do_syscall_32_irqs_on(regs, nr);
+	syscall_return_slowpath(regs);
 }
 
-static bool __do_fast_syscall_32(struct pt_regs *regs)
+static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
+	unsigned int nr	= syscall_32_enter(regs);
 	int res;
 
+	instrumentation_begin();
 	/* Fetch EBP from where the vDSO stashed it. */
 	if (IS_ENABLED(CONFIG_X86_64)) {
 		/*
@@ -460,17 +458,18 @@ static bool __do_fast_syscall_32(struct
 		res = get_user(*(u32 *)&regs->bp,
 		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
 	}
+	instrumentation_end();
 
 	if (res) {
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
-		local_irq_disable();
-		__prepare_exit_to_usermode(regs);
+		syscall_return_slowpath(regs);
 		return false;
 	}
 
 	/* Now this is just like a normal syscall. */
-	do_syscall_32_irqs_on(regs);
+	do_syscall_32_irqs_on(regs, nr);
+	syscall_return_slowpath(regs);
 	return true;
 }
 
@@ -483,7 +482,6 @@ static bool __do_fast_syscall_32(struct
 	 */
 	unsigned long landing_pad = (unsigned long)current->mm->context.vdso +
 					vdso_image_32.sym_int80_landing_pad;
-	bool success;
 
 	/*
 	 * SYSENTER loses EIP, and even SYSCALL32 needs us to skip forward
@@ -492,17 +490,8 @@ static bool __do_fast_syscall_32(struct
 	 */
 	regs->ip = landing_pad;
 
-	enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	local_irq_enable();
-	success = __do_fast_syscall_32(regs);
-
-	instrumentation_end();
-	exit_to_user_mode();
-
-	/* If it failed, keep it simple: use IRET. */
-	if (!success)
+	/* Invoke the syscall. If it failed, keep it simple: use IRET. */
+	if (!__do_fast_syscall_32(regs))
 		return 0;
 
 #ifdef CONFIG_X86_64



