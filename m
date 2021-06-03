Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC04399FE5
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 13:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhFCLhy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 07:37:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhFCLhw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 07:37:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCF37613E7;
        Thu,  3 Jun 2021 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622720168;
        bh=C9DIzOphc6fr5cipQlhio6wxZ4sUPuZ30lMxnkXl5Zo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fz0CjwTisYMYUbWkaIXzpxZbgQn4ts9xE44dNWjcSFJzrNicz+zKibeah6MY/sIBq
         FrXC6uzanqvQXWP/INu3jhmPEpJHSBWyC/nrmX4qXxfgEtvYwibg+bt1Z9f0Fzlcif
         3DOicRZL1uus5oUTTP5FrlXBArMImqiV4Ohb8zb1FOB8GAFIzpHCoEfDtql5qsxM7s
         wfiANDoD9vVykwpWlEFWlwbJQs4HNuHZClZacw0gftegHMeC70oHX3xlP31TDAPaL7
         nmZwnN8AINC12/aSmrsM6HQwF7UEEz1QMlnlaPDol9wosiiDVrE2NNnkga0v6O/iEo
         nbvg5GDTnO+mQ==
Date:   Thu, 3 Jun 2021 12:36:01 +0100
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
Message-ID: <20210603113600.GA592@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YLXt+/Wr5/KWymPC@hirez.programming.kicks-ass.net>
 <YLYZv4v68OnAlx+3@hirez.programming.kicks-ass.net>
 <20210602125452.GG30593@willie-the-truck>
 <YLiwahWvnnkeL+vc@hirez.programming.kicks-ass.net>
 <20210603105856.GB32641@willie-the-truck>
 <YLi8Ttw3Xb3ynUW2@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLi8Ttw3Xb3ynUW2@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 03, 2021 at 01:26:06PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 03, 2021 at 11:58:56AM +0100, Will Deacon wrote:
> > On Thu, Jun 03, 2021 at 12:35:22PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 02, 2021 at 01:54:53PM +0100, Will Deacon wrote:
> 
> > > > > @@ -116,20 +173,8 @@ bool freeze_task(struct task_struct *p)
> > > > >  {
> > > > >  	unsigned long flags;
> > > > >  
> > > > >  	spin_lock_irqsave(&freezer_lock, flags);
> > > > > +	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
> > > > >  		spin_unlock_irqrestore(&freezer_lock, flags);
> > > > >  		return false;
> > > > >  	}
> > > > 
> > > > I've been trying to figure out how this serialises with ttwu(), given that
> > > > frozen(p) will go and read p->state. I suppose it works out because only the
> > > > freezer can wake up tasks from the FROZEN state, but it feels a bit brittle.
> > > 
> > > p->pi_lock; both ttwu() and __freeze_task() (which is essentially a
> > > variant of set_special_state()) take ->pi_lock. I'll put in a comment.
> > 
> > The part I struggled with was freeze_task(), which doesn't take ->pi_lock
> > yet calls frozen(p).
> 
> Ah, I can't read... I assumed you were asking about __freeze_task().
> 
> So frozen(p) checks for p->state == TASK_FROZEN (and complicated), which
> is a stable state. Once you're frozen you stay frozen until thaw, which
> is after freezing per construction.
> 
> The tricky bit is __freeze_task(), that does take pi_lock. It checks for
> FREEZABLE and if set, changes to FROZEN. And this does in fact race with
> ttwu() and relies on pi_lock to serialize.
> 
> A concurrent wakeup (from a non-frozen task) can try and wake the task
> we're trying to freeze. If we win, ttwu will see FROZEN and ignore, if
> ttwu() wins, we don't see FREEZABLE and do another round of freezing.

Good, thanks. That's where I'd ended up. It means that nobody else better
try waking up FROZEN tasks!

> > > > > @@ -137,7 +182,7 @@ bool freeze_task(struct task_struct *p)
> > > > >  	if (!(p->flags & PF_KTHREAD))
> > > > >  		fake_signal_wake_up(p);
> > > > >  	else
> > > > > -		wake_up_state(p, TASK_INTERRUPTIBLE);
> > > > > +		wake_up_state(p, TASK_INTERRUPTIBLE); // TASK_NORMAL ?!?
> > > > >  
> > > > >  	spin_unlock_irqrestore(&freezer_lock, flags);
> > > > >  	return true;
> > > > > @@ -148,8 +193,8 @@ void __thaw_task(struct task_struct *p)
> > > > >  	unsigned long flags;
> > > > >  
> > > > >  	spin_lock_irqsave(&freezer_lock, flags);
> > > > > -	if (frozen(p))
> > > > > -		wake_up_process(p);
> > > > > +	WARN_ON_ONCE(freezing(p));
> > > > > +	wake_up_state(p, TASK_FROZEN | TASK_NORMAL);
> > > > 
> > > > Why do we need TASK_NORMAL here?
> > > 
> > > It's a left-over from hacking, but I left it in because anything
> > > TASK_NORMAL should be able to deal with spuriuos wakeups, something
> > > try_to_freeze() now also relies on.
> > 
> > I just worry that it might hide bugs if TASK_FROZEN is supposed to be
> > sufficient, as it would imply that we have some unfrozen tasks kicking
> > around. I dunno, maybe just a comment saying that everything _should_ be
> > FROZEN at this point?
> 
> I'll take it out. It really shouldn't matter.

Perfect.

Will
