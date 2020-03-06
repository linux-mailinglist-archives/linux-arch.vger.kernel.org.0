Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3417BBB9
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgCFLcD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 06:32:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgCFLcC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 06:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gVYfVAk3KO+g2j+XGdHVbdJHCQeeRvAXa6ZJkiT2+rs=; b=PBiw1JGlFqdhZJqMKou720MxCa
        sQwQVatz60It3GeJKZHlbMRrjel7ddDYBzFLNWB75jPZRjQPpmfewC3JNMVkLQDz7/x/p2o/u39N2
        68ERwHxQqiq8Vr+WkUd0UnlKldcCkBc3x3xxUh9SJ4gql0aP+p8PMqayBk+NCTCDbFtX/vJbYFdi7
        GlF2HabZJZKldXtmsGC0h007HsbDZi/txNKibEuV+DkKcQDbkklLeMWHah294Osk4PeCzDmfITnxk
        eQQnm4NCrIDXxgVRGekPEXubuhG17i+7BFIMcoMjTTyfLT41btIImNPBtbdqyfrZlAUluWzv0VoKX
        8NzBn3TQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jABCc-00009q-9b; Fri, 06 Mar 2020 11:31:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 77326980DE9; Fri,  6 Mar 2020 12:31:35 +0100 (CET)
Date:   Fri, 6 Mar 2020 12:31:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v4 16/27] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200306113135.GA8787@worktop.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134216.051596115@infradead.org>
 <20200306104335.GF3348@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306104335.GF3348@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 06, 2020 at 11:43:35AM +0100, Peter Zijlstra wrote:
> On Fri, Feb 21, 2020 at 02:34:32PM +0100, Peter Zijlstra wrote:
> > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > taught perf how to deal with not having an RCU context provided.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> >  include/linux/tracepoint.h |    8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo
> >  		 * For rcuidle callers, use srcu since sched-rcu	\
> >  		 * doesn't work from the idle path.			\
> >  		 */							\
> > -		if (rcuidle) {						\
> > +		if (rcuidle)						\
> >  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> > -			rcu_irq_enter_irqsave();			\
> > -		}							\
> >  									\
> >  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> >  									\
> > @@ -194,10 +192,8 @@ static inline struct tracepoint *tracepo
> >  			} while ((++it_func_ptr)->func);		\
> >  		}							\
> >  									\
> > -		if (rcuidle) {						\
> > -			rcu_irq_exit_irqsave();				\
> > +		if (rcuidle)						\
> >  			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
> > -		}							\
> >  									\
> >  		preempt_enable_notrace();				\
> >  	} while (0)
> 
> So what happens when BPF registers for these tracepoints? BPF very much
> wants RCU on AFAIU.

I suspect we needs something like this...

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a2f15222f205..67a39dbce0ce 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1475,11 +1475,13 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 static __always_inline
 void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
 {
+	int rcu_flags = trace_rcu_enter();
 	rcu_read_lock();
 	preempt_disable();
 	(void) BPF_PROG_RUN(prog, args);
 	preempt_enable();
 	rcu_read_unlock();
+	trace_rcu_exit(rcu_flags);
 }
 
 #define UNPACK(...)			__VA_ARGS__

