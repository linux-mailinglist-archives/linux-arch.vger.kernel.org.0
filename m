Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C932B9891
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgKSQtD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:49:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgKSQtC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 11:49:02 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCB9F2222A;
        Thu, 19 Nov 2020 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605804541;
        bh=ns5wbhzeg4dC+prdvUnrFedGYQBDPfSDGGmE4SbJ3+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eta835dkweaJOJWk+x5fJSzaMhHso83BKyz95Plc9rIVVdCgqlGnbf7WRksirWXWY
         Cy1gXw49m8aDDLvuDnvwSKwh/WkPXLCh7d5V4iroJ/XYC1D1tOKmqtg8FGX/w442qm
         26RnQbEr+8NB3BcUcIqD5gGKgQrmbq3vJUnLoC90=
Date:   Thu, 19 Nov 2020 16:48:55 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 08/14] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
Message-ID: <20201119164853.GF4582@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-9-will@kernel.org>
 <20201119161448.GR3121392@hirez.programming.kicks-ass.net>
 <20201119162822.GA4582@willie-the-truck>
 <20201119164203.GU3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164203.GU3121392@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 05:42:03PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 19, 2020 at 04:28:23PM +0000, Will Deacon wrote:
> > On Thu, Nov 19, 2020 at 05:14:48PM +0100, Peter Zijlstra wrote:
> > > On Fri, Nov 13, 2020 at 09:37:13AM +0000, Will Deacon wrote:
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
> > > This silently destroys user state, at the very least that ought to go
> > > with a WARN or something. Ideally SIGKILL though. What's to stop someone
> > > from doing a sched_setaffinity() right after the execve, same problem.
> > > So why bother..
> > 
> > It's no different to CPU hot-unplug though, is it? From the perspective of
> > the 32-bit task, the 64-bit-only cores were hot-unplugged at the point of
> > execve(). Calls to sched_setaffinity() for 32-bit tasks will reject attempts
> > to include 64-bit-only cores.
> 
> select_fallback_rq() has a printk() in to at least notify things went
> bad. But I don't particularly like the current hotplug semantics; I've
> wanted to disallow the hotplug when it would result in this case, but
> computing that is tricky. It's one of those things that's forever on the
> todo list ... :/

I know that feeling...

I can add a printk() in the case where we override the mask (I think taking
the subset is ok), since I agree that it would be better if userspace had
had the foresight to avoid the situation in the first place.

> > I initially wanted to punt this all to userspace, but one of the big
> > problems with that is when a 64-bit task is running on a CPU only capable
> > of running 64-bit tasks and it execve()s a 32-bit task. At the point, we
> > have to do something because we can't even run the new task for it to do
> > a sched_affinity() call (and we also can't deliver SIGILL).
> 
> Userspace can see that one coming though...  I suppose you can simply
> make the execve fail before the point of no return.

If we could open up all the 32-bit apps out there and fix them, then I'd be
more sympathetic, but the reality is that we need to run existing binaries
on these stupid systems and exec'ing 32-bit payloads from 64-bit tasks is
something that we need to continue to support.

If it makes things any better, all of this stuff is off by default and gated
on a cmdline option.

Will
