Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8452884FA
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 10:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732501AbgJIINV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 04:13:21 -0400
Received: from foss.arm.com ([217.140.110.172]:44276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732463AbgJIINU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 04:13:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08B28D6E;
        Fri,  9 Oct 2020 01:13:20 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A83613F70D;
        Fri,  9 Oct 2020 01:13:18 -0700 (PDT)
Date:   Fri, 9 Oct 2020 10:13:12 +0200
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/3] arm64: Handle AArch32 tasks running on non
 AArch32 cpu
Message-ID: <20201009081312.GA8004@e123083-lin>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-4-qais.yousef@arm.com>
 <20201009072943.GD2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009072943.GD2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 09, 2020 at 09:29:43AM +0200, Peter Zijlstra wrote:
> On Thu, Oct 08, 2020 at 07:16:41PM +0100, Qais Yousef wrote:
> > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > index cf94cc248fbe..7e97f1589f33 100644
> > --- a/arch/arm64/kernel/signal.c
> > +++ b/arch/arm64/kernel/signal.c
> > @@ -908,13 +908,28 @@ static void do_signal(struct pt_regs *regs)
> >  	restore_saved_sigmask();
> >  }
> >  
> > +static void set_32bit_cpus_allowed(void)
> >  {
> > +	cpumask_var_t cpus_allowed;
> > +	int ret = 0;
> > +
> > +	if (cpumask_subset(current->cpus_ptr, &aarch32_el0_mask))
> > +		return;
> > +
> >  	/*
> > +	 * On asym aarch32 systems, if the task has invalid cpus in its mask,
> > +	 * we try to fix it by removing the invalid ones.
> >  	 */
> > +	if (!alloc_cpumask_var(&cpus_allowed, GFP_ATOMIC)) {
> > +		ret = -ENOMEM;
> > +	} else {
> > +		cpumask_and(cpus_allowed, current->cpus_ptr, &aarch32_el0_mask);
> > +		ret = set_cpus_allowed_ptr(current, cpus_allowed);
> > +		free_cpumask_var(cpus_allowed);
> > +	}
> > +
> > +	if (ret) {
> > +		pr_warn_once("Failed to fixup affinity of running 32-bit task\n");
> >  		force_sig(SIGKILL);
> >  	}
> >  }
> 
> Yeah, no. Not going to happen.
> 
> Fundamentally, you're not supposed to change the userspace provided
> affinity mask. If we want to do something like this, we'll have to teach
> the scheduler about this second mask such that it can compute an
> effective mask as the intersection between the 'feature' and user mask.

I agree that we shouldn't mess wit the user-space mask directly. Would it
be unthinkable to go down the route of maintaining a new mask which is
the intersection of the feature mask (controlled and updated by arch
code) and the user-space mask?

It shouldn't add overhead in the scheduler as it would use the
intersection mask instead of the user-space mask, the main complexity
would be around making sure the intersection mask is updated correctly
(cpusets, hotplug, ...).

Like the above tweak, this won't help if the intersection mask is empty,
task will still get killed but it will allow tasks to survive
user-space masks including some non-compatible CPUs. If we want to
prevent task killing in all cases (ignoring hotplug) it gets more ugly
as we would have to ignore the user-space mask in some cases.

Morten
