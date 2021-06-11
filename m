Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81913A3E18
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jun 2021 10:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhFKIgm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Jun 2021 04:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhFKIgl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Jun 2021 04:36:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6903EC061574;
        Fri, 11 Jun 2021 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rJpVdKSdgjpXE6p9Oop7DIQvMfxOIdi3nB3yxo4fMFE=; b=CWR8uW2z2v4Dcg+Wzx4PI0dnVw
        XoKJVqJOzxVFYD+sRtJ0FInRN4sERX02CLhxY4IIvmxWATB2eKgxL6Gpyb1H+2mYp2DTZtDIVthgE
        5Ul10rj4kp3xkVxtKQ7zdzJY0lDTzmSemg7ndBVLjAS9fpx8BnExlyCMcJu9PTJemO6Lpg6fqO0Rz
        fSm0epZHPMtHBOvtjISYY09EsR14jOzRL0xopL+wkizEfh+1OfaeYdMug8pS54ZcT2q0654uQBNJh
        W1UjAcQHOctvz45J9dVOso50uiM/3YQcHyCMe+ASOLWFLpP68WGdQ6strm9lRbkNS51xl0Xxhu6aQ
        kI5bM2wQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lrcY0-002ZVx-Ji; Fri, 11 Jun 2021 08:30:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0C0083002C6;
        Fri, 11 Jun 2021 10:29:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E3EF12BCF3930; Fri, 11 Jun 2021 10:29:42 +0200 (CEST)
Message-ID: <20210611082838.222401495@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 11 Jun 2021 10:28:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 2/7] sched: Introduce task_is_running()
References: <20210611082810.970791107@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace a bunch of 'p->state == TASK_RUNNING' with a new helper:
task_is_running(p).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/alpha/kernel/process.c    |    2 +-
 arch/arc/kernel/stacktrace.c   |    2 +-
 arch/arm/kernel/process.c      |    2 +-
 arch/arm64/kernel/process.c    |    2 +-
 arch/csky/kernel/stacktrace.c  |    2 +-
 arch/h8300/kernel/process.c    |    2 +-
 arch/hexagon/kernel/process.c  |    2 +-
 arch/ia64/kernel/process.c     |    4 ++--
 arch/m68k/kernel/process.c     |    2 +-
 arch/mips/kernel/process.c     |    2 +-
 arch/nds32/kernel/process.c    |    2 +-
 arch/nios2/kernel/process.c    |    2 +-
 arch/parisc/kernel/process.c   |    4 ++--
 arch/powerpc/kernel/process.c  |    4 ++--
 arch/riscv/kernel/stacktrace.c |    2 +-
 arch/s390/kernel/process.c     |    2 +-
 arch/s390/mm/fault.c           |    2 +-
 arch/sh/kernel/process_32.c    |    2 +-
 arch/sparc/kernel/process_32.c |    3 +--
 arch/sparc/kernel/process_64.c |    3 +--
 arch/um/kernel/process.c       |    2 +-
 arch/x86/kernel/process.c      |    4 ++--
 arch/xtensa/kernel/process.c   |    2 +-
 block/blk-mq.c                 |    2 +-
 include/linux/sched.h          |    2 ++
 kernel/kcsan/report.c          |    2 +-
 kernel/locking/lockdep.c       |    2 +-
 kernel/rcu/tree_plugin.h       |    2 +-
 kernel/sched/core.c            |    6 +++---
 kernel/sched/stats.h           |    2 +-
 kernel/signal.c                |    2 +-
 kernel/softirq.c               |    3 +--
 mm/compaction.c                |    2 +-
 33 files changed, 40 insertions(+), 41 deletions(-)

