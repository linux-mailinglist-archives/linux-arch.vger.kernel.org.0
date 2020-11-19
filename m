Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD752B9803
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgKSQao (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:30:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:46152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726830AbgKSQao (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 11:30:44 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 934BC20719;
        Thu, 19 Nov 2020 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605803443;
        bh=N6xdGG0doQbrGa8+QPn36N+1EmsnHM4CcGJuBAqB2fY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJ+75b0lqfj0M055v7SEW9Hjpd0k8isgiS9FLc2qfjyeUmy+B3hdXs+91HzyqTTRP
         dAC5Q596ur6OeLgZ55QTQ2N8H0k8lXBzDX9lmJ9ODHBayPPBbfwNi0pLcBWkxp2Q5B
         ltn+cOZiRRstOCECfl+X5EjkpeQju+gzbnW8QdnE=
Date:   Thu, 19 Nov 2020 16:30:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 08/14] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
Message-ID: <20201119163035.GB4582@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-9-will@kernel.org>
 <20201119092407.GB2416649@google.com>
 <20201119110603.GB3946@willie-the-truck>
 <20201119161956.GS3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119161956.GS3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 05:19:56PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 19, 2020 at 11:06:04AM +0000, Will Deacon wrote:
> > On Thu, Nov 19, 2020 at 09:24:07AM +0000, Quentin Perret wrote:
> > > On Friday 13 Nov 2020 at 09:37:13 (+0000), Will Deacon wrote:
> > > > When exec'ing a 32-bit task on a system with mismatched support for
> > > > 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> > > > run it.
> > > > 
> > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > ---
> > > >  arch/arm64/kernel/process.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > > index 1540ab0fbf23..17b94007fed4 100644
> > > > --- a/arch/arm64/kernel/process.c
> > > > +++ b/arch/arm64/kernel/process.c
> > > > @@ -625,6 +625,16 @@ unsigned long arch_align_stack(unsigned long sp)
> > > >  	return sp & ~0xf;
> > > >  }
> > > >  
> > > > +static void adjust_compat_task_affinity(struct task_struct *p)
> > > > +{
> > > > +	const struct cpumask *mask = system_32bit_el0_cpumask();
> > > > +
> > > > +	if (restrict_cpus_allowed_ptr(p, mask))
> > > > +		set_cpus_allowed_ptr(p, mask);
> > > 
> > > My understanding of this call to set_cpus_allowed_ptr() is that you're
> > > mimicking the hotplug vs affinity case behaviour in some ways. That is,
> > > if a task is pinned to a CPU and userspace hotplugs that CPU, then the
> > > kernel will reset the affinity of the task to the remaining online CPUs.
> > 
> > Correct. It looks to the 32-bit application like all the 64-bit-only CPUs
> > were hotplugged off at the point of the execve().
> 
> This doesn't respect cpusets though :/

How does that differ from select_fallback_rq()?

Will
