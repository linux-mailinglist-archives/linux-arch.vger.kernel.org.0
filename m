Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F039175B
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhEZMet (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 08:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhEZMes (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 May 2021 08:34:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27367C061574;
        Wed, 26 May 2021 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RzUqrNAT99P+Q/VTlGYT/bKmVQ5B0IFOwa9vVPGIyuk=; b=nI+87QSFA/Z8ANauzcCoB/LYzF
        i+6MjAz0uIAqi7VdxQxnc5OLffT0ZejDtWb/upA79r2d3ZfCfUQyhgdwLBS8ZBrRyawsDUPwH2fPh
        rjlDCG3XohUjg7h8Eo6dDScrnI9kvgp05Cdkz4BFJg99kOwXLENTiFTru2tOFzT3DHcKvVtqwr8FL
        bFO1RSjQkM5EziurmA6wn4W1Gq749svk3TUkWWxO6Dfll2pkLruzyEzit9wYvP/JgqJSw36chxA7s
        nHPXkIjgGstlUctf1UkB9BviJDR227lUWWFWyFHHk8ZPmHago7XzmuSTvVI/VLwLpZKohhBRuJ7mp
        H0R8awoA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llsiL-004Vn3-9h; Wed, 26 May 2021 12:32:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C0891300242;
        Wed, 26 May 2021 14:32:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9E5F7201DB6C5; Wed, 26 May 2021 14:32:43 +0200 (CEST)
Date:   Wed, 26 May 2021 14:32:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
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
Subject: Re: [PATCH v7 01/22] sched: Favour predetermined active CPU as
 migration destination
Message-ID: <YK4/6+lX4WJxcLDw@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-2-will@kernel.org>
 <877djlhhmb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877djlhhmb.mognet@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 26, 2021 at 12:14:20PM +0100, Valentin Schneider wrote:
> On 25/05/21 16:14, Will Deacon wrote:

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

Yep.

> I'm not sure I've paged back in all of the subtleties laying in ambush
> here, but what about the below?
> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5226cc26a095..cd447c9db61d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

> @@ -1954,19 +1953,15 @@ static int migration_cpu_stop(void *data)
>  		if (pending) {
>  			p->migration_pending = NULL;
>  			complete = true;
>  
>  			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
>  				goto out;
>  		}
>  
>  		if (task_on_rq_queued(p))
> +			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);

> @@ -2249,7 +2244,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>  			init_completion(&my_pending.done);
>  			my_pending.arg = (struct migration_arg) {
>  				.task = p,
> +				.dest_cpu = dest_cpu,
>  				.pending = &my_pending,
>  			};
>  
> @@ -2257,6 +2252,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>  		} else {
>  			pending = p->migration_pending;
>  			refcount_inc(&pending->refs);
> +			pending->arg.dest_cpu = dest_cpu;
>  		}
>  	}

Argh.. that might just work. But I'm thinking we wants comments this
time around :-) This is even more subtle.
