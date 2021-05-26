Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E617391CBF
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhEZQO1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 12:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232197AbhEZQO1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 12:14:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7E4F611BE;
        Wed, 26 May 2021 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622045575;
        bh=Lpj06ByCJmTxPWA4x0Oyba4e2Wlf4pynAXzKIJbruZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mEBW4cmZTsN62rBVHYLfrVtCPnifgwsBV3ZCNcKdb20TQOulcn8BYboc5IsWdQ3/4
         4KfVhE6HjNj91vCzYxvCaqh4MdYHyL1mUAEVeV+te/IsXinEpwhBb7J+JCm/J8mZ38
         4OBP3BI6GJG8L1yXGVxIymXYBB5Bri5n43V2sIHu6jY7WNFktCa4eYP0d7wiFN2ljb
         kjKWwbOuNK3qdDxgX9sFHOn2c/G9tOe6egcPfvwpkmy8eNdX9fJ62iIwzxqNuo0Vsl
         uK83iTEg5j9iYCGFQdOyy+enF2fN6RrF0KpH16UQ+A2XcwRyYTXu5goBw7tVWRaXLl
         t60xbZ5ma10AQ==
Date:   Wed, 26 May 2021 17:12:49 +0100
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 10/22] sched: Reject CPU affinity changes based on
 task_cpu_possible_mask()
Message-ID: <20210526161249.GD19691@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-11-will@kernel.org>
 <YK5mJxsmxosX1ciH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK5mJxsmxosX1ciH@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 26, 2021 at 05:15:51PM +0200, Peter Zijlstra wrote:
> On Tue, May 25, 2021 at 04:14:20PM +0100, Will Deacon wrote:
> > Reject explicit requests to change the affinity mask of a task via
> > set_cpus_allowed_ptr() if the requested mask is not a subset of the
> > mask returned by task_cpu_possible_mask(). This ensures that the
> > 'cpus_mask' for a given task cannot contain CPUs which are incapable of
> > executing it, except in cases where the affinity is forced.
> > 
> > Reviewed-by: Quentin Perret <qperret@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  kernel/sched/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 00ed51528c70..8ca7854747f1 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2346,6 +2346,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  				  u32 flags)
> >  {
> >  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> > +	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
> >  	unsigned int dest_cpu;
> >  	struct rq_flags rf;
> >  	struct rq *rq;
> > @@ -2366,6 +2367,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
> >  		 */
> >  		cpu_valid_mask = cpu_online_mask;
> > +	} else if (!cpumask_subset(new_mask, cpu_allowed_mask)) {
> > +		ret = -EINVAL;
> > +		goto out;
> >  	}
> 
> So what about the case where the 32bit task is in-kernel and in
> migrate-disable ? surely we ought to still validate the new mask against
> task_cpu_possible_mask.

That's a good question.

Given that 32-bit tasks in the kernel are running in 64-bit mode, we can
actually tolerate them moving around arbitrarily as long as they _never_ try
to return to userspace on a 64-bit-only CPU. I think this should be the case
as long as we don't try to return to userspace with migration disabled, no?

Will
