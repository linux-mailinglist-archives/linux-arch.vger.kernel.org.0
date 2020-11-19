Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0E2B909D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 12:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgKSLF5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 06:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:32976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKSLF5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 06:05:57 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C2E22248;
        Thu, 19 Nov 2020 11:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605783956;
        bh=g83zsAw1L28Dyy0iuhil8dhaCafVEDeI9B1H3qU4DZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/vkPFNcUf0qbzgqywiSVqIg3KVXiJf4OZLpfdIZ+Hky6gQYMGlzS/fdpzAnZqbmE
         HY4SrEH60JXO2yQgRZjAAgNAaOhhL0WbRP5oTFnXWi+kmAWvUYxybQlxc6GWf7p2q4
         ihMVUefWCVk9PgS72ftqBHXduUh2yF1VwMnIaQl8=
Date:   Thu, 19 Nov 2020 11:05:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 07/14] sched: Introduce restrict_cpus_allowed_ptr() to
 limit task CPU affinity
Message-ID: <20201119110549.GA3946@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-8-will@kernel.org>
 <20201119091820.GA2416649@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119091820.GA2416649@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Quentin,

Thanks for having a look.

On Thu, Nov 19, 2020 at 09:18:20AM +0000, Quentin Perret wrote:
> On Friday 13 Nov 2020 at 09:37:12 (+0000), Will Deacon wrote:
> > -static int __set_cpus_allowed_ptr(struct task_struct *p,
> > -				  const struct cpumask *new_mask, bool check)
> > +static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
> > +					 const struct cpumask *new_mask,
> > +					 bool check,
> > +					 struct rq *rq,
> > +					 struct rq_flags *rf)
> >  {
> >  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> >  	unsigned int dest_cpu;
> > -	struct rq_flags rf;
> > -	struct rq *rq;
> >  	int ret = 0;
> 
> Should we have a lockdep assertion here?

I pondered that, but I don't think it's necessary because we already have
one in do_set_cpus_allowed() so adding an extra one here doesn't really add
anything.

> > -	rq = task_rq_lock(p, &rf);
> >  	update_rq_clock(rq);
> >  
> >  	if (p->flags & PF_KTHREAD) {
> > @@ -1929,7 +1923,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  	if (task_running(rq, p) || p->state == TASK_WAKING) {
> >  		struct migration_arg arg = { p, dest_cpu };
> >  		/* Need help from migration thread: drop lock and wait. */
> > -		task_rq_unlock(rq, p, &rf);
> > +		task_rq_unlock(rq, p, rf);
> >  		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
> >  		return 0;
> >  	} else if (task_on_rq_queued(p)) {
> > @@ -1937,20 +1931,69 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  		 * OK, since we're going to drop the lock immediately
> >  		 * afterwards anyway.
> >  		 */
> > -		rq = move_queued_task(rq, &rf, p, dest_cpu);
> > +		rq = move_queued_task(rq, rf, p, dest_cpu);
> >  	}
> >  out:
> > -	task_rq_unlock(rq, p, &rf);
> > +	task_rq_unlock(rq, p, rf);
> 
> And that's a little odd to have here no? Can we move it back on the
> caller's side?

I don't think so, unfortunately. __set_cpus_allowed_ptr_locked() can trigger
migration, so it can drop the rq lock as part of that and end up relocking a
new rq, which it also unlocks before returning. Doing the unlock in the
caller is therfore even weirder, because you'd have to return the lock
pointer or something horrible like that.

I did add a comment about this right before the function and it's an
internal function to the scheduler so I think it's ok.

Will
