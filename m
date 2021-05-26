Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3138B391CA0
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 18:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbhEZQE5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 12:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234690AbhEZQEz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 12:04:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E8B861284;
        Wed, 26 May 2021 16:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622045004;
        bh=brygyaZMme8W1VhWpvcS9FsnOYnmb8rPHENNvFQRLRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uqwacT1bgi2y30ruYAfzKsbxd36BLQcdd8NtUaxp4vsDMZhKAXSNYD8hzBUiT9deM
         O5vDX7PehPAUYthTGZHHtPMKpFWDBFWSww927muxE1oMWy0gwaSbaSaoNFDlILbLNl
         DFQLmjrH5vnxE1MZTmxhI7944zkKGYAqqIE+m4aCKSkxyfp5Q2X0h5wVCtDZ7jV08i
         HKP5Ci2LLqi+j5xt7IOEVt2GfhBrQYtxwdz/aqK89L4VaBGfJ1VWa2bJ1mUjHxU6JK
         bbR0YIWG65rQ6MHBDeCJrz9YMHSI7oOwXryoWmvYGQQBHQh57S3hqLGCuDS5GU9Ei/
         vytVMeqpVskbA==
Date:   Wed, 26 May 2021 17:03:18 +0100
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
Subject: Re: [PATCH v7 01/22] sched: Favour predetermined active CPU as
 migration destination
Message-ID: <20210526160317.GB19691@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-2-will@kernel.org>
 <877djlhhmb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877djlhhmb.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 26, 2021 at 12:14:20PM +0100, Valentin Schneider wrote:
> On 25/05/21 16:14, Will Deacon wrote:
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 5226cc26a095..1702a60d178d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1869,6 +1869,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> >  struct migration_arg {
> >       struct task_struct		*task;
> >       int				dest_cpu;
> > +	const struct cpumask		*dest_mask;
> >       struct set_affinity_pending	*pending;
> >  };
> >
> > @@ -1917,6 +1918,7 @@ static int migration_cpu_stop(void *data)
> >       struct set_affinity_pending *pending = arg->pending;
> >       struct task_struct *p = arg->task;
> >       int dest_cpu = arg->dest_cpu;
> > +	const struct cpumask *dest_mask = arg->dest_mask;
> >       struct rq *rq = this_rq();
> >       bool complete = false;
> >       struct rq_flags rf;
> > @@ -1956,12 +1958,8 @@ static int migration_cpu_stop(void *data)
> >                       complete = true;
> >               }
> >
> > -		if (dest_cpu < 0) {
> > -			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
> > -				goto out;
> > -
> > -			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
> > -		}
> > +		if (dest_mask && (cpumask_test_cpu(task_cpu(p), dest_mask)))
> > +			goto out;
> >
> 
> IIRC the reason we deferred the pick to migration_cpu_stop() was because of
> those insane races involving multiple SCA calls the likes of:
> 
>   p->cpus_mask = [0, 1]; p on CPU0
> 
>   CPUx                           CPUy                   CPU0
> 
>   SCA(p, [2])
>     __do_set_cpus_allowed();
>     queue migration_cpu_stop()
>                                  SCA(p, [3])
>                                    __do_set_cpus_allowed();
>                                                         migration_cpu_stop()
> 
> The stopper needs to use the latest cpumask set by the second SCA despite
> having an arg->pending set up by the first SCA. Doesn't this break here?

Yes, well spotted. I was so caught up with the hotplug race that I didn't
even consider a straightforward SCA race. Hurumph.

> I'm not sure I've paged back in all of the subtleties laying in ambush
> here, but what about the below?

I can't break it, but I'm also not very familiar with this code. Please can
you post it as a proper patch so that I drop this from my series?

Thanks,

Will
