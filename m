Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A94439E9B9
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFGWpx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 18:45:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhFGWpx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 18:45:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71CE161090;
        Mon,  7 Jun 2021 22:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623105841;
        bh=Yw5rjpX5d8vEagOcYCPCOfcNKG/SO6zfojyqFIO0VpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kj880acHv3Vytdnt5xZudPfN553KUXCz4cahjcyMHdadvOGWIVI9FmIRWTUw9JRGp
         UyIfvRdP+q+VF0GgnSHzUWZKOAUY9aH5rmnZJzm0NqJcPHCZS348HKZq3F4g2vASd7
         ZdzXCG9CxLQECgGCtU4phuPwgKbPayRAI9o3fJdqecxvo9J2YZVXJI8YoTpkvSqfc8
         3CIDCUFggWYJe4BvreAWuifea/Lso8Nrnk1rOzXRhsOLx6NcgcerzHFOX9UB96L3SK
         Bz5tSW3jhZkGXYPm0IgCsKO0hb0LvJUutO3v4HcZdbkz6dZFDe1j+/idbvE7x7UF5z
         kZ2jNacR+xIUA==
Date:   Mon, 7 Jun 2021 23:43:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v8 08/19] sched: Reject CPU affinity changes based on
 task_cpu_possible_mask()
Message-ID: <20210607224354.GA8215@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-9-will@kernel.org>
 <874kedeeqv.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kedeeqv.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 06:11:52PM +0100, Valentin Schneider wrote:
> On 02/06/21 17:47, Will Deacon wrote:
> > Reject explicit requests to change the affinity mask of a task via
> > set_cpus_allowed_ptr() if the requested mask is not a subset of the
> > mask returned by task_cpu_possible_mask(). This ensures that the
> > 'cpus_mask' for a given task cannot contain CPUs which are incapable of
> > executing it, except in cases where the affinity is forced.
> >
> > Reviewed-by: Quentin Perret <qperret@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> One comment/observation below, but regardless:
> 
> Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>

Thanks!

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0c1b6f1a6c91..b23c7f0ab31a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2347,15 +2347,17 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >                                 u32 flags)
> >  {
> >       const struct cpumask *cpu_valid_mask = cpu_active_mask;
> > +	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
> >       unsigned int dest_cpu;
> >       struct rq_flags rf;
> >       struct rq *rq;
> >       int ret = 0;
> > +	bool kthread = p->flags & PF_KTHREAD;
> >
> >       rq = task_rq_lock(p, &rf);
> >       update_rq_clock(rq);
> >
> > -	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
> > +	if (kthread || is_migration_disabled(p)) {
> >               /*
> >                * Kernel threads are allowed on online && !active CPUs,
> >                * however, during cpu-hot-unplug, even these might get pushed
> > @@ -2369,6 +2371,11 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >               cpu_valid_mask = cpu_online_mask;
> >       }
> >
> > +	if (!kthread && !cpumask_subset(new_mask, cpu_allowed_mask)) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> 
> IIUC this wouldn't be required if guarantee_online_cpus() couldn't build a
> mask that extends beyond task_cpu_possible_mask(p): if the new mask doesn't
> intersect with that possible mask, it means we're carrying an empty cpumask
> and the cpumask_any_and_distribute() below would return nr_cpu_ids, so we'd
> bail with -EINVAL.
> 
> I don't really see a way around it though due to the expectations behind
> guarantee_online_cpus() :/

Mostly agreed. I started out hacking SCA and only then started knocking the
callers on the head. However, given how many callers there are for this
thing, I'm much more comfortable having the mask check there to ensure that
we return an error if the requested mask contains CPUs on which we're unable
to run, and yes, guarantee_online_cpus() is one such caller.

Will
