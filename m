Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908AA4379EB
	for <lists+linux-arch@lfdr.de>; Fri, 22 Oct 2021 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhJVPbE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Oct 2021 11:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbhJVPbD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Oct 2021 11:31:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DA5C061766;
        Fri, 22 Oct 2021 08:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pFVW69OOchUF+9Dn4vW0LtEN8i6v/6r4Mtie2H7jKuE=; b=n7OnwmfoKIVkI5OzBLSxphFHlB
        pfG8irCLwpjLOY/dfJg83a7RQMyOmaPtYgV5myr22dTOhdNlOn4m7m6Wf9nsXfE2erKk9Xq6rd5wm
        rnvRZgUfFrpm8Hzb629fmwmNXc1SJiXjaiGczzWhdxWXs7FpuwoknE7oekBHTunOUs9petG9L7zIK
        HBZ+b8w9p6tL0FsyCeu2oLJYBoTWlFRFf4oMpqY+blYuerO17oxNI0f8B6//8a1p6MTkxZ8Tb+ekV
        Nk5/8KFmdv3wcJPSZ+oABDqWVRj/eYlKWLE2dDJp4aqWrAD6hbEcaUv9X9qsYdaErELGe+5mkh3UB
        Fug2+RyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdwOE-00DyY7-34; Fri, 22 Oct 2021 15:23:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 85EB33005CB;
        Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 65E092C0CA17D; Fri, 22 Oct 2021 17:23:23 +0200 (CEST)
Message-ID: <20211022152104.215612498@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 22 Oct 2021 17:09:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: [PATCH 2/7] stacktrace,sched: Make stack_trace_save_tsk() more robust
References: <20211022150933.883959987@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Recent patches to get_wchan() made it more robust by only doing the
unwind when the task was blocked and serialized against wakeups.

Extract this functionality as a simpler companion to task_call_func()
named task_try_func() that really only cares about blocked tasks. Then
employ this new function to implement the same robustness for
ARCH_STACKWALK based stack_trace_save_tsk().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/wait.h |    1 
 kernel/sched/core.c  |   62 ++++++++++++++++++++++++++++++++++++++++++++-------
 kernel/stacktrace.c  |   13 ++++++----
 3 files changed, 63 insertions(+), 13 deletions(-)

--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1162,5 +1162,6 @@ int autoremove_wake_function(struct wait
 
 typedef int (*task_call_f)(struct task_struct *p, void *arg);
 extern int task_call_func(struct task_struct *p, task_call_f func, void *arg);
+extern int task_try_func(struct task_struct *p, task_call_f func, void *arg);
 
 #endif /* _LINUX_WAIT_H */
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1966,21 +1966,21 @@ bool sched_task_on_rq(struct task_struct
 	return task_on_rq_queued(p);
 }
 
+static int try_get_wchan(struct task_struct *p, void *arg)
+{
+	unsigned long *wchan = arg;
+	*wchan = __get_wchan(p);
+	return 0;
+}
+
 unsigned long get_wchan(struct task_struct *p)
 {
 	unsigned long ip = 0;
-	unsigned int state;
 
 	if (!p || p == current)
 		return 0;
 
-	/* Only get wchan if task is blocked and we can keep it that way. */
-	raw_spin_lock_irq(&p->pi_lock);
-	state = READ_ONCE(p->__state);
-	smp_rmb(); /* see try_to_wake_up() */
-	if (state != TASK_RUNNING && state != TASK_WAKING && !p->on_rq)
-		ip = __get_wchan(p);
-	raw_spin_unlock_irq(&p->pi_lock);
+	task_try_func(p, try_get_wchan, &ip);
 
 	return ip;
 }
@@ -4184,6 +4184,52 @@ int task_call_func(struct task_struct *p
 	return ret;
 }
 
+/*
+ * task_try_func - Invoke a function on task in blocked state
+ * @p: Process for which the function is to be invoked
+ * @func: Function to invoke
+ * @arg: Argument to function
+ *
+ * Fix the task in a blocked state, when possible. And if so, invoke @func on it.
+ *
+ * Returns:
+ *  -EBUSY or whatever @func returns
+ */
+int task_try_func(struct task_struct *p, task_call_f func, void *arg)
+{
+	unsigned long flags;
+	unsigned int state;
+	int ret = -EBUSY;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+
+	state = READ_ONCE(p->__state);
+
+	/*
+	 * Ensure we load p->on_rq after p->__state, otherwise it would be
+	 * possible to, falsely, observe p->on_rq == 0.
+	 *
+	 * See try_to_wake_up() for a longer comment.
+	 */
+	smp_rmb();
+
+	/*
+	 * Since pi->lock blocks try_to_wake_up(), we don't need rq->lock when
+	 * the task is blocked. Make sure to check @state since ttwu() can drop
+	 * locks at the end, see ttwu_queue_wakelist().
+	 */
+	if (state != TASK_RUNNING && state != TASK_WAKING && !p->on_rq) {
+		/*
+		 * The task is blocked and we're holding off wakeupsr. For any
+		 * of the other task states, see task_call_func().
+		 */
+		ret = func(p, arg);
+	}
+
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	return ret;
+}
+
 /**
  * wake_up_process - Wake up a specific process
  * @p: The process to be woken up.
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -123,6 +123,13 @@ unsigned int stack_trace_save(unsigned l
 }
 EXPORT_SYMBOL_GPL(stack_trace_save);
 
+static int try_arch_stack_walk_tsk(struct task_struct *tsk, void *arg)
+{
+	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
+	arch_stack_walk(consume_entry, arg, tsk, NULL);
+	return 0;
+}
+
 /**
  * stack_trace_save_tsk - Save a task stack trace into a storage array
  * @task:	The task to examine
@@ -135,7 +142,6 @@ EXPORT_SYMBOL_GPL(stack_trace_save);
 unsigned int stack_trace_save_tsk(struct task_struct *tsk, unsigned long *store,
 				  unsigned int size, unsigned int skipnr)
 {
-	stack_trace_consume_fn consume_entry = stack_trace_consume_entry_nosched;
 	struct stacktrace_cookie c = {
 		.store	= store,
 		.size	= size,
@@ -143,11 +149,8 @@ unsigned int stack_trace_save_tsk(struct
 		.skip	= skipnr + (current == tsk),
 	};
 
-	if (!try_get_task_stack(tsk))
-		return 0;
+	task_try_func(tsk, try_arch_stack_walk_tsk, &c);
 
-	arch_stack_walk(consume_entry, &c, tsk, NULL);
-	put_task_stack(tsk);
 	return c.len;
 }
 


