Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F92E38E672
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhEXMTT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 08:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232678AbhEXMTR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 08:19:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9C6261209;
        Mon, 24 May 2021 12:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621858669;
        bh=teXbnvQA/9F8le8shlLhKROaQfKBflKP12itvlr6NDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n9EzFsn5dgbYafkGAnH83DXTFT9rXqgvD6woQxgp/zRM42lpntgjsNnJ9EBz0pe/I
         XZjedXwXuS7lp6oLxvheJqEThhwQInWq+dDnTYVC0iiLPrXEwCqrwJao6eq2cSz3z6
         1Yi1rlh8b7hWw9gD5LGJ8/Y8D+V39pA8fL2SI4VCV71zwKHlze5995dCCMpiurWsg+
         kKr8iswfH1CbKIXn3uvejF8r1k+/8KP21/JqDZ0sOb6bmFXn2GKr7NtwoptdURx+Vp
         w5JM2OYBfaOmHTafGekf7wiN48UGOizAmsReN5yotDsYLv4mCFfnMQ/JSqQjI4ULc5
         7uo1w5mMC3n2g==
Date:   Mon, 24 May 2021 13:17:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 06/21] sched: Introduce task_cpu_possible_mask() to
 limit fallback rq selection
Message-ID: <20210524121743.GC14913@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-7-will@kernel.org>
 <20210521160344.GJ5618@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521160344.GJ5618@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 06:03:44PM +0200, Peter Zijlstra wrote:
> On Tue, May 18, 2021 at 10:47:10AM +0100, Will Deacon wrote:
> > diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
> > index 03dee12d2b61..bc4ac3c525e6 100644
> > --- a/include/linux/mmu_context.h
> > +++ b/include/linux/mmu_context.h
> > @@ -14,4 +14,12 @@
> >  static inline void leave_mm(int cpu) { }
> >  #endif
> >  
> > +/*
> > + * CPUs that are capable of running task @p. By default, we assume a sane,
> > + * homogeneous system. Must contain at least one active CPU.
> > + */
> > +#ifndef task_cpu_possible_mask
> > +# define task_cpu_possible_mask(p)	cpu_possible_mask
> > +#endif
> 
> #ifndef task_cpu_possible_mask
> # define task_cpu_possible_mask(p)	cpu_possible_mask
> # define task_cpu_possible(cpu, p)	true
> #else
> # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
> #endif
> 
> > +
> >  #endif
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 5226cc26a095..482f7fdca0e8 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1813,8 +1813,11 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
> >  		return cpu_online(cpu);
> >  
> >  	/* Non kernel threads are not allowed during either online or offline. */
> >  	if (!(p->flags & PF_KTHREAD))
> > -		return cpu_active(cpu);
> +		return cpu_active(cpu) && task_cpu_possible(cpu, p);
> 
> >  	/* KTHREAD_IS_PER_CPU is always allowed. */
> >  	if (kthread_is_per_cpu(p))
> 
> Would something like that make sense?

I think this is probably the only place that we could use the helper, but
it's also one of the places where architectures that don't have to worry
about asymmetry end up with the check so, yes, I'll do that for v7.

Will
