Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F9FEC692
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2019 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfKAQVK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Nov 2019 12:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbfKAQVK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 1 Nov 2019 12:21:10 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CA4F20650;
        Fri,  1 Nov 2019 16:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572625269;
        bh=k12AzSAqxdxy32Yrt7DJQNzY1udksse6xWrpXXTEWnU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=anLJEMRtloI7RkTSHP12Kyp2r1zIvTpZexrLuGP0q2uXrW4xmbjoCE16eoHiW9GcP
         +FQHZukmxICpGUElcCDkgTyPsDM8RdhDv3IYUFuzPQ6MJEwMaZ3OYVrspGeABZO0Q5
         e3dbHPEe5lxcZAwtXLQTFGvsIjiOJzKwKQ3qDdgY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 403483520744; Fri,  1 Nov 2019 09:21:09 -0700 (PDT)
Date:   Fri, 1 Nov 2019 09:21:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Rik van Riel <riel@surriel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Jann Horn <jannh@google.com>,
        David Windsor <dwindsor@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Yuyang Du <duyuyang@gmail.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>, rcu@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 11/11] x86,rcu: use percpu rcu_preempt_depth
Message-ID: <20191101162109.GN20975@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20191031100806.1326-1-laijs@linux.alibaba.com>
 <20191031100806.1326-12-laijs@linux.alibaba.com>
 <20191101125816.GD17910@paulmck-ThinkPad-P72>
 <20191101131315.GY4131@hirez.programming.kicks-ass.net>
 <20191101143036.GM20975@paulmck-ThinkPad-P72>
 <06b15cfa-620f-d6b1-61d1-8ddfba74a2c8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06b15cfa-620f-d6b1-61d1-8ddfba74a2c8@linux.alibaba.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 01, 2019 at 11:32:32PM +0800, Lai Jiangshan wrote:
