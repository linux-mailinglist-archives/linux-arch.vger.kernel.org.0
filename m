Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4CE394159
	for <lists+linux-arch@lfdr.de>; Fri, 28 May 2021 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbhE1KwP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 May 2021 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236340AbhE1KwP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 May 2021 06:52:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF13C061574;
        Fri, 28 May 2021 03:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u3m5wLgAjvJBHYkZOkiFus88mFUHihz/DHEHlULAQLE=; b=EDr+ac/5OoljsunqhNF0hhsz5/
        O+sZs9STR9Wgc/BfdDQOA2YH6RWtdCwFLC/QH4xwvlKtiy8RYfrYGn+jz5ARdpxCURxV5YngFivg/
        7WK4/06lOImtKZHUALWAK766wCqWgsTSPpQCIFTcSBA8b+Fpt3Z0pjtpoEnNj6btrRPSw94aiWqAq
        nXVnq0FjHJSzs9WbCJtqV+oGqem7hvIrE3ERH8EPb2O2Rjgfqs1sonH1MJwTGdFP2oNxS0vM1/kos
        rdub8ZWlEJq4+RkNdIDYi+ewmMq5hXel4U9BNwIEBJIxRogebRFmlgCsEgL+MLeKd+YY9LJi0okC3
        EXZI5+Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lma41-006VuF-Tw; Fri, 28 May 2021 10:50:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F3D330022C;
        Fri, 28 May 2021 12:50:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DDE0201DB6CE; Fri, 28 May 2021 12:50:00 +0200 (CEST)
Date:   Fri, 28 May 2021 12:49:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 16/22] sched: Defer wakeup in ttwu() for unschedulable
 frozen tasks
Message-ID: <YLDK1w3IS6cuGMKm@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YK+oSPlNQJKiMYYc@hirez.programming.kicks-ass.net>
 <YK+tV/DTNlpGJ7J8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK+tV/DTNlpGJ7J8@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 27, 2021 at 04:31:51PM +0200, Peter Zijlstra wrote:
> How's something *completely* untested like this?

I now have the below; which builds defconfig -cgroup-freezer. I've yet
to boot and test.

---
 include/linux/freezer.h | 53 +++++++++++---------------------------
 include/linux/sched.h   |  6 ++---
 init/do_mounts_initrd.c |  7 ++----
 kernel/freezer.c        | 67 ++++++++++++++++++++++++++++++-------------------
 kernel/hung_task.c      |  4 +--
 kernel/power/main.c     |  5 ++--
 kernel/power/process.c  | 10 +++-----
 kernel/sched/core.c     |  2 +-
 8 files changed, 70 insertions(+), 84 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 0621c5f86c39..cdc65bc1e081 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -8,9 +8,11 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/atomic.h>
+#include <linux/jump_label.h>
 
 #ifdef CONFIG_FREEZER
-extern atomic_t system_freezing_cnt;	/* nr of freezing conds in effect */
+DECLARE_STATIC_KEY_FALSE(freezer_active);
+
 extern bool pm_freezing;		/* PM freezing in effect */
 extern bool pm_nosig_freezing;		/* PM nosig freezing in effect */
 
@@ -24,7 +26,7 @@ extern unsigned int freeze_timeout_msecs;
  */
 static inline bool frozen(struct task_struct *p)
 {
-	return p->flags & PF_FROZEN;
+	return p->state == TASK_FROZEN;
 }
 
 extern bool freezing_slow_path(struct task_struct *p);
@@ -34,9 +36,10 @@ extern bool freezing_slow_path(struct task_struct *p);
  */
 static inline bool freezing(struct task_struct *p)
 {
-	if (likely(!atomic_read(&system_freezing_cnt)))
-		return false;
-	return freezing_slow_path(p);
+	if (static_branch_unlikely(&freezer_active))
+		return freezing_slow_path(p);
+
+	return false;
 }
 
 /* Takes and releases task alloc lock using task_lock() */
