Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040BC39E043
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFGP1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 11:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFGP1Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 11:27:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BC0860C3D;
        Mon,  7 Jun 2021 15:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623079534;
        bh=xZEnrI7aJgHlHkDAZk2TG+DH/0IpNBw25vfcP+ltli4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AjY3K2wqq2We6lmQTn0Zc8+dXN3DFbK57ZP3WwJok7WAX/ZtBrcugjbq3pVfKmTsn
         liSsk7G+uMJrSkpCWH38VnBUOhwUkpojjwOR29Y1veQpGzBpSNPNSA4xGtefkmCWiy
         +yNJlLMjbvg2lZytLiFqr0SEGh/nQKOBdrFQ1CRAArKtHLojAZBU90i+pUUu+r4jrc
         aEpslhaVCiirV9uPofzDpezXnrxWcBs37mwNEEDFnyif4ncxiDIKkXq9Y4DO5AK7Ir
         LnVggRSp+MWLGKBEUYp3+Z4kOxVb/t4kMWTPiml/sCOy1IQF3OSpJZpycrgUBe/NWW
         ARCDZd2RuQpOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EC68A5C0395; Mon,  7 Jun 2021 08:25:33 -0700 (PDT)
Date:   Mon, 7 Jun 2021 08:25:33 -0700
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
Message-ID: <20210607152533.GQ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606182213.GA1741684@rowland.harvard.edu>
 <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
 <YL34NZ12mKoiSLvu@hirez.programming.kicks-ass.net>
 <20210607115234.GA7205@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607115234.GA7205@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 12:52:35PM +0100, Will Deacon wrote:
> On Mon, Jun 07, 2021 at 12:43:01PM +0200, Peter Zijlstra wrote:
> > On Sun, Jun 06, 2021 at 11:43:42AM -0700, Linus Torvalds wrote:
> > > So while the example code is insane and pointless (and you shouldn't
> > > read *too* much into it), conceptually the notion of that pattern of
> > > 
> > >     if (READ_ONCE(a)) {
> > >         WRITE_ONCE(b,1);
> > >         .. do something ..
> > >     } else {
> > >         WRITE_ONCE(b,1);
> > >         .. do something else ..
> > >     }
> > 
> > This is actually more tricky than it would appear (isn't it always).
> > 
> > The thing is, that normally we must avoid speculative stores, because
> > they'll result in out-of-thin-air values.
> > 
> > *Except* in this case, where both branches emit the same store, then
> > it's a given that the store will happen and it will not be OOTA.
> > Someone's actually done the proof for that apparently (Will, you have a
> > reference to Jade's paper?)
> 
> I don't think there's a paper on this, but Jade and I are hoping to talk
> about aspects of it at LPC (assuming the toolchain MC gets accepted).
> 
> > There's apparently also a competition going on who can build the
> > weakestest ARM64 implementation ever.
> > 
> > Combine the two, and you'll get a CPU that *will* emit the store early
> > :/
> 
> So there are a lot of important details missing here and, as above, I think
> this is something worth discussing at LPC with Jade. The rough summary is
> that the arm64 memory model recently (so recently that it's not yet landed
> in the public docs) introduced something called "pick dependencies", which
> are a bit like control dependencies only they don't create order to all
> subsequent stores. These are useful for some conditional data-processing
> instructions such as CSEL and CAS, but it's important to note here that
> *conditional branch instructions behave exactly as you would expect*.
> 
> <disclaimer; I don't work for Arm so any mistakes here are mine>
> 
> To reiterate, in the code sequence at the top of this mail, if the compiler
> emits something along the lines of:
> 
> 	LDR
> 	<conditional branch instruction>
> 	STR
> 
> then the load *will* be ordered before the store, even if the same store
> instruction is executed regardless of the branch direction. Yes, one can
> fantasize about a CPU that executes both taken and non-taken paths and
> figures out that the STR can be hoisted before the load, but that is not
> allowed by the architecture today.
> 
> It's the conditional instructions that are more fun. For example, the CSEL
> instruction:
> 
> 	CSEL	X0, X1, X2, <cond>
> 
> basically says:
> 
> 	if (cond)
> 		X0 = X1;
> 	else
> 		X0 = X2;
> 
> these are just register-register operations, but the idea is that the CPU
> can predict that "branching event" inside the CSEL instruction and
> speculatively rename X0 while waiting for the condition to resolve.
> 
> So then you can add loads and stores to the mix along the lines of:
> 
> 	LDR	X0, [X1]		// X0 = *X1
> 	CMP	X0, X2
> 	CSEL	X3, X4, X5, EQ		// X3 = (X0 == X2) ? X4 : X5
> 	STR	X3, [X6]		// MUST BE ORDERED AFTER THE LOAD
> 	STR	X7, [X8]		// Can be reordered
> 
> (assuming X1, X6, X8 all point to different locations in memory)
> 
> So now we have a dependency from the load to the first store, but the
> interesting part is that the last store is _not_ ordered wrt either of the
> other two memory accesses, whereas it would be if we used a conditional
> branch instead of the CSEL. Make sense?

And if I remember correctly, this is why LKMM orders loads in the
"if" condition only with stores in the "then" and "else" clauses,
not with stores after the end of the "if" statement.  Or is there
some case that I am missing?

> Now, obviously the compiler is blissfully unaware that conditional
> data processing instructions can give rise to dependencies than
> conditional branches, so the question really is how much do we need to
> care in the kernel?
> 
> My preference is to use load-acquire instead of control dependencies so
> that we don't have to worry about this, or any future relaxations to the
> CPU architecture, at all.

From what I can see, ARMv8 has DMB(LD) and DMB(ST).  Does it have
something like a DMB(LD,ST) that would act something like powerpc lwsync?

Or are you proposing rewriting the "if" conditions to upgrade
READ_ONCE() to smp_load_acquire()?  Or something else?

Just trying to find out exactly what you are proposing.  ;-)

						Thanx, Paul

> Jade -- please can you correct me if I got any of this wrong?
> 
> Will
