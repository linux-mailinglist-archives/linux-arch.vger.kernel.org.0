Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B241B2B985B
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgKSQo1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgKSQo0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 11:44:26 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8C6C0613CF;
        Thu, 19 Nov 2020 08:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wsLfXjOUb7k94iVGlwmbXuzfOOU9iLV4p1vlaVNg328=; b=aPw2cjLEbuAk9sffw1SyN12mzE
        xGA3HaEVMjcPXoGk0MCUQlqIGOBeWK1oAX0Ji1bp9JH/5r3oohaA6Egr1/k3AU3+G4uTlULqeXlxZ
        gYAEOukuxEpzsBfzFt3mly3eT9O33XM5BnyyHbTK6fN+WjvV6bpVYQmlyjVYBGJzSwmiH21JfQ5ht
        22pms09JsVLwwFZ6UGElKJdY3scHWGGW/d4FQwI7qYAD8ngvf6IFcxpNXd/EzNLa4YOBf5pGE1kEc
        2Qe6TFk/5FRrJGJcP3F0NKTlIgMcW/nXWEyT1Kg6rSjbSjrjUU9SBGNzgZOpd1+/P+Kf3uco3WWcq
        f2GYv0ug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfn2c-0000Sq-BE; Thu, 19 Nov 2020 16:44:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3673E300F7A;
        Thu, 19 Nov 2020 17:44:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20E982C37252F; Thu, 19 Nov 2020 17:44:11 +0100 (CET)
Date:   Thu, 19 Nov 2020 17:44:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20201119164411.GV3121392@hirez.programming.kicks-ass.net>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-9-will@kernel.org>
 <20201119092407.GB2416649@google.com>
 <20201119110603.GB3946@willie-the-truck>
 <20201119161956.GS3121392@hirez.programming.kicks-ass.net>
 <20201119163035.GB4582@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119163035.GB4582@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 04:30:36PM +0000, Will Deacon wrote:
> On Thu, Nov 19, 2020 at 05:19:56PM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 19, 2020 at 11:06:04AM +0000, Will Deacon wrote:
> > > On Thu, Nov 19, 2020 at 09:24:07AM +0000, Quentin Perret wrote:
> > > > On Friday 13 Nov 2020 at 09:37:13 (+0000), Will Deacon wrote:
> > > > > When exec'ing a 32-bit task on a system with mismatched support for
> > > > > 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> > > > > run it.
> > > > > 
> > > > > Signed-off-by: Will Deacon <will@kernel.org>
> > > > > ---
> > > > >  arch/arm64/kernel/process.c | 12 +++++++++++-
> > > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > > > > index 1540ab0fbf23..17b94007fed4 100644
> > > > > --- a/arch/arm64/kernel/process.c
> > > > > +++ b/arch/arm64/kernel/process.c
> > > > > @@ -625,6 +625,16 @@ unsigned long arch_align_stack(unsigned long sp)
> > > > >  	return sp & ~0xf;
> > > > >  }
> > > > >  
> > > > > +static void adjust_compat_task_affinity(struct task_struct *p)
> > > > > +{
> > > > > +	const struct cpumask *mask = system_32bit_el0_cpumask();
> > > > > +
> > > > > +	if (restrict_cpus_allowed_ptr(p, mask))
> > > > > +		set_cpus_allowed_ptr(p, mask);
> > > > 
> > > > My understanding of this call to set_cpus_allowed_ptr() is that you're
> > > > mimicking the hotplug vs affinity case behaviour in some ways. That is,
> > > > if a task is pinned to a CPU and userspace hotplugs that CPU, then the
> > > > kernel will reset the affinity of the task to the remaining online CPUs.
> > > 
> > > Correct. It looks to the 32-bit application like all the 64-bit-only CPUs
> > > were hotplugged off at the point of the execve().
> > 
> > This doesn't respect cpusets though :/
> 
> How does that differ from select_fallback_rq()?

That has that cpuset state it tries first, only if that fails does it do
the possible mask.

