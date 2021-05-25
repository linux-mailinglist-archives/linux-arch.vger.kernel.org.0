Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C38438FE0C
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 11:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhEYJpV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 05:45:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhEYJpV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 05:45:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E39B61409;
        Tue, 25 May 2021 09:43:48 +0000 (UTC)
Date:   Tue, 25 May 2021 10:43:46 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 18/21] arm64: Prevent offlining first CPU with 32-bit
 EL0 on mismatched system
Message-ID: <20210525094346.GB15564@arm.com>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-19-will@kernel.org>
 <20210524154657.GE14645@arm.com>
 <20210524203249.GD15545@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524203249.GD15545@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 24, 2021 at 09:32:50PM +0100, Will Deacon wrote:
> On Mon, May 24, 2021 at 04:46:58PM +0100, Catalin Marinas wrote:
> > On Tue, May 18, 2021 at 10:47:22AM +0100, Will Deacon wrote:
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 959442f76ed7..72efdc611b14 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -2896,15 +2896,33 @@ void __init setup_cpu_features(void)
> > >  
> > >  static int enable_mismatched_32bit_el0(unsigned int cpu)
> > >  {
> > > +	static int lucky_winner = -1;
> > > +
> > >  	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> > >  	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
> > >  
> > >  	if (cpu_32bit) {
> > >  		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
> > >  		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
> > > -		setup_elf_hwcaps(compat_elf_hwcaps);
> > >  	}
> > >  
> > > +	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
> > > +		return 0;
> > 
> > I don't fully understand this early return. AFAICT, we still call
> > setup_elf_hwcaps() via setup_cpu_features() if the system supports
> > 32-bit EL0 (mismatched or not) at boot. For CPU hotplug, we can add the
> > compat hwcaps later if we didn't set them up at boot. So this part is
> > fine.
> > 
> > However, if CPU0 is 32-bit-capable, it looks like we'd never disable the
> > offlining on any of the 32-bit-capable CPUs and there's nothing that
> > prevents offlining CPU0.
> 
> That is also deferred until we actually detect the mismatch. For example, if
> CPU0 is 32-bit capable but none of the others are, then when we online CPU1
> we will print:
> 
>   | CPU features: Asymmetric 32-bit EL0 support detected on CPU 1; CPU hot-unplug disabled on CPU 0
> 
> so the check above is really asking "Is the CPU being onlined mismatched wrt
> the boot CPU?". If yes, then we need to make sure that we're keeping a
> 32-bit-capable CPU around.

Got it now, the offlining will only be disabled if we detected a
mismatch. For this patch:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
