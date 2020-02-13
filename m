Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0906515CE30
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 23:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgBMWjW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 17:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgBMWjW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 17:39:22 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [62.84.152.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48C9420873;
        Thu, 13 Feb 2020 22:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581633560;
        bh=OqdcLgYs/O9qqvdnmHXY1jRd3h/sJ5VBb0Ngu9FAJxM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=R2f4JpXEx2zuvBJ6laAxYpDspURS90V6ML4VJammQCKBvC59xnXmQ9vc3MBHvdgyz
         YxfPVHDCkgq1igoVHhBInlyCRyt6VkLFk+Wn4wxOEyTcbMGOBgSsVxsYeamu6IS6Hg
         9afQboKq4CyRthERhgQVklupNcN3L0CAmRQwHc60=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ACE013520B69; Thu, 13 Feb 2020 14:39:18 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:39:18 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213223918.GN2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213170451.690c4e5c@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 05:04:51PM -0500, Steven Rostedt wrote:
> On Thu, 13 Feb 2020 13:50:04 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Thu, Feb 13, 2020 at 04:38:25PM -0500, Steven Rostedt wrote:
> > > [ Added Masami ]
> > > 
> > > On Thu, 13 Feb 2020 16:19:30 -0500
> > > Joel Fernandes <joel@joelfernandes.org> wrote:
> > >   
> > > > On Thu, Feb 13, 2020 at 12:54:42PM -0800, Paul E. McKenney wrote:  
> > > > > On Thu, Feb 13, 2020 at 03:44:44PM -0500, Joel Fernandes wrote:    
> > > > > > On Thu, Feb 13, 2020 at 10:56:12AM -0800, Paul E. McKenney wrote:
> > > > > > [...]     
> > > > > > > > > It might well be that I could make these functions be NMI-safe, but
> > > > > > > > > rcu_prepare_for_idle() in particular would be a bit ugly at best.
> > > > > > > > > So, before looking into that, I have a question.  Given these proposed
> > > > > > > > > changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
> > > > > > > > > to just use in_nmi()?    
> > > > > > > > 
> > > > > > > > That _should_ already be the case today. That is, if we end up in a
> > > > > > > > tracer and in_nmi() is unreliable we're already screwed anyway.    
> > > > > > > 
> > > > > > > So something like this, then?  This is untested, probably doesn't even
> > > > > > > build, and could use some careful review from both Peter and Steve,
> > > > > > > at least.  As in the below is the second version of the patch, the first
> > > > > > > having been missing a couple of important "!" characters.    
> > > > > > 
> > > > > > I removed the static from rcu_nmi_enter()/exit() as it is called from
> > > > > > outside, that makes it build now. Updated below is Paul's diff. I also added
> > > > > > NOKPROBE_SYMBOL() to rcu_nmi_exit() to match rcu_nmi_enter() since it seemed
> > > > > > asymmetric.    
> > > > > 
> > > > > My compiler complained about the static and the __always_inline, so I
> > > > > fixed those.  But please help me out on adding the NOKPROBE_SYMBOL()
> > > > > to rcu_nmi_exit().  What bad thing happens if we leave this on only
> > > > > rcu_nmi_enter()?    
> > > > 
> > > > It seemed odd to me we were not allowing kprobe on the rcu_nmi_enter() but
> > > > allowing it on exit (from a code reading standpoint) so my reaction was to
> > > > add it to both, but we could probably keep that as a separate
> > > > patch/discussion since it is slightly unrelated to the patch.. Sorry to
> > > > confuse the topic.
> > > >  
> > > 
> > > rcu_nmi_enter() was marked NOKPROBE or other reasons. See commit
> > > c13324a505c77 ("x86/kprobes: Prohibit probing on functions before
> > > kprobe_int3_handler()")
> > > 
> > > The issue was that we must not allow anything in do_int3() call kprobe
> > > code before kprobe_int3_handler() is called. Because ist_enter() (in
> > > do_int3()) calls rcu_nmi_enter() it had to be marked NOKPROBE. It had
> > > nothing to do with it being RCU nor NMI, but because it was simply
> > > called in do_int3().
> > > 
> > > Thus, there's no reason to make rcu_nmi_exit() NOKPROBE. But a commont
> > > to why rcu_nmi_enter() would probably be useful, like below:  
> > 
> > Thank you, Steve!  Could I please have your Signed-off-by for this?
> 
> Sure, but it was untested ;-)

No problem!  I will fire up rcutorture on it.  ;-)

But experience indicates that you cannot even make a joke around here.
There is probably already someone out there somewhere building a
comment-checker based on deep semantic analysis and machine learning.  :-/

> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> I'd like a Reviewed-by from Masami though.

Sounds good!  Masami, would you be willing to review?

							Thanx, Paul
