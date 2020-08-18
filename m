Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546EF248A38
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 17:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHRPmB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgHRPl5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 11:41:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DD0C061389;
        Tue, 18 Aug 2020 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YC5uocxVWr0+W2/Gmoj0x49mC0HJbzGZXtwi1gy/ZcQ=; b=SS9qWW4idnVrCKkBcCU6p41ReX
        FbE/tWKHXCBN1dynhu4TioUKAvis/2xaDgWasXUZeqxXnSLOUXPcNJReKashsZVkV2mZ/WPUvpDqE
        rniDmzWbKqmZ3/J1j0dNL3mRHmfDElx4qfghEf7CIRadcbJTNdTkc8habCarBSY9/Y3KraOt+/5OW
        KBc6ykYp6SlAlisz4QzMyDw29bGYWsvoxfzo266zxINRAIgvj9zUQ42J6VqyzuxWXzJBp/IjHsiKa
        qXPNiybyxs7NplvnIBe0U3K2p15x+oSHEPMygRBpdzsqF7kqu8S01CtTzcLIQn/6PDtCSaEIF195A
        cnpgycng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k83kC-0004ai-3J; Tue, 18 Aug 2020 15:41:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1DDC3300DB4;
        Tue, 18 Aug 2020 17:41:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B714200D4BEA; Tue, 18 Aug 2020 17:41:43 +0200 (CEST)
Date:   Tue, 18 Aug 2020 17:41:43 +0200
From:   peterz@infradead.org
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
Message-ID: <20200818154143.GT2674@hirez.programming.kicks-ass.net>
References: <20200723105615.1268126-1-npiggin@gmail.com>
 <20200807111126.GI2674@hirez.programming.kicks-ass.net>
 <1597220073.mbvcty6ghk.astroid@bobo.none>
 <20200812103530.GL2674@hirez.programming.kicks-ass.net>
 <1597735273.s0usqkrlsk.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597735273.s0usqkrlsk.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 18, 2020 at 05:22:33PM +1000, Nicholas Piggin wrote:
> Excerpts from peterz@infradead.org's message of August 12, 2020 8:35 pm:
> > On Wed, Aug 12, 2020 at 06:18:28PM +1000, Nicholas Piggin wrote:
> >> Excerpts from peterz@infradead.org's message of August 7, 2020 9:11 pm:
> >> > 
> >> > What's wrong with something like this?
> >> > 
> >> > AFAICT there's no reason to actually try and add IRQ tracing here, it's
> >> > just a hand full of instructions at the most.
> >> 
> >> Because we may want to use that in other places as well, so it would
> >> be nice to have tracing.
> >> 
> >> Hmm... also, I thought NMI context was free to call local_irq_save/restore
> >> anyway so the bug would still be there in those cases?
> > 
> > NMI code has in_nmi() true, in which case the IRQ tracing is disabled
> > (except for x86 which has CONFIG_TRACE_IRQFLAGS_NMI).
> > 
> 
> That doesn't help. It doesn't fix the lockdep irq state going out of
> synch with the actual irq state. The code which triggered this with the
> special powerpc irq disable has in_nmi() true as well.

Urgh, you're talking about using lockdep_assert_irqs*() from NMI
context?

If not, I'm afraid I might've lost the plot a little on what exact
failure case we're talking about.
