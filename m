Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0307C167F46
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgBUNv7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:51:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56312 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgBUNu1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=qSxh1JDkdSLbgxbvFaVDkpxSLx98JO+1nlcRpgGZvVE=; b=YfjBwXrCBIp8elkSrkXmGgkO0V
        be0yZt35oIwjxbJQNrIuY0o1orNPa9FcfXYhEApIObNUlNEV6O++q7hcnObtLbKFYIKfYAP3DpRym
        wH2Y40LOpsVAY0stzNHRv7wHgQP58UMS43S1Rv4IL17MHYuKJRx5pMZ6xsIEbKmJLjhTy99tFrR7A
        XkYcgOfWXzj5lTnZCF5aM6zaf3x7LlslFMUdc1meoCYwxVwS+6ttkjsEFoaXrf2OSonek9ikVVQx+
        jiDwlSjw9GXe2DfsPDIDkd0tUiXagB0HDitoGVwmg0MIMsG2h7vfa1GoKHPfvRJcpN9J+MULEFnNB
        KHzEyCNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j58gt-0000OS-O0; Fri, 21 Feb 2020 13:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86C9930610C;
        Fri, 21 Feb 2020 14:48:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B43F029B5903E; Fri, 21 Feb 2020 14:50:00 +0100 (CET)
Message-Id: <20200221134215.264229755@infradead.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Feb 2020 14:34:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: [PATCH v4 04/27] x86/mce: Delete ist_begin_non_atomic()
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It is an abomination; and in prepration of removing the whole
ist_enter() thing, it needs to go.

Convert #MC over to using task_work_add() instead; it will run the
same code slightly later, on the return to user path of the same
exception.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/traps.h   |    2 -
 arch/x86/kernel/cpu/mce/core.c |   53 +++++++++++++++++++++++------------------
 arch/x86/kernel/traps.c        |   37 ----------------------------
 include/linux/sched.h          |    6 ++++
 4 files changed, 36 insertions(+), 62 deletions(-)

--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -123,8 +123,6 @@ asmlinkage void smp_irq_move_cleanup_int
 
 extern void ist_enter(struct pt_regs *regs);
 extern void ist_exit(struct pt_regs *regs);
-extern void ist_begin_non_atomic(struct pt_regs *regs);
-extern void ist_end_non_atomic(void);
 
 #ifdef CONFIG_VMAP_STACK
 void __noreturn handle_stack_overflow(const char *message,
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -42,6 +42,7 @@
 #include <linux/export.h>
 #include <linux/jump_label.h>
 #include <linux/set_memory.h>
+#include <linux/task_work.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -1084,23 +1085,6 @@ static void mce_clear_state(unsigned lon
 	}
 }
 
-static int do_memory_failure(struct mce *m)
-{
-	int flags = MF_ACTION_REQUIRED;
-	int ret;
-
-	pr_err("Uncorrected hardware memory error in user-access at %llx", m->addr);
-	if (!(m->mcgstatus & MCG_STATUS_RIPV))
-		flags |= MF_MUST_KILL;
-	ret = memory_failure(m->addr >> PAGE_SHIFT, flags);
-	if (ret)
-		pr_err("Memory error not recovered");
-	else
-		set_mce_nospec(m->addr >> PAGE_SHIFT);
-	return ret;
-}
-
-
 /*
  * Cases where we avoid rendezvous handler timeout:
  * 1) If this CPU is offline.
@@ -1202,6 +1186,29 @@ static void __mc_scan_banks(struct mce *
 	*m = *final;
 }
 
+static void kill_me_now(struct callback_head *ch)
+{
+	force_sig(SIGBUS);
+}
+
+static void kill_me_maybe(struct callback_head *cb)
+{
+	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
+	int flags = MF_ACTION_REQUIRED;
+
+	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
+	if (!(p->mce_status & MCG_STATUS_RIPV))
+		flags |= MF_MUST_KILL;
+
+	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags)) {
+		set_mce_nospec(p->mce_addr >> PAGE_SHIFT);
+		return;
+	}
+
+	pr_err("Memory error not recovered");
+	kill_me_now(cb);
+}
+
 /*
  * The actual machine check handler. This only handles real
  * exceptions when something got corrupted coming in through int 18.
@@ -1344,13 +1351,13 @@ void do_machine_check(struct pt_regs *re
 
 	/* Fault was in user mode and we need to take some action */
 	if ((m.cs & 3) == 3) {
-		ist_begin_non_atomic(regs);
-		local_irq_enable();
+		current->mce_addr = m.addr;
+		current->mce_status = m.mcgstatus;
+		current->mce_kill_me.func = kill_me_maybe;
+		if (kill_it)
+			current->mce_kill_me.func = kill_me_now;
 
-		if (kill_it || do_memory_failure(&m))
-			force_sig(SIGBUS);
-		local_irq_disable();
-		ist_end_non_atomic();
+		task_work_add(current, &current->mce_kill_me, true);
 	} else {
 		if (!fixup_exception(regs, X86_TRAP_MC, error_code, 0))
 			mce_panic("Failed kernel mode recovery", &m, msg);
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -117,43 +117,6 @@ void ist_exit(struct pt_regs *regs)
 		rcu_nmi_exit();
 }
 
-/**
- * ist_begin_non_atomic() - begin a non-atomic section in an IST exception
- * @regs:	regs passed to the IST exception handler
- *
- * IST exception handlers normally cannot schedule.  As a special
- * exception, if the exception interrupted userspace code (i.e.
- * user_mode(regs) would return true) and the exception was not
- * a double fault, it can be safe to schedule.  ist_begin_non_atomic()
- * begins a non-atomic section within an ist_enter()/ist_exit() region.
- * Callers are responsible for enabling interrupts themselves inside
- * the non-atomic section, and callers must call ist_end_non_atomic()
- * before ist_exit().
- */
-void ist_begin_non_atomic(struct pt_regs *regs)
-{
-	BUG_ON(!user_mode(regs));
-
-	/*
-	 * Sanity check: we need to be on the normal thread stack.  This
-	 * will catch asm bugs and any attempt to use ist_preempt_enable
-	 * from double_fault.
-	 */
-	BUG_ON(!on_thread_stack());
-
-	preempt_enable_no_resched();
-}
-
-/**
- * ist_end_non_atomic() - begin a non-atomic section in an IST exception
- *
- * Ends a non-atomic section started with ist_begin_non_atomic().
- */
-void ist_end_non_atomic(void)
-{
-	preempt_disable();
-}
-
 int is_valid_bugaddr(unsigned long addr)
 {
 	unsigned short ud;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1285,6 +1285,12 @@ struct task_struct {
 	unsigned long			prev_lowest_stack;
 #endif
 
+#ifdef CONFIG_X86_MCE
+	u64				mce_addr;
+	u64				mce_status;
+	struct callback_head		mce_kill_me;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.


