Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4B164A6F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBSQb6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:31:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgBSQb6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:31:58 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0C7924654;
        Wed, 19 Feb 2020 16:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582129916;
        bh=Z68qVfNQ0z0dRq0qrxhhTv3+OjeqcObk6RNhURSJoqQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TR4CmeF/wYivso8JLtehnGUsUcUBbraJDjSHAypO0Up2u/3F72KGjA7AyDSGo4li7
         HTFHLn83v470Dga6IoApucm0FgG8CKKrFmyWXqQRn5OV1rkob8rGoWwQLwReRVkW6r
         uGE3bpz72GsgvWfkUpR8h/3jyyTP58JiHnLjvLxo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A87BB35209B0; Wed, 19 Feb 2020 08:31:56 -0800 (PST)
Date:   Wed, 19 Feb 2020 08:31:56 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 05/22] rcu: Make RCU IRQ enter/exit functions rely on
 in_nmi()
Message-ID: <20200219163156.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150744.661923520@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219150744.661923520@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 03:47:29PM +0100, Peter Zijlstra wrote:
> From: Paul E. McKenney <paulmck@kernel.org>
> 
> The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
> "irq" parameter that indicates whether these functions are invoked from
> an irq handler (irq==true) or an NMI handler (irq==false).  However,
> recent changes have applied notrace to a few critical functions such
> that rcu_nmi_enter_common() and rcu_nmi_exit_common() many now rely
> on in_nmi().  Note that in_nmi() works no differently than before,
> but rather that tracing is now prohibited in code regions where in_nmi()
> would incorrectly report NMI state.
> 
> This commit therefore removes the "irq" parameter and inlines
> rcu_nmi_enter_common() and rcu_nmi_exit_common() into rcu_nmi_enter()
> and rcu_nmi_exit(), respectively.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Again, thank you.

Would you like to also take the added comment for NOKPROBE_SYMBOL(),
or would you prefer that I carry that separately?  (I dropped it for
now to avoid the conflict with the patch below.)

Here is the latest version of that comment, posted by Steve Rostedt.

							Thanx, Paul

/*
 * All functions called in the breakpoint trap handler (e.g. do_int3()
 * on x86), must not allow kprobes until the kprobe breakpoint handler
 * is called, otherwise it can cause an infinite recursion.
 * On some archs, rcu_nmi_enter() is called in the breakpoint handler
 * before the kprobe breakpoint handler is called, thus it must be
 * marked as NOKPROBE.
 */

> ---
>  kernel/rcu/tree.c |   45 ++++++++++++++-------------------------------
>  1 file changed, 14 insertions(+), 31 deletions(-)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -614,16 +614,18 @@ void rcu_user_enter(void)
>  }
>  #endif /* CONFIG_NO_HZ_FULL */
>  
> -/*
> +/**
> + * rcu_nmi_exit - inform RCU of exit from NMI context
> + *
>   * If we are returning from the outermost NMI handler that interrupted an
>   * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
>   * to let the RCU grace-period handling know that the CPU is back to
>   * being RCU-idle.
>   *
> - * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
> + * If you add or remove a call to rcu_nmi_exit(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -static __always_inline void rcu_nmi_exit_common(bool irq)
> +void rcu_nmi_exit(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> @@ -651,27 +653,16 @@ static __always_inline void rcu_nmi_exit
>  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
>  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
>  
> -	if (irq)
> +	if (!in_nmi())
>  		rcu_prepare_for_idle();
>  
>  	rcu_dynticks_eqs_enter();
>  
> -	if (irq)
> +	if (!in_nmi())
>  		rcu_dynticks_task_enter();
>  }
>  
>  /**
> - * rcu_nmi_exit - inform RCU of exit from NMI context
> - *
> - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> - * with CONFIG_RCU_EQS_DEBUG=y.
> - */
> -void rcu_nmi_exit(void)
> -{
> -	rcu_nmi_exit_common(false);
> -}
> -
> -/**
>   * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
>   *
>   * Exit from an interrupt handler, which might possibly result in entering
> @@ -693,7 +684,7 @@ void rcu_nmi_exit(void)
>  void rcu_irq_exit(void)
>  {
>  	lockdep_assert_irqs_disabled();
> -	rcu_nmi_exit_common(true);
> +	rcu_nmi_exit();
>  }
>  
>  /*
> @@ -777,7 +768,7 @@ void rcu_user_exit(void)
>  #endif /* CONFIG_NO_HZ_FULL */
>  
>  /**
> - * rcu_nmi_enter_common - inform RCU of entry to NMI context
> + * rcu_nmi_enter - inform RCU of entry to NMI context
>   * @irq: Is this call from rcu_irq_enter?
>   *
>   * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
> @@ -786,10 +777,10 @@ void rcu_user_exit(void)
>   * long as the nesting level does not overflow an int.  (You will probably
>   * run out of stack space first.)
>   *
> - * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> + * If you add or remove a call to rcu_nmi_enter(), be sure to test
>   * with CONFIG_RCU_EQS_DEBUG=y.
>   */
> -static __always_inline void rcu_nmi_enter_common(bool irq)
> +void rcu_nmi_enter(void)
>  {
>  	long incby = 2;
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> @@ -807,12 +798,12 @@ static __always_inline void rcu_nmi_ente
>  	 */
>  	if (rcu_dynticks_curr_cpu_in_eqs()) {
>  
> -		if (irq)
> +		if (!in_nmi())
>  			rcu_dynticks_task_exit();
>  
>  		rcu_dynticks_eqs_exit();
>  
> -		if (irq)
> +		if (!in_nmi())
>  			rcu_cleanup_after_idle();
>  
>  		incby = 1;
> @@ -834,14 +825,6 @@ static __always_inline void rcu_nmi_ente
>  		   rdp->dynticks_nmi_nesting + incby);
>  	barrier();
>  }
> -
> -/**
> - * rcu_nmi_enter - inform RCU of entry to NMI context
> - */
> -void rcu_nmi_enter(void)
> -{
> -	rcu_nmi_enter_common(false);
> -}
>  NOKPROBE_SYMBOL(rcu_nmi_enter);
>  
>  /**
> @@ -869,7 +852,7 @@ NOKPROBE_SYMBOL(rcu_nmi_enter);
>  void rcu_irq_enter(void)
>  {
>  	lockdep_assert_irqs_disabled();
> -	rcu_nmi_enter_common(true);
> +	rcu_nmi_enter();
>  }
>  
>  /*
> 
> 
