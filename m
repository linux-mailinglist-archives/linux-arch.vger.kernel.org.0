Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1C101632DE
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2020 21:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRUR3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 15:17:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgBRUR3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Feb 2020 15:17:29 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F522176D;
        Tue, 18 Feb 2020 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582057048;
        bh=weYP7sKkXUQ9+dPSpuZHGyb6ldBepLg2xY6Xq6EVWLs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q8LUAi98bCOoRUbZZiAC1tCRV4FMwu6P0vOLNRqBMcE0qEqbCkjTLOwNu32ynWOyu
         F+SsHBGc7Nra3m5+tFZPN6BuuzWqMssm+fyPZwIectsVuSy1olsP17yRe/nInxXbcz
         6sx/4Ff6mwwfF1m9qlusanJK1PREGZIqETu3dfXM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 980213520856; Tue, 18 Feb 2020 12:17:28 -0800 (PST)
Date:   Tue, 18 Feb 2020 12:17:28 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200218201728.GH2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
 <20200213185612.GG2935@paulmck-ThinkPad-P72>
 <20200213204444.GA94647@google.com>
 <20200218195831.GD11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218195831.GD11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 18, 2020 at 08:58:31PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 13, 2020 at 03:44:44PM -0500, Joel Fernandes wrote:
> 
> > > > That _should_ already be the case today. That is, if we end up in a
> > > > tracer and in_nmi() is unreliable we're already screwed anyway.
> 
> > I removed the static from rcu_nmi_enter()/exit() as it is called from
> > outside, that makes it build now. Updated below is Paul's diff. I also added
> > NOKPROBE_SYMBOL() to rcu_nmi_exit() to match rcu_nmi_enter() since it seemed
> > asymmetric.
> 
> > +__always_inline void rcu_nmi_exit(void)
> >  {
> >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> >  
> > @@ -651,25 +653,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> >  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
> >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> >  
> > -	if (irq)
> > +	if (!in_nmi())
> >  		rcu_prepare_for_idle();
> >  
> >  	rcu_dynticks_eqs_enter();
> >  
> > -	if (irq)
> > +	if (!in_nmi())
> >  		rcu_dynticks_task_enter();
> >  }
> 
> Boris and me have been going over the #MC code (and finding loads of
> 'interesting' code) and ran into ist_enter(), whish has the following
> code:
> 
>                 /*
>                  * We might have interrupted pretty much anything.  In
>                  * fact, if we're a machine check, we can even interrupt
>                  * NMI processing.  We don't want in_nmi() to return true,
>                  * but we need to notify RCU.
>                  */
>                 rcu_nmi_enter();
> 
> 
> Which, to me, sounds all sorts of broken. The IST (be it #DB or #MC) can
> happen while we're holding all sorts of locks. This must be an NMI-like
> context.

Ouch!  Looks like I need to hold off on getting rid of the "irq"
parameters if in_nmi() isn't going to be accurate.

							Thanx, Paul
