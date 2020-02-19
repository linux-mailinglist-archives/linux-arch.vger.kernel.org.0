Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D8D164C3D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSRk0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgBSRk0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:40:26 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FA220801;
        Wed, 19 Feb 2020 17:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582134026;
        bh=i92S40+jzCfAaut1HbIbCYpH99Q9SSIALtCHn4Qn0eY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gu/5ow6Hv34c40kPs1ZHrz3VzubkdmEsjjyh3Nr7n/t6WHgyI3H/5XLTnyR4Bpysq
         pPA6ygMa0irWXaC2FQzYFCWIi6hY3zOY9VsIvFj1x+2Tf49aKmGLEqPMo13u6YAr6r
         R/2JNcN/qnS/qXTxavVI0kSOVz9LLv8QbSY7gRrQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E215A35209B0; Wed, 19 Feb 2020 09:40:25 -0800 (PST)
Date:   Wed, 19 Feb 2020 09:40:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 13/22] tracing: Remove regular RCU context for
 _rcuidle tracepoints (again)
Message-ID: <20200219174025.GJ2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150745.125119627@infradead.org>
 <20200219164356.GB2935@paulmck-ThinkPad-P72>
 <20200219164736.GL18400@hirez.programming.kicks-ass.net>
 <20200219170507.GH14946@hirez.programming.kicks-ass.net>
 <20200219122116.7aeaf230@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219122116.7aeaf230@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 12:21:16PM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2020 18:05:07 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Feb 19, 2020 at 05:47:36PM +0100, Peter Zijlstra wrote:
> > > On Wed, Feb 19, 2020 at 08:43:56AM -0800, Paul E. McKenney wrote:  
> > > > On Wed, Feb 19, 2020 at 03:47:37PM +0100, Peter Zijlstra wrote:  
> > > > > Effectively revert commit 865e63b04e9b2 ("tracing: Add back in
> > > > > rcu_irq_enter/exit_irqson() for rcuidle tracepoints") now that we've
> > > > > taught perf how to deal with not having an RCU context provided.
> > > > > 
> > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > ---
> > > > >  include/linux/tracepoint.h |    8 ++------
> > > > >  1 file changed, 2 insertions(+), 6 deletions(-)
> > > > > 
> > > > > --- a/include/linux/tracepoint.h
> > > > > +++ b/include/linux/tracepoint.h
> > > > > @@ -179,10 +179,8 @@ static inline struct tracepoint *tracepo  
> > > > 
> > > > Shouldn't we also get rid of this line above?
> > > > 
> > > > 		int __maybe_unused __idx = 0;				\
> > > >   
> > > 
> > > Probably makes a lot of sense, lemme fix that!  
> > 
> > Oh wait, no! SRCU is the one that remains !
> 
> Correct, and if rcuidle is not set, and this is a macro, the SRCU
> portion is compiled out.

Sigh!  Apologies for the noise!

If we are using SRCU, we don't care whether or not RCU is watching.  OK,
maybe finally catching up -- the whole point was use of RCU in other
tracing code, wasn't it?

						Thanx, Paul
