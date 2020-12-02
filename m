Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6D42CBF18
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 15:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbgLBOIL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 09:08:11 -0500
Received: from foss.arm.com ([217.140.110.172]:40906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgLBOIK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 09:08:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDDFE1063;
        Wed,  2 Dec 2020 06:07:24 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A600A3F718;
        Wed,  2 Dec 2020 06:07:22 -0800 (PST)
Date:   Wed, 2 Dec 2020 14:07:20 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 08/14] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
Message-ID: <20201202140720.vlnpvge3bgtvn43s@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-9-will@kernel.org>
 <20201127132306.ee4frq6ujz3fqxic@e107158-lin.cambridge.arm.com>
 <20201201165556.GA27783@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201165556.GA27783@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/01/20 16:55, Will Deacon wrote:
> > > +static void adjust_compat_task_affinity(struct task_struct *p)
> > > +{
> > > +	cpumask_var_t cpuset_mask;
> > > +	const struct cpumask *possible_mask = system_32bit_el0_cpumask();
> > > +	const struct cpumask *newmask = possible_mask;
> > > +
> > > +	/*
> > > +	 * Restrict the CPU affinity mask for a 32-bit task so that it contains
> > > +	 * only the 32-bit-capable subset of its original CPU mask. If this is
> > > +	 * empty, then try again with the cpuset allowed mask. If that fails,
> > > +	 * forcefully override it with the set of all 32-bit-capable CPUs that
> > > +	 * we know about.
> > > +	 *
> > > +	 * From the perspective of the task, this looks similar to what would
> > > +	 * happen if the 64-bit-only CPUs were hot-unplugged at the point of
> > > +	 * execve().
> > > +	 */
> > > +	if (!restrict_cpus_allowed_ptr(p, possible_mask))
> > > +		goto out;
> > > +
> > > +	if (alloc_cpumask_var(&cpuset_mask, GFP_KERNEL)) {
> > > +		cpuset_cpus_allowed(p, cpuset_mask);
> > > +		if (cpumask_and(cpuset_mask, cpuset_mask, possible_mask)) {
> > > +			newmask = cpuset_mask;
> > > +			goto out_set_mask;
> > > +		}
> > > +	}
> > 
> > Wouldn't it be better to move this logic to restrict_cpus_allowed_ptr()?
> > I think it should always take cpusets into account and it's not special to
> > this particular handling here, no?
> 
> I did actually try this but didn't pursue it further because I was worried
> that I was putting too much of the "can't run a 32-bit task on a 64-bit-only
> CPU" logic into what would otherwise be a potentially useful library function
> if/when other architectures want something similar. But I'll have another
> look because there were a couple of ideas I didn't try out.

If we improve the cpuset handling issues to take into account
arch_task_cpu_possible_mask() as discussed in the other thread, I think we can
drop the cpuset handling here.

> 
> > > +	if (printk_ratelimit()) {
> > > +		printk_deferred("Overriding affinity for 32-bit process %d (%s) to CPUs %*pbl\n",
> > > +				task_pid_nr(p), p->comm, cpumask_pr_args(newmask));
> > > +	}
> > 
> > We have 2 cases where the affinity could have been overridden but we won't
> > print anything:
> > 
> > 	1. restrict_cpus_allowed_ptr()
> > 	2. intersection of cpuset_mask and possible mask drops some cpus.
> > 
> > Shouldn't we print something in these cases too?
> 
> I don't think so: in these cases we've found a subset of CPUs that we can
> run on, and so there's no need to warn. Nothing says we _have_ to use all
> the CPUs available to us. The case where we override the affinity mask
> altogether, however, does warrant a warning. This is very similar to the
> hotplug behaviour in select_fallback_rq().

Okay. It is just to warn when we actually break the affinity because we ended
up with empty mask; not just because we changed the affinity to an intersecting
one.

I think this makes sense, yes. We might be able to drop this too if we improve
cpuset handling. The devil is in the details I guess.

Thanks

--
Qais Yousef
