Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FA443FEEE
	for <lists+linux-arch@lfdr.de>; Fri, 29 Oct 2021 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhJ2PEZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Oct 2021 11:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ2PEY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 Oct 2021 11:04:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF918610C7;
        Fri, 29 Oct 2021 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635519716;
        bh=YU3SKyC4e2m8Lcg4RAF1+N0COfHneo3Q2e46w4Iwa8w=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cd2JjO30e1QlVXotH2ecvoeeyFpuKEltiLrgGIFGVLpvBGQmT19cCxJoE1+ddBeiD
         XfPbPCn1bx9HqUpAyV1aB4fCZuxC4L16zg7BCxSSlYXb5svkcOeEWUPFf82MstQWOd
         kK04SIq0NPemINsI1IejTW/R8KOU1j/xEjowDrQ16/bBwprcBKXQp5iNQB1B7eInqV
         sjTHoyW+Sw+uZBqyhULEKANdCrzCN0kAEUjq4l8zB3PhcbdVNmGVVnfZR3ZMzR2W2q
         abdWXXVdgiyZgVLXeCsSBrHCJYqcLzhywEl7rUzX1bVT5FiCBoJ97EQenJZfo02NQG
         gvG5yzMUgWXeQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 570E35C051B; Fri, 29 Oct 2021 08:01:55 -0700 (PDT)
Date:   Fri, 29 Oct 2021 08:01:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Dan Lustig <dlustig@nvidia.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Anvin <hpa@zytor.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Stephane Eranian <eranian@google.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mpe@ellerman.id.au,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC v2 3/3] tools/memory-model: litmus: Add two tests for
 unlock(A)+lock(B) ordering
Message-ID: <20211029150155.GS880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211025145416.698183-1-boqun.feng@gmail.com>
 <20211025145416.698183-4-boqun.feng@gmail.com>
 <YXenrNeS+IaSDwvU@hirez.programming.kicks-ass.net>
 <20211028191129.GJ880162@paulmck-ThinkPad-P17-Gen-1>
 <YXs3i8g+GHYbRCRQ@boqun-archlinux>
 <20211029143442.GB1384368@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029143442.GB1384368@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 29, 2021 at 10:34:42AM -0400, Alan Stern wrote:
> On Fri, Oct 29, 2021 at 07:51:39AM +0800, Boqun Feng wrote:
> > On Thu, Oct 28, 2021 at 12:11:29PM -0700, Paul E. McKenney wrote:
> > > On Tue, Oct 26, 2021 at 09:01:00AM +0200, Peter Zijlstra wrote:
> > > > On Mon, Oct 25, 2021 at 10:54:16PM +0800, Boqun Feng wrote:
> > > > > diff --git a/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> > > > > new file mode 100644
> > > > > index 000000000000..955b9c7cdc7f
> > > > > --- /dev/null
> > > > > +++ b/tools/memory-model/litmus-tests/LB+unlocklockonceonce+poacquireonce.litmus
> > > > > @@ -0,0 +1,33 @@
> > > > > +C LB+unlocklockonceonce+poacquireonce
> > > > > +
> > > > > +(*
> > > > > + * Result: Never
> > > > > + *
> > > > > + * If two locked critical sections execute on the same CPU, all accesses
> > > > > + * in the first must execute before any accesses in the second, even if
> > > > > + * the critical sections are protected by different locks.
> > > > 
> > > > One small nit; the above "all accesses" reads as if:
> > > > 
> > > > 	spin_lock(s);
> > > > 	WRITE_ONCE(*x, 1);
> > > > 	spin_unlock(s);
> > > > 	spin_lock(t);
> > > > 	r1 = READ_ONCE(*y);
> > > > 	spin_unlock(t);
> > > > 
> > > > would also work, except of course that's the one reorder allowed by TSO.
> > > 
> > > I applied this series with Peter's Acked-by, and with the above comment
> > 
> > Thanks!
> > 
> > > reading as follows:
> > > 
> > > +(*
> > > + * Result: Never
> > > + *
> > > + * If two locked critical sections execute on the same CPU, all accesses
> > > + * in the first must execute before any accesses in the second, even if the
> > > + * critical sections are protected by different locks.  The one exception
> > > + * to this rule is that (consistent with TSO) a prior write can be reordered
> > > + * with a later read from the viewpoint of a process not holding both locks.
> > 
> > Just want to be accurate, in our memory model "execute" means a CPU
> > commit an memory access instruction to the Memory Subsystem, so if we
> > have a store W and a load R, where W executes before R, it doesn't mean
> > the memory effect of W is observed before the memory effect of R by
> > other CPUs, consider the following case
> > 
> > 
> > 	CPU0			Memory Subsystem		CPU1
> > 	====							====
> > 	WRITE_ONCE(*x,1); // W ---------->|
> > 	spin_unlock(s);                   |
> > 	spin_lock(t);                     |
> > 	r1 = READ_ONCE(*y); // R -------->|
> > 	// R reads 0                      |
> > 					  |<----------------WRITR_ONCE(*y, 1); // W'
> > 		 W' propagates to CPU0    |
> > 		<-------------------------|
> > 					  |                 smp_mb();
> > 					  |<----------------r1 = READ_ONCE(*x); // R' reads 0
> > 					  |
> > 					  | W progrates to CPU 1
> > 		                          |----------------->
> > 
> > The "->" from CPU0 to the Memory Subsystem shows that W executes before
> > R, however the memory effect of a store can be observed only after the
> > Memory Subsystem propagates it to another CPU, as a result CPU1 doesn't
> > observe W before R is executed. So the original version of the comments
> > is correct in our memory model terminology, at least that's how I
> > understand it, Alan can correct me if I'm wrong.
> 
> Indeed, that is correct.
> 
> It is an unfortunate inconsistency with the terminology in 
> Documentation/memory-barriers.txt.  I suspect most people think of a 
> write as executing when it is observed by another CPU, even though that 
> really isn't a coherent concept.  (For example, it could easily lead 
> somebody to think that a write observed at different times by different 
> CPUs has executed more than once!)

Agreed, the terminology is odd.  But the fact that different CPUs can
see writes in different orders is probably always going to be a bit
counter-intuitive, so it is good to avoid giving that intuition any
support.

> > Maybe it's better to replace the sentence starting with "The one
> > exception..." into:
> > 
> > One thing to notice is that even though a write executes by a read, the
> > memory effects can still be reordered from the viewpoint of a process
> > not holding both locks, similar to TSO ordering.
> > 
> > Thoughts?
> 
> Or more briefly:
> 
> 	Note: Even when a write executes before a read, their memory
> 	effects can be reordered from the viewpoint of another CPU (the 
> 	kind of reordering allowed by TSO).

Very good!  I took this verbatim in a fixup patch to be combined
with the original on my next rebase.

							Thanx, Paul

> Alan
> 
> > Apologies for responsing late...
> > 
> > ("Memory Subsystem" is an abstraction in our memory model, which doesn't
> > mean hardware implements things in the same way.).
> > 
> > Regards,
> > Boqun
> > 
> > > + *)
> > > 
> > > Thank you all!
> > > 
> > > 							Thanx, Paul
