Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B16165F56
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 14:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBTN6C (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 08:58:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbgBTN6C (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Feb 2020 08:58:02 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCC2208C4;
        Thu, 20 Feb 2020 13:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582207081;
        bh=a//YMSVQwP5BKAyj9ETtea5hXXc220huUdutsNvXaiI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Kio15uvR+I1ZDyQLgxiae9theyhsK3aHI1sixTT4gPoi3/WbLHeNZKDf/YY2fNV00
         xJGJxRGn+kEzEtUPcqLwIlJKV++7RPGN61iKMA6k4QpBvQP+Iw7sOfHLCdmmZDfKgH
         J2lYEybgIJyX7RPFhmtb4YGEYnzJNO0qyMbaCqzM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F13CF35202FA; Thu, 20 Feb 2020 05:58:00 -0800 (PST)
Date:   Thu, 20 Feb 2020 05:58:00 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200220135800.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150744.832297480@infradead.org>
 <20200219104903.46686b81@gandalf.local.home>
 <20200219155828.GF18400@hirez.programming.kicks-ass.net>
 <20200219111532.719c0a6b@gandalf.local.home>
 <20200219163535.GJ18400@hirez.programming.kicks-ass.net>
 <20200219164449.GC2935@paulmck-ThinkPad-P72>
 <20200220103421.GV18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220103421.GV18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 11:34:21AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 08:44:50AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2020 at 05:35:35PM +0100, Peter Zijlstra wrote:
> 
> > > Possibly, and I suppose the current version is less obviously dependent
> > > on the in_nmi() functionality as was the previous, seeing how Paul
> > > frobbed that all the way into the rcu_irq_enter*() implementation.
> > > 
> > > So sure, I can go move it I suppose.
> > 
> > No objections here.
> 
> It now looks like so:
> 
> ---
> Subject: rcu,tracing: Create trace_rcu_{enter,exit}()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed Feb 12 09:18:57 CET 2020
> 
> To facilitate tracers that need RCU, add some helpers to wrap the
> magic required.
> 
> The problem is that we can call into tracers (trace events and
> function tracing) while RCU isn't watching and this can happen from
> any context, including NMI.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

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
