Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89312CBEC0
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgLBNxH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 08:53:07 -0500
Received: from foss.arm.com ([217.140.110.172]:40150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgLBNxH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 08:53:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 191E230E;
        Wed,  2 Dec 2020 05:52:21 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB2393F718;
        Wed,  2 Dec 2020 05:52:18 -0800 (PST)
Date:   Wed, 2 Dec 2020 13:52:16 +0000
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
Subject: Re: [PATCH v4 04/14] arm64: Kill 32-bit applications scheduled on
 64-bit-only CPUs
Message-ID: <20201202135216.7jilpcvocnqqp5aj@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-5-will@kernel.org>
 <20201127131217.skekrybqjdidm5ki@e107158-lin.cambridge.arm.com>
 <20201201165633.GC27783@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201165633.GC27783@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/01/20 16:56, Will Deacon wrote:
> On Fri, Nov 27, 2020 at 01:12:17PM +0000, Qais Yousef wrote:
> > On 11/24/20 15:50, Will Deacon wrote:
> > > Scheduling a 32-bit application on a 64-bit-only CPU is a bad idea.
> > > 
> > > Ensure that 32-bit applications always take the slow-path when returning
> > > to userspace on a system with mismatched support at EL0, so that we can
> > > avoid trying to run on a 64-bit-only CPU and force a SIGKILL instead.
> > > 
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > 
> > nit: We drop this patch at the end. Can't we avoid it altogether instead?
> 
> I did it like this so that the last patch can be reverted for
> testing/debugging, but also because I think it helps the structure of the
> series.

Cool. I had a comment about the barrier(), you were worried about
cpu_affinity_invalid() being inlined by the compiler and then things get
mangled such that TIF_NOTIFY_RESUME clearing is moved after the call as you
described? Can the compiler move things if cpu_affinity_invalid() is a proper
function call (not inlined)?

> 
> > > diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> > > index a8184cad8890..bcb6ca2d9a7c 100644
> > > --- a/arch/arm64/kernel/signal.c
> > > +++ b/arch/arm64/kernel/signal.c
> > > @@ -911,6 +911,19 @@ static void do_signal(struct pt_regs *regs)
> > >  	restore_saved_sigmask();
> > >  }
> > >  
> > > +static bool cpu_affinity_invalid(struct pt_regs *regs)
> > > +{
> > > +	if (!compat_user_mode(regs))
> > > +		return false;
> > 
> > Silly question. Is there an advantage of using compat_user_mode() vs
> > is_compat_task()? I see the latter used in the file although struct pt_regs
> > *regs is passed to the functions calling it.
> > 
> > Nothing's wrong with it, just curious.
> 
> Not sure about advantages, but is_compat_task() is available in core code,
> whereas compat_user_mode() is specific to arm64. The former implicitly
> operates on 'current' and just checks thread flag, whereas the latter
> actually goes and looks at mode field of the spsr to see what we're
> going to be returning into.

Okay, so just 2 different ways to do the same thing and you happened to pick
the one that first came to mind.

Thanks

--
Qais Yousef