@@ -92,6 +95,8 @@ static inline bool cgroup_freezing(struct task_struct *task)
  * waking up the parent.
  */
 
+extern void __freezer_do_not_count(void);
+extern void __freezer_count(void);
 
 /**
  * freezer_do_not_count - tell freezer to ignore %current
@@ -106,7 +111,8 @@ static inline bool cgroup_freezing(struct task_struct *task)
  */
 static inline void freezer_do_not_count(void)
 {
-	current->flags |= PF_FREEZER_SKIP;
+	if (static_branch_unlikely(&freezer_active))
+		__freezer_do_not_count();
 }
 
 /**
@@ -118,47 +124,17 @@ static inline void freezer_do_not_count(void)
  */
 static inline void freezer_count(void)
 {
-	current->flags &= ~PF_FREEZER_SKIP;
-	/*
-	 * If freezing is in progress, the following paired with smp_mb()
-	 * in freezer_should_skip() ensures that either we see %true
-	 * freezing() or freezer_should_skip() sees !PF_FREEZER_SKIP.
-	 */
-	smp_mb();
-	try_to_freeze();
+	if (static_branch_unlikely(&freezer_active))
+		__freezer_count();
 }
 
 /* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */
 static inline void freezer_count_unsafe(void)
 {
-	current->flags &= ~PF_FREEZER_SKIP;
 	smp_mb();
 	try_to_freeze_unsafe();
 }
 
-/**
- * freezer_should_skip - whether to skip a task when determining frozen
- *			 state is reached
- * @p: task in quesion
- *
- * This function is used by freezers after establishing %true freezing() to
- * test whether a task should be skipped when determining the target frozen
- * state is reached.  IOW, if this function returns %true, @p is considered
- * frozen enough.
- */
-static inline bool freezer_should_skip(struct task_struct *p)
-{
-	/*
-	 * The following smp_mb() paired with the one in freezer_count()
-	 * ensures that either freezer_count() sees %true freezing() or we
-	 * see cleared %PF_FREEZER_SKIP and return %false.  This makes it
-	 * impossible for a task to slip frozen state testing after
-	 * clearing %PF_FREEZER_SKIP.
-	 */
-	smp_mb();
-	return p->flags & PF_FREEZER_SKIP;
-}
-
 /*
  * These functions are intended to be used whenever you want allow a sleeping
  * task to be frozen. Note that neither return any clear indication of
@@ -283,7 +259,6 @@ static inline bool try_to_freeze(void) { return false; }
 
 static inline void freezer_do_not_count(void) {}
 static inline void freezer_count(void) {}
-static inline int freezer_should_skip(struct task_struct *p) { return 0; }
 static inline void set_freezable(void) {}
 
 #define freezable_schedule()  schedule()
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2c881384517..744dc617dbea 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -95,7 +95,9 @@ struct task_group;
 #define TASK_WAKING			0x0200
 #define TASK_NOLOAD			0x0400
 #define TASK_NEW			0x0800
-#define TASK_STATE_MAX			0x1000
+#define TASK_MAY_FREEZE			0x1000
+#define TASK_FROZEN			0x2000
+#define TASK_STATE_MAX			0x4000
 
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
@@ -1572,7 +1574,6 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USED_ASYNC		0x00004000	/* Used async_schedule*(), used by module init */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF_FROZEN		0x00010000	/* Frozen for system suspend */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
@@ -1584,7 +1585,6 @@ extern struct pid *cad_pid;
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
 #define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
-#define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
 
 /*
diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 533d81ed74d4..2f1227053694 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -80,10 +80,9 @@ static void __init handle_initrd(void)
 	init_chdir("/old");
 
 	/*
-	 * In case that a resume from disk is carried out by linuxrc or one of
-	 * its children, we need to tell the freezer not to wait for us.
+	 * PF_FREEZER_SKIP is pointless because UMH is laundered through a
+	 * workqueue and that doesn't have the current context.
 	 */
