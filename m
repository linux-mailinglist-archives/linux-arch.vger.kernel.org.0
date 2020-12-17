Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658502DD37E
	for <lists+linux-arch@lfdr.de>; Thu, 17 Dec 2020 16:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgLQPAm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Dec 2020 10:00:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:60282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgLQPAm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 Dec 2020 10:00:42 -0500
Date:   Thu, 17 Dec 2020 14:59:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608217201;
        bh=SryEihmoGHKC5r1tLLVQJV4OdHijgIVYH18Si4+ZQUE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=N22OMxb+xaAjqkpCj4d3MHixRyNQhPXV6rdtIQ15RNVqNQeprGTLVAd20egsnrxJY
         uOSYgL8oU5NSCqc52q24+/d0n6RFicWy26aoTiR8Ohqb2TMnSA7YqXYaDDA06T3h9R
         evanQ6FiSR/bOONjtVrKzXXJgMedjO686WaL35XToPghTZB9DrIeuBzUQtJAQqzIqa
         43uHKXNHr1PPswqSI592mhRYcyvFB3ppLEhUPpag9ct0eabMRS/H0zmH4RDiCyv+HG
         ue7W0nBnopnMCer75U/CLVzAxUXfkEQ9tq31m1EgzuxwbwD/J1tZfCQWUm2ZNY4SAq
         x2wufl1GC+/OA==
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
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
Message-ID: <20201217145954.GA17881@willie-the-truck>
References: <20201208132835.6151-1-will@kernel.org>
 <20201208132835.6151-8-will@kernel.org>
 <20201217121552.ds7g2icvqp5nvtha@e107158-lin.cambridge.arm.com>
 <20201217134401.GY3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217134401.GY3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 17, 2020 at 02:44:01PM +0100, Peter Zijlstra wrote:
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

I think Qais a point with v2 though: if task_cs(tsk)->cpus_allowed
contains 64-bit-only CPUs, then we're in trouble here. I should be
taking the intersection with the task_cpu_possible_mask() for the task.

Will
