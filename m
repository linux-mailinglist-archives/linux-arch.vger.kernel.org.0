Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4242B97AB
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKSQUN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgKSQUM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Nov 2020 11:20:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68996C0613CF;
        Thu, 19 Nov 2020 08:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bOVCXTn/e5HaxBsvxwaKXYiTGTqcPOSmIoQubGqoKvM=; b=kSazHfeXo+LkV2Vie2s2quIyRx
        M/ywH8ECFNlDmcfEbgXjHfgLa4dd6Qgp2Eo0SmcDHxNRI/muOcTgs7hb5ZlhzvE/2/2/bv6pIlF3r
        ixoqUZ/RPFFartamavEWuqbVaQpTe863dRoOWrJkb4PsSSLO/6Up27jsNUaV5kpQYFeGSrhTAAzsv
        IOB7F/kPJxtjwdi6FjLi04bBstADgdr5j+2q3B4r7sqorsrWBrz2Dv/xdtshuyp3YIj0Qdw66HjnU
        5upweAbbYN3JiA3lUyG+kS7LdxXdtVntHGQLXBIYCeHYDsBPCQ30llVfuBFV02PVnQTjG/ee6SUb4
        m/E9uv8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfmf7-0007Hj-K5; Thu, 19 Nov 2020 16:19:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DA1CA3019CE;
        Thu, 19 Nov 2020 17:19:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C2D9C200E0A45; Thu, 19 Nov 2020 17:19:56 +0100 (CET)
Date:   Thu, 19 Nov 2020 17:19:56 +0100
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
Message-ID: <20201119161956.GS3121392@hirez.programming.kicks-ass.net>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-9-will@kernel.org>
 <20201119092407.GB2416649@google.com>
 <20201119110603.GB3946@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119110603.GB3946@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 11:06:04AM +0000, Will Deacon wrote:
> On Thu, Nov 19, 2020 at 09:24:07AM +0000, Quentin Perret wrote:
> > On Friday 13 Nov 2020 at 09:37:13 (+0000), Will Deacon wrote:
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
> > My understanding of this call to set_cpus_allowed_ptr() is that you're
> > mimicking the hotplug vs affinity case behaviour in some ways. That is,
> > if a task is pinned to a CPU and userspace hotplugs that CPU, then the
> > kernel will reset the affinity of the task to the remaining online CPUs.
> 
> Correct. It looks to the 32-bit application like all the 64-bit-only CPUs
> were hotplugged off at the point of the execve().

This doesn't respect cpusets though :/