-	current->flags |= PF_FREEZER_SKIP;
 
 	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
 					 GFP_KERNEL, init_linuxrc, NULL, NULL);
@@ -91,8 +90,6 @@ static void __init handle_initrd(void)
 		return;
 	call_usermodehelper_exec(info, UMH_WAIT_PROC);
 
-	current->flags &= ~PF_FREEZER_SKIP;
-
 	/* move initrd to rootfs' /old */
 	init_mount("..", ".", NULL, MS_MOVE, NULL);
 	/* switch root and cwd back to / of rootfs */
diff --git a/kernel/freezer.c b/kernel/freezer.c
index dc520f01f99d..e316008042df 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -13,8 +13,8 @@
 #include <linux/kthread.h>
 
 /* total number of freezing conditions in effect */
-atomic_t system_freezing_cnt = ATOMIC_INIT(0);
-EXPORT_SYMBOL(system_freezing_cnt);
+DEFINE_STATIC_KEY_FALSE(freezer_active);
+EXPORT_SYMBOL(freezer_active);
 
 /* indicate whether PM freezing is in effect, protected by
  * system_transition_mutex
@@ -29,7 +29,7 @@ static DEFINE_SPINLOCK(freezer_lock);
  * freezing_slow_path - slow path for testing whether a task needs to be frozen
  * @p: task to be tested
  *
- * This function is called by freezing() if system_freezing_cnt isn't zero
+ * This function is called by freezing() if freezer_active isn't zero
  * and tests whether @p needs to enter and stay in frozen state.  Can be
  * called under any context.  The freezers are responsible for ensuring the
  * target tasks see the updated state.
@@ -63,18 +63,13 @@ bool __refrigerator(bool check_kthr_stop)
 	pr_debug("%s entered refrigerator\n", current->comm);
 
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-
 		spin_lock_irq(&freezer_lock);
-		current->flags |= PF_FROZEN;
-		if (!freezing(current) ||
-		    (check_kthr_stop && kthread_should_stop()))
-			current->flags &= ~PF_FROZEN;
+		if (freezing(current) && (check_kthr_stop && kthread_should_stop())) {
+			set_current_state(TASK_FROZEN);
+			was_frozen = true;
+		}
 		spin_unlock_irq(&freezer_lock);
 
-		if (!(current->flags & PF_FROZEN))
-			break;
-		was_frozen = true;
 		schedule();
 	}
 
@@ -101,6 +96,38 @@ static void fake_signal_wake_up(struct task_struct *p)
 	}
 }
 
+void __freezer_do_not_count(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&current->pi_lock, flags);
+	if (current->state)
+		current->state |= TASK_MAY_FREEZE;
+	raw_spin_unlock_irqrestore(&current->pi_lock, flags);
+}
+EXPORT_SYMBOL(__freezer_do_not_count);
+
+void __freezer_count(void)
+{
+	try_to_freeze();
+}
+EXPORT_SYMBOL(__freezer_count);
+
+static bool __freeze_task(struct task_struct *p)
+{
+	unsigned long flags;
+	bool frozen = false;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	if (p->state & TASK_MAY_FREEZE) {
+		p->state = TASK_FROZEN;
+		frozen = true;
+	}
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	return frozen;
+}
+
 /**
  * freeze_task - send a freeze request to given task
  * @p: task to send the request to
@@ -116,20 +143,8 @@ bool freeze_task(struct task_struct *p)
 {
 	unsigned long flags;
 
-	/*
-	 * This check can race with freezer_do_not_count, but worst case that
-	 * will result in an extra wakeup being sent to the task.  It does not
-	 * race with freezer_count(), the barriers in freezer_count() and
-	 * freezer_should_skip() ensure that either freezer_count() sees
-	 * freezing == true in try_to_freeze() and freezes, or
-	 * freezer_should_skip() sees !PF_FREEZE_SKIP and freezes the task
-	 * normally.
-	 */
-	if (freezer_should_skip(p))
-		return false;
-
 	spin_lock_irqsave(&freezer_lock, flags);
