Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59B5223EAB
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jul 2020 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGQOvD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jul 2020 10:51:03 -0400
Received: from netrider.rowland.org ([192.131.102.5]:34099 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726204AbgGQOvD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jul 2020 10:51:03 -0400
Received: (qmail 1150141 invoked by uid 1000); 17 Jul 2020 10:51:02 -0400
Date:   Fri, 17 Jul 2020 10:51:02 -0400
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
Message-ID: <20200717145102.GC1147780@rowland.harvard.edu>
References: <20200710015646.2020871-1-npiggin@gmail.com>
 <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
 <1594868476.6k5kvx8684.astroid@bobo.none>
 <1594873644.viept6os6j.astroid@bobo.none>
 <1494299304.15894.1594914382695.JavaMail.zimbra@efficios.com>
 <1370747990.15974.1594915396143.JavaMail.zimbra@efficios.com>
 <595582123.17106.1594925921537.JavaMail.zimbra@efficios.com>
 <20200716212416.GA1126458@rowland.harvard.edu>
 <1770378591.18523.1594993165391.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1770378591.18523.1594993165391.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 17, 2020 at 09:39:25AM -0400, Mathieu Desnoyers wrote:
> ----- On Jul 16, 2020, at 5:24 PM, Alan Stern stern@rowland.harvard.edu wrote:
> 
> > On Thu, Jul 16, 2020 at 02:58:41PM -0400, Mathieu Desnoyers wrote:
> >> ----- On Jul 16, 2020, at 12:03 PM, Mathieu Desnoyers
> >> mathieu.desnoyers@efficios.com wrote:
> >> 
> >> > ----- On Jul 16, 2020, at 11:46 AM, Mathieu Desnoyers
> >> > mathieu.desnoyers@efficios.com wrote:
> >> > 
> >> >> ----- On Jul 16, 2020, at 12:42 AM, Nicholas Piggin npiggin@gmail.com wrote:
> >> >>> I should be more complete here, especially since I was complaining
> >> >>> about unclear barrier comment :)
> >> >>> 
> >> >>> 
> >> >>> CPU0                     CPU1
> >> >>> a. user stuff            1. user stuff
> >> >>> b. membarrier()          2. enter kernel
> >> >>> c. smp_mb()              3. smp_mb__after_spinlock(); // in __schedule
> >> >>> d. read rq->curr         4. rq->curr switched to kthread
> >> >>> e. is kthread, skip IPI  5. switch_to kthread
> >> >>> f. return to user        6. rq->curr switched to user thread
> >> >>> g. user stuff            7. switch_to user thread
> >> >>>                         8. exit kernel
> >> >>>                         9. more user stuff

...

> >> Requiring a memory barrier between update of rq->curr (back to current process's
> >> thread) and following user-space memory accesses does not seem to guarantee
> >> anything more than what the initial barrier at the beginning of __schedule
> >> already
> >> provides, because the guarantees are only about accesses to user-space memory.

...

> > Is it correct to say that the switch_to operations in 5 and 7 include
> > memory barriers?  If they do, then skipping the IPI should be okay.
> > 
> > The reason is as follows: The guarantee you need to enforce is that
> > anything written by CPU0 before the membarrier() will be visible to CPU1
> > after it returns to user mode.  Let's say that a writes to X and 9
> > reads from X.
> > 
> > Then we have an instance of the Store Buffer pattern:
> > 
> >	CPU0			CPU1
> >	a. Write X		6. Write rq->curr for user thread
> >	c. smp_mb()		7. switch_to memory barrier
> >	d. Read rq->curr	9. Read X
> > 
> > In this pattern, the memory barriers make it impossible for both reads
> > to miss their corresponding writes.  Since d does fail to read 6 (it
> > sees the earlier value stored by 4), 9 must read a.
> > 
> > The other guarantee you need is that g on CPU0 will observe anything
> > written by CPU1 in 1.  This is easier to see, using the fact that 3 is a
> > memory barrier and d reads from 4.
> 
> Right, and Nick's reply involving pairs of loads/stores on each side
> clarifies the situation even further.

The key part of my reply was the question: "Is it correct to say that 
the switch_to operations in 5 and 7 include memory barriers?"  From the 
text quoted above and from Nick's reply, it seems clear that they do 
not.

I agree with Nick: A memory barrier is needed somewhere between the 
assignment at 6 and the return to user mode at 8.  Otherwise you end up 
with the Store Buffer pattern having a memory barrier on only one side, 
and it is well known that this arrangement does not guarantee any 
ordering.

One thing I don't understand about all this: Any context switch has to 
include a memory barrier somewhere, but both you and Nick seem to be 
saying that steps 6 and 7 don't include (or don't need) any memory 
barriers.  What am I missing?

Alan Stern
