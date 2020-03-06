Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3692817C5C8
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 19:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCFS73 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 13:59:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgCFS73 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 13:59:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD94520637;
        Fri,  6 Mar 2020 18:59:26 +0000 (UTC)
Date:   Fri, 6 Mar 2020 13:59:25 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        dan carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200306135925.50c38bec@gandalf.local.home>
In-Reply-To: <20200306184538.GA92717@google.com>
References: <20200221133416.777099322@infradead.org>
        <20200221134216.051596115@infradead.org>
        <20200306104335.GF3348@worktop.programming.kicks-ass.net>
        <20200306113135.GA8787@worktop.programming.kicks-ass.net>
        <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
        <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
        <20200306125500.6aa75c0d@gandalf.local.home>
        <20200306184538.GA92717@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 6 Mar 2020 13:45:38 -0500
Joel Fernandes <joel@joelfernandes.org> wrote:

> On Fri, Mar 06, 2020 at 12:55:00PM -0500, Steven Rostedt wrote:
> > On Fri, 6 Mar 2020 11:04:28 -0500 (EST)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> > > If we care about not adding those extra branches on the fast-path, there is
> > > an alternative way to do things: BPF could provide two distinct probe callbacks,
> > > one meant for rcuidle tracepoints (which would have the trace_rcu_enter/exit), and
> > > the other for the for 99% of the other callsites which have RCU watching.
> > > 
> > > I would recommend performing benchmarks justifying the choice of one approach over
> > > the other though.  
> > 
> > I just whipped this up (haven't even tried to compile it), but this should
> > satisfy everyone. Those that register a callback that needs RCU protection
> > simply registers with one of the _rcu versions, and all will be done. And
> > since DO_TRACE is a macro, and rcuidle is a constant, the rcu protection
> > code will be compiled out for locations that it is not needed.
> > 
> > With this, perf doesn't even need to do anything extra but register with
> > the "_rcu" version.  
> 
> Looks nice! Some comments below:
> 
> > -- Steve
> > 
> > diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> > index b29950a19205..582dece30170 100644
> > --- a/include/linux/tracepoint-defs.h
> > +++ b/include/linux/tracepoint-defs.h
> > @@ -25,6 +25,7 @@ struct tracepoint_func {
> >  	void *func;
> >  	void *data;
> >  	int prio;
> > +	int requires_rcu;
> >  };
> >  
> >  struct tracepoint {
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index 1fb11daa5c53..5f4de82ffa0f 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -179,25 +179,28 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  		 * For rcuidle callers, use srcu since sched-rcu	\
> >  		 * doesn't work from the idle path.			\
> >  		 */							\
> > -		if (rcuidle) {						\
> > +		if (rcuidle)						\
> >  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\  
> 
> Small addition:
> To prevent confusion, we could make more clear that SRCU here is just to
> protect the tracepoint function table and not the callbacks themselves.
> 
> > -			rcu_irq_enter_irqson();				\
> > -		}							\
> >  									\
> >  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> >  									\
> >  		if (it_func_ptr) {					\
> >  			do {						\
> > +				int rcu_flags;				\
> >  				it_func = (it_func_ptr)->func;		\
> > +				if (rcuidle &&				\
> > +				    (it_func_ptr)->requires_rcu)	\
> > +					rcu_flags = trace_rcu_enter();	\
> >  				__data = (it_func_ptr)->data;		\
> >  				((void(*)(proto))(it_func))(args);	\
> > +				if (rcuidle &&				\
> > +				    (it_func_ptr)->requires_rcu)	\
> > +					trace_rcu_exit(rcu_flags);	\  
> 
> Nit: If we have incurred the cost of trace_rcu_enter() once, we can call
> it only once and then call trace_rcu_exit() after the do-while loop. That way
> we pay the price only once.
>

I thought about that, but the common case is only one callback attached at
a time. To make the code complex for the non common case seemed too much
of an overkill. If we find that it does help, it's best to do that as a
separate patch because then if something goes wrong we know where it
happened.

Currently, this provides the same overhead as if each callback did it
themselves like we were proposing (but without the added need to do it for
all instances of the callback).

-- Steve
