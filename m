Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECDC1164C46
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBSRmM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:42:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBSRmM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:42:12 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33950206DB;
        Wed, 19 Feb 2020 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582134131;
        bh=vIgg2+36Ua5x8HLBjl9/8lcExSUzV+uuuacH+jPaAXU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nAIpKrpFowh8AD0faMeogIAyLpP8hxzgnzmFYS81QqfDCsn+lJvzjeUAE0wD8YPsu
         c+gcGvF4qhq+TM2ofGgTVpgDlhogxD1pEPMSa8mId/A0cP+wHbiEzpKWUFOZDcJf4V
         K1IiVYU1t6nm2uPfnXU4/iGlfM2i03Ngxmut/IAw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0FCBF35209B0; Wed, 19 Feb 2020 09:42:11 -0800 (PST)
Date:   Wed, 19 Feb 2020 09:42:11 -0800
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
Message-ID: <20200219174211.GL2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150744.661923520@infradead.org>
 <20200219163156.GY2935@paulmck-ThinkPad-P72>
 <20200219163700.GK18400@hirez.programming.kicks-ass.net>
 <20200219170304.GG14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219170304.GG14946@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 06:03:04PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 05:37:00PM +0100, Peter Zijlstra wrote:
> > On Wed, Feb 19, 2020 at 08:31:56AM -0800, Paul E. McKenney wrote:
> 
> > > Here is the latest version of that comment, posted by Steve Rostedt.
> > > 
> > > 							Thanx, Paul
> > > 
> > > /*
> > >  * All functions called in the breakpoint trap handler (e.g. do_int3()
> > >  * on x86), must not allow kprobes until the kprobe breakpoint handler
> > >  * is called, otherwise it can cause an infinite recursion.
> > >  * On some archs, rcu_nmi_enter() is called in the breakpoint handler
> > >  * before the kprobe breakpoint handler is called, thus it must be
> > >  * marked as NOKPROBE.
> > >  */
> > 
> > Oh right, let me stick that in a separate patch. Best we not loose that
> > I suppose ;-)
> 
> Having gone over the old thread, I ended up with the below. Anyone
> holler if I got it wrong somehow.

Looks good to me!

							Thanx, Paul

> ---
> Subject: rcu: Provide comment for NOKPROBE() on rcu_nmi_enter()
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The rcu_nmi_enter() function was marked NOKPROBE() by commit
> c13324a505c77 ("x86/kprobes: Prohibit probing on functions before
> kprobe_int3_handler()") because the do_int3() call kprobe code must
> not be invoked before kprobe_int3_handler() is called.  It turns out
> that ist_enter() (in do_int3()) calls rcu_nmi_enter(), hence the
> marking NOKPROBE() being added to rcu_nmi_enter().
> 
> This commit therefore adds a comment documenting this line of
> reasoning.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/rcu/tree.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -842,6 +842,14 @@ void rcu_nmi_enter(void)
>  {
>  	rcu_nmi_enter_common(false);
>  }
> +/*
> + * All functions called in the breakpoint trap handler (e.g. do_int3()
> + * on x86), must not allow kprobes until the kprobe breakpoint handler
> + * is called, otherwise it can cause an infinite recursion.
> + * On some archs, rcu_nmi_enter() is called in the breakpoint handler
> + * before the kprobe breakpoint handler is called, thus it must be
> + * marked as NOKPROBE.
> + */
>  NOKPROBE_SYMBOL(rcu_nmi_enter);
>  
>  /**