> 
> 
> On 2019/11/1 10:30 下午, Paul E. McKenney wrote:
> > On Fri, Nov 01, 2019 at 02:13:15PM +0100, Peter Zijlstra wrote:
> > > On Fri, Nov 01, 2019 at 05:58:16AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Oct 31, 2019 at 10:08:06AM +0000, Lai Jiangshan wrote:
> > > > > +/* We mask the RCU_NEED_SPECIAL bit so that it return real depth */
> > > > > +static __always_inline int rcu_preempt_depth(void)
> > > > > +{
> > > > > +	return raw_cpu_read_4(__rcu_preempt_depth) & ~RCU_NEED_SPECIAL;
> > > > 
> > > > Why not raw_cpu_generic_read()?
> > > > 
> > > > OK, OK, I get that raw_cpu_read_4() translates directly into an "mov"
> > > > instruction on x86, but given that x86 percpu_from_op() is able to
> > > > adjust based on operand size, why doesn't something like raw_cpu_read()
> > > > also have an x86-specific definition that adjusts based on operand size?
> > > 
> > > The reason for preempt.h was header recursion hell.
> > 
> > Fair enough, being as that is also the reason for _rcu_read_lock()
> > not being inlined.  :-/
> > 
> > > > > +}
> > > > > +
> > > > > +static __always_inline void rcu_preempt_depth_set(int pc)
> > > > > +{
> > > > > +	int old, new;
> > > > > +
> > > > > +	do {
> > > > > +		old = raw_cpu_read_4(__rcu_preempt_depth);
> > > > > +		new = (old & RCU_NEED_SPECIAL) |
> > > > > +			(pc & ~RCU_NEED_SPECIAL);
> > > > > +	} while (raw_cpu_cmpxchg_4(__rcu_preempt_depth, old, new) != old);
> > > > 
> > > > Ummm...
> > > > 
> > > > OK, as you know, I have long wanted _rcu_read_lock() to be inlineable.
> > > > But are you -sure- that an x86 cmpxchg is faster than a function call
> > > > and return?  I have strong doubts on that score.
> > > 
> > > This is a regular CMPXCHG instruction, not a LOCK prefixed one, and that
> > > should make all the difference
> > 
> > Yes, understood, but this is also adding some arithmetic, a comparison,
> > and a conditional branch.  Are you -sure- that this is cheaper than
> > an unconditional call and return?
> 
> rcu_preempt_depth_set() is used only for exit_rcu().
> The performance doesn't matter here. And since RCU_NEED_SPECIAL
> bit is allowed to lost in exit_rcu(), rcu_preempt_depth_set()
> can be a single raw_cpu_write_4() if the performance is matter.

That code only executes if there is a bug involving a missing
rcu_read_unlock(), but in that case it would be necessary to keep the
check of ->rcu_read_lock_special.b.blocked due to the possibility that
the exiting task was preempted some time after the rcu_read_lock()
that would have been paired with the missing rcu_read_unlock().

> (This complex code is copied from preempt.h and I can't expect
> how will rcu_preempt_depth_set() be used in the feture
> so I keep it unchanged.)
> 
> 
> +static __always_inline void rcu_preempt_depth_inc(void)
> +{
> +	raw_cpu_add_4(__rcu_preempt_depth, 1);
> +}
> 
> This one is for read_read_lock(). ONE instruction.

Apologies, I did in fact confuse _inc with _set.

> +
> +static __always_inline bool rcu_preempt_depth_dec_and_test(void)
> +{
> +	return GEN_UNARY_RMWcc("decl", __rcu_preempt_depth, e,
> __percpu_arg([var]));
> +}
> 
> This one is for read_read_unlock() which will be 2 instructions
> ("decl" and "je"), which is the same as preempt_enable().
> 
> In news days, preempt_disable() is discouraged unless it is
> really necessary and rcu is always encouraged. Low overhead
> read_read_[un]lock() is essential.

Agreed.  And you give instruction counts below, thank you.  But is
this reduction in the number of instructions really visible in terms of
performance at the system level?

> > > > Plus multiplying the x86-specific code by 26 doesn't look good.
> > > > 
> > > > And the RCU read-side nesting depth really is a per-task thing.  Copying
> > > > it to and from the task at context-switch time might make sense if we
> > > > had a serious optimization, but it does not appear that we do.
> 
> Once upon a time, __preempt_count is also being copied to and from the
> task at context-switch, and worked well.
> 
> > > > You original patch some years back, ill-received though it was at the
> > > > time, is looking rather good by comparison.  Plus it did not require
> > > > architecture-specific code!
> > > 
> > > Right, so the per-cpu preempt_count code relies on the preempt_count
> > > being invariant over context switches. That means we never have to
> > > save/restore the thing.
> > > 
> > > For (preemptible) rcu, this is 'obviously' not the case.
> > > 
> > > That said, I've not looked over this patch series, I only got 1 actual
> > > patch, not the whole series, and I've not had time to go dig out the
> > > rest..
> > 
> > I have taken a couple of the earlier patches in the series.
> > 
> > Perhaps inlining these things is instead a job for the long anticipated
> > GCC LTO?  ;-)
> 
> Adding a kenerl/offset.c and some Mafefile stuff will help inlining
> these things. But I don't think Linus will happy with introducing
> kenerl/offset.c. There will be 3 instructions for rcu_read_lock()
> and 5 for rcu_read_unlock(), which doesn't taste so delicious.

Adding kernel/offset.c would be to implement the original approach of
computing the offset of ->rcu_read_lock_nesting within task_struct,
correct?  (As opposed to GCC LTO.)  If so, what are your thoughts on
the GCC LTO approach?

> Moving rcu_read_lock_nesting to struct thread_info is another
> possible way. The number of instructions is also 3 and 5.

At first glance, that would require much less architecture-specific code,
so would be more attractive.  And it would be good to avoid having two
different _rcu_read_lock() and _rcu_read_unlock() implementations for
PREEMPT=y.  Here are some questions, though:

o	Do any architectures have size limits on thread_info?

o	The thread_info reference clearly cannot change at the same
	time as the current pointer.  Are there any issues with
	code that executes between these two operations, either
	when switching out or when switching in?

Any other questions that I should be asking?

And please rest assured that despite my lack of enthusiasm for your
current approach, I do very much appreciate your looking into this!!!

							Thanx, Paul
