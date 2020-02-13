Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03B9B15BAC1
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 09:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgBMI16 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 03:27:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37828 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgBMI15 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 13 Feb 2020 03:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hBfDlwtqklEammb2YxFsK0X9jlsEpvDn83y+O10mAko=; b=iRzU+Cyhwkt+b7sSBUwIG5Yb9Y
        T+kqkDL/I76g1B8E0nsqwBKUHE2vQadqc6LO6nwboFfRhV/fURG2GIHlWiwodWxoppLM8xLq63nR4
        vYM+dTP8QWEUPAVdQnIXbX7X9f8H5FjQzh7t6LlYZx4DidQ+Pe+IgKKUZExtlfw0Cpd349Xx1JBo4
        y5luIsMUYs25lqboCl04k1imEULFW7tYlO+JFlGi7HkgDmg6bU8ruCcXdrg0n8GozwceNEHUwwld+
        h7/FakeGnqrL9bCsLKaXh+8f56/XfCBDojWB4Blv69fs11oJjGXK/5cuR3DE48jNiQRS4evG4wV6A
        NhT8P+3A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j29qA-0005cI-EY; Thu, 13 Feb 2020 08:27:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 39CD63012D8;
        Thu, 13 Feb 2020 09:25:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8664C20206D6B; Thu, 13 Feb 2020 09:27:16 +0100 (CET)
Date:   Thu, 13 Feb 2020 09:27:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213082716.GI14897@hirez.programming.kicks-ass.net>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232005.GC115917@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212232005.GC115917@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 12, 2020 at 06:20:05PM -0500, Joel Fernandes wrote:
> On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:

> > +#define trace_rcu_enter()					\
> > +({								\
> > +	unsigned long state = 0;				\
> > +	if (!rcu_is_watching())	{				\
> > +		if (in_nmi()) {					\
> > +			state = __TR_NMI;			\
> > +			rcu_nmi_enter();			\
> > +		} else {					\
> > +			state = __TR_IRQ;			\
> > +			rcu_irq_enter_irqsave();		\
> 
> I think this can be simplified. You don't need to rely on in_nmi() here. I
> believe for NMI's, you can just call rcu_irq_enter_irqsave() and that should
> be sufficient to get RCU watching. Paul can correct me if I'm wrong, but I am
> pretty sure that would work.
> 
> In fact, I think a better naming for rcu_irq_enter_irqsave() pair could be
> (in the first patch):
> 
> rcu_ensure_watching_begin();
> rcu_ensure_watching_end();

So I hadn't looked deeply into rcu_irq_enter(), it seems to call
rcu_nmi_enter_common(), but with @irq=true.

What exactly is the purpose of that @irq argument, and how much will it
hurt to lie there? Will it come apart if we have @irq != !in_nmi()
for example?

There is a comment in there that says ->dynticks_nmi_nesting ought to be
odd only if we're in NMI. The only place that seems to care is
rcu_nmi_exit_common(), and that does indeed do something different for
IRQs vs NMIs.

So I don't think we can blindly unify this. But perhaps Paul sees a way?
