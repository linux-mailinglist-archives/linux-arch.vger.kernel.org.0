Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0585160DD7
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 09:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgBQIz1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Feb 2020 03:55:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:46902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbgBQIz0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Feb 2020 03:55:26 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C331520718;
        Mon, 17 Feb 2020 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581929725;
        bh=LiD0wpeLuAZLFDhqBJDQhakw+QOv6Ro2nF6g7+1ShYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T7j5g6BqDf63jH2rOMD76ozsTApstwhm6WAn6KxHSeOYJd1va3x3KizirWGUirv4T
         1V9pPbHndMu/++4cKBFG9hQXRiLTr6nfYWL7plWP3SmZLT8n05+EoTzIH33ry2rx8V
         h1n1wdA2B9OiI9W004ewtnR6ggjG8CLQ3LH0wxiE=
Date:   Mon, 17 Feb 2020 17:55:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-Id: <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
In-Reply-To: <20200215145934.GD2935@paulmck-ThinkPad-P72>
References: <20200213164031.GH14914@hirez.programming.kicks-ass.net>
        <20200213185612.GG2935@paulmck-ThinkPad-P72>
        <20200213204444.GA94647@google.com>
        <20200213205442.GK2935@paulmck-ThinkPad-P72>
        <20200213211930.GG170680@google.com>
        <20200213163800.5c51a5f1@gandalf.local.home>
        <20200213215004.GM2935@paulmck-ThinkPad-P72>
        <20200213170451.690c4e5c@gandalf.local.home>
        <20200213223918.GN2935@paulmck-ThinkPad-P72>
        <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
        <20200215145934.GD2935@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, 15 Feb 2020 06:59:34 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Fri, Feb 14, 2020 at 03:19:06PM +0900, Masami Hiramatsu wrote:
