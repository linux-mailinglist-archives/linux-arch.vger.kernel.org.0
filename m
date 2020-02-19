Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D37164A86
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgBSQf4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:35:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBSQf4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RKcyo1DsXf10MaYZNGHcHnkvm+uvIpJqM0TGLBVYsGQ=; b=EEPf7khcWkraQK+cMOMLl/KhoB
        B4iefPdjAGLalHAUSISw79ttDPlFEdlSPyS0oWEFP2Ye2hWLzhmvUMsm2whdzPiKGxSG8jsCXLbja
        8uFtYVgvy/FLQKEfKPAFW24+3izID9JgQIHc08x1K71DkUUwU15BOP9XQLe7Bdnq98lngwdhVgWq6
        8n5ETttozHA1rFZRQrb6Lr0hXWHN7Qt+1GGyir7S5fQaSBjRR83GMWtnFHtCg232zv6hd4ILYB4CX
        orMvibQYqzWV1GjsOVZAga7OgMmFPyjLsafzhgqsCbz1r5H0ZJthzQ/QInHxkbebPQHAaN9w466Td
        Cp1c3baQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SK1-000745-O5; Wed, 19 Feb 2020 16:35:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA5B0300606;
        Wed, 19 Feb 2020 17:33:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3C03201BADC1; Wed, 19 Feb 2020 17:35:35 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:35:35 +0100
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
Message-ID: <20200219163535.GJ18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.832297480@infradead.org>
 <20200219104903.46686b81@gandalf.local.home>
 <20200219155828.GF18400@hirez.programming.kicks-ass.net>
 <20200219111532.719c0a6b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219111532.719c0a6b@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 11:15:32AM -0500, Steven Rostedt wrote:
> On Wed, 19 Feb 2020 16:58:28 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, Feb 19, 2020 at 10:49:03AM -0500, Steven Rostedt wrote:
> > > On Wed, 19 Feb 2020 15:47:32 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:  
> > 
> > > > These helpers are macros because of header-hell; they're placed here
> > > > because of the proximity to nmi_{enter,exit{().  
> > 
> > ^^^^
> 
> Bah I can't read, because I even went looking for this!
> 
> > 
> > > > +#define trace_rcu_enter()					\
> > > > +({								\
> > > > +	unsigned long state = 0;				\
> > > > +	if (!rcu_is_watching())	{				\
> > > > +		rcu_irq_enter_irqsave();			\
> > > > +		state = 1;					\
> > > > +	}							\
> > > > +	state;							\
> > > > +})
> > > > +
> > > > +#define trace_rcu_exit(state)					\
> > > > +do {								\
> > > > +	if (state)						\
> > > > +		rcu_irq_exit_irqsave();				\
> > > > +} while (0)
> > > > +  
> > > 
> > > Is there a reason that these can't be static __always_inline functions?  
> > 
> > It can be done, but then we need fwd declarations of those RCU functions
> > somewhere outside of rcupdate.h. It's all a bit of a mess.
> 
> Maybe this belongs in the rcupdate.h file then?

Possibly, and I suppose the current version is less obviously dependent
on the in_nmi() functionality as was the previous, seeing how Paul
frobbed that all the way into the rcu_irq_enter*() implementation.

So sure, I can go move it I suppose.
