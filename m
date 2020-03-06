Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A6617BC25
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 12:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCFLv3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 06:51:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:48516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFLv2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Mar 2020 06:51:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ASyBuuTofRbVwPI7PA6nCkMbt1FOFFYZDyxdw70e1XQ=; b=Qcw37GPDXfZ5Izoe6gO4qMlqAv
        dO22ZmKpMQRD3YdRENFo8YXVd5jg1DbLZfdNoL5VF2PsRireMkDvKh0NxvI9GQqZ9oMnAtxMIeN/K
        hO8WHKpi+gDbNH+20Ph0i8HPs5JlLT6BXfFtD95vl8w+IE0CPVm46wd7tBhDCb1EsESaxB24qijyn
        rMC/E7HWz14GUPr12IO28lA8p2BZ+6faN8YeA2muPVZB7KG9HB0xz9KkkyQ+IhhVhPQHHd0HUpYoh
        lArzUdchklX41lToO8PAZl+bimUIBfhusdVRVI1Z0whRq9c7CiHGV95LlO0I1BccFRYnNMLmImkhL
        Hzy6QPHw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jABV7-0005NX-7p; Fri, 06 Mar 2020 11:50:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95AC8980DE9; Fri,  6 Mar 2020 12:50:42 +0100 (CET)
Date:   Fri, 6 Mar 2020 12:50:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org
Cc:     mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 11/27] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200306115042.GG3348@worktop.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.673793889@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221134215.673793889@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 02:34:27PM +0100, Peter Zijlstra wrote:
> To facilitate tracers that need RCU, add some helpers to wrap the
> magic required.
> 
> The problem is that we can call into tracers (trace events and
> function tracing) while RCU isn't watching and this can happen from
> any context, including NMI.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  include/linux/rcupdate.h |   29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -175,6 +175,35 @@ do { \
>  #error "Unknown RCU implementation specified to kernel configuration"
>  #endif
>  
> +/**
> + * trace_rcu_enter - Force RCU to be active, for code that needs RCU readers
> + *
> + * Very similar to RCU_NONIDLE() above.
> + *
> + * Tracing can happen while RCU isn't active yet, for instance in the idle loop
> + * between rcu_idle_enter() and rcu_idle_exit(), or early in exception entry.
> + * RCU will happily ignore any read-side critical sections in this case.
> + *
> + * This function ensures that RCU is aware hereafter and the code can readily
> + * rely on RCU read-side critical sections working as expected.
> + *
> + * This function is NMI safe -- provided in_nmi() is correct and will nest up-to
> + * INT_MAX/2 times.
> + */
> +static inline int trace_rcu_enter(void)
> +{
> +	int state = !rcu_is_watching();
> +	if (state)
> +		rcu_irq_enter_irqsave();
> +	return state;
> +}
> +
> +static inline void trace_rcu_exit(int state)
> +{
> +	if (state)
> +		rcu_irq_exit_irqsave();
> +}
> +
>  /*
>   * The init_rcu_head_on_stack() and destroy_rcu_head_on_stack() calls
>   * are needed for dynamic initialization and destruction of rcu_head

Massmi; afaict we also need the below. That is, when you stick an
optimized kprobe in a region RCU is not watching, nothing will make RCU
go.

---
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9ad5e6b346f8..fa14918613da 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -370,6 +370,7 @@ static bool kprobes_allow_optimization;
  */
 void opt_pre_handler(struct kprobe *p, struct pt_regs *regs)
 {
+	int rcu_flags = trace_rcu_enter();
 	struct kprobe *kp;

 	list_for_each_entry_rcu(kp, &p->list, list) {
@@ -379,6 +380,7 @@ void opt_pre_handler(struct kprobe *p, struct pt_regs *regs)
 		}
 		reset_kprobe_instance();
 	}
+	trace_rcu_exit(rcu_flags);
 }
 NOKPROBE_SYMBOL(opt_pre_handler);


