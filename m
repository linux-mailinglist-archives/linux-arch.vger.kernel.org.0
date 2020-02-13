Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71D115CE68
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 23:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgBMW64 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 17:58:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44394 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgBMW6z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 17:58:55 -0500
Received: by mail-qt1-f193.google.com with SMTP id k7so5699995qth.11
        for <linux-arch@vger.kernel.org>; Thu, 13 Feb 2020 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QQ8aqjci/Lwyw9q7suLzZpcUN0T/hD2Iv8u4ubfdK48=;
        b=kWOo8uCeKieahZ+ybYWZM3x7RVS4A2jmbvaRDycQFoBM9+9Ymq8sa6dSYezmrHTjYC
         FymL8ax9jbhLxDqkYKcdWgFPi+MOzVMCCEo4g3+/1YvGCxVYb0+Vgav4U0OURgSFH3c2
         7m1AJUdWUEUBYvo7+W1HDemO8Wf9+jYkUEuiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QQ8aqjci/Lwyw9q7suLzZpcUN0T/hD2Iv8u4ubfdK48=;
        b=YLap6AjREOGH5/jJExBmOWW0Ousr9pXpGXe3DEO1NmZr6JFn/e6iabI3LEBvUkeEB/
         1xMyQHVtRv8OYqLi56piC1CC7xM1/d7K3aJQQHXiRMPQxgYShYTXiatvzyTe1yq+2VOl
         ZtF3iaNfEeFFHOoGNL/UOxdw3jcSn03zRzMSkFh5nwRmkn8fRxSsctsjpW22xiPoa0XR
         EEn7hfmcUINpn/O8URR7ivF/ikWlTjuy1n6CfrLf6U6UFMlRTS2VqK5OX3boGKLLze+H
         jUp2GOCCRZM7rE6Z7thBQdPDC4BpgoKsmV/So+kOOsFaSoiPbZSKx5ddE7MFO+9ggc8S
         3ONA==
X-Gm-Message-State: APjAAAWEgPx+M5plNCjmhEAdvW8WpOyV770a9RWpYiIycrxezRKhGsrG
        ZAGq99k/aIx7d0mzZm6J4KmuIA==
X-Google-Smtp-Source: APXvYqwhCRC/g7GQf6Y2QhfsSs4pBHwdi/mReCnFduCOhskIwE3bDHjtCmPLxLOm+JQ/BbHZzN8Bdg==
X-Received: by 2002:ac8:7b9b:: with SMTP id p27mr369676qtu.2.1581634734355;
        Thu, 13 Feb 2020 14:58:54 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a13sm2139459qkh.123.2020.02.13.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 14:58:53 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:58:53 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213225853.GB112239@google.com>
References: <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
 <20200213185612.GG2935@paulmck-ThinkPad-P72>
 <20200213204444.GA94647@google.com>
 <20200213205442.GK2935@paulmck-ThinkPad-P72>
 <20200213211930.GG170680@google.com>
 <20200213214859.GL2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213214859.GL2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 01:48:59PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 13, 2020 at 04:19:30PM -0500, Joel Fernandes wrote:
> > On Thu, Feb 13, 2020 at 12:54:42PM -0800, Paul E. McKenney wrote:
> > > On Thu, Feb 13, 2020 at 03:44:44PM -0500, Joel Fernandes wrote:
> > > > On Thu, Feb 13, 2020 at 10:56:12AM -0800, Paul E. McKenney wrote:
> > > > [...] 
> > > > > > > It might well be that I could make these functions be NMI-safe, but
> > > > > > > rcu_prepare_for_idle() in particular would be a bit ugly at best.
> > > > > > > So, before looking into that, I have a question.  Given these proposed
> > > > > > > changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
> > > > > > > to just use in_nmi()?
> > > > > > 
> > > > > > That _should_ already be the case today. That is, if we end up in a
> > > > > > tracer and in_nmi() is unreliable we're already screwed anyway.
> > > > > 
> > > > > So something like this, then?  This is untested, probably doesn't even
> > > > > build, and could use some careful review from both Peter and Steve,
> > > > > at least.  As in the below is the second version of the patch, the first
> > > > > having been missing a couple of important "!" characters.
> > > > 
> > > > I removed the static from rcu_nmi_enter()/exit() as it is called from
> > > > outside, that makes it build now. Updated below is Paul's diff. I also added
> > > > NOKPROBE_SYMBOL() to rcu_nmi_exit() to match rcu_nmi_enter() since it seemed
> > > > asymmetric.
> > > 
> > > My compiler complained about the static and the __always_inline, so I
> > > fixed those.  But please help me out on adding the NOKPROBE_SYMBOL()
> > > to rcu_nmi_exit().  What bad thing happens if we leave this on only
> > > rcu_nmi_enter()?
> > 
> > It seemed odd to me we were not allowing kprobe on the rcu_nmi_enter() but
> > allowing it on exit (from a code reading standpoint) so my reaction was to
> > add it to both, but we could probably keep that as a separate
> > patch/discussion since it is slightly unrelated to the patch.. Sorry to
> > confuse the topic.
> 
> Actually and perhaps unusually, I was not being sarcastic, but was instead
> asking a serious question.  Is the current code correct?  Should the
> current NOKPROBE_SYMBOL() be removed?  Should the other NOKPROBE_SYMBOL()
> be added?  Something else?  And either way, why?

Oh ok, it was a fair question. Seems Steve nailed it, only the
rcu_nmi_enter() needs NOKPROBE, although as you mentioned in the other
thread, it would be good to get Masami's eyes on it since he introduced the
NOKPROBE.