-	if (!freezing(p) || frozen(p)) {
+	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
 		spin_unlock_irqrestore(&freezer_lock, flags);
 		return false;
 	}
@@ -149,7 +164,7 @@ void __thaw_task(struct task_struct *p)
 
 	spin_lock_irqsave(&freezer_lock, flags);
 	if (frozen(p))
-		wake_up_process(p);
+		wake_up_state(p, TASK_FROZEN);
 	spin_unlock_irqrestore(&freezer_lock, flags);
 }
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 396ebaebea3f..154cac8b805a 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -92,8 +92,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * Ensure the task is not frozen.
 	 * Also, skip vfork and any other user process that freezer should skip.
 	 */
-	if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
-	    return;
+	if (unlikely(t->state & (TASK_MAY_FREEZE | TASK_FROZEN)))
+		return;
 
 	/*
 	 * When a freshly created task is scheduled once, changes its state to
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 12c7e1bb442f..0817e3913294 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -23,7 +23,8 @@
 
 void lock_system_sleep(void)
 {
-	current->flags |= PF_FREEZER_SKIP;
+	WARN_ON_ONCE(current->flags & PF_NOFREEZE);
+	current->flags |= PF_NOFREEZE;
 	mutex_lock(&system_transition_mutex);
 }
 EXPORT_SYMBOL_GPL(lock_system_sleep);
@@ -46,7 +47,7 @@ void unlock_system_sleep(void)
 	 * Which means, if we use try_to_freeze() here, it would make them
 	 * enter the refrigerator, thus causing hibernation to lockup.
 	 */
-	current->flags &= ~PF_FREEZER_SKIP;
+	current->flags &= ~PF_NOFREEZE;
 	mutex_unlock(&system_transition_mutex);
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
diff --git a/kernel/power/process.c b/kernel/power/process.c
index 50cc63534486..36dee2dcfeab 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -53,8 +53,7 @@ static int try_to_freeze_tasks(bool user_only)
 			if (p == current || !freeze_task(p))
 				continue;
 
-			if (!freezer_should_skip(p))
-				todo++;
+			todo++;
 		}
 		read_unlock(&tasklist_lock);
 
@@ -99,8 +98,7 @@ static int try_to_freeze_tasks(bool user_only)
 		if (!wakeup || pm_debug_messages_on) {
 			read_lock(&tasklist_lock);
 			for_each_process_thread(g, p) {
-				if (p != current && !freezer_should_skip(p)
-				    && freezing(p) && !frozen(p))
+				if (p != current && freezing(p) && !frozen(p))
 					sched_show_task(p);
 			}
 			read_unlock(&tasklist_lock);
@@ -132,7 +130,7 @@ int freeze_processes(void)
 	current->flags |= PF_SUSPEND_TASK;
 
 	if (!pm_freezing)
-		atomic_inc(&system_freezing_cnt);
+		static_branch_inc(&freezer_active);
 
 	pm_wakeup_clear(true);
 	pr_info("Freezing user space processes ... ");
@@ -193,7 +191,7 @@ void thaw_processes(void)
 
 	trace_suspend_resume(TPS("thaw_processes"), 0, true);
 	if (pm_freezing)
-		atomic_dec(&system_freezing_cnt);
+		static_branch_dec(&freezer_active);
 	pm_freezing = false;
 	pm_nosig_freezing = false;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..6bc5df6f8d73 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5082,7 +5082,7 @@ static void __sched notrace __schedule(bool preempt)
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
-				!(prev->flags & PF_FROZEN);
+				!(prev_state & TASK_FROZEN);
 
 			if (prev->sched_contributes_to_load)
 				rq->nr_uninterruptible++;