--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -380,7 +380,7 @@ get_wchan(struct task_struct *p)
 {
 	unsigned long schedule_frame;
 	unsigned long pc;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 	/*
 	 * This one depends on the frame size of schedule().  Do a
--- a/arch/arc/kernel/stacktrace.c
+++ b/arch/arc/kernel/stacktrace.c
@@ -83,7 +83,7 @@ seed_unwind_frame_info(struct task_struc
 		 *    is safe-kept and BLINK at a well known location in there
 		 */
 
-		if (tsk->state == TASK_RUNNING)
+		if (task_is_running(tsk))
 			return -1;
 
 		frame_info->task = tsk;
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -288,7 +288,7 @@ unsigned long get_wchan(struct task_stru
 	struct stackframe frame;
 	unsigned long stack_page;
 	int count = 0;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	frame.fp = thread_saved_fp(p);
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -598,7 +598,7 @@ unsigned long get_wchan(struct task_stru
 	struct stackframe frame;
 	unsigned long stack_page, ret = 0;
 	int count = 0;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)try_get_task_stack(p);
--- a/arch/csky/kernel/stacktrace.c
+++ b/arch/csky/kernel/stacktrace.c
@@ -115,7 +115,7 @@ unsigned long get_wchan(struct task_stru
 {
 	unsigned long pc = 0;
 
-	if (likely(task && task != current && task->state != TASK_RUNNING))
+	if (likely(task && task != current && !task_is_running(task)))
 		walk_stackframe(task, NULL, save_wchan, &pc);
 	return pc;
 }
--- a/arch/h8300/kernel/process.c
+++ b/arch/h8300/kernel/process.c
@@ -134,7 +134,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long stack_page;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)p;
--- a/arch/hexagon/kernel/process.c
+++ b/arch/hexagon/kernel/process.c
@@ -135,7 +135,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count = 0;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)task_stack_page(p);
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -529,7 +529,7 @@ get_wchan (struct task_struct *p)
 	unsigned long ip;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	/*
@@ -542,7 +542,7 @@ get_wchan (struct task_struct *p)
 	 */
 	unw_init_from_blocked_task(&info, p);
 	do {
-		if (p->state == TASK_RUNNING)
+		if (task_is_running(p))
 			return 0;
 		if (unw_unwind(&info) < 0)
 			return 0;
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -268,7 +268,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long fp, pc;
 	unsigned long stack_page;
 	int count = 0;
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)task_stack_page(p);
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -662,7 +662,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long ra = 0;
 #endif
 
-	if (!task || task == current || task->state == TASK_RUNNING)
+	if (!task || task == current || task_is_running(task))
 		goto out;
 	if (!task_stack_page(task))
 		goto out;
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -239,7 +239,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long stack_start, stack_end;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	if (IS_ENABLED(CONFIG_FRAME_POINTER)) {
--- a/arch/nios2/kernel/process.c
+++ b/arch/nios2/kernel/process.c
@@ -223,7 +223,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long stack_page;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long)p;
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -249,7 +249,7 @@ get_wchan(struct task_struct *p)
 	unsigned long ip;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	/*
@@ -260,7 +260,7 @@ get_wchan(struct task_struct *p)
 	do {
 		if (unwind_once(&info) < 0)
 			return 0;
-		if (p->state == TASK_RUNNING)
+		if (task_is_running(p))
                         return 0;
 		ip = info.ip;
 		if (!in_sched_functions(ip))
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2084,7 +2084,7 @@ static unsigned long __get_wchan(struct
 	unsigned long ip, sp;
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	sp = p->thread.ksp;
@@ -2094,7 +2094,7 @@ static unsigned long __get_wchan(struct
 	do {
 		sp = *(unsigned long *)sp;
 		if (!validate_sp(sp, p, STACK_FRAME_OVERHEAD) ||
-		    p->state == TASK_RUNNING)
+		    task_is_running(p))
 			return 0;
 		if (count > 0) {
 			ip = ((unsigned long *)sp)[STACK_FRAME_LR_SAVE];
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -132,7 +132,7 @@ unsigned long get_wchan(struct task_stru
 {
 	unsigned long pc = 0;
 
-	if (likely(task && task != current && task->state != TASK_RUNNING))
+	if (likely(task && task != current && !task_is_running(task)))
 		walk_stackframe(task, NULL, save_wchan, &pc);
 	return pc;
 }
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -180,7 +180,7 @@ unsigned long get_wchan(struct task_stru
 	struct unwind_state state;
 	unsigned long ip = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING || !task_stack_page(p))
+	if (!p || p == current || task_is_running(p) || !task_stack_page(p))
 		return 0;
 
 	if (!try_get_task_stack(p))
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -702,7 +702,7 @@ static void pfault_interrupt(struct ext_
 			 * interrupt since it must be a leftover of a PFAULT
 			 * CANCEL operation which didn't remove all pending
 			 * completion interrupts. */
-			if (tsk->state == TASK_RUNNING)
+			if (task_is_running(tsk))
 				tsk->thread.pfault_wait = -1;
 		}
 	} else {
--- a/arch/sh/kernel/process_32.c
+++ b/arch/sh/kernel/process_32.c
@@ -186,7 +186,7 @@ unsigned long get_wchan(struct task_stru
 {
 	unsigned long pc;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	/*
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -376,8 +376,7 @@ unsigned long get_wchan(struct task_stru
 	struct reg_window32 *rw;
 	int count = 0;
 
-	if (!task || task == current ||
-            task->state == TASK_RUNNING)
+	if (!task || task == current || task_is_running(task))
 		goto out;
 
 	fp = task_thread_info(task)->ksp + bias;
--- a/arch/sparc/kernel/process_64.c
+++ b/arch/sparc/kernel/process_64.c
@@ -674,8 +674,7 @@ unsigned long get_wchan(struct task_stru
         unsigned long ret = 0;
 	int count = 0; 
 
-	if (!task || task == current ||
-            task->state == TASK_RUNNING)
+	if (!task || task == current || task_is_running(task))
 		goto out;
 
 	tp = task_thread_info(task);
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -369,7 +369,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long stack_page, sp, ip;
 	bool seen_sched = 0;
 
-	if ((p == NULL) || (p == current) || (p->state == TASK_RUNNING))
+	if ((p == NULL) || (p == current) || task_is_running(p))
 		return 0;
 
 	stack_page = (unsigned long) task_stack_page(p);
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -931,7 +931,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
 	int count = 0;
 
-	if (p == current || p->state == TASK_RUNNING)
+	if (p == current || task_is_running(p))
 		return 0;
 
 	if (!try_get_task_stack(p))
@@ -975,7 +975,7 @@ unsigned long get_wchan(struct task_stru
 			goto out;
 		}
 		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
-	} while (count++ < 16 && p->state != TASK_RUNNING);
+	} while (count++ < 16 && !task_is_running(p));
 
 out:
 	put_task_stack(p);
--- a/arch/xtensa/kernel/process.c
+++ b/arch/xtensa/kernel/process.c
@@ -304,7 +304,7 @@ unsigned long get_wchan(struct task_stru
 	unsigned long stack_page = (unsigned long) task_stack_page(p);
 	int count = 0;
 
-	if (!p || p == current || p->state == TASK_RUNNING)
+	if (!p || p == current || task_is_running(p))
 		return 0;
 
 	sp = p->thread.sp;
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3926,7 +3926,7 @@ int blk_poll(struct request_queue *q, bl
 		if (signal_pending_state(state, current))
 			__set_current_state(TASK_RUNNING);
 
-		if (current->state == TASK_RUNNING)
+		if (task_is_running(current))
 			return 1;
 		if (ret < 0 || !spin)
 			break;
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -113,6 +113,8 @@ struct task_group;
 					 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
 					 TASK_PARKED)
 
+#define task_is_running(task)		(READ_ONCE((task)->state) == TASK_RUNNING)
+
 #define task_is_traced(task)		((task->state & __TASK_TRACED) != 0)
 
 #define task_is_stopped(task)		((task->state & __TASK_STOPPED) != 0)
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -460,7 +460,7 @@ static void set_other_info_task_blocking
 	 * We may be instrumenting a code-path where current->state is already
 	 * something other than TASK_RUNNING.
 	 */
-	const bool is_running = current->state == TASK_RUNNING;
+	const bool is_running = task_is_running(current);
 	/*
 	 * To avoid deadlock in case we are in an interrupt here and this is a
 	 * race with a task on the same CPU (KCSAN_INTERRUPT_WATCHER), provide a
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -760,7 +760,7 @@ static void lockdep_print_held_locks(str
 	 * It's not reliable to print a task's held locks if it's not sleeping
 	 * and it's not the current task.
 	 */
-	if (p->state == TASK_RUNNING && p != current)
+	if (p != current && task_is_running(p))
 		return;
 	for (i = 0; i < depth; i++) {
 		printk(" #%d: ", i);
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2768,7 +2768,7 @@ EXPORT_SYMBOL_GPL(rcu_bind_current_to_no
 #ifdef CONFIG_SMP
 static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
 {
-	return tsp && tsp->state == TASK_RUNNING && !tsp->on_cpu ? "!" : "";
+	return tsp && task_is_running(tsp) && !tsp->on_cpu ? "!" : "";
 }
 #else // #ifdef CONFIG_SMP
 static char *show_rcu_should_be_on_cpu(struct task_struct *tsp)
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5989,7 +5989,7 @@ static inline void sched_submit_work(str
 {
 	unsigned int task_flags;
 
-	if (!tsk->state)
+	if (task_is_running(tsk))
 		return;
 
 	task_flags = tsk->flags;
@@ -7964,7 +7964,7 @@ int __sched yield_to(struct task_struct
 	if (curr->sched_class != p->sched_class)
 		goto out_unlock;
 
-	if (task_running(p_rq, p) || p->state)
+	if (task_running(p_rq, p) || !task_is_running(p))
 		goto out_unlock;
 
 	yielded = curr->sched_class->yield_to_task(rq, p);
@@ -8167,7 +8167,7 @@ void sched_show_task(struct task_struct
 
 	pr_info("task:%-15.15s state:%c", p->comm, task_state_to_char(p));
 
-	if (p->state == TASK_RUNNING)
+	if (task_is_running(p))
 		pr_cont("  running task    ");
 #ifdef CONFIG_DEBUG_STACK_USAGE
 	free = stack_not_used(p);
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -217,7 +217,7 @@ static inline void sched_info_depart(str
 
 	rq_sched_info_depart(rq, delta);
 
-	if (t->state == TASK_RUNNING)
+	if (task_is_running(t))
 		sched_info_enqueue(rq, t);
 }
 
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -4719,7 +4719,7 @@ void kdb_send_sig(struct task_struct *t,
 	}
 	new_t = kdb_prev_t != t;
 	kdb_prev_t = t;
-	if (t->state != TASK_RUNNING && new_t) {
+	if (!task_is_running(t) && new_t) {
 		spin_unlock(&t->sighand->siglock);
 		kdb_printf("Process is not RUNNING, sending a signal from "
 			   "kdb risks deadlock\n"
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,8 +92,7 @@ static bool ksoftirqd_running(unsigned l
 
 	if (pending & SOFTIRQ_NOW_MASK)
 		return false;
-	return tsk && (tsk->state == TASK_RUNNING) &&
-		!__kthread_should_park(tsk);
+	return tsk && task_is_running(tsk) && !__kthread_should_park(tsk);
 }
 
 #ifdef CONFIG_TRACE_IRQFLAGS
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1955,7 +1955,7 @@ static inline bool is_via_compact_memory
 
 static bool kswapd_is_running(pg_data_t *pgdat)
 {
-	return pgdat->kswapd && (pgdat->kswapd->state == TASK_RUNNING);
+	return pgdat->kswapd && task_is_running(pgdat->kswapd);
 }
 
 /*


