Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9005C16328B
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2020 21:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgBRUHf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 15:07:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33422 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgBRT65 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 14:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jhFMuIkrGdoFJ2Bzf898MeLf5h06pE6PgMihUSGnnDk=; b=mxsS0/EU42AG2iYsPYJdls+yF1
        PrlGW+zlqETrZtlV7Vx5vhcX3h7Zj4Grh0Pn9VA8K32FhlVOuJE8pwMx/ggjIvT0ZBHgwLwfVez6S
        ZZon/NmW8gJa+4vPf91VX3lxFtT7Hnw+PqUuWL3rbf5kbYyDkFP4huOQHB4JAEaOAqGtoMgFHmWDb
        sKSIBbwqug1KkoXyBMd80l3mNmlqS6TDmzoQRFFpkIuvG6YhvF/r0HOLu/sCtVO/5LGVvkE0fqyS1
        SVeH3cbjJSkHXVjW5Qi427wWuQn8GbRVVyNR5M5pQUKei7yOOL8W7MUHrI8sZI/vzLWUK2jruoUON
        ainiY+YQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j490u-0005LK-No; Tue, 18 Feb 2020 19:58:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 75315980E53; Tue, 18 Feb 2020 20:58:31 +0100 (CET)
Date:   Tue, 18 Feb 2020 20:58:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200218195831.GD11457@worktop.programming.kicks-ass.net>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
 <20200213082716.GI14897@hirez.programming.kicks-ass.net>
 <20200213135138.GB2935@paulmck-ThinkPad-P72>
 <20200213164031.GH14914@hirez.programming.kicks-ass.net>
 <20200213185612.GG2935@paulmck-ThinkPad-P72>
 <20200213204444.GA94647@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213204444.GA94647@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 13, 2020 at 03:44:44PM -0500, Joel Fernandes wrote:

> > > That _should_ already be the case today. That is, if we end up in a
> > > tracer and in_nmi() is unreliable we're already screwed anyway.

> I removed the static from rcu_nmi_enter()/exit() as it is called from
> outside, that makes it build now. Updated below is Paul's diff. I also added
> NOKPROBE_SYMBOL() to rcu_nmi_exit() to match rcu_nmi_enter() since it seemed
> asymmetric.

> +__always_inline void rcu_nmi_exit(void)
>  {
>  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>  
> @@ -651,25 +653,15 @@ static __always_inline void rcu_nmi_exit_common(bool irq)
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

Boris and me have been going over the #MC code (and finding loads of
'interesting' code) and ran into ist_enter(), whish has the following
code:

                /*
                 * We might have interrupted pretty much anything.  In
                 * fact, if we're a machine check, we can even interrupt
                 * NMI processing.  We don't want in_nmi() to return true,
                 * but we need to notify RCU.
                 */
                rcu_nmi_enter();


Which, to me, sounds all sorts of broken. The IST (be it #DB or #MC) can
happen while we're holding all sorts of locks. This must be an NMI-like
context.


