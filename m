Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A437399F56
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 12:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFCLAr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 07:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229610AbhFCLAr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 07:00:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2EA860FEE;
        Thu,  3 Jun 2021 10:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622717942;
        bh=KemI2Hd6fvYHivyCBcAgtmkUK8KyXDbKOjArerr5H9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOskmeuYODybu+Le9EqSFv8m4vtXmVKZPX3iqKfCZYwJmQMPwjyCcXLrQGCmXYRC1
         jRhZ5CmlVW3uJwkW4mjwdGnm77gOJnpm4BwStCecnpNNt4IxvqloKhUYFuE9Xt5oTl
         efqZJhkeTnXqbdKb0VfUReNCy5EuP2efSntBGzXizL89biXX5DreRvA7vjeMeJV70o
         IkElmJT4B45BNSEhUQrCvvb5jW4r9egH9irbFQLD4JicQIlmu9OHNHXLpj+1yqGkMy
         8DF81nhLwXg6b4k2JjiW9jfHYshGbtGqe269lBYwUxbuOuf1sYVfwQQiqQYqSN792z
         iLW7l/kGfxn9g==
Date:   Thu, 3 Jun 2021 11:58:56 +0100
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
        kernel-team@android.com, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <20210603105856.GB32641@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YLXt+/Wr5/KWymPC@hirez.programming.kicks-ass.net>
 <YLYZv4v68OnAlx+3@hirez.programming.kicks-ass.net>
 <20210602125452.GG30593@willie-the-truck>
 <YLiwahWvnnkeL+vc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLiwahWvnnkeL+vc@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 03, 2021 at 12:35:22PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 02, 2021 at 01:54:53PM +0100, Will Deacon wrote:
> 
> > There's also Documentation/power/freezing-of-tasks.rst to update. I'm not
> 
> Since it's .rst, the only update I'm willing to do is delete it
> outright.

Hah! Well, don't do that.

> > sure if fs/proc/array.c should be updated to display frozen tasks; I
> > couldn't see how that was useful, but thought I'd mention it anyway.
> 
> Yeah, I considered it too, but I figured that if we're all frozen
> there's noone left to observe us being frozen, so I didn't bother.

Agreed.

> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index 2982cfab1ae9..bfadc1dbcf24 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -95,7 +95,12 @@ struct task_group;
> > >  #define TASK_WAKING			0x0200
> > >  #define TASK_NOLOAD			0x0400
> > >  #define TASK_NEW			0x0800
> > > -#define TASK_STATE_MAX			0x1000
> > > +#define TASK_FREEZABLE			0x1000
> > > +#define __TASK_FREEZABLE_UNSAFE		0x2000
> > 
> > Give that this is only needed to avoid lockdep checks, maybe we should avoid
> > allocating the bit if lockdep is not enabled? Otherwise, people might start
> > to use it for other things.
> 
> Something like
> 
> #define __TASK_FREEZABLE_UNSAFE			(0x2000 * IS_ENABLED(CONFIG_LOCKDEP))
> 
> ?

Yup.

> > > +#define TASK_FROZEN			0x4000
> > > +#define TASK_STATE_MAX			0x8000
> > > +
> > > +#define TASK_FREEZABLE_UNSAFE		(TASK_FREEZABLE | __TASK_FREEZABLE_UNSAFE)
> > 
> > We probably want to preserve the "DO NOT ADD ANY NEW CALLERS OF THIS STATE"
> > comment for the unsafe stuff.
> 
> Done.

Thanks.

> > > +/* Recursion relies on tail-call optimization to not blow away the stack */
> > > +static bool __frozen(struct task_struct *p)
> > > +{
> > > +	if (p->state == TASK_FROZEN)
> > > +		return true;
> > 
> > READ_ONCE()?
> 
> task_struct::state is volatile -- for now. I've got other patches to
> deal with that.

Thanks, I missed that and have since reviewed your other series.

> > > @@ -116,20 +173,8 @@ bool freeze_task(struct task_struct *p)
> > >  {
> > >  	unsigned long flags;
> > >  
> > >  	spin_lock_irqsave(&freezer_lock, flags);
> > > +	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
> > >  		spin_unlock_irqrestore(&freezer_lock, flags);
> > >  		return false;
> > >  	}
> > 
> > I've been trying to figure out how this serialises with ttwu(), given that
> > frozen(p) will go and read p->state. I suppose it works out because only the
> > freezer can wake up tasks from the FROZEN state, but it feels a bit brittle.
> 
> p->pi_lock; both ttwu() and __freeze_task() (which is essentially a
> variant of set_special_state()) take ->pi_lock. I'll put in a comment.

The part I struggled with was freeze_task(), which doesn't take ->pi_lock
yet calls frozen(p).

> 
> > > @@ -137,7 +182,7 @@ bool freeze_task(struct task_struct *p)
> > >  	if (!(p->flags & PF_KTHREAD))
> > >  		fake_signal_wake_up(p);
> > >  	else
> > > -		wake_up_state(p, TASK_INTERRUPTIBLE);
> > > +		wake_up_state(p, TASK_INTERRUPTIBLE); // TASK_NORMAL ?!?
> > >  
> > >  	spin_unlock_irqrestore(&freezer_lock, flags);
> > >  	return true;
> > > @@ -148,8 +193,8 @@ void __thaw_task(struct task_struct *p)
> > >  	unsigned long flags;
> > >  
> > >  	spin_lock_irqsave(&freezer_lock, flags);
> > > -	if (frozen(p))
> > > -		wake_up_process(p);
> > > +	WARN_ON_ONCE(freezing(p));
> > > +	wake_up_state(p, TASK_FROZEN | TASK_NORMAL);
> > 
> > Why do we need TASK_NORMAL here?
> 
> It's a left-over from hacking, but I left it in because anything
> TASK_NORMAL should be able to deal with spuriuos wakeups, something
> try_to_freeze() now also relies on.

I just worry that it might hide bugs if TASK_FROZEN is supposed to be
sufficient, as it would imply that we have some unfrozen tasks kicking
around. I dunno, maybe just a comment saying that everything _should_ be
FROZEN at this point?

Will
