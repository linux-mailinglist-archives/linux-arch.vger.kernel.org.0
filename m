Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4655B3F01ED
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 12:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhHRKnK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 06:43:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233902AbhHRKnJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Aug 2021 06:43:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB2F060F58;
        Wed, 18 Aug 2021 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629283355;
        bh=bbi6ktG6FrjFoI+90EdyKoJgarLRcDLvzTOS9lfuw1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tC55WRQxaYOwDkc7ctK5plhM78JGMGTfr9di/SZkM5GADwqyLsyKiSrVo5DW7Z+lc
         6E30EFa/oHIg7pWInfHsAHWMBe9UIWPAaewLNWVRvEIe1RBSjPOzdmX9Dlt7R+++dm
         LebXqn1mqc/W/SliTJWX2U3yzHwbfWnAMP0ymPyo9ibACWlTLu1YJ4B+jiCpR8fePw
         ktCF/14EYBZbw8opPPZc7qIxOBH5Y/GMmwOcoLZpXCZHhSrINOt7rxsFws8HabCuTp
         VP0i9ao90A+gZcInxKjBR5Kdt9r3sXBC0dK82DgpmUTu6C5dyBA0xqe4lh9ltKIqSo
         k4GVd0aK1d/Qg==
Date:   Wed, 18 Aug 2021 11:42:28 +0100
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v11 08/16] sched: Allow task CPU affinity to be
 restricted on asymmetric systems
Message-ID: <20210818104227.GA13828@willie-the-truck>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-9-will@kernel.org>
 <YRvRfZ/NnuNyIu3s@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRvRfZ/NnuNyIu3s@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Tue, Aug 17, 2021 at 05:10:53PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 30, 2021 at 12:24:35PM +0100, Will Deacon wrote:
> > @@ -2783,20 +2778,173 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  
> >  	__do_set_cpus_allowed(p, new_mask, flags);
> >  
> > -	return affine_move_task(rq, p, &rf, dest_cpu, flags);
> > +	if (flags & SCA_USER)
> > +		release_user_cpus_ptr(p);
> > +
> > +	return affine_move_task(rq, p, rf, dest_cpu, flags);
> >  
> >  out:
> > -	task_rq_unlock(rq, p, &rf);
> > +	task_rq_unlock(rq, p, rf);
> >  
> >  	return ret;
> >  }
> 
> > +void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
> > +{
> > +	unsigned long flags;
> > +	struct cpumask *mask = p->user_cpus_ptr;
> > +
> > +	/*
> > +	 * Try to restore the old affinity mask. If this fails, then
> > +	 * we free the mask explicitly to avoid it being inherited across
> > +	 * a subsequent fork().
> > +	 */
> > +	if (!mask || !__sched_setaffinity(p, mask))
> > +		return;
> > +
> > +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> > +	release_user_cpus_ptr(p);
> > +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> > +}
> 
> Both these are a problem on RT.

Ah, sorry. I didn't realise you couldn't _free_ with a raw lock held in RT.
Is there somewhere I can read up on that?

> The easiest recourse is simply never freeing the CPU mask (except on
> exit). The alternative is something like the below I suppose..
> 
> I'm leaning towards the former option, wdyt?

Defering the freeing until exit feels like a little fiddly, as we still
want to clear ->user_cpus_ptr on affinity changes when SCA_USER is set
so we'd have to keep track of the mask somewhere and reuse it instead
of allocating a new one if we need it later on. Do-able, but feels a bit
nasty, particular across fork().

As for your other suggestion:

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2733,6 +2733,7 @@ static int __set_cpus_allowed_ptr_locked
>  	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
>  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
>  	bool kthread = p->flags & PF_KTHREAD;
> +	struct cpumask *user_mask = NULL;
>  	unsigned int dest_cpu;
>  	int ret = 0;
>  
> @@ -2792,9 +2793,13 @@ static int __set_cpus_allowed_ptr_locked
>  	__do_set_cpus_allowed(p, new_mask, flags);
>  
>  	if (flags & SCA_USER)
> -		release_user_cpus_ptr(p);
> +		swap(user_mask, p->user_cpus_ptr);
> +
> +	ret = affine_move_task(rq, p, rf, dest_cpu, flags);
> +
> +	kfree(user_mask);
>  
> -	return affine_move_task(rq, p, rf, dest_cpu, flags);
> +	return ret;
>  
>  out:
>  	task_rq_unlock(rq, p, rf);
> @@ -2954,8 +2959,10 @@ void relax_compatible_cpus_allowed_ptr(s
>  		return;
>  
>  	raw_spin_lock_irqsave(&p->pi_lock, flags);
> -	release_user_cpus_ptr(p);
> +	p->user_cpus_ptr = NULL;
>  	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +
> +	kfree(mask);

I think the idea looks good, but perhaps we could wrap things up a bit:

/* Comment about why this is useful with RT */
static cpumask_t *clear_user_cpus_ptr(struct task_struct *p)
{
	struct cpumask *user_mask = NULL;

	swap(user_mask, p->user_cpus_ptr);
	return user_mask;
}

void release_user_cpus_ptr(struct task_struct *p)
{
	kfree(clear_user_cpus_ptr(p));
}

Then just use clear_user_cpus_ptr() in sched/core.c where we know what
we're doing (well, at least one of us does!).

Will
