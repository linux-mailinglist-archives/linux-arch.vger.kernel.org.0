Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8419739BE3B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 19:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFDROY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 13:14:24 -0400
Received: from foss.arm.com ([217.140.110.172]:43926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhFDROY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 13:14:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C8041063;
        Fri,  4 Jun 2021 10:12:37 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0BA93F73D;
        Fri,  4 Jun 2021 10:12:34 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v8 11/19] sched: Allow task CPU affinity to be restricted on asymmetric systems
In-Reply-To: <20210602164719.31777-12-will@kernel.org>
References: <20210602164719.31777-1-will@kernel.org> <20210602164719.31777-12-will@kernel.org>
Date:   Fri, 04 Jun 2021 18:12:32 +0100
Message-ID: <87zgw5d05b.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/06/21 17:47, Will Deacon wrote:
> +static int restrict_cpus_allowed_ptr(struct task_struct *p,
> +				     struct cpumask *new_mask,
> +				     const struct cpumask *subset_mask)
> +{
> +	struct rq_flags rf;
> +	struct rq *rq;
> +	int err;
> +	struct cpumask *user_mask = NULL;
> +
> +	if (!p->user_cpus_ptr) {
> +		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> +
> +		if (!user_mask)
> +			return -ENOMEM;
> +	}
> +
> +	rq = task_rq_lock(p, &rf);
> +
> +	/*
> +	 * Forcefully restricting the affinity of a deadline task is
> +	 * likely to cause problems, so fail and noisily override the
> +	 * mask entirely.
> +	 */
> +	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
> +		err = -EPERM;
> +		goto err_unlock;
> +	}
> +
> +	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
> +		err = -EINVAL;
> +		goto err_unlock;
> +	}
> +
> +	/*
> +	 * We're about to butcher the task affinity, so keep track of what
> +	 * the user asked for in case we're able to restore it later on.
> +	 */
> +	if (user_mask) {
> +		cpumask_copy(user_mask, p->cpus_ptr);
> +		p->user_cpus_ptr = user_mask;
> +	}
> +

Shouldn't that be done before any of the bailouts above, so we can
potentially restore the mask even if we end up forcefully expanding the
affinity?

> +	return __set_cpus_allowed_ptr_locked(p, new_mask, 0, rq, &rf);
> +
> +err_unlock:
> +	task_rq_unlock(rq, p, &rf);
> +	kfree(user_mask);
> +	return err;
> +}
> +
> +/*
> + * Restrict the CPU affinity of task @p so that it is a subset of
> + * task_cpu_possible_mask() and point @p->user_cpu_ptr to a copy of the
> + * old affinity mask. If the resulting mask is empty, we warn and walk
> + * up the cpuset hierarchy until we find a suitable mask.
> + */
> +void force_compatible_cpus_allowed_ptr(struct task_struct *p)
> +{
> +	cpumask_var_t new_mask;
> +	const struct cpumask *override_mask = task_cpu_possible_mask(p);
> +
> +	alloc_cpumask_var(&new_mask, GFP_KERNEL);
> +
> +	/*
> +	 * __migrate_task() can fail silently in the face of concurrent
> +	 * offlining of the chosen destination CPU, so take the hotplug
> +	 * lock to ensure that the migration succeeds.
> +	 */
> +	cpus_read_lock();

I'm thinking this might not be required with:

  http://lore.kernel.org/r/20210526205751.842360-3-valentin.schneider@arm.com

but then again this isn't merged yet :-)

> +	if (!cpumask_available(new_mask))
> +		goto out_set_mask;
> +
> +	if (!restrict_cpus_allowed_ptr(p, new_mask, override_mask))
> +		goto out_free_mask;
> +
> +	/*
> +	 * We failed to find a valid subset of the affinity mask for the
> +	 * task, so override it based on its cpuset hierarchy.
> +	 */
> +	cpuset_cpus_allowed(p, new_mask);
> +	override_mask = new_mask;
> +
> +out_set_mask:
> +	if (printk_ratelimit()) {
> +		printk_deferred("Overriding affinity for process %d (%s) to CPUs %*pbl\n",
> +				task_pid_nr(p), p->comm,
> +				cpumask_pr_args(override_mask));
> +	}
> +
> +	WARN_ON(set_cpus_allowed_ptr(p, override_mask));
> +out_free_mask:
> +	cpus_read_unlock();
> +	free_cpumask_var(new_mask);
> +}
> +
> +static int
> +__sched_setaffinity(struct task_struct *p, const struct cpumask *mask);
> +
> +/*
> + * Restore the affinity of a task @p which was previously restricted by a
> + * call to force_compatible_cpus_allowed_ptr(). This will clear (and free)
> + * @p->user_cpus_ptr.
> + */
> +void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
> +{
> +	unsigned long flags;
> +	struct cpumask *mask = p->user_cpus_ptr;
> +
> +	/*
> +	 * Try to restore the old affinity mask. If this fails, then
> +	 * we free the mask explicitly to avoid it being inherited across
> +	 * a subsequent fork().
> +	 */
> +	if (!mask || !__sched_setaffinity(p, mask))
> +		return;
> +
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +	release_user_cpus_ptr(p);
> +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);

AFAICT an affinity change can happen between __sched_setaffinity() and
reacquiring the ->pi_lock. Right now this can't be another
force_compatible_cpus_allowed_ptr() because this is only driven by
arch_setup_new_exec() against current, so we should be fine, but here be
dragons.
