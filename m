Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB2D2DD38C
	for <lists+linux-arch@lfdr.de>; Thu, 17 Dec 2020 16:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgLQPBj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Dec 2020 10:01:39 -0500
Received: from foss.arm.com ([217.140.110.172]:40786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbgLQPBj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Dec 2020 10:01:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A48130E;
        Thu, 17 Dec 2020 07:00:53 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F036B3F66B;
        Thu, 17 Dec 2020 07:00:50 -0800 (PST)
Date:   Thu, 17 Dec 2020 15:00:48 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v5 07/15] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20201217150048.d6enq5hhchvh32hz@e107158-lin.cambridge.arm.com>
References: <20201208132835.6151-1-will@kernel.org>
 <20201208132835.6151-8-will@kernel.org>
 <20201217121552.ds7g2icvqp5nvtha@e107158-lin.cambridge.arm.com>
 <20201217134401.GY3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201217134401.GY3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/17/20 14:44, Peter Zijlstra wrote:
> On Thu, Dec 17, 2020 at 12:15:52PM +0000, Qais Yousef wrote:
> > On 12/08/20 13:28, Will Deacon wrote:
> > > If the scheduler cannot find an allowed CPU for a task,
> > > cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
> > > if cgroup v1 is in use.
> > > 
> > > In preparation for allowing architectures to provide their own fallback
> > > mask, just return early if we're not using cgroup v2 and allow
> > > select_fallback_rq() to figure out the mask by itself.
> > > 
> > > Cc: Li Zefan <lizefan@huawei.com>
> > > Cc: Tejun Heo <tj@kernel.org>
> > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > Reviewed-by: Quentin Perret <qperret@google.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  kernel/cgroup/cpuset.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > index 57b5b5d0a5fd..e970737c3ed2 100644
> > > --- a/kernel/cgroup/cpuset.c
> > > +++ b/kernel/cgroup/cpuset.c
> > > @@ -3299,9 +3299,11 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> > >  
> > >  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> > >  {
> > > +	if (!is_in_v2_mode())
> > > +		return; /* select_fallback_rq will try harder */
> > > +
> > >  	rcu_read_lock();
> > > -	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
> > > -		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
> > > +	do_set_cpus_allowed(tsk, task_cs(tsk)->cpus_allowed);
> > 
> > Why is it safe to return that for cpuset v2?
> 
> v1
> 
> Because in that case it does cpu_possible_mask, which, if you look at
> select_fallback_rq(), is exactly what happens when cpuset 'fails' to
> find a candidate.
> 
> Or at least, that's how I read the patch.

Okay I can see that if v2 has effectively empty mask for the 32bit tasks, then
we'll fallback to the 'possible' switch case where we set
task_cpu_possible_mask().

But how about when task_cs(tsk)->cpus_allowed contains partially invalid cpus?

The search for a candidate cpu will return a correct dest_cpu, but the actual
cpu_mask of the task will contain invalid cpus that could be picked up later,
no? Shouldn't we

	cpumask_and(mask, task_cs(tsk)->cpus_allowed, task_cpu_possible_mask())

to remove those invalid cpus?

Thanks

--
Qais Yousef
