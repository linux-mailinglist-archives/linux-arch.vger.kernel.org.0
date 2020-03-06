Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159ED17C435
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 18:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgCFRVn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 12:21:43 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42003 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFRVm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 12:21:42 -0500
Received: by mail-qt1-f195.google.com with SMTP id r6so2240897qtt.9
        for <linux-arch@vger.kernel.org>; Fri, 06 Mar 2020 09:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RPHN/DBmdoWcZAErc3vvXF6J22CCdEuHhdpp8tNFXjw=;
        b=ebfyopt9aJpnPROyIMSooR+UXJkpa9Y5iJBuY8TqgsasZmBgDf34cesTs62aiMtV4Z
         jm9EMjxtMCw7Khbwha7nj104xonREUsaB5pb+2qMskNmJTLMl5pC1qdG81bhCm6ro48V
         JTrV10ir2Gl1zwn70Klj8lo8howuw5UlOaRb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RPHN/DBmdoWcZAErc3vvXF6J22CCdEuHhdpp8tNFXjw=;
        b=j4YhxStOOXh0PgVlFzg0OmsiKluvADXdpy6+SUUuvwXWLAVDfqXDb69nB90cbDPe4x
         0tR7h0rpi2auhWiRYf/pKdzkqzW+zVqkPSRGvRYMskDdCFuLTxjBMk9CIe9apKqH1sT0
         M1ArUodtYVeqYHQk76IoXVhrj83G2PzrgLF48lGHOwzikN+vPpOSUEZgLYBoFxYL4jBG
         1ER5OKt85amToInKIco1qoRNRWq73eM7QlyeutVD+DmwguSmFG9w3KB9Q3BLLdS4exhM
         Sz/yA1TwhFgq36nt3sduiR8Vab98o2yMBEAFJxyVx2dBVLUDvMRMW0F4Y3BKZytobVPx
         3kWw==
X-Gm-Message-State: ANhLgQ0GZI8KKvM5FPB29izek3pKyCtP91OJ/wLQ+8GNiPcRzBFGTK3f
        5ApHSe+4lt0MrnJaAf9BUl9J8w==
X-Google-Smtp-Source: ADFU+vun+md9w//z+yQqm5h2WbliutEM1HC5b8I8CDxYXGyg0zfZ57BL+ZdOVZgy8jl6iL8oQc54Mw==
X-Received: by 2002:ac8:40ca:: with SMTP id f10mr3994116qtm.377.1583515301642;
        Fri, 06 Mar 2020 09:21:41 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r4sm4834419qkm.98.2020.03.06.09.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 09:21:41 -0800 (PST)
Date:   Fri, 6 Mar 2020 12:21:40 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        jiangshanlai@gmail.com, Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200306172140.GA237112@google.com>
References: <20200221133416.777099322@infradead.org>
 <20200221134216.051596115@infradead.org>
 <20200306104335.GF3348@worktop.programming.kicks-ass.net>
 <20200306113135.GA8787@worktop.programming.kicks-ass.net>
 <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 06, 2020 at 07:51:18AM -0800, Alexei Starovoitov wrote:
> On Fri, Mar 6, 2020 at 3:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Fri, Mar 06, 2020 at 11:43:35AM +0100, Peter Zijlstra wrote:
> > > On Fri, Feb 21, 2020 at 02:34:32PM +0100, Peter Zijlstra wrote:
> > > > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > > > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > > > taught perf how to deal with not having an RCU context provided.
> > > >
> > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > > ---
> > > >  include/linux/tracepoint.h |    8 ++------
> > > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > >
> > > > --- a/include/linux/tracepoint.h
> > > > +++ b/include/linux/tracepoint.h
> > > > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
> > > >              * For rcuidle callers, use srcu since sched-rcu        \
> > > >              * doesn't work from the idle path.                     \
> > > >              */                                                     \
> > > > -           if (rcuidle) {                                          \
> > > > +           if (rcuidle)                                            \
> > > >                     __idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> > > > -                   rcu_irq_enter_irqsave();                        \
> > > > -           }                                                       \
> > > >                                                                     \
> > > >             it_func_ptr = rcu_dereference_raw((tp)->funcs);         \
> > > >                                                                     \
> > > > @@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
> > > >                     } while ((++it_func_ptr)->func);                \
> > > >             }                                                       \
> > > >                                                                     \
> > > > -           if (rcuidle) {                                          \
> > > > -                   rcu_irq_exit_irqsave();                         \
> > > > +           if (rcuidle)                                            \
> > > >                     srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> > > > -           }                                                       \
> > > >                                                                     \
> > > >             preempt_enable_notrace();                               \
> > > >     } while (0)
> > >
> > > So what happens when BPF registers for these tracepoints? BPF very much
> > > wants RCU on AFAIU.
> >
> > I suspect we needs something like this...
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a2f15222f205..67a39dbce0ce 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1475,11 +1475,13 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
> >  static __always_inline
> >  void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
> >  {
> > +       int rcu_flags = trace_rcu_enter();
> >         rcu_read_lock();
> >         preempt_disable();
> >         (void) BPF_PROG_RUN(prog, args);
> >         preempt_enable();
> >         rcu_read_unlock();
> > +       trace_rcu_exit(rcu_flags);
> 
> One big NACK.
> I will not slowdown 99% of cases because of one dumb user.
> Absolutely no way.

For the 99% usecases, they incur an additional atomic_read and a branch, with
the above.  Is that the concern? Just want to make sure we are talking about
same thing.

Speaking of slowdowns, you don't really need that rcu_read_lock/unlock()
pair in __bpf_trace_run() AFAICS. The rcu_read_unlock() can run into the
rcu_read_unlock_special() slowpath and if not, at least has branches.  Most
importantly, RCU is consolidated which means preempt_disable() implies
rcu_read_lock().

thanks,

 - Joel

