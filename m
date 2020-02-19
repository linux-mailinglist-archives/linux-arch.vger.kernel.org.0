Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37AF1649A3
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSQPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:15:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbgBSQPf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:15:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7F8820675;
        Wed, 19 Feb 2020 16:15:33 +0000 (UTC)
Date:   Wed, 19 Feb 2020 11:15:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200219111532.719c0a6b@gandalf.local.home>
In-Reply-To: <20200219155828.GF18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.832297480@infradead.org>
        <20200219104903.46686b81@gandalf.local.home>
        <20200219155828.GF18400@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Feb 2020 16:58:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Feb 19, 2020 at 10:49:03AM -0500, Steven Rostedt wrote:
> > On Wed, 19 Feb 2020 15:47:32 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:  
> 
> > > These helpers are macros because of header-hell; they're placed here
> > > because of the proximity to nmi_{enter,exit{().  
> 
> ^^^^

Bah I can't read, because I even went looking for this!

> 
> > > +#define trace_rcu_enter()					\
> > > +({								\
> > > +	unsigned long state = 0;				\
> > > +	if (!rcu_is_watching())	{				\
> > > +		rcu_irq_enter_irqsave();			\
> > > +		state = 1;					\
> > > +	}							\
> > > +	state;							\
> > > +})
> > > +
> > > +#define trace_rcu_exit(state)					\
> > > +do {								\
> > > +	if (state)						\
> > > +		rcu_irq_exit_irqsave();				\
> > > +} while (0)
> > > +  
> > 
> > Is there a reason that these can't be static __always_inline functions?  
> 
> It can be done, but then we need fwd declarations of those RCU functions
> somewhere outside of rcupdate.h. It's all a bit of a mess.

Maybe this belongs in the rcupdate.h file then?

-- Steve
