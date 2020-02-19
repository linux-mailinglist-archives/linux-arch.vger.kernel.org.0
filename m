Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95ACA164AD5
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgBSQou (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:44:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgBSQou (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:44:50 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27D6820578;
        Wed, 19 Feb 2020 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582130690;
        bh=3icYN1SeiNmmW3EIIPczDVA3qladDaUDxqtlYKOI90I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=SDPh3vO62GlM+EpS9rnrESSkbIuq24zJYhivDiAEZnf9E3EoQrxRk9dqZCnR3tESm
         M2ZQMVIzpIVkP+G/Lt9PMqUHdwSzXJTACXA587S7lSzO1Epm7EUukUgi2tCOgyY/q7
         H4VttNC4/prpUfbw2yPzqadD6eaA2KnKnf66uQC4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 033B135209B0; Wed, 19 Feb 2020 08:44:50 -0800 (PST)
Date:   Wed, 19 Feb 2020 08:44:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200219164449.GC2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150744.832297480@infradead.org>
 <20200219104903.46686b81@gandalf.local.home>
 <20200219155828.GF18400@hirez.programming.kicks-ass.net>
 <20200219111532.719c0a6b@gandalf.local.home>
 <20200219163535.GJ18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219163535.GJ18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 05:35:35PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 11:15:32AM -0500, Steven Rostedt wrote:
> > On Wed, 19 Feb 2020 16:58:28 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > On Wed, Feb 19, 2020 at 10:49:03AM -0500, Steven Rostedt wrote:
> > > > On Wed, 19 Feb 2020 15:47:32 +0100
> > > > Peter Zijlstra <peterz@infradead.org> wrote:  
> > > 
> > > > > These helpers are macros because of header-hell; they're placed here
> > > > > because of the proximity to nmi_{enter,exit{().  
> > > 
> > > ^^^^
> > 
> > Bah I can't read, because I even went looking for this!
> > 
> > > 
> > > > > +#define trace_rcu_enter()					\
> > > > > +({								\
> > > > > +	unsigned long state = 0;				\
> > > > > +	if (!rcu_is_watching())	{				\
> > > > > +		rcu_irq_enter_irqsave();			\
> > > > > +		state = 1;					\
> > > > > +	}							\
> > > > > +	state;							\
> > > > > +})
> > > > > +
> > > > > +#define trace_rcu_exit(state)					\
> > > > > +do {								\
> > > > > +	if (state)						\
> > > > > +		rcu_irq_exit_irqsave();				\
> > > > > +} while (0)
> > > > > +  
> > > > 
> > > > Is there a reason that these can't be static __always_inline functions?  
> > > 
> > > It can be done, but then we need fwd declarations of those RCU functions
> > > somewhere outside of rcupdate.h. It's all a bit of a mess.
> > 
> > Maybe this belongs in the rcupdate.h file then?
> 
> Possibly, and I suppose the current version is less obviously dependent
> on the in_nmi() functionality as was the previous, seeing how Paul
> frobbed that all the way into the rcu_irq_enter*() implementation.
> 
> So sure, I can go move it I suppose.

No objections here.

							Thanx, Paul
