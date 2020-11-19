Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5DD2B9850
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgKSQmU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgKSQmT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 11:42:19 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C027C0613CF;
        Thu, 19 Nov 2020 08:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ro7/mwg9uhblYjtHtV4hug/+uxfQeXmbXjYfMe3rxNM=; b=as9DMQ5vEGp/bNqLKJ05+8QGK1
        a2D6a9ywZtFVVYX/O2qMv7ajhX+X5OhQep+jZoZrNeKke2lePW0ZETY6R5bSjfm6QfkIo5BE1xWPf
        aviNzTqTAcGqJgH6FJ/LyQFQ0m4ufALpiRPoHwmgVqQRF4QZTQixZ/2SSad78tng2Qvq5zwEpRilw
        dsJKooRY9sBbtBLW5UD/aG/daO+AKf18bTeCxvpt/bI9BzcQMKEf3nGQM0l3dfluVKvRm6FfZlU4w
        +1RzV8yvXie/5wurglRv8HhNvdsujNArEi1yI4AFJLzpnwDJfJqKTfNY5AQ3IqzOUjJf68rHbxGBD
        qa+S17Nw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfn0W-0000Oi-71; Thu, 19 Nov 2020 16:42:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F88D3019CE;
        Thu, 19 Nov 2020 17:42:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 193C9200E0A43; Thu, 19 Nov 2020 17:42:03 +0100 (CET)
Date:   Thu, 19 Nov 2020 17:42:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20201119164203.GU3121392@hirez.programming.kicks-ass.net>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-9-will@kernel.org>
 <20201119161448.GR3121392@hirez.programming.kicks-ass.net>
 <20201119162822.GA4582@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119162822.GA4582@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 04:28:23PM +0000, Will Deacon wrote:
> On Thu, Nov 19, 2020 at 05:14:48PM +0100, Peter Zijlstra wrote:
> > On Fri, Nov 13, 2020 at 09:37:13AM +0000, Will Deacon wrote:
> > > When exec'ing a 32-bit task on a system with mismatched support for
> > > 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> > > run it.
> > > 
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  arch/arm64/kernel/process.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > index 1540ab0fbf23..17b94007fed4 100644
> > > --- a/arch/arm64/kernel/process.c
> > > +++ b/arch/arm64/kernel/process.c
> > > @@ -625,6 +625,16 @@ unsigned long arch_align_stack(unsigned long sp)
> > >  	return sp & ~0xf;
> > >  }
> > >  
> > > +static void adjust_compat_task_affinity(struct task_struct *p)
> > > +{
> > > +	const struct cpumask *mask = system_32bit_el0_cpumask();
> > > +
> > > +	if (restrict_cpus_allowed_ptr(p, mask))
> > > +		set_cpus_allowed_ptr(p, mask);
> > 
> > This silently destroys user state, at the very least that ought to go
> > with a WARN or something. Ideally SIGKILL though. What's to stop someone
> > from doing a sched_setaffinity() right after the execve, same problem.
> > So why bother..
> 
> It's no different to CPU hot-unplug though, is it? From the perspective of
> the 32-bit task, the 64-bit-only cores were hot-unplugged at the point of
> execve(). Calls to sched_setaffinity() for 32-bit tasks will reject attempts
> to include 64-bit-only cores.

select_fallback_rq() has a printk() in to at least notify things went
bad. But I don't particularly like the current hotplug semantics; I've
wanted to disallow the hotplug when it would result in this case, but
computing that is tricky. It's one of those things that's forever on the
todo list ... :/

> I initially wanted to punt this all to userspace, but one of the big
> problems with that is when a 64-bit task is running on a CPU only capable
> of running 64-bit tasks and it execve()s a 32-bit task. At the point, we
> have to do something because we can't even run the new task for it to do
> a sched_affinity() call (and we also can't deliver SIGILL).

Userspace can see that one coming though...  I suppose you can simply
make the execve fail before the point of no return.
