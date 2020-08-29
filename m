Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB01F25696E
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 19:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgH2RbD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Aug 2020 13:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728139AbgH2RbD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 29 Aug 2020 13:31:03 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C4220757;
        Sat, 29 Aug 2020 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598722261;
        bh=MIejLqCcrs1VRg7ixEsu20TKbHNfmfOmpymgis+xDAs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vrnNntjzOiZFvoYkZ0iQ4dzR5oKfwpzgI5nJ9G/vAV5m+TX0viJULfFgV2x2xy5eG
         BWafutq7HG2YAtPUbP0YhJHJ4arzKJwJ618fzvyM9TCQelSoSebEZuN62wGRbT5mYb
         BMgwyoEcP9NZBzr46+AUyX1/I854yqP3uc4f8TwQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BD3773523112; Sat, 29 Aug 2020 10:31:00 -0700 (PDT)
Date:   Sat, 29 Aug 2020 10:31:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org
Subject: Re: [PATCH v4 18/23] sched: Fix try_invoke_on_locked_down_task()
 semantics
Message-ID: <20200829173100.GS2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
 <159861779482.992023.8503137488052381952.stgit@devnote2>
 <20200829110155.70c676520ad2cfef8374171d@kernel.org>
 <20200829073049.GC2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829073049.GC2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 29, 2020 at 09:30:49AM +0200, peterz@infradead.org wrote:
> On Sat, Aug 29, 2020 at 11:01:55AM +0900, Masami Hiramatsu wrote:
> > On Fri, 28 Aug 2020 21:29:55 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > In the next version I will drop this since I will merge the kretprobe_holder
> > things into removing kretporbe hash patch.
> > 
> > However, this patch itself seems fixing a bug of commit 2beaf3280e57
> > ("sched/core: Add function to sample state of locked-down task").
> > Peter, could you push this separately?
> 
> Yeah, Paul and me have a slightly different version for that, this also
> changes semantics we're still bickering over ;-)
> 
> But yes, I'll take care of it.

For whatever it is worth, I ended up back at your original patch with
one change to the header comment, as shown below.  Does this work for you?

							Thanx, Paul

------------------------------------------------------------------------

commit 3f73a1137f8e999a606357064ebd914cf5f2c897
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Sat Aug 29 10:22:24 2020 -0700

    sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled
    
    The try_invoke_on_locked_down_task() function currently requires
    that interrupts be enabled, but it is called with interrupts
    disabled from rcu_print_task_stall(), resulting in an "IRQs not
    enabled as expected" diagnostic.  This commit therefore updates
    try_invoke_on_locked_down_task() to use raw_spin_lock_irqsave() instead
    of raw_spin_lock_irq(), thus allowing use from either context.
    
    Link: https://lore.kernel.org/lkml/000000000000903d5805ab908fc4@google.com/
    Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
    Not-signed-off-by: Peter Zijlstra <peterz@infradead.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8471a0f..a814028 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2988,7 +2988,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 
 /**
  * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
- * @p: Process for which the function is to be invoked.
+ * @p: Process for which the function is to be invoked, can be @current.
  * @func: Function to invoke.
  * @arg: Argument to function.
  *
@@ -3006,12 +3006,11 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
-	bool ret = false;
 	struct rq_flags rf;
+	bool ret = false;
 	struct rq *rq;
 
-	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (p->on_rq) {
 		rq = __task_rq_lock(p, &rf);
 		if (task_rq(p) == rq)
@@ -3028,7 +3027,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 				ret = func(p, arg);
 		}
 	}
-	raw_spin_unlock_irq(&p->pi_lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
 
