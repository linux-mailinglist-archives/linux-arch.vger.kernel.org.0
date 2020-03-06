Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7307417C238
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 16:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCFPvd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 10:51:33 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33655 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgCFPvd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 10:51:33 -0500
Received: by mail-lf1-f66.google.com with SMTP id c20so2327149lfb.0;
        Fri, 06 Mar 2020 07:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vpKlxC6kfx/8ZEoHOV/lRWNX/tTNmbczPd46/3sqEc=;
        b=XfZXnAg7SpiORK5atXAtoAXdiyl4DfgFaVoB3ydY3ygwtW/387vVOoRgbZxbZKfKwM
         8oaCjXWru31WY0xBI/QcCXiTAAHefK6flvHQjYNLRgwiesTKIGV5X1DoOcoH5wZoef/L
         u2+e8YzvBan6Ow4VBp2EnkcyF4f+G/mZkJVcJLPO4eZdgUMEQbDlSnkRw/zuFO1FdSNs
         U5X1JOpCD341/wcHPOXwpLOK2eWeTcAaXOmqMk73kr9mSq8dmMQq3iJOO41r0ReUWzMS
         rsS76vv67abvaAZ+0rsAOJVsfKpCuqLJ4aLC3gJMagKwEdxkTQE1+dpJrWX7OKk5EOwQ
         0lTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vpKlxC6kfx/8ZEoHOV/lRWNX/tTNmbczPd46/3sqEc=;
        b=IaJb2G0S42j+TacYRP++EZMoXUjIFIsIUtVnRU5XhV7PnumRAG3yxeLKoLJzDCBGqH
         vTdQn+NtFeMX67X0GK65wufAITBVEAG5TYQUbfvwIUQxV+a26exPsXuyLp0RrZ9IOE+d
         Z9Yvu5AbYbcIa4D+xNh9HWylSIStVYQXdTW0DUKl3MiRzoa76AuBRpHA3DuhKSJdFuxT
         Uz3Xz/MWOsmMBcf/T6Kjjn9tAi0XMXrsOop08S2VGa49XItB6JIBU4nifak1iNJfIkou
         7kE4jpXLrjSSk1gpzeXbkieNrZnXlDAbNCl6xEcgf2ZC+S/Lnx5lpDfKLqrQ1XLswPkk
         sg4A==
X-Gm-Message-State: ANhLgQ38uf5wZaj2+DerzQjKU+mwmAm3qnuVRLyCjVwUS6tViXfT01rq
        IKbHjh3SEkw07i9w3ZKTeD6rZKJK04ac8CjQGqM=
X-Google-Smtp-Source: ADFU+vtn69XZXX/kFdXPbs7zor1IlvqpO+zLZqcQapmofU9e5T2kEJcKuCgrhX4rG3PpRoGnbpNhkP8BA+n03ocZc5A=
X-Received: by 2002:ac2:4647:: with SMTP id s7mr2314121lfo.73.1583509890293;
 Fri, 06 Mar 2020 07:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20200221133416.777099322@infradead.org> <20200221134216.051596115@infradead.org>
 <20200306104335.GF3348@worktop.programming.kicks-ass.net> <20200306113135.GA8787@worktop.programming.kicks-ass.net>
In-Reply-To: <20200306113135.GA8787@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 6 Mar 2020 07:51:18 -0800
Message-ID: <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for _rcuidle
 tracepoints (again)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 6, 2020 at 3:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Mar 06, 2020 at 11:43:35AM +0100, Peter Zijlstra wrote:
> > On Fri, Feb 21, 2020 at 02:34:32PM +0100, Peter Zijlstra wrote:
> > > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > > taught perf how to deal with not having an RCU context provided.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---
> > >  include/linux/tracepoint.h |    8 ++------
> > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > >
> > > --- a/include/linux/tracepoint.h
> > > +++ b/include/linux/tracepoint.h
> > > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
> > >              * For rcuidle callers, use srcu since sched-rcu        \
> > >              * doesn't work from the idle path.                     \
> > >              */                                                     \
> > > -           if (rcuidle) {                                          \
> > > +           if (rcuidle)                                            \
> > >                     __idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> > > -                   rcu_irq_enter_irqsave();                        \
> > > -           }                                                       \
> > >                                                                     \
> > >             it_func_ptr = rcu_dereference_raw((tp)->funcs);         \
> > >                                                                     \
> > > @@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
> > >                     } while ((++it_func_ptr)->func);                \
> > >             }                                                       \
> > >                                                                     \
> > > -           if (rcuidle) {                                          \
> > > -                   rcu_irq_exit_irqsave();                         \
> > > +           if (rcuidle)                                            \
> > >                     srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> > > -           }                                                       \
> > >                                                                     \
> > >             preempt_enable_notrace();                               \
> > >     } while (0)
> >
> > So what happens when BPF registers for these tracepoints? BPF very much
> > wants RCU on AFAIU.
>
> I suspect we needs something like this...
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a2f15222f205..67a39dbce0ce 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1475,11 +1475,13 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
>  static __always_inline
>  void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>  {
> +       int rcu_flags = trace_rcu_enter();
>         rcu_read_lock();
>         preempt_disable();
>         (void) BPF_PROG_RUN(prog, args);
>         preempt_enable();
>         rcu_read_unlock();
> +       trace_rcu_exit(rcu_flags);

One big NACK.
I will not slowdown 99% of cases because of one dumb user.
Absolutely no way.
