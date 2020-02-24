Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C31816A3D6
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 11:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXKZI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 05:25:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXKZI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 05:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o+RIwl2z3fGfSXogz+6Ms1fMnA92KhDOrp7AJFVIC0k=; b=FF26n3sWHo+Vcn0lMopmKWt9X1
        7s2zYag2QmNGNcwQcCEAmsPDT6cmbNzjATLt8UDMUxT/h7kcPHcyEDnM7E6u2SYTdhcQaYXhLI7x7
        St0Nc9vwQ7Q3pRo6/8jLuca8PUSp9uDD9oTBK59Zfjp+c1WToyUXb8wQyP8Tmi5PuXhpeXBUrf/qk
        OVfkAPq1LN6Qa6lysaFneZ+8NXXvbsi7alZN2zgWBAgPdTvG9qQy6W3jK44Pe89+gXm9yvCY6rKGX
        OAU8/0AeHlJaTo1M3hkT3AHHUHLVC30ZyBdEs42+al5z60PwX+100Ju3i3YRCHNwn4N9qju6V1fB7
        4OZUM8Ww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6Aus-0000Mc-3J; Mon, 24 Feb 2020 10:24:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9185C300F7A;
        Mon, 24 Feb 2020 11:22:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DAAAA29B59023; Mon, 24 Feb 2020 11:24:43 +0100 (CET)
Date:   Mon, 24 Feb 2020 11:24:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v4 09/27] rcu: Rename rcu_irq_{enter,exit}_irqson()
Message-ID: <20200224102443.GF14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.559644596@infradead.org>
 <20200221152153.15b3cf36@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221152153.15b3cf36@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 03:21:53PM -0500, Steven Rostedt wrote:
> On Fri, 21 Feb 2020 14:34:25 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -699,10 +699,10 @@ void rcu_irq_exit(void)
> >  /*
> >   * Wrapper for rcu_irq_exit() where interrupts are enabled.
> 
> 			where interrupts may be enabled.
> 
> >   *
> > - * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
> > + * If you add or remove a call to rcu_irq_exit_irqsave(), be sure to test
> >   * with CONFIG_RCU_EQS_DEBUG=y.
> >   */
> > -void rcu_irq_exit_irqson(void)
> > +void rcu_irq_exit_irqsave(void)
> >  {
> >  	unsigned long flags;
> >  
> > @@ -875,10 +875,10 @@ void rcu_irq_enter(void)
> >  /*
> >   * Wrapper for rcu_irq_enter() where interrupts are enabled.
> 
> 			where interrupts may be enabled.
> 

Thanks, done!
