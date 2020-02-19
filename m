Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 215A4164959
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBSP6t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:58:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44750 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSP6t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 10:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lF60vD/VbwV6dlhUvIYdXfu8tD3bK6PgeF8jmlh4ohI=; b=sMvDR2y8CaJhITjdfjfneGqJX6
        yCnvmM/T5PWkVlXFZzoaIiNRg7BL7hRXPrMT/C768pnh0w9P0ZXINsGdE9NKny3sc6AAHh8ftq1A4
        UjYqn72Vj262L/wZP7R+sdGd1AB5Kcwvm5kw5Slz5/o4Pzh5wPTYDsfd/DkDZ28kwyti7rXLMj+Tc
        EfZf6IjA0bYWmUNiPJL5KlbdrtgnGzTuoTozsfZfWxDXBdOIxOyUjjnMkHm47sAuF7yu1U5TtBalg
        tDDUBO17qGrBSL6cLlyaleyiIwh7mj4zfyDvXFUtlku213hNpHXX2tgURnkVDla5LjBWGnDyUWYOy
        sxpRjHJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Rk6-0006gM-7c; Wed, 19 Feb 2020 15:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 02690306151;
        Wed, 19 Feb 2020 16:56:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6AC1A201E47AE; Wed, 19 Feb 2020 16:58:28 +0100 (CET)
Date:   Wed, 19 Feb 2020 16:58:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 08/22] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200219155828.GF18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.832297480@infradead.org>
 <20200219104903.46686b81@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219104903.46686b81@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 10:49:03AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2020 15:47:32 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:

> > These helpers are macros because of header-hell; they're placed here
> > because of the proximity to nmi_{enter,exit{().

^^^^

> > +#define trace_rcu_enter()					\
> > +({								\
> > +	unsigned long state = 0;				\
> > +	if (!rcu_is_watching())	{				\
> > +		rcu_irq_enter_irqsave();			\
> > +		state = 1;					\
> > +	}							\
> > +	state;							\
> > +})
> > +
> > +#define trace_rcu_exit(state)					\
> > +do {								\
> > +	if (state)						\
> > +		rcu_irq_exit_irqsave();				\
> > +} while (0)
> > +
> 
> Is there a reason that these can't be static __always_inline functions?

It can be done, but then we need fwd declarations of those RCU functions
somewhere outside of rcupdate.h. It's all a bit of a mess.
