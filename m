Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37821399F09
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 12:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFCKhU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhFCKhT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2021 06:37:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C4C06174A;
        Thu,  3 Jun 2021 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gOJNBm3mAGq0zAQTkuVR7PBi0NVymxc7LOWCrLlQHr0=; b=gLWID2tJU79aIIlcZxZ6dS4tjD
        eOMgpxrPpNa7qwk7FqCTIQr6+bsEG6AnUycxND7lhYLQXwu8xICNKeTspzwVNNeHwuSng2mbanawl
        5oumS4o4fDJ+pFlVxSl3pNbxBE4csks6B39/rUIcY5qUAwBR5ttn+j8REBjy3zlfxfrJrss2lKB/2
        dxvGZdASjOIfPiGrsnAs8uJTjN+MfMqZgq+7hLxCXZYw6/B5DE2w2/I7HGFZCmmJRR0ad7rJcZAm5
        LXf/Ecd8QSQJwXxYFmV01Bztjr9BgYlzhytMEqkMvxE7NF3nOcTlk1S24O2p3ZFP+KG1RP4FtObN2
        YD+gyytQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lokh2-0037ab-VZ; Thu, 03 Jun 2021 10:35:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C02AA300223;
        Thu,  3 Jun 2021 12:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A210B200AD120; Thu,  3 Jun 2021 12:35:22 +0200 (CEST)
Date:   Thu, 3 Jun 2021 12:35:22 +0200
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH] freezer,sched: Rewrite core freezer logic
Message-ID: <YLiwahWvnnkeL+vc@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YLXt+/Wr5/KWymPC@hirez.programming.kicks-ass.net>
 <YLYZv4v68OnAlx+3@hirez.programming.kicks-ass.net>
 <20210602125452.GG30593@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602125452.GG30593@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 02, 2021 at 01:54:53PM +0100, Will Deacon wrote:

> There's also Documentation/power/freezing-of-tasks.rst to update. I'm not

Since it's .rst, the only update I'm willing to do is delete it
outright.

> sure if fs/proc/array.c should be updated to display frozen tasks; I
> couldn't see how that was useful, but thought I'd mention it anyway.

Yeah, I considered it too, but I figured that if we're all frozen
there's noone left to observe us being frozen, so I didn't bother.

> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 2982cfab1ae9..bfadc1dbcf24 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -95,7 +95,12 @@ struct task_group;
> >  #define TASK_WAKING			0x0200
> >  #define TASK_NOLOAD			0x0400
> >  #define TASK_NEW			0x0800
> > -#define TASK_STATE_MAX			0x1000
> > +#define TASK_FREEZABLE			0x1000
> > +#define __TASK_FREEZABLE_UNSAFE		0x2000
> 
> Give that this is only needed to avoid lockdep checks, maybe we should avoid
> allocating the bit if lockdep is not enabled? Otherwise, people might start
> to use it for other things.

Something like

#define __TASK_FREEZABLE_UNSAFE			(0x2000 * IS_ENABLED(CONFIG_LOCKDEP))

?

> > +#define TASK_FROZEN			0x4000
> > +#define TASK_STATE_MAX			0x8000
> > +
> > +#define TASK_FREEZABLE_UNSAFE		(TASK_FREEZABLE | __TASK_FREEZABLE_UNSAFE)
> 
> We probably want to preserve the "DO NOT ADD ANY NEW CALLERS OF THIS STATE"
> comment for the unsafe stuff.

Done.

> > +/* Recursion relies on tail-call optimization to not blow away the stack */
> > +static bool __frozen(struct task_struct *p)
> > +{
> > +	if (p->state == TASK_FROZEN)
> > +		return true;
> 
> READ_ONCE()?

task_struct::state is volatile -- for now. I've got other patches to
deal with that.

> > +
> > +	/*
> > +	 * If stuck in TRACED, and the ptracer is FROZEN, we're frozen too.
> > +	 */
> > +	if (task_is_traced(p))
> > +		return frozen(rcu_dereference(p->parent));
> > +
> > +	/*
> > +	 * If stuck in STOPPED and the parent is FROZEN, we're frozen too.
> > +	 */
> > +	if (task_is_stopped(p))
> > +		return frozen(rcu_dereference(p->real_parent));
> 
> This looks convincing, but I really can't tell if we're missing anything.

Yeah, Oleg would be the one to tell us I suppose.

> > +static bool __freeze_task(struct task_struct *p)
> > +{
> > +	unsigned long flags;
> > +	unsigned int state;
> > +	bool frozen = false;
> > +
> > +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> > +	state = READ_ONCE(p->state);
> > +	if (state & TASK_FREEZABLE) {
> > +		/*
> > +		 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE,
> > +		 * since they can suffer spurious wakeups.
> > +		 */
> > +		WARN_ON_ONCE(!(state & TASK_NORMAL));
> > +
> > +#ifdef CONFIG_LOCKDEP
> > +		/*
> > +		 * It's dangerous to freeze with locks held; there be dragons there.
> > +		 */
> > +		if (!(state & __TASK_FREEZABLE_UNSAFE))
> > +			WARN_ON_ONCE(debug_locks && p->lockdep_depth);
> > +#endif
> > +
> > +		p->state = TASK_FROZEN;
> > +		frozen = true;
> > +	}
> > +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> > +
> > +	return frozen;
> > +}
> > +
> >  /**
> >   * freeze_task - send a freeze request to given task
> >   * @p: task to send the request to
> > @@ -116,20 +173,8 @@ bool freeze_task(struct task_struct *p)
> >  {
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&freezer_lock, flags);
> > +	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
> >  		spin_unlock_irqrestore(&freezer_lock, flags);
> >  		return false;
> >  	}
> 
> I've been trying to figure out how this serialises with ttwu(), given that
> frozen(p) will go and read p->state. I suppose it works out because only the
> freezer can wake up tasks from the FROZEN state, but it feels a bit brittle.

p->pi_lock; both ttwu() and __freeze_task() (which is essentially a
variant of set_special_state()) take ->pi_lock. I'll put in a comment.

> > @@ -137,7 +182,7 @@ bool freeze_task(struct task_struct *p)
> >  	if (!(p->flags & PF_KTHREAD))
> >  		fake_signal_wake_up(p);
> >  	else
> > -		wake_up_state(p, TASK_INTERRUPTIBLE);
> > +		wake_up_state(p, TASK_INTERRUPTIBLE); // TASK_NORMAL ?!?
> >  
> >  	spin_unlock_irqrestore(&freezer_lock, flags);
> >  	return true;
> > @@ -148,8 +193,8 @@ void __thaw_task(struct task_struct *p)
> >  	unsigned long flags;
> >  
> >  	spin_lock_irqsave(&freezer_lock, flags);
> > -	if (frozen(p))
> > -		wake_up_process(p);
> > +	WARN_ON_ONCE(freezing(p));
> > +	wake_up_state(p, TASK_FROZEN | TASK_NORMAL);
> 
> Why do we need TASK_NORMAL here?

It's a left-over from hacking, but I left it in because anything
TASK_NORMAL should be able to deal with spuriuos wakeups, something
try_to_freeze() now also relies on.

