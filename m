Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0712122DEE4
	for <lists+linux-arch@lfdr.de>; Sun, 26 Jul 2020 14:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgGZMLs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Jul 2020 08:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGZMLr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 08:11:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF3AC0619D2;
        Sun, 26 Jul 2020 05:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xA3Hnz+mwiXbGsGPSLX5kHfDe9+CoKBCym0WXsIlDDo=; b=sP1/Yjfm/lG5EQn9AxmxZdauaJ
        MxUY80ZJ40JT45IWrg88x3weHFXoDis8wKOuWPpaMIKIHT08gNY7ds8XI+dxwzg/7jpjPM5iU3K2a
        fp+AniTB/M1sw3UKSnx+aNRJC078VCBq9AdVx7ousLRNjP3pvlfP78klqSV0BgalGdz6OA1Z+sNsB
        Pdlh4P7ZYXdDJN5EdIY3uw5oUbRhUZ2nn575NPj46hthp++5huQ5fcxEiK1rkElZeDTP+ReSLIUI/
        0KbZrzjPc0Kv5ZJ+TYr8ZZQvtgIhBbBqfpHnOyaokMhJJixAzDdIdFV42GrzYf3XwrXS/bGClBsAG
        nzv6UgBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzfVD-0001ia-Rc; Sun, 26 Jul 2020 12:11:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 37A07301AC6;
        Sun, 26 Jul 2020 14:11:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1BD78285770B1; Sun, 26 Jul 2020 14:11:38 +0200 (CEST)
Date:   Sun, 26 Jul 2020 14:11:38 +0200
From:   peterz@infradead.org
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200726121138.GC119549@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200725202617.GI10769@hirez.programming.kicks-ass.net>
 <1595735694.b784cvipam.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595735694.b784cvipam.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 26, 2020 at 02:14:34PM +1000, Nicholas Piggin wrote:
> Excerpts from Peter Zijlstra's message of July 26, 2020 6:26 am:

> > Which is 'funny' when it interleaves like:
> > 
> > 	local_irq_disable();
> > 	...
> > 	local_irq_enable()
> > 	  trace_hardirqs_on();
> > 	  <NMI/>
> > 	  raw_local_irq_enable();
> > 
> > Because then it will undo the trace_hardirqs_on() we just did. With the
> > result that both tracing and lockdep will see a hardirqs-disable without
> > a matching enable, while the hardware state is enabled.
> 
> Seems like an arch problem -- why not disable if it was enabled only?
> I guess the local_irq tracing calls are a mess so maybe they copied 
> those.

Because, as I wrote earlier, then we can miss updating software state.
So your proposal has:

	raw_local_irq_disable()
	<NMI>
	  if (!arch_irqs_disabled(regs->flags) // false
	    trace_hardirqs_off();

	  // tracing/lockdep still think IRQs are enabled
	  // hardware IRQ state is disabled.

With the current code we have:

	local_irq_enable()
	  trace_hardirqs_on();
	  <NMI>
	    trace_hardirqs_off();
	    ...
	    if (!arch_irqs_disabled(regs->flags)) // false
	      trace_hardirqs_on();
	  </NMI>
	  // and now the NMI disabled software state again
	  // while we're about to enable the hardware state
	  raw_local_irq_enable();

> > Which is exactly the state Alexey seems to have ran into.
> 
> No his was what I said, the interruptee's trace_hardirqs_on() in
> local_irq_enable getting lost because the NMI's local_irq_disable
> always disables, but the enable doesn't re-enable.

That's _exactly_ the case above. It doesn't re-enable because hardirqs
are actually still disabled. You _cannot_ rely on hardirq state for
NMIs, that'll get you wrong state.

> It's all just weird asymmetrical special case hacks AFAIKS, the
> code should just be symmetric and lockdep handle it's own weirdness.

It's for non-maskable exceptions/interrupts, because there the hardware
and software state changes non-atomically. For maskable interrupts doing
the software state transitions inside the disabled region makes perfect
sense, because that keeps it atomic.
