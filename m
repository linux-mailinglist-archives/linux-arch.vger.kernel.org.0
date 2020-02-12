Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F334315B3F9
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 23:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgBLWip (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 17:38:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42547 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLWip (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Feb 2020 17:38:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id o28so2432124qkj.9
        for <linux-arch@vger.kernel.org>; Wed, 12 Feb 2020 14:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MbuouEYX9Z5H4Bei49aJTBTOhhzBjt11ZC9Vcbkm2TY=;
        b=LcnC4u4utEQh5u2B7Cy8I0wiVFJav4imq09k05KoYVAT91KM6wIJKJKyAxuMC/0piq
         mbzuJdfVYzZL5kRntwkIpgNs3Mp5b+a4sB03duMuuzsomRJg6g1ozZs+Hf0h+wcpxNh/
         ecNpJ4qX1xrxy8Vf/FihrxuPvOAUTlyWW8rNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MbuouEYX9Z5H4Bei49aJTBTOhhzBjt11ZC9Vcbkm2TY=;
        b=GC4sBZ+W6wMo+7LzYn5G84Rq9ll2T/GXs1kaejUP8ohOTB2oAPhWUL/6xvN2O6H5GI
         oRb5n0wRfTw92w2Y7ZmDI5UdsnoPNkjatjLRFYJGuHKVXFQb64AQHbsXGBXhoA98SH8k
         oNPlXjJw3W7wivvFRNYC8F3tCjT83joxzAd09u4IxcCyEQfytmq8GwpBjrjeOqkfvoZL
         FGIWJ7gEypHn8RVRr5Mss7SVyvgYWWGNnAeDeFqOnllnEdH8YbYFyCCQqnYbUqzRGyDO
         tgj4yeeR4gPFS7xXl7CdTOZPRYwJUMCJjorB8FiQi8uNYGmQeE2XpQglANNsGudl2aB/
         zBLQ==
X-Gm-Message-State: APjAAAUfz4BPN5GaX7yc39WbBxcBKtVK5OItk/aEXBrbNap6p84eGE/x
        tgMO8UIKCq5NXIKnfU97YonnhQ==
X-Google-Smtp-Source: APXvYqxilKvNE1pe0kckjH0YEcr3/p5zYeWTBIgYpExn2meot/UiU7lxVr0r1cKxwONr0BPfJIx/wA==
X-Received: by 2002:a05:620a:1426:: with SMTP id k6mr10915279qkj.276.1581547123725;
        Wed, 12 Feb 2020 14:38:43 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p50sm398573qtf.5.2020.02.12.14.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:38:43 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:38:37 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 1/9] rcu: Rename rcu_irq_{enter,exit}_irqson()
Message-ID: <20200212223837.GB115917@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.858223764@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212210749.858223764@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 10:01:40PM +0100, Peter Zijlstra wrote:
> The functions do in fact use local_irq_{save,restore}() and can
> therefore be used when IRQs are in fact disabled. Worse, they are
> already used in places where IRQs are disabled, leading to great
> confusion when reading the code.
> 
> Rename them to fix this confusion.


Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
