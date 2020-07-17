Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC48F22424E
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgGQRoC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 13:44:02 -0400
Received: from netrider.rowland.org ([192.131.102.5]:37627 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726593AbgGQRoB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 13:44:01 -0400
Received: (qmail 1156982 invoked by uid 1000); 17 Jul 2020 13:44:00 -0400
Date:   Fri, 17 Jul 2020 13:44:00 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>, paulmck <paulmck@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than
 membarrier_mm_sync_core_before_usermode
Message-ID: <20200717174400.GA1156312@rowland.harvard.edu>
References: <20200710015646.2020871-1-npiggin@gmail.com>
 <1370747990.15974.1594915396143.JavaMail.zimbra@efficios.com>
 <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com>
 <20200716212416.GA1126458@rowland.harvard.edu>
 <1770378591.18523.1594993165391.JavaMail.zimbra@efficios.com>
 <20200717145102.GC1147780@rowland.harvard.edu>
 <1697220787.18880.1595000348405.JavaMail.zimbra@efficios.com>
 <20200717161145.GA1150454@rowland.harvard.edu>
 <12700909.18968.1595002969773.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12700909.18968.1595002969773.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 17, 2020 at 12:22:49PM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 17, 2020, at 12:11 PM, Alan Stern stern@rowland.harvard.edu wrote:
> 
> >> > I agree with Nick: A memory barrier is needed somewhere between the
> >> > assignment at 6 and the return to user mode at 8.  Otherwise you end up
> >> > with the Store Buffer pattern having a memory barrier on only one side,
> >> > and it is well known that this arrangement does not guarantee any
> >> > ordering.
> >> 
> >> Yes, I see this now. I'm still trying to wrap my head around why the memory
> >> barrier at the end of membarrier() needs to be paired with a scheduler
> >> barrier though.
> > 
> > The memory barrier at the end of membarrier() on CPU0 is necessary in
> > order to enforce the guarantee that any writes occurring on CPU1 before
> > the membarrier() is executed will be visible to any code executing on
> > CPU0 after the membarrier().  Ignoring the kthread issue, we can have:
> > 
> >	CPU0			CPU1
> >				x = 1
> >				barrier()
> >				y = 1
> >	r2 = y
> >	membarrier():
> >	  a: smp_mb()
> >	  b: send IPI		IPI-induced mb
> >	  c: smp_mb()
> >	r1 = x
> > 
> > The writes to x and y are unordered by the hardware, so it's possible to
> > have r2 = 1 even though the write to x doesn't execute until b.  If the
> > memory barrier at c is omitted then "r1 = x" can be reordered before b
> > (although not before a), so we get r1 = 0.  This violates the guarantee
> > that membarrier() is supposed to provide.
> > 
> > The timing of the memory barrier at c has to ensure that it executes
> > after the IPI-induced memory barrier on CPU1.  If it happened before
> > then we could still end up with r1 = 0.  That's why the pairing matters.
> > 
> > I hope this helps your head get properly wrapped.  :-)
> 
> It does help a bit! ;-)
> 
> This explains this part of the comment near the smp_mb at the end of membarrier:
> 
>          * Memory barrier on the caller thread _after_ we finished
>          * waiting for the last IPI. [...]
> 
> However, it does not explain why it needs to be paired with a barrier in the
> scheduler, clearly for the case where the IPI is skipped. I wonder whether this part
> of the comment is factually correct:
> 
>          * [...] Matches memory barriers around rq->curr modification in scheduler.

The reasoning is pretty much the same as above:

	CPU0			CPU1
				x = 1
				barrier()
				y = 1
	r2 = y
	membarrier():
	  a: smp_mb()
				switch to kthread (includes mb)
	  b: read rq->curr == kthread
				switch to user (includes mb)
	  c: smp_mb()
	r1 = x

Once again, it is possible that x = 1 doesn't become visible to CPU0 
until shortly before b.  But if c is omitted then "r1 = x" can be 
reordered before b (to any time after a), so we can have r1 = 0.

Here the timing requirement is that c executes after the first memory 
barrier on CPU1 -- which is one of the ones around the rq->curr 
modification.  (In fact, in this scenario CPU1's switch back to the user 
process is irrelevant.)

Alan Stern