thanks,

 - Joel


> 							Thanx, Paul
> 
> > thanks,
> > 
> >  - Joel
> > 
> > 
> > > 							Thanx, Paul
> > > 
> > > > ---8<-----------------------
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index d91c9156fab2e..bbcc7767f18ee 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -614,16 +614,18 @@ void rcu_user_enter(void)
> > > >  }
> > > >  #endif /* CONFIG_NO_HZ_FULL */
> > > >  
> > > > -/*
> > > > +/**
> > > > + * rcu_nmi_exit - inform RCU of exit from NMI context
> > > > + *
> > > >   * If we are returning from the outermost NMI handler that interrupted an
> > > >   * RCU-idle period, update rdp->dynticks and rdp->dynticks_nmi_nesting
> > > >   * to let the RCU grace-period handling know that the CPU is back to
> > > >   * being RCU-idle.
> > > >   *
> > > > - * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
> > > > + * If you add or remove a call to rcu_nmi_exit(), be sure to test
> > > >   * with CONFIG_RCU_EQS_DEBUG=y.
> > > >   */
> > > > -static __always_inline void rcu_nmi_exit_common(bool irq)
> > > > +__always_inline void rcu_nmi_exit(void)
> > > >  {
> > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > >  
> > > > @@ -651,25 +653,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
> > > >  	trace_rcu_dyntick(TPS("Startirq"), rdp->dynticks_nmi_nesting, 0, atomic_read(&rdp->dynticks));
> > > >  	WRITE_ONCE(rdp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
> > > >  
> > > > -	if (irq)
> > > > +	if (!in_nmi())
> > > >  		rcu_prepare_for_idle();
> > > >  
> > > >  	rcu_dynticks_eqs_enter();
> > > >  
> > > > -	if (irq)
> > > > +	if (!in_nmi())
> > > >  		rcu_dynticks_task_enter();
> > > >  }
> > > > -
> > > > -/**
> > > > - * rcu_nmi_exit - inform RCU of exit from NMI context
> > > > - *
> > > > - * If you add or remove a call to rcu_nmi_exit(), be sure to test
> > > > - * with CONFIG_RCU_EQS_DEBUG=y.
> > > > - */
> > > > -void rcu_nmi_exit(void)
> > > > -{
> > > > -	rcu_nmi_exit_common(false);
> > > > -}
> > > > +NOKPROBE_SYMBOL(rcu_nmi_exit);
> > > >  
> > > >  /**
> > > >   * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
> > > > @@ -693,7 +685,7 @@ void rcu_nmi_exit(void)
> > > >  void rcu_irq_exit(void)
> > > >  {
> > > >  	lockdep_assert_irqs_disabled();
> > > > -	rcu_nmi_exit_common(true);
> > > > +	rcu_nmi_exit();
> > > >  }
> > > >  
> > > >  /*
> > > > @@ -777,7 +769,7 @@ void rcu_user_exit(void)
> > > >  #endif /* CONFIG_NO_HZ_FULL */
> > > >  
> > > >  /**
> > > > - * rcu_nmi_enter_common - inform RCU of entry to NMI context
> > > > + * rcu_nmi_enter - inform RCU of entry to NMI context
> > > >   * @irq: Is this call from rcu_irq_enter?
> > > >   *
> > > >   * If the CPU was idle from RCU's viewpoint, update rdp->dynticks and
> > > > @@ -786,10 +778,10 @@ void rcu_user_exit(void)
> > > >   * long as the nesting level does not overflow an int.  (You will probably
> > > >   * run out of stack space first.)
> > > >   *
> > > > - * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
> > > > + * If you add or remove a call to rcu_nmi_enter(), be sure to test
> > > >   * with CONFIG_RCU_EQS_DEBUG=y.
> > > >   */
> > > > -static __always_inline void rcu_nmi_enter_common(bool irq)
> > > > +__always_inline void rcu_nmi_enter(void)
> > > >  {
> > > >  	long incby = 2;
> > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > > @@ -807,12 +799,12 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > > >  	 */
> > > >  	if (rcu_dynticks_curr_cpu_in_eqs()) {
> > > >  
> > > > -		if (irq)
> > > > +		if (!in_nmi())
> > > >  			rcu_dynticks_task_exit();
> > > >  
> > > >  		rcu_dynticks_eqs_exit();
> > > >  
> > > > -		if (irq)
> > > > +		if (!in_nmi())
> > > >  			rcu_cleanup_after_idle();
> > > >  
> > > >  		incby = 1;
> > > > @@ -834,14 +826,6 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > > >  		   rdp->dynticks_nmi_nesting + incby);
> > > >  	barrier();
> > > >  }
> > > > -
> > > > -/**
> > > > - * rcu_nmi_enter - inform RCU of entry to NMI context
> > > > - */
> > > > -void rcu_nmi_enter(void)
> > > > -{
> > > > -	rcu_nmi_enter_common(false);
> > > > -}
> > > >  NOKPROBE_SYMBOL(rcu_nmi_enter);
> > > >  
> > > >  /**
> > > > @@ -869,7 +853,7 @@ NOKPROBE_SYMBOL(rcu_nmi_enter);
> > > >  void rcu_irq_enter(void)
> > > >  {
> > > >  	lockdep_assert_irqs_disabled();
> > > > -	rcu_nmi_enter_common(true);
> > > > +	rcu_nmi_enter();
> > > >  }
> > > >  
> > > >  /*
