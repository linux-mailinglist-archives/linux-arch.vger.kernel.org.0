Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DF439E9CC
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 00:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFGWyB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 18:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhFGWyB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 18:54:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82632610C7;
        Mon,  7 Jun 2021 22:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623106329;
        bh=WaNp1TylVxIDpajJun/RGMsjtK/LLdNZo+wOLZ/qvqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KgBgiXXfTHZj3F/lf9QX3uJkrtwE7qLK9joY82TANSb5yNP44Jr9ZDtj+LAd27vxV
         W3/ufy+GsVHIlxF63/OaUj4InNRGBTYGPr5sx0BUR2B8lUuQ8d1duPewxPSvN2P7eX
         yRDOzBB1x6P8+ILCPqIyQVTcjqe/SRuhxD2rp3imOzzBUmFwgRanw3YywTo9tQOKuW
         ZfPvIKebXbqh0e/zcGW3btINSdp27bSSA+RCT/qbOehNoUawXoPd0y2nNPTkPpkuOi
         +Pln20vS4TrEUSANKWX4ahsx3wW/yAVzk1XmmlKAZHH/EMPNfmUSLjqhayJFMIXstD
         4VKUhMxucrnEw==
Date:   Mon, 7 Jun 2021 23:52:03 +0100
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
Subject: Re: [PATCH v8 11/19] sched: Allow task CPU affinity to be restricted
 on asymmetric systems
Message-ID: <20210607225202.GB8215@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-12-will@kernel.org>
 <87zgw5d05b.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgw5d05b.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 06:12:32PM +0100, Valentin Schneider wrote:
> On 02/06/21 17:47, Will Deacon wrote:
> > +static int restrict_cpus_allowed_ptr(struct task_struct *p,
> > +				     struct cpumask *new_mask,
> > +				     const struct cpumask *subset_mask)
> > +{
> > +	struct rq_flags rf;
> > +	struct rq *rq;
> > +	int err;
> > +	struct cpumask *user_mask = NULL;
> > +
> > +	if (!p->user_cpus_ptr) {
> > +		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> > +
> > +		if (!user_mask)
> > +			return -ENOMEM;
> > +	}
> > +
> > +	rq = task_rq_lock(p, &rf);
> > +
> > +	/*
> > +	 * Forcefully restricting the affinity of a deadline task is
> > +	 * likely to cause problems, so fail and noisily override the
> > +	 * mask entirely.
> > +	 */
> > +	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
> > +		err = -EPERM;
> > +		goto err_unlock;
> > +	}
> > +
> > +	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
> > +		err = -EINVAL;
> > +		goto err_unlock;
> > +	}
> > +
> > +	/*
> > +	 * We're about to butcher the task affinity, so keep track of what
> > +	 * the user asked for in case we're able to restore it later on.
> > +	 */
> > +	if (user_mask) {
> > +		cpumask_copy(user_mask, p->cpus_ptr);
> > +		p->user_cpus_ptr = user_mask;
> > +	}
> > +
> 
> Shouldn't that be done before any of the bailouts above, so we can
> potentially restore the mask even if we end up forcefully expanding the
> affinity?

I don't think so. I deliberately only track the old mask if we've managed
to take a subset for the 32-bit task. If we end up having to override the
mask entirely, then I treat it the same way as an explicit affinity change
(only with a warning printed) and don't then try to restore the old mask --
it feels like we'd be overriding the affinity twice if we tried to do that.

> > +	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
> > +
> > +err_unlock:
> > +	task_rq_unlock(rq, p, &rf);
> > +	kfree(user_mask);
> > +	return err;
> > +}
> > +
> > +/*
> > + * Restrict the CPU affinity of task @p so that it is a subset of
> > + * task_cpu_possible_mask() and point @p->user_cpu_ptr to a copy of the
> > + * old affinity mask. If the resulting mask is empty, we warn and walk
> > + * up the cpuset hierarchy until we find a suitable mask.
> > + */
> > +void force_compatible_cpus_allowed_ptr(struct task_struct *p)
> > +{
> > +	cpumask_var_t new_mask;
> > +	const struct cpumask *override_mask = task_cpu_possible_mask(p);
> > +
> > +	alloc_cpumask_var(&new_mask, GFP_KERNEL);
> > +
> > +	/*
> > +	 * __migrate_task() can fail silently in the face of concurrent
> > +	 * offlining of the chosen destination CPU, so take the hotplug
> > +	 * lock to ensure that the migration succeeds.
> > +	 */
> > +	cpus_read_lock();
> 
> I'm thinking this might not be required with:
> 
>   http://lore.kernel.org/r/20210526205751.842360-3-valentin.schneider@arm.com
> 
> but then again this isn't merged yet :-)

Agreed, if that patch does what it says on the tin ;)

I need to digest your reply to me, as this is mind-bending stuff.

> > +static int
> > +__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
> > +
> > +/*
> > + * Restore the affinity of a task @p which was previously restricted by a
> > + * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
> > + * @p->user_cpus_ptr.
> > + */
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
> 
> AFAICT an affinity change can happen between __sched_setaffinity() and
> reacquiring the ->pi_lock. Right now this can't be another
> force_compatible_cpus_allowed_ptr() because this is only driven by
> arch_setup_new_exec() against current, so we should be fine, but here be
> dragons.

That's a good point. I'll add a comment for now, since I'm not sure who
else might end up using this in future. Generally it's pretty agnostic to
how it's being used, but we're certainly relying on the serialisation of
restrict/relax calls.

Will
