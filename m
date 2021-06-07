Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB9E39E637
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 20:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhFGSKV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 14:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhFGSKT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 14:10:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A1186100B;
        Mon,  7 Jun 2021 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623089306;
        bh=NwgiKp1vePEOmgz/sNu7+oR/y96zqS8ePq3897GVbuc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ID4Iv5JGnQ9ws3tx5Mf86eop9S5Ra2xHBeozexaeDzzX8Q8ZVFt3Jxr7AeFPX8RfX
         RRHGNlK5gsUj2PbS5KFZ9JAO6TGAd9uaFuSVvfCdJj5LGzdTJViMHAAxRUv2RqjRxk
         KARkNZx+bstLIhbvsU6exw01mVC+ZMGFIAy9mmeO8XR1Bj+nc/5BEkL+NWWuPCZBY6
         JDpprBeKOybKKGnFpdynlxqixFSXRDcIXmo0M0qSsA8905+JpmoyW8X4kLR14GOf3/
         uMf6/YDCJgJ568KTSi9WO02WfR0aD322D937wC6a/8kJI8FU+GmGZpf/pX2L3/jXyH
         KAgSY2tgIPerg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 496BC5C0395; Mon,  7 Jun 2021 11:08:26 -0700 (PDT)
Date:   Mon, 7 Jun 2021 11:08:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210607180826.GV4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606182213.GA1741684@rowland.harvard.edu>
 <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
 <YL34NZ12mKoiSLvu@hirez.programming.kicks-ass.net>
 <20210607115234.GA7205@willie-the-truck>
 <20210607152533.GQ4397@paulmck-ThinkPad-P17-Gen-1>
 <20210607160252.GA7580@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607160252.GA7580@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 05:02:53PM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Mon, Jun 07, 2021 at 08:25:33AM -0700, Paul E. McKenney wrote:
> > On Mon, Jun 07, 2021 at 12:52:35PM +0100, Will Deacon wrote:
> > > It's the conditional instructions that are more fun. For example, the CSEL
> > > instruction:
> > > 
> > > 	CSEL	X0, X1, X2, <cond>
> > > 
> > > basically says:
> > > 
> > > 	if (cond)
> > > 		X0 = X1;
> > > 	else
> > > 		X0 = X2;
> > > 
> > > these are just register-register operations, but the idea is that the CPU
> > > can predict that "branching event" inside the CSEL instruction and
> > > speculatively rename X0 while waiting for the condition to resolve.
> > > 
> > > So then you can add loads and stores to the mix along the lines of:
> > > 
> > > 	LDR	X0, [X1]		// X0 = *X1
> > > 	CMP	X0, X2
> > > 	CSEL	X3, X4, X5, EQ		// X3 = (X0 == X2) ? X4 : X5
> > > 	STR	X3, [X6]		// MUST BE ORDERED AFTER THE LOAD
> > > 	STR	X7, [X8]		// Can be reordered
> > > 
> > > (assuming X1, X6, X8 all point to different locations in memory)
> > > 
> > > So now we have a dependency from the load to the first store, but the
> > > interesting part is that the last store is _not_ ordered wrt either of the
> > > other two memory accesses, whereas it would be if we used a conditional
> > > branch instead of the CSEL. Make sense?
> > 
> > And if I remember correctly, this is why LKMM orders loads in the
> > "if" condition only with stores in the "then" and "else" clauses,
> > not with stores after the end of the "if" statement.  Or is there
> > some case that I am missing?
> 
> It's not clear to me that such a restriction prevents the compiler from
> using any of the arm64 conditional instructions in place of the conditional
> branch in such a way that you end up with an "independent" store in the
> assembly output constructed from two stores on the "then" and "else" paths
> which the compiler determined where the same.
> 
> > > Now, obviously the compiler is blissfully unaware that conditional
> > > data processing instructions can give rise to dependencies than
> > > conditional branches, so the question really is how much do we need to
> > > care in the kernel?
> > > 
> > > My preference is to use load-acquire instead of control dependencies so
> > > that we don't have to worry about this, or any future relaxations to the
> > > CPU architecture, at all.
> > 
> > From what I can see, ARMv8 has DMB(LD) and DMB(ST).  Does it have
> > something like a DMB(LD,ST) that would act something like powerpc lwsync?
> > 
> > Or are you proposing rewriting the "if" conditions to upgrade
> > READ_ONCE() to smp_load_acquire()?  Or something else?
> > 
> > Just trying to find out exactly what you are proposing.  ;-)
> 
> Some options are:
> 
>  (1) Do nothing until something actually goes wrong (and hope we spot/debug it)
> 
>  (2) Have volatile_if force a conditional branch, assuming that it solves
>      the problem and doesn't hurt codegen (I still haven't convinced myself
>      for either case)
> 
>  (3) Upgrade READ_ONCE() to RCpc acquire, relaxed atomic RMWs to RCsc
>      acquire on arm64
> 
>  (4) Introduce e.g. READ_ONCE_CTRL(), atomic_add_return_ctrl() etc
>      specifically for control dependencies and upgrade only those for
>      arm64
> 
>  (5) Work to get toolchain support for dependency ordering and use that
> 
> I'm suggesting (3) or (4) because, honestly, it feels like we're being
> squeezed from both sides with both the compiler and the hardware prepared
> to break control dependencies.

I will toss out this as well:

  (6) Create a volatile_if() that does not support an "else" clause,
      thus covering all current use cases and avoiding some of the
      same-store issues.  Which in the end might or might not help,
      but perhaps worth looking into.

							Thanx, Paul
