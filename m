Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81EA2CC494
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgLBSJS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 13:09:18 -0500
Received: from foss.arm.com ([217.140.110.172]:46930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgLBSJS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 13:09:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BB1E1042;
        Wed,  2 Dec 2020 10:08:32 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39D093F575;
        Wed,  2 Dec 2020 10:08:30 -0800 (PST)
Date:   Wed, 2 Dec 2020 18:08:27 +0000
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
Subject: Re: [PATCH v4 12/14] arm64: Prevent offlining first CPU with 32-bit
 EL0 on mismatched system
Message-ID: <20201202180827.7thdjnpnvfxh3s3r@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-13-will@kernel.org>
 <20201127134122.oughqeizhl2j4iky@e107158-lin.cambridge.arm.com>
 <20201201221335.GA28496@willie-the-truck>
 <20201202125952.z2q6oucoqbwt6aq2@e107158-lin.cambridge.arm.com>
 <20201202174230.GA29939@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201202174230.GA29939@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/02/20 17:42, Will Deacon wrote:
> On Wed, Dec 02, 2020 at 12:59:52PM +0000, Qais Yousef wrote:
> > On 12/01/20 22:13, Will Deacon wrote:
> > > On Fri, Nov 27, 2020 at 01:41:22PM +0000, Qais Yousef wrote:
> > > > On 11/24/20 15:50, Will Deacon wrote:
> > > > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > > > index 29017cbb6c8e..fe470683b43e 100644
> > > > > --- a/arch/arm64/kernel/cpufeature.c
> > > > > +++ b/arch/arm64/kernel/cpufeature.c
> > > > > @@ -1237,6 +1237,8 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
> > > > >  
> > > > >  static int enable_mismatched_32bit_el0(unsigned int cpu)
> > > > >  {
> > > > > +	static int lucky_winner = -1;
> > > > > +
> > > > >  	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
> > > > >  	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
> > > > >  
> > > > > @@ -1245,6 +1247,22 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
> > > > >  		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
> > > > >  	}
> > > > >  
> > > > > +	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
> > > > > +		return 0;
> > > > 
> > > > Hmm I'm struggling to get what you're doing here. You're treating CPU0 (the
> > > > boot CPU) specially here, but I don't get why?
> > > 
> > > If our ability to execute 32-bit code is the same as the boot CPU then we
> > > don't have to do anything. That way, we can postpone nominating the lucky
> > > winner until we really need to.
> > 
> > Okay I see what you're doing now. The '== cpu_32bit' part of the check gave me
> > trouble. If the first N cpus are 64bit only, we'll skip them here. Worth
> > a comment?
> > 
> > Wouldn't it be better to replace this with a check if cpu_32bit_el0_mask is
> > empty instead? That would be a lot easier to read.
> 
> Sorry, but I don't follow. What if all the CPUs are 32-bit capable?

You're right I missed this case.

--
Qais Yousef
