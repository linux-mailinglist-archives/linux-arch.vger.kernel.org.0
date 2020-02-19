Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16E5D164AA6
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgBSQiB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbgBSQiB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:38:01 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FA3424656;
        Wed, 19 Feb 2020 16:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582130280;
        bh=ACKzIqdrnFtV0FFqptMxhiTP7NwwRO+06iz2twchFQQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XIAnyBdocShxMXVBWTgaMbJW3qbkUhapUga77mw09uqicPtYZSnWt51Car3M+vT9N
         +BBZxhS71mPZb262IXNtWdbuYBCjwxP9fsMA8r33zzgkUG1kRA0Si8Q/Iv0kPgZgeG
         /imIvhWxE//aTVJiGc5gW8FfDT/QryoFU7TQ/5dU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0A14035209B0; Wed, 19 Feb 2020 08:38:00 -0800 (PST)
Date:   Wed, 19 Feb 2020 08:38:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 06/22] rcu: Rename rcu_irq_{enter,exit}_irqson()
Message-ID: <20200219163800.GZ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150744.719277483@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219150744.719277483@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 03:47:30PM +0100, Peter Zijlstra wrote:
> The functions do in fact use local_irq_{save,restore}() and can
> therefore be used when IRQs are in fact disabled. Worse, they are
> already used in places where IRQs are disabled, leading to great
> confusion when reading the code.
> 
> Rename them to fix this confusion.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

My first reaction was "Hey, wait, where is the _irqrestore()?"

Nevertheless, especially since these are the only _irqson() functions:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/rcupdate.h   |    4 ++--
>  include/linux/rcutiny.h    |    4 ++--
>  include/linux/rcutree.h    |    4 ++--
>  include/linux/tracepoint.h |    4 ++--
>  kernel/cpu_pm.c            |    4 ++--
>  kernel/rcu/tree.c          |    8 ++++----
>  kernel/trace/trace.c       |    4 ++--
>  7 files changed, 16 insertions(+), 16 deletions(-)
> 
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -120,9 +120,9 @@ static inline void rcu_init_nohz(void) {
>   */
>  #define RCU_NONIDLE(a) \
>  	do { \
> -		rcu_irq_enter_irqson(); \
> +		rcu_irq_enter_irqsave(); \
>  		do { a; } while (0); \
> -		rcu_irq_exit_irqson(); \
> +		rcu_irq_exit_irqsave(); \
>  	} while (0)
>  
>  /*
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -68,8 +68,8 @@ static inline int rcu_jiffies_till_stall
>  static inline void rcu_idle_enter(void) { }
>  static inline void rcu_idle_exit(void) { }
>  static inline void rcu_irq_enter(void) { }
> -static inline void rcu_irq_exit_irqson(void) { }
> -static inline void rcu_irq_enter_irqson(void) { }
> +static inline void rcu_irq_exit_irqsave(void) { }
> +static inline void rcu_irq_enter_irqsave(void) { }
>  static inline void rcu_irq_exit(void) { }
>  static inline void exit_rcu(void) { }
>  static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
> --- a/include/linux/rcutree.h
> +++ b/include/linux/rcutree.h
> @@ -46,8 +46,8 @@ void rcu_idle_enter(void);
>  void rcu_idle_exit(void);
>  void rcu_irq_enter(void);
>  void rcu_irq_exit(void);
> -void rcu_irq_enter_irqson(void);
> -void rcu_irq_exit_irqson(void);
> +void rcu_irq_enter_irqsave(void);
> +void rcu_irq_exit_irqsave(void);
>  
>  void exit_rcu(void);
>  
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -181,7 +181,7 @@ static inline struct tracepoint *tracepo
>  		 */							\
>  		if (rcuidle) {						\
>  			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> -			rcu_irq_enter_irqson();				\
> +			rcu_irq_enter_irqsave();			\
>  		}							\
>  									\
>  		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> @@ -195,7 +195,7 @@ static inline struct tracepoint *tracepo
>  		}							\
>  									\
>  		if (rcuidle) {						\
> -			rcu_irq_exit_irqson();				\
> +			rcu_irq_exit_irqsave();				\
>  			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
>  		}							\
>  									\
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -24,10 +24,10 @@ static int cpu_pm_notify(enum cpu_pm_eve
>  	 * could be disfunctional in cpu idle. Copy RCU_NONIDLE code to let
>  	 * RCU know this.
>  	 */
> -	rcu_irq_enter_irqson();
> +	rcu_irq_enter_irqsave();
>  	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
>  		nr_to_call, nr_calls);
> -	rcu_irq_exit_irqson();
> +	rcu_irq_exit_irqsave();
>  
>  	return notifier_to_errno(ret);
>  }
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -699,10 +699,10 @@ void rcu_irq_exit(void)
>  /*
>   * Wrapper for rcu_irq_exit() where interrupts are enabled.
>   *
> - * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
> + * If you add or remove a call to rcu_irq_exit_irqsave(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_irq_exit_irqson(void)
> +void rcu_irq_exit_irqsave(void)
>  {
>  	unsigned long flags;
>  
> @@ -875,10 +875,10 @@ void rcu_irq_enter(void)
>  /*
>   * Wrapper for rcu_irq_enter() where interrupts are enabled.
>   *
> - * If you add or remove a call to rcu_irq_enter_irqson(), be sure to test
> + * If you add or remove a call to rcu_irq_enter_irqsave(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -void rcu_irq_enter_irqson(void)
> +void rcu_irq_enter_irqsave(void)
>  {
>  	unsigned long flags;
>  
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3004,9 +3004,9 @@ void __trace_stack(struct trace_array *t
>  	if (unlikely(in_nmi()))
>  		return;
>  
> -	rcu_irq_enter_irqson();
> +	rcu_irq_enter_irqsave();
>  	__ftrace_trace_stack(buffer, flags, skip, pc, NULL);
> -	rcu_irq_exit_irqson();
> +	rcu_irq_exit_irqsave();
>  }
>  
>  /**
> 
> 
