Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B793930F1
	for <lists+linux-arch@lfdr.de>; Thu, 27 May 2021 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhE0OeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 May 2021 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbhE0OeB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 May 2021 10:34:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED7C061574;
        Thu, 27 May 2021 07:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wBOb0pLdklXznCRn8ZX6JMKIhvwMbGAA3q/Mabl/4g8=; b=mAqzebLVJL6NNkFF6KOFv3Il4s
        yValS6QmukypBsNnt6EZH/nH3ybLvdrikVXAZjSZcsTR3Ts1UodBN8NNHWTpl8ICNXuAZxZx1oFSX
        biurVrvgi2wQq2ZP0pbQtIirPxOyhrxih6cR3KNirKPBs0hwGuVx0kvFgA3GYKbTSgqSgv23fdWsD
        50eEAKi2r1K/HMak1iTvU04pQDtAuScVVfoimkpfXfvovAPSlCZaI+Al4MnZr8j1unOBO+IYqFRbq
        zsuqhhMTCAQQonb007q6xrd+VnuCnU0kHdQiu5+/YtE6CTnWQgybgTTPsoaFmk1G7QY4xgY8IJeJy
        7Z+uMwJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmH3A-005czd-4q; Thu, 27 May 2021 14:32:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6F989300221;
        Thu, 27 May 2021 16:31:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 53D842018A4F3; Thu, 27 May 2021 16:31:51 +0200 (CEST)
Date:   Thu, 27 May 2021 16:31:51 +0200
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
Message-ID: <YK+tV/DTNlpGJ7J8@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YK+oSPlNQJKiMYYc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK+oSPlNQJKiMYYc@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 27, 2021 at 04:10:16PM +0200, Peter Zijlstra wrote:
> On Tue, May 25, 2021 at 04:14:26PM +0100, Will Deacon wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 42e2aecf087c..6cb9677d635a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3529,6 +3529,19 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> >  	if (!(p->state & state))
> >  		goto unlock;
> >  
> > +#ifdef CONFIG_FREEZER
> > +	/*
> > +	 * If we're going to wake up a thread which may be frozen, then
> > +	 * we can only do so if we have an active CPU which is capable of
> > +	 * running it. This may not be the case when resuming from suspend,
> > +	 * as the secondary CPUs may not yet be back online. See __thaw_task()
> > +	 * for the actual wakeup.
> > +	 */
> > +	if (unlikely(frozen_or_skipped(p)) &&
> > +	    !cpumask_intersects(cpu_active_mask, task_cpu_possible_mask(p)))
> > +		goto unlock;
> > +#endif
> > +
> >  	trace_sched_waking(p);
> >  
> >  	/* We're going to change ->state: */
> 
> OK, I really hate this. This is slowing down the very hot wakeup path
> for the silly freezer that *never* happens. Let me try and figure out if
> there's another option.


How's something *completely* untested like this?

---
diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 0621c5f86c39..44ece41c3db3 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -24,7 +24,7 @@ extern unsigned int freeze_timeout_msecs;
  */
 static inline bool frozen(struct task_struct *p)
 {
-	return p->flags & PF_FROZEN;
+	return p->state == TASK_FROZEN;
 }
 
 extern bool freezing_slow_path(struct task_struct *p);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2982cfab1ae9..7e7775c5b742 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -95,7 +95,8 @@ struct task_group;
 #define TASK_WAKING			0x0200
 #define TASK_NOLOAD			0x0400
 #define TASK_NEW			0x0800
-#define TASK_STATE_MAX			0x1000
+#define TASK_FROZEN			0x1000
+#define TASK_STATE_MAX			0x2000
 
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
@@ -1579,7 +1580,6 @@ extern struct pid *cad_pid;
 #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
 #define PF_USED_ASYNC		0x00004000	/* Used async_schedule*(), used by module init */
 #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
-#define PF_FROZEN		0x00010000	/* Frozen for system suspend */
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
diff --git a/kernel/freezer.c b/kernel/freezer.c
index dc520f01f99d..be6c86078510 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
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
 
@@ -149,7 +144,7 @@ void __thaw_task(struct task_struct *p)
 
 	spin_lock_irqsave(&freezer_lock, flags);
 	if (frozen(p))
-		wake_up_process(p);
+		wake_up_state(p, TASK_FROZEN);
 	spin_unlock_irqrestore(&freezer_lock, flags);
 }
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 396ebaebea3f..71a6509f8d4f 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -92,8 +92,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * Ensure the task is not frozen.
 	 * Also, skip vfork and any other user process that freezer should skip.
 	 */
-	if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
-	    return;
+	if (unlikely((t->flags & PF_FREEZER_SKIP) || frozen(t)))
+		return;
 
 	/*
 	 * When a freshly created task is scheduled once, changes its state to
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 401f012349d1..1eedf6a044f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5889,7 +5889,7 @@ static void __sched notrace __schedule(bool preempt)
 			prev->sched_contributes_to_load =
 				(prev_state & TASK_UNINTERRUPTIBLE) &&
 				!(prev_state & TASK_NOLOAD) &&
-				!(prev->flags & PF_FROZEN);
+				!(prev_state & TASK_FROZEN);
 
 			if (prev->sched_contributes_to_load)
 				rq->nr_uninterruptible++;
