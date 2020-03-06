Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E461D17C273
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 17:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCFQEa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 11:04:30 -0500
Received: from mail.efficios.com ([167.114.26.124]:44462 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCFQEa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 11:04:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C1CAA256FB7;
        Fri,  6 Mar 2020 11:04:28 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dxrs-FQVPtJQ; Fri,  6 Mar 2020 11:04:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 595EC256DF7;
        Fri,  6 Mar 2020 11:04:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 595EC256DF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583510668;
        bh=6j5JaL7Ua/h0tRIOesi8OT8YjRo+RrU/0uZVVdHVaUc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=WtwakTcInK9Ow6gYVMTNvKU9/piqdY3nhzkNHs1hUwILaWj7bES3pHrnTDvxDYQPA
         nt+z6IPj7xtrrQkQsPYFSwNmsx5PtiIpEMbCuXYutme4/CRamTY3xZ/FH5F+JL3YTF
         ywOwPNgw4KgJ+opE/39MgZ2RLinIUrZKjTEmHfLFDJBUrUj6XxqAH9LSQLTdHxvmiX
         /B0SCzLgKWUpACIEbU7Jh8Fsf8BK/cBubt34IayVmWwBWaQLVKW32OgNuwwltpiXFH
         l7sCK0Xq4h2sNFe9qCW0O9HD4BDn+AC+XiHEKB6shS4ZAYSy0+r6ZWUwzfGd7KkdMW
         2PaejpLRwFf/Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TvwxhIRj8G-2; Fri,  6 Mar 2020 11:04:28 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4587D257286;
        Fri,  6 Mar 2020 11:04:28 -0500 (EST)
Date:   Fri, 6 Mar 2020 11:04:28 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
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
Message-ID: <1896740806.20220.1583510668164.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
References: <20200221133416.777099322@infradead.org> <20200221134216.051596115@infradead.org> <20200306104335.GF3348@worktop.programming.kicks-ass.net> <20200306113135.GA8787@worktop.programming.kicks-ass.net> <CAADnVQKp=UKg8HAuMOFknhmXtfm_LVu_ynTNJuedHqKdA6zh1g@mail.gmail.com>
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracing: Remove regular RCU context for _rcuidle tracepoints (again)
Thread-Index: EGOI/yncDm66QywVpmO/bDrskNz8Mw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Mar 6, 2020, at 10:51 AM, Alexei Starovoitov alexei.starovoitov@gmail.com wrote:

> On Fri, Mar 6, 2020 at 3:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Fri, Mar 06, 2020 at 11:43:35AM +0100, Peter Zijlstra wrote:
>> > On Fri, Feb 21, 2020 at 02:34:32PM +0100, Peter Zijlstra wrote:
>> > > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
>> > > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
>> > > taught perf how to deal with not having an RCU context provided.
>> > >
>> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> > > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> > > ---
>> > >  include/linux/tracepoint.h |    8 ++------
>> > >  1 file changed, 2 insertions(+), 6 deletions(-)
>> > >
>> > > --- a/include/linux/tracepoint.h
>> > > +++ b/include/linux/tracepoint.h
>> > > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
>> > >              * For rcuidle callers, use srcu since sched-rcu        \
>> > >              * doesn't work from the idle path.                     \
>> > >              */                                                     \
>> > > -           if (rcuidle) {                                          \
>> > > +           if (rcuidle)                                            \
>> > >                     __idx = srcu_read_lock_notrace(&tracepoint_srcu);\
>> > > -                   rcu_irq_enter_irqsave();                        \
>> > > -           }                                                       \
>> > >                                                                     \
>> > >             it_func_ptr = rcu_dereference_raw((tp)->funcs);         \
>> > >                                                                     \
>> > > @@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
>> > >                     } while ((++it_func_ptr)->func);                \
>> > >             }                                                       \
>> > >                                                                     \
>> > > -           if (rcuidle) {                                          \
>> > > -                   rcu_irq_exit_irqsave();                         \
>> > > +           if (rcuidle)                                            \
>> > >                     srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
>> > > -           }                                                       \
>> > >                                                                     \
>> > >             preempt_enable_notrace();                               \
>> > >     } while (0)
>> >
>> > So what happens when BPF registers for these tracepoints? BPF very much
>> > wants RCU on AFAIU.
>>
>> I suspect we needs something like this...
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index a2f15222f205..67a39dbce0ce 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1475,11 +1475,13 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map
>> *btp)
>>  static __always_inline
>>  void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>>  {
>> +       int rcu_flags = trace_rcu_enter();
>>         rcu_read_lock();
>>         preempt_disable();
>>         (void) BPF_PROG_RUN(prog, args);
>>         preempt_enable();
>>         rcu_read_unlock();
>> +       trace_rcu_exit(rcu_flags);
> 
> One big NACK.
> I will not slowdown 99% of cases because of one dumb user.
> Absolutely no way.

If we care about not adding those extra branches on the fast-path, there is
an alternative way to do things: BPF could provide two distinct probe callbacks,
one meant for rcuidle tracepoints (which would have the trace_rcu_enter/exit), and
the other for the for 99% of the other callsites which have RCU watching.

I would recommend performing benchmarks justifying the choice of one approach over
the other though.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
