Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5902CA919
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 18:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392149AbgLAQ4o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 11:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391870AbgLAQ4o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 11:56:44 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC5D20758;
        Tue,  1 Dec 2020 16:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841763;
        bh=vUuXTXCHpWTLplaXDa7P3d5b/wIiiAS0ETXN4wuN2fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1wIYNg/HvF50Fj/9wfP8UwgScivH9fyVobDbKu3FMRDi9Y45PIaNfIyFFMbk1TAI
         giZ1+3jsBg0JgigKTmUCm4FDNjikJjPRLTTnafkXTAtK3VboulGEVLUSDrLaTt/6cU
         jDqN7gTIGMZwUJM6GvOUp0J3Rh5bjTiZco63HcXs=
Date:   Tue, 1 Dec 2020 16:55:56 +0000
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
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
Message-ID: <20201201165556.GA27783@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-9-will@kernel.org>
 <20201127132306.ee4frq6ujz3fqxic@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127132306.ee4frq6ujz3fqxic@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 27, 2020 at 01:23:06PM +0000, Qais Yousef wrote:
> On 11/24/20 15:50, Will Deacon wrote:
> > When exec'ing a 32-bit task on a system with mismatched support for
> > 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> > run it.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kernel/process.c | 42 ++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 41 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 1540ab0fbf23..72116b0c7c73 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -31,6 +31,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/init.h>
> >  #include <linux/cpu.h>
> > +#include <linux/cpuset.h>
> >  #include <linux/elfcore.h>
> >  #include <linux/pm.h>
> >  #include <linux/tick.h>
> > @@ -625,6 +626,45 @@ unsigned long arch_align_stack(unsigned long sp)
> >  	return sp & ~0xf;
> >  }
> >  
> > +static void adjust_compat_task_affinity(struct task_struct *p)
> > +{
> > +	cpumask_var_t cpuset_mask;
> > +	const struct cpumask *possible_mask = system_32bit_el0_cpumask();
> > +	const struct cpumask *newmask = possible_mask;
> > +
> > +	/*
> > +	 * Restrict the CPU affinity mask for a 32-bit task so that it contains
> > +	 * only the 32-bit-capable subset of its original CPU mask. If this is
> > +	 * empty, then try again with the cpuset allowed mask. If that fails,
> > +	 * forcefully override it with the set of all 32-bit-capable CPUs that
> > +	 * we know about.
> > +	 *
> > +	 * From the perspective of the task, this looks similar to what would
> > +	 * happen if the 64-bit-only CPUs were hot-unplugged at the point of
> > +	 * execve().
> > +	 */
> > +	if (!restrict_cpus_allowed_ptr(p, possible_mask))
> > +		goto out;
> > +
> > +	if (alloc_cpumask_var(&cpuset_mask, GFP_KERNEL)) {
> > +		cpuset_cpus_allowed(p, cpuset_mask);
> > +		if (cpumask_and(cpuset_mask, cpuset_mask, possible_mask)) {
> > +			newmask = cpuset_mask;
> > +			goto out_set_mask;
> > +		}
> > +	}
> 
> Wouldn't it be better to move this logic to restrict_cpus_allowed_ptr()?
> I think it should always take cpusets into account and it's not special to
> this particular handling here, no?

I did actually try this but didn't pursue it further because I was worried
that I was putting too much of the "can't run a 32-bit task on a 64-bit-only
CPU" logic into what would otherwise be a potentially useful library function
if/when other architectures want something similar. But I'll have another
look because there were a couple of ideas I didn't try out.

> > +	if (printk_ratelimit()) {
> > +		printk_deferred("Overriding affinity for 32-bit process %d (%s) to CPUs %*pbl\n",
> > +				task_pid_nr(p), p->comm, cpumask_pr_args(newmask));
> > +	}
> 
> We have 2 cases where the affinity could have been overridden but we won't
> print anything:
> 
> 	1. restrict_cpus_allowed_ptr()
> 	2. intersection of cpuset_mask and possible mask drops some cpus.
> 
> Shouldn't we print something in these cases too?

I don't think so: in these cases we've found a subset of CPUs that we can
run on, and so there's no need to warn. Nothing says we _have_ to use all
the CPUs available to us. The case where we override the affinity mask
altogether, however, does warrant a warning. This is very similar to the
hotplug behaviour in select_fallback_rq().

Will
