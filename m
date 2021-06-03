Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8AA1399FBF
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 13:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFCL24 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 07:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFCL24 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Jun 2021 07:28:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79562C06174A;
        Thu,  3 Jun 2021 04:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Op/kpj4knPq6gIMNdA9CHiokJxzXHNsUDkaxqMZWO1k=; b=WXD2kkSaWpVGOtayn5KMERvh2b
        9HIOTPSZfW7uZv3ilrmYZRipMgKjdlwTOpIoTvc9EPfcgfStCjOOl5KOhrLykJ0O4tzBvGeH7wjQ0
        jTMleLs1zf9prqJU10k5KRgURHItp83mBVd+EBstqgtOW8iFDW9aoWXUJ5ulrGWoIRJRLZMObr7xA
        oVEVXibxDcUMl2mXvoN5HxLyFS1urZsMOPk+tYmGeZDYJVTX0AbiWl3xtfTEoPfKl8fE2iHumvuTQ
        As4TrPCXnx/vNf8JmyEp8d2z3A11jXgQsnq6wqiFYQzpMWnhqla9fcgr9LQFof6r17wgkxgW0f8g2
        /2uKAkrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lolUF-00C5qD-Od; Thu, 03 Jun 2021 11:26:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F66C300091;
        Thu,  3 Jun 2021 13:26:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B619201A8933; Thu,  3 Jun 2021 13:26:06 +0200 (CEST)
Date:   Thu, 3 Jun 2021 13:26:06 +0200
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
Message-ID: <YLi8Ttw3Xb3ynUW2@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-17-will@kernel.org>
 <YLXt+/Wr5/KWymPC@hirez.programming.kicks-ass.net>
 <YLYZv4v68OnAlx+3@hirez.programming.kicks-ass.net>
 <20210602125452.GG30593@willie-the-truck>
 <YLiwahWvnnkeL+vc@hirez.programming.kicks-ass.net>
 <20210603105856.GB32641@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603105856.GB32641@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 03, 2021 at 11:58:56AM +0100, Will Deacon wrote:
> On Thu, Jun 03, 2021 at 12:35:22PM +0200, Peter Zijlstra wrote:
> > On Wed, Jun 02, 2021 at 01:54:53PM +0100, Will Deacon wrote:

> > > > @@ -116,20 +173,8 @@ bool freeze_task(struct task_struct *p)
> > > >  {
> > > >  	unsigned long flags;
> > > >  
> > > >  	spin_lock_irqsave(&freezer_lock, flags);
> > > > +	if (!freezing(p) || frozen(p) || __freeze_task(p)) {
> > > >  		spin_unlock_irqrestore(&freezer_lock, flags);
> > > >  		return false;
> > > >  	}
> > > 
> > > I've been trying to figure out how this serialises with ttwu(), given that
> > > frozen(p) will go and read p->state. I suppose it works out because only the
> > > freezer can wake up tasks from the FROZEN state, but it feels a bit brittle.
> > 
> > p->pi_lock; both ttwu() and __freeze_task() (which is essentially a
> > variant of set_special_state()) take ->pi_lock. I'll put in a comment.
> 
> The part I struggled with was freeze_task(), which doesn't take ->pi_lock
> yet calls frozen(p).

Ah, I can't read... I assumed you were asking about __freeze_task().

So frozen(p) checks for p->state == TASK_FROZEN (and complicated), which
is a stable state. Once you're frozen you stay frozen until thaw, which
is after freezing per construction.

The tricky bit is __freeze_task(), that does take pi_lock. It checks for
FREEZABLE and if set, changes to FROZEN. And this does in fact race with
ttwu() and relies on pi_lock to serialize.

A concurrent wakeup (from a non-frozen task) can try and wake the task
we're trying to freeze. If we win, ttwu will see FROZEN and ignore, if
ttwu() wins, we don't see FREEZABLE and do another round of freezing.

> > > > @@ -137,7 +182,7 @@ bool freeze_task(struct task_struct *p)
> > > >  	if (!(p->flags & PF_KTHREAD))
> > > >  		fake_signal_wake_up(p);
> > > >  	else
> > > > -		wake_up_state(p, TASK_INTERRUPTIBLE);
> > > > +		wake_up_state(p, TASK_INTERRUPTIBLE); // TASK_NORMAL ?!?
> > > >  
> > > >  	spin_unlock_irqrestore(&freezer_lock, flags);
> > > >  	return true;
> > > > @@ -148,8 +193,8 @@ void __thaw_task(struct task_struct *p)
> > > >  	unsigned long flags;
> > > >  
> > > >  	spin_lock_irqsave(&freezer_lock, flags);
> > > > -	if (frozen(p))
> > > > -		wake_up_process(p);
> > > > +	WARN_ON_ONCE(freezing(p));
> > > > +	wake_up_state(p, TASK_FROZEN | TASK_NORMAL);
> > > 
> > > Why do we need TASK_NORMAL here?
> > 
> > It's a left-over from hacking, but I left it in because anything
> > TASK_NORMAL should be able to deal with spuriuos wakeups, something
> > try_to_freeze() now also relies on.
> 
> I just worry that it might hide bugs if TASK_FROZEN is supposed to be
> sufficient, as it would imply that we have some unfrozen tasks kicking
> around. I dunno, maybe just a comment saying that everything _should_ be
> FROZEN at this point?

I'll take it out. It really shouldn't matter.
