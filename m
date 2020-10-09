Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F7288556
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 10:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbgJIIby (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 04:31:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732796AbgJIIbx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 9 Oct 2020 04:31:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E8722251;
        Fri,  9 Oct 2020 08:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602232312;
        bh=tbYuOpQDVa83BZYltjwMSS2+tI316DFb2wbnl2m8DrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Waaes3G6nyzIcv5Vfex9WPbs3koRa1o0GU5V/xaGIGmEV1UgzMPw1Yg1J93tyTYdF
         sUYTv2ELdpgEpZ6dUvWnBfyJi6g26L+PY9GLyPAhuiZbFb4vXZTlqmgTHefQWFWaDW
         VKLdnq/Uey+VjsWuOZP3pMAj7gRGNQVYkH9ersyQ=
Date:   Fri, 9 Oct 2020 09:31:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Qais Yousef <qais.yousef@arm.com>, linux-arch@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 3/3] arm64: Handle AArch32 tasks running on non
 AArch32 cpu
Message-ID: <20201009083146.GA29594@willie-the-truck>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-4-qais.yousef@arm.com>
 <20201009072943.GD2628@hirez.programming.kicks-ass.net>
 <20201009081312.GA8004@e123083-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009081312.GA8004@e123083-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 09, 2020 at 10:13:12AM +0200, Morten Rasmussen wrote:
> On Fri, Oct 09, 2020 at 09:29:43AM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 08, 2020 at 07:16:41PM +0100, Qais Yousef wrote:
> > > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > > index cf94cc248fbe..7e97f1589f33 100644
> > > --- a/arch/arm64/kernel/signal.c
> > > +++ b/arch/arm64/kernel/signal.c
> > > @@ -908,13 +908,28 @@ static void do_signal(struct pt_regs *regs)
> > >  	restore_saved_sigmask();
> > >  }
> > >  
> > > +static void set_32bit_cpus_allowed(void)
> > >  {
> > > +	cpumask_var_t cpus_allowed;
> > > +	int ret = 0;
> > > +
> > > +	if (cpumask_subset(current->cpus_ptr, &aarch32_el0_mask))
> > > +		return;
> > > +
> > >  	/*
> > > +	 * On asym aarch32 systems, if the task has invalid cpus in its mask,
> > > +	 * we try to fix it by removing the invalid ones.
> > >  	 */
> > > +	if (!alloc_cpumask_var(&cpus_allowed, GFP_ATOMIC)) {
> > > +		ret = -ENOMEM;
> > > +	} else {
> > > +		cpumask_and(cpus_allowed, current->cpus_ptr, &aarch32_el0_mask);
> > > +		ret = set_cpus_allowed_ptr(current, cpus_allowed);
> > > +		free_cpumask_var(cpus_allowed);
> > > +	}
> > > +
> > > +	if (ret) {
> > > +		pr_warn_once("Failed to fixup affinity of running 32-bit task\n");
> > >  		force_sig(SIGKILL);
> > >  	}
> > >  }
> > 
> > Yeah, no. Not going to happen.
> > 
> > Fundamentally, you're not supposed to change the userspace provided
> > affinity mask. If we want to do something like this, we'll have to teach
> > the scheduler about this second mask such that it can compute an
> > effective mask as the intersection between the 'feature' and user mask.
> 
> I agree that we shouldn't mess wit the user-space mask directly. Would it
> be unthinkable to go down the route of maintaining a new mask which is
> the intersection of the feature mask (controlled and updated by arch
> code) and the user-space mask?
> 
> It shouldn't add overhead in the scheduler as it would use the
> intersection mask instead of the user-space mask, the main complexity
> would be around making sure the intersection mask is updated correctly
> (cpusets, hotplug, ...).
> 
> Like the above tweak, this won't help if the intersection mask is empty,
> task will still get killed but it will allow tasks to survive
> user-space masks including some non-compatible CPUs. If we want to
> prevent task killing in all cases (ignoring hotplug) it gets more ugly
> as we would have to ignore the user-space mask in some cases.

Honestly, I don't understand why we're trying to hide this asymmetry from
userspace by playing games with affinity masks in the kernel. Userspace
is likely to want to move things about _anyway_ because even amongst the
32-bit capable cores, you may well have different clock frequencies to
contend with.

So I'd be *much* happier to let the schesduler do its thing, and if one
of these 32-bit tasks ends up on a core that can't deal with it, then
tough, it gets killed. Give userspace the information it needs to avoid
that happening in the first place, rather than implicitly limit the mask.

That way, the kernel support really boils down to two parts:

  1. Remove the sanity checks we have to prevent 32-bit applications running
     on asymmetric systems

  2. Tell userspace about the problem

Will