> > On Thu, 13 Feb 2020 14:39:18 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > On Thu, Feb 13, 2020 at 05:04:51PM -0500, Steven Rostedt wrote:
> > > > On Thu, 13 Feb 2020 13:50:04 -0800
> > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > 
> > > > > On Thu, Feb 13, 2020 at 04:38:25PM -0500, Steven Rostedt wrote:
> > > > > > [ Added Masami ]
> > > > > > 
> > > > > > On Thu, 13 Feb 2020 16:19:30 -0500
> > > > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > > >   
> > > > > > > On Thu, Feb 13, 2020 at 12:54:42PM -0800, Paul E. McKenney wrote:  
> > > > > > > > On Thu, Feb 13, 2020 at 03:44:44PM -0500, Joel Fernandes wrote:    
> > > > > > > > > On Thu, Feb 13, 2020 at 10:56:12AM -0800, Paul E. McKenney wrote:
> > > > > > > > > [...]     
> > > > > > > > > > > > It might well be that I could make these functions be NMI-safe, but
> > > > > > > > > > > > rcu_prepare_for_idle() in particular would be a bit ugly at best.
> > > > > > > > > > > > So, before looking into that, I have a question.  Given these proposed
> > > > > > > > > > > > changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
> > > > > > > > > > > > to just use in_nmi()?    
> > > > > > > > > > > 
> > > > > > > > > > > That _should_ already be the case today. That is, if we end up in a
> > > > > > > > > > > tracer and in_nmi() is unreliable we're already screwed anyway.    
> > > > > > > > > > 
> > > > > > > > > > So something like this, then?  This is untested, probably doesn't even
> > > > > > > > > > build, and could use some careful review from both Peter and Steve,
> > > > > > > > > > at least.  As in the below is the second version of the patch, the first
> > > > > > > > > > having been missing a couple of important "!" characters.    
> > > > > > > > > 
> > > > > > > > > I removed the static from rcu_nmi_enter()/exit() as it is called from
> > > > > > > > > outside, that makes it build now. Updated below is Paul's diff. I also added
> > > > > > > > > NOKPROBE_SYMBOL() to rcu_nmi_exit() to match rcu_nmi_enter() since it seemed
> > > > > > > > > asymmetric.    
> > > > > > > > 
> > > > > > > > My compiler complained about the static and the __always_inline, so I
> > > > > > > > fixed those.  But please help me out on adding the NOKPROBE_SYMBOL()
> > > > > > > > to rcu_nmi_exit().  What bad thing happens if we leave this on only
> > > > > > > > rcu_nmi_enter()?    
> > > > > > > 
> > > > > > > It seemed odd to me we were not allowing kprobe on the rcu_nmi_enter() but
> > > > > > > allowing it on exit (from a code reading standpoint) so my reaction was to
> > > > > > > add it to both, but we could probably keep that as a separate
> > > > > > > patch/discussion since it is slightly unrelated to the patch.. Sorry to
> > > > > > > confuse the topic.
> > > > > > >  
> > > > > > 
> > > > > > rcu_nmi_enter() was marked NOKPROBE or other reasons. See commit
> > > > > > c13324a505c77 ("x86/kprobes: Prohibit probing on functions before
> > > > > > kprobe_int3_handler()")
> > > > > > 
> > > > > > The issue was that we must not allow anything in do_int3() call kprobe
> > > > > > code before kprobe_int3_handler() is called. Because ist_enter() (in
> > > > > > do_int3()) calls rcu_nmi_enter() it had to be marked NOKPROBE. It had
> > > > > > nothing to do with it being RCU nor NMI, but because it was simply
> > > > > > called in do_int3().
> > > > > > 
> > > > > > Thus, there's no reason to make rcu_nmi_exit() NOKPROBE. But a commont
> > > > > > to why rcu_nmi_enter() would probably be useful, like below:  
> > > > > 
> > > > > Thank you, Steve!  Could I please have your Signed-off-by for this?
> > > > 
> > > > Sure, but it was untested ;-)
> > > 
> > > No problem!  I will fire up rcutorture on it.  ;-)
> > > 
> > > But experience indicates that you cannot even make a joke around here.
> > > There is probably already someone out there somewhere building a
> > > comment-checker based on deep semantic analysis and machine learning.  :-/
> > > 
> > > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > > 
> > > > I'd like a Reviewed-by from Masami though.
> > > 
> > > Sounds good!  Masami, would you be willing to review?
> > 
> > Yes, the functions before calling kprobe_int3_handler() must not
> > be kprobed. It can cause an infinite recursive int3 trapping.
> > 
> > Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thank you both!
> 
> Like this?
> 
> 							Thanx, Paul
> 

This is good to me.
BTW, if you consider the x86 specific code is in the generic file,
we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
(Sorry, I've hit this idea right now)

Thank you,

> ------------------------------------------------------------------------
> 
> commit 1817fdc8f4e4bd18c76305c9b937fb0dccbb1583
> Author: Steven Rostedt <rostedt@goodmis.org>
> Date:   Sat Feb 15 06:54:50 2020 -0800
> 
>     rcu: Provide comment for NOKPROBE() on rcu_nmi_enter()
>     
>     The rcu_nmi_enter() function was marked NOKPROBE() by commit
>     c13324a505c77 ("x86/kprobes: Prohibit probing on functions before
>     kprobe_int3_handler()") because the do_int3() call kprobe code must
>     not be invoked before kprobe_int3_handler() is called.  It turns out
>     that ist_enter() (in do_int3()) calls rcu_nmi_enter(), hence the
>     marking NOKPROBE() being added to rcu_nmi_enter().
>     
>     This commit therefore adds a comment documenting this line of reasoning.
>     
>     Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>     Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 132b53e..4a885af 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -835,6 +835,12 @@ void rcu_nmi_enter(void)
>  		   rdp->dynticks_nmi_nesting + incby);
>  	barrier();
>  }
> +/*
> + * On x86, All functions in do_int3() must be marked NOKPROBE before
> + * kprobe_int3_handler() is called. ist_enter() which is called in do_int3()
> + * before kprobe_int3_handle() happens to call rcu_nmi_enter() which means
> + * that rcu_nmi_enter() must be marked NOKRPOBE.
> + */
>  NOKPROBE_SYMBOL(rcu_nmi_enter);
>  
>  /**


-- 
Masami Hiramatsu <mhiramat@kernel.org>
