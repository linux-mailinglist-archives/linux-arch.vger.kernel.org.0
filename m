Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A981F5525
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jun 2020 14:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgFJMso (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Jun 2020 08:48:44 -0400
Received: from foss.arm.com ([217.140.110.172]:58356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbgFJMso (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Jun 2020 08:48:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96B891F1;
        Wed, 10 Jun 2020 05:48:43 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D485D3F66F;
        Wed, 10 Jun 2020 05:48:42 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:48:40 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/6] prctl.2: Add SVE prctls (arm64)
Message-ID: <20200610124838.GG25945@arm.com>
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-5-git-send-email-Dave.Martin@arm.com>
 <20200609095734.GA25362@willie-the-truck>
 <20200609140948.GA25945@arm.com>
 <20200609144905.GA28353@willie-the-truck>
 <20200610094440.GD25945@arm.com>
 <20200610101649.GA17788@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610101649.GA17788@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 10, 2020 at 11:16:49AM +0100, Will Deacon wrote:
> [Dropped linux-man and Michael]
> 
> On Wed, Jun 10, 2020 at 10:44:42AM +0100, Dave Martin wrote:
> > On Tue, Jun 09, 2020 at 03:49:05PM +0100, Will Deacon wrote:
> > > On Tue, Jun 09, 2020 at 03:11:42PM +0100, Dave Martin wrote:
> > > > On Tue, Jun 09, 2020 at 10:57:35AM +0100, Will Deacon wrote:
> > > > > On Wed, May 27, 2020 at 10:17:36PM +0100, Dave Martin wrote:
> > > > > > +.RS
> > > > > > +.TP
> > > > > > +.B 0
> > > > > > +Perform the change immediately.
> > > > > > +At the next
> > > > > > +.BR execve (2)
> > > > > > +in the thread,
> > > > > > +the vector length will be reset to the value configured in
> > > > > > +.IR /proc/sys/abi/sve_default_vector_length .
> > > > > 
> > > > > (implementation note: does this mean that 'sve_default_vl' should be
> > > > >  an atomic_t, as it can be accessed concurrently? We probably need
> > > > >  {READ,WRITE}_ONCE() at the very least, as I'm not seeing any locks
> > > > >  that help us here...)
> > > > 
> > > > Is this purely theoretical?  Can you point to what could go wrong?
> > > 
> > > If the write is torn by the compiler, then a concurrent reader could end
> > > up seeing a bogus value. There could also be ToCToU issues if it's re-read.
> > 
> > It won't be torn in practice, no decision logic depends on the value
> > read, and you can't even get from the write to the read or vice-versa
> > without crossing a TU boundary (even under LTO), so there's basically
> > zero scope for sabotXXXXXoptimisation by the compiler.
> 
> Perhaps, but I'm not brave enough to state that :) Look at this crazy
> thing, for example:
> 
> https://lore.kernel.org/lkml/CAG48ez2nFks+yN1Kp4TZisso+rjvv_4UW0FTo8iFUd4Qyq1qDw@mail.gmail.com/
> 
> Could the same sort of technique be applied to:
> 
> 
> 	vl = current->thread.sve_vl_onexec ?
> 	     current->thread.sve_vl_onexec : sve_default_vl;
> 
> 	if (WARN_ON(!sve_vl_valid(vl)))
> 		vl = SVE_VL_MIN;
> 
> 	supported_vl = find_supported_vector_length(vl);
> 
> 
> so that the compiled code does something like:
> 
> 
> 	if (within_valid_bounds(sve_default_vl)) {
> 		supported_vl = jump_table(sve_default_vl); // Reload the variable
> 	} else {
> 		WARN_ON(1);
> 		supported_vl = SVE_VL_MIN;
> 	}
> 
> 
> ?
> 
> I'd certainly prefer not to have to think about that!

Well sure, but the compiler has much to lose and nothing to gain from
such a transformation here.  This is a bit different from a load of
conditional code that can be heavily const-folded during specialisation.

Anyway, I'm not saying that you're not correct about the risk, just that
this feels like a common pattern.


> > Only root is allowed to write this thing anyway.
> > 
> > > > While I doubt I thought about this very hard and I agree that you're
> > > > right in principle, I think there are probably non-atomic sysctls and
> > > > debugs files etc. all over the place.
> > > > 
> > > > I didn't want to clutter the code unnecessarily.
> > > 
> > > Right, but KCSAN is coming along and so somebody less familiar with the code
> > > will hit this eventually.
> > 
> > So the issue is theoretical, probably one of very many similar issues,
> > and anyway we have a tool for tracking them down if we need to?
> > 
> > I'm playing devil's advocate here, but I'd debate whether it's worth
> > it -- or even wise -- to fix these piecemeal unless we're confident this
> > is an egregious case.  Doing so may encourage a false sense of safety.
> > When we're in a position to do a treewide cleanup, that would be better,
> > no?
> 
> That's a good point, but it is inevitable that people will try to attempt
> treewide introduction of {READ,WRITE}_ONCE() based solely on KCSAN reports
> rather than an understanding of the code, and so I'd much rather somebody
> who understands the code (that's you ;) deals with it first.
> 
> If the race is benign, then you can annotate the accesses with data_race()
> and add a comment along the lines of your "It won't be torn in practice..."
> paragraph above.

Oh, it's complex enough to reason about that we should definitely use
proper atomics here so that we don't have to think about it.  Also, I'd
concede that the fact that this code has a custom sysctl accessor may
make justify a special case fix.

For most users, it would be better to clip sysctl's wings so that only
atomic accesses are allowed if the default implementation is used.  sysctl
is not a fast path: for single values of fundamental types, there's no
reason I can think of not to use atomics across the board.


> Anyway, this is entirely independent to the manpage effort, just that the
> concurrency wasn't clear to me before I read what you'd written and thought
> I'd mention this before I forget. It's also looking less likely that KCSAN
> is going to land for 5.8, so there's no urgency to this at all.

Sure, and I don't think I thought much beyond "I wonder what happens if
... nah, probably fine, if it mattered then everyone would be doing it."

I'm pretty sure I didn't get that wording out of the C spec.

It's a good spot though, and I may look at a fix if I get around to it.
Can't promise when, though.

Cheers
---Dave
