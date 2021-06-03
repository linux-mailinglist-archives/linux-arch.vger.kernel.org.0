Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680BE39A965
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 19:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhFCRmt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 13:42:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhFCRms (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 13:42:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 545C5613E7;
        Thu,  3 Jun 2021 17:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622742063;
        bh=a/8+IvMo0IoYYLvMI+Pg2wZu5Ht+DS6jCUOZb+m06Jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KVlMmJFreClMtZWvYJb3UwweJvlF5gfGF8yWaIqOD1BSn5ZJZfJD8MCqyzambMKYU
         Pi7tpwQdFWP9+v5KSN79mYMsJJ40hjlTZzlkChDwbM52GwsAIg0Y6Vr+tDIeBuwC19
         SamjAVqLMCnOZWJgWJZlNPbro0oWuCmd+o+SJh9H/AUeg0K5MLzwnjPbk5ygkuYnO3
         AAz7YZry5joQyerZe7GpzXxYdDqSlXpUFBHCtLCOflYK1svAzypPyoYWze41SJCqZ9
         oX4paQSD0c6fB7ZnR0ZyRprShOMdqd2YzblDRtpRPxcbKRbvNWvoECy2tiI1/pfJXt
         rRNSHDFrRyrxg==
Date:   Thu, 3 Jun 2021 18:40:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
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
        Valentin Schneider <valentin.schneider@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v8 15/19] arm64: Prevent offlining first CPU with 32-bit
 EL0 on mismatched system
Message-ID: <20210603174056.GB1170@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org>
 <20210602164719.31777-16-will@kernel.org>
 <20210603125856.GC48596@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603125856.GC48596@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 03, 2021 at 01:58:56PM +0100, Mark Rutland wrote:
> On Wed, Jun 02, 2021 at 05:47:15PM +0100, Will Deacon wrote:
> > If we want to support 32-bit applications, then when we identify a CPU
> > with mismatched 32-bit EL0 support we must ensure that we will always
> > have an active 32-bit CPU available to us from then on. This is important
> > for the scheduler, because is_cpu_allowed() will be constrained to 32-bit
> > CPUs for compat tasks and forced migration due to a hotplug event will
> > hang if no 32-bit CPUs are available.
> > 
> > On detecting a mismatch, prevent offlining of either the mismatching CPU
> > if it is 32-bit capable, or find the first active 32-bit capable CPU
> > otherwise.
> > 
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kernel/cpufeature.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 4194a47de62d..b31d7a1eaed6 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2877,15 +2877,33 @@ void __init setup_cpu_features(void)
> >  
> >  static int enable_mismatched_32bit_el0(unsigned int cpu)
> >  {
> > +	static int lucky_winner = -1;
> 
> This is cute, but could we please give it a meaningful name, e.g.
> `pinned_cpu` ?

I really don't see the problem, nor why it's "cute".

Tell you what, I'll add a comment instead:

	/*
	 * The first 32-bit-capable CPU we detected and so can no longer
	 * be offlined by userspace. -1 indicates we haven't yet onlined
	 * a 32-bit-capable CPU.
	 */

> >  	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> >  	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
> >  
> >  	if (cpu_32bit) {
> >  		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
> >  		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
> > -		setup_elf_hwcaps(compat_elf_hwcaps);
> >  	}
> >  
> > +	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
> > +		return 0;
> > +
> > +	if (lucky_winner >= 0)
> > +		return 0;
> > +
> > +	/*
> > +	 * We've detected a mismatch. We need to keep one of our CPUs with
> > +	 * 32-bit EL0 online so that is_cpu_allowed() doesn't end up rejecting
> > +	 * every CPU in the system for a 32-bit task.
> > +	 */
> > +	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
> > +							 cpu_active_mask);
> > +	get_cpu_device(lucky_winner)->offline_disabled = true;
> > +	setup_elf_hwcaps(compat_elf_hwcaps);
> > +	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
> > +		cpu, lucky_winner);
> >  	return 0;
> >  }
> 
> I guess this is going to play havoc with kexec and hibernate. :/

The kernel can still offline the CPUs (see the whole freezer mess that I
linked to in the cover letter). What specific havoc are you thinking of?

Will
