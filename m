Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B33D393135
	for <lists+linux-arch@lfdr.de>; Thu, 27 May 2021 16:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhE0Opy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 May 2021 10:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhE0Opv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 May 2021 10:45:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 825CF61181;
        Thu, 27 May 2021 14:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622126658;
        bh=bC9l7MRsxVJ2kY1MsF0KeFCAkODPDJOZ+Ldk31//gtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CGMYmmsX+GwjQ4QJpoNA3tllJTW+i8lxKQRNYU4scvoTSMQI67B9xFMjxWEBvMQhl
         h7doWGV3LCla6k4h+egE1uVipNEO/eCAQM48UiakRiPtCdEpw8PEDU+EPzTxFrnM47
         Z5NzykJr3DJZX0WiWU6tyyhMXuTzW1xVUv+3p+atck1Gt1ALC7bDRC79z135cTRibo
         Vd88Ix9Px34jUaluSJD5Ss1RjLvEFypalPshY1Kxe4ZTsRWiZ+fVjAeAWwqhLvY7fW
         A7HkAkxUkB8ys3aBuIxDhlb40Qg1do3JdBqlnIh0xeOCTf9LdQZ/yjuq4AeqbFvK/+
         27cvAxLOpuNIA==
Date:   Thu, 27 May 2021 15:44:12 +0100
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 16/22] sched: Defer wakeup in ttwu() for unschedulable
 frozen tasks
Message-ID: <20210527144412.GB23086@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YK+oSPlNQJKiMYYc@hirez.programming.kicks-ass.net>
 <YK+tV/DTNlpGJ7J8@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK+tV/DTNlpGJ7J8@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 27, 2021 at 04:31:51PM +0200, Peter Zijlstra wrote:
> On Thu, May 27, 2021 at 04:10:16PM +0200, Peter Zijlstra wrote:
> > On Tue, May 25, 2021 at 04:14:26PM +0100, Will Deacon wrote:
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 42e2aecf087c..6cb9677d635a 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3529,6 +3529,19 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> > >  	if (!(p->state & state))
> > >  		goto unlock;
> > >  
> > > +#ifdef CONFIG_FREEZER
> > > +	/*
> > > +	 * If we're going to wake up a thread which may be frozen, then
> > > +	 * we can only do so if we have an active CPU which is capable of
> > > +	 * running it. This may not be the case when resuming from suspend,
> > > +	 * as the secondary CPUs may not yet be back online. See __thaw_task()
> > > +	 * for the actual wakeup.
> > > +	 */
> > > +	if (unlikely(frozen_or_skipped(p)) &&
> > > +	    !cpumask_intersects(cpu_active_mask, task_cpu_possible_mask(p)))
> > > +		goto unlock;
> > > +#endif
> > > +
> > >  	trace_sched_waking(p);
> > >  
> > >  	/* We're going to change ->state: */
> > 
> > OK, I really hate this. This is slowing down the very hot wakeup path
> > for the silly freezer that *never* happens. Let me try and figure out if
> > there's another option.
> 
> 
> How's something *completely* untested like this?

I'm not seeing how this handles tasks which weren't put in the freezer
because they have PF_FREEZER_SKIP set. For these tasks, we need to make
sure that they don't become runnable before we have onlined a core which
is capable of running them, and this could occur because of any old
wakeup (i.e. whatever it was that they blocked on).

Will
