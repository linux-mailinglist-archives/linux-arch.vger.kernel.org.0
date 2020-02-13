Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2670515BFC2
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 14:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbgBMNvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 08:51:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730122AbgBMNvk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 08:51:40 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [193.85.242.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AC25222C2;
        Thu, 13 Feb 2020 13:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581601900;
        bh=pF4wlPm9/JXNtyZZgcDgJBkXBHSKCagMx2dgXhEweXI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MJE+YmU/LHus552WlM+1i1hPEfM2/kwib0ms+NklJoBrzVaob0EEwAW1ddWpUjgw8
         0XDOtwXwr7RvXmP23EFI3vuy4BH/xWWFs92UAYuXbaPDaoZSPaFn0nXCnZLHRFY5kb
         FWFkYz44r6vEkpwdPTT9cEKdwTvy0DafEO4T9dXY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3AAA935226E8; Thu, 13 Feb 2020 05:51:38 -0800 (PST)
Date:   Thu, 13 Feb 2020 05:51:38 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213135138.GB2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213082716.GI14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 09:27:16AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 06:20:05PM -0500, Joel Fernandes wrote:
> > On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:
> 
> > > +#define trace_rcu_enter()					\
> > > +({								\
> > > +	unsigned long state = 0;				\
> > > +	if (!rcu_is_watching())	{				\
> > > +		if (in_nmi()) {					\
> > > +			state = __TR_NMI;			\
> > > +			rcu_nmi_enter();			\
> > > +		} else {					\
> > > +			state = __TR_IRQ;			\
> > > +			rcu_irq_enter_irqsave();		\
> > 
> > I think this can be simplified. You don't need to rely on in_nmi() here. I
> > believe for NMI's, you can just call rcu_irq_enter_irqsave() and that should
> > be sufficient to get RCU watching. Paul can correct me if I'm wrong, but I am
> > pretty sure that would work.
> > 
> > In fact, I think a better naming for rcu_irq_enter_irqsave() pair could be
> > (in the first patch):
> > 
> > rcu_ensure_watching_begin();
> > rcu_ensure_watching_end();
> 
> So I hadn't looked deeply into rcu_irq_enter(), it seems to call
> rcu_nmi_enter_common(), but with @irq=true.
> 
> What exactly is the purpose of that @irq argument, and how much will it
> hurt to lie there? Will it come apart if we have @irq != !in_nmi()
> for example?
> 
> There is a comment in there that says ->dynticks_nmi_nesting ought to be
> odd only if we're in NMI. The only place that seems to care is
> rcu_nmi_exit_common(), and that does indeed do something different for
> IRQs vs NMIs.
> 
> So I don't think we can blindly unify this. But perhaps Paul sees a way?

The reason for the irq argument is to avoid invoking
rcu_prepare_for_idle() and rcu_dynticks_task_enter() from NMI context
from rcu_nmi_exit_common().  Similarly, we need to avoid invoking
rcu_dynticks_task_exit() and rcu_cleanup_after_idle() from NMI context
from rcu_nmi_enter_common().

It might well be that I could make these functions be NMI-safe, but
rcu_prepare_for_idle() in particular would be a bit ugly at best.
So, before looking into that, I have a question.  Given these proposed
changes, will rcu_nmi_exit_common() and rcu_nmi_enter_common() be able
to just use in_nmi()?

							Thanx, Paul
