Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1E15D1F8
	for <lists+linux-arch@lfdr.de>; Fri, 14 Feb 2020 07:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgBNGTN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 01:19:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgBNGTN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Feb 2020 01:19:13 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29572217F4;
        Fri, 14 Feb 2020 06:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581661152;
        bh=mpFmXT6Xd6Sb4Pk1Lu3bQXzeeAAKLtOtxcaUiHtjYiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PxPjyk9PmkZQ62oSo1us11UDwH+jkNkDbE59duc/Jxrzb0mEiW+4H+QzjCVfnio2g
         qoQaJC4ixHsYyEHoe/1wyXRsPP/IGDTBqfsZCkR0/hvCNYaoXJTUpA5Y72oECjp61a
         nco4pO/PcP9Cs6m715zqhIQyxI5F5+ufUPYfHyWo=
Date:   Fri, 14 Feb 2020 15:19:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-Id: <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
In-Reply-To: <20200213223918.GN2935@paulmck-ThinkPad-P72>
References: <20200213082716.GI14897@hirez.programming.kicks-ass.net>
        <20200213135138.GB2935@paulmck-ThinkPad-P72>
        <20200213164031.GH14914@hirez.programming.kicks-ass.net>
        <20200213185612.GG2935@paulmck-ThinkPad-P72>
        <20200213204444.GA94647@google.com>
        <20200213205442.GK2935@paulmck-ThinkPad-P72>
        <20200213211930.GG170680@google.com>
        <20200213163800.5c51a5f1@gandalf.local.home>
        <20200213215004.GM2935@paulmck-ThinkPad-P72>
        <20200213170451.690c4e5c@gandalf.local.home>
        <20200213223918.GN2935@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 13 Feb 2020 14:39:18 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Thu, Feb 13, 2020 at 05:04:51PM -0500, Steven Rostedt wrote:
> > On Thu, 13 Feb 2020 13:50:04 -0800
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > On Thu, Feb 13, 2020 at 04:38:25PM -0500, Steven Rostedt wrote:
> > > > [ Added Masami ]
> > > > 
> > > > On Thu, 13 Feb 2020 16:19:30 -0500
> > > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > > >   
> > > > > On Thu, Feb 13, 2020 at 12:54:42PM -0800, Paul E. McKenney wrote:  
> > > > > > On Thu, Feb 13, 2020 at 03:44:44PM -0500, Joel Fernandes wrote:    
> > > > > > > On Thu, Feb 13, 2020 at 10:56:12AM -0800, Paul E. McKenney wrote:
> > > > > > > [...]     
> > > > > > > > > > It might well be that I could make these functions be NMI-safe, but
> > > > > > > > > > rcu_prepare_for_idle() in particular would be a bit ugly at best.
> > > > > > > > > > So, before looking into that, I have a question.  Given these proposed
> > > > > > > > > > changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
> > > > > > > > > > to just use in_nmi()?    
> > > > > > > > > 
> > > > > > > > > That _should_ already be the case today. That is, if we end up in a
> > > > > > > > > tracer and in_nmi() is unreliable we're already screwed anyway.    
> > > > > > > > 
> > > > > > > > So something like this, then?  This is untested, probably doesn't even
> > > > > > > > build, and could use some careful review from both Peter and Steve,
> > > > > > > > at least.  As in the below is the second version of the patch, the first
> > > > > > > > having been missing a couple of important "!" characters.    
> > > > > > > 
> > > > > > > I removed the static from rcu_nmi_enter()/exit() as it is called from
> > > > > > > outside, that makes it build now. Updated below is Paul's diff. I also added
> > > > > > > NOKPROBE_SYMBOL() to rcu_nmi_exit() to match rcu_nmi_enter() since it seemed
> > > > > > > asymmetric.    
> > > > > > 
> > > > > > My compiler complained about the static and the __always_inline, so I
> > > > > > fixed those.  But please help me out on adding the NOKPROBE_SYMBOL()
> > > > > > to rcu_nmi_exit().  What bad thing happens if we leave this on only
> > > > > > rcu_nmi_enter()?    
> > > > > 
> > > > > It seemed odd to me we were not allowing kprobe on the rcu_nmi_enter() but
> > > > > allowing it on exit (from a code reading standpoint) so my reaction was to
> > > > > add it to both, but we could probably keep that as a separate
> > > > > patch/discussion since it is slightly unrelated to the patch.. Sorry to
> > > > > confuse the topic.
> > > > >  
> > > > 
> > > > rcu_nmi_enter() was marked NOKPROBE or other reasons. See commit
> > > > c13324a505c77 ("x86/kprobes: Prohibit probing on functions before
> > > > kprobe_int3_handler()")
> > > > 
> > > > The issue was that we must not allow anything in do_int3() call kprobe
> > > > code before kprobe_int3_handler() is called. Because ist_enter() (in
> > > > do_int3()) calls rcu_nmi_enter() it had to be marked NOKPROBE. It had
> > > > nothing to do with it being RCU nor NMI, but because it was simply
> > > > called in do_int3().
> > > > 
> > > > Thus, there's no reason to make rcu_nmi_exit() NOKPROBE. But a commont
> > > > to why rcu_nmi_enter() would probably be useful, like below:  
> > > 
> > > Thank you, Steve!  Could I please have your Signed-off-by for this?
> > 
> > Sure, but it was untested ;-)
> 
> No problem!  I will fire up rcutorture on it.  ;-)
> 
> But experience indicates that you cannot even make a joke around here.
> There is probably already someone out there somewhere building a
> comment-checker based on deep semantic analysis and machine learning.  :-/
> 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > I'd like a Reviewed-by from Masami though.
> 
> Sounds good!  Masami, would you be willing to review?

Yes, the functions before calling kprobe_int3_handler() must not
be kprobed. It can cause an infinite recursive int3 trapping.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
