Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ABD3DE31C
	for <lists+linux-arch@lfdr.de>; Tue,  3 Aug 2021 01:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhHBXcH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 19:32:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:38024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232425AbhHBXcH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Aug 2021 19:32:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10DC560EC0;
        Mon,  2 Aug 2021 23:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627947117;
        bh=F7eyFt0babKm737hBTlUOArue8hBauwGDHaUACSscNA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UQ1QVfBx8nIB0NYHUCTYdvntPQuiuIOXKEWaJ6DcxZu7qyddYtx/fjNr3tHVyIaCr
         aIVjhzL8uT8Z6s/jnQ4Pq11NH2fV8osLT13k5+WJ172XNvEMbLDKtbbAzy3w/qMxYe
         CqoMvRanoKF09BeoYFva4wYZfVMCYenMt5zddxyQPUSOkbAqK6Ouzl+HBEpEIWM1ty
         sIPe5TFZ678q2UXHebn/j+KiHHRtzn3qEegGKOVOmAzTAhr8e1GHWjD7kUlmbRLWQq
         S/jTtYUTx8VG2driF+OOyuSS3DtBLlYGtSYXTDeMZ9rmqkUC3jFZuzR1H4NTYjbc9C
         VG5SxtRG1HK+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D28E95C0892; Mon,  2 Aug 2021 16:31:56 -0700 (PDT)
Date:   Mon, 2 Aug 2021 16:31:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jade Alglave <j.alglave@ucl.ac.uk>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210802233156.GM4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606182213.GA1741684@rowland.harvard.edu>
 <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
 <YL34NZ12mKoiSLvu@hirez.programming.kicks-ass.net>
 <20210607115234.GA7205@willie-the-truck>
 <20210730172020.GA32396@knuckles.cs.ucl.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730172020.GA32396@knuckles.cs.ucl.ac.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 06:20:22PM +0100, Jade Alglave wrote:

[ . . . ]

> Sincere apologies in taking so long to reply. I attach a technical
> report which describes the status of dependencies in the Arm memory
> model. 
> 
> I have also released the corresponding cat files and a collection of
> interesting litmus tests over here:
> https://github.com/herd/herdtools7/commit/f80bd7c2e49d7d3adad22afc62ff4768d65bf830
> 
> I hope this material can help inform this conversation and I would love
> to hear your thoughts.

It is very good to see this!  A few random questions and comments below
based on a couple of passes through this document.

							Thanx, Paul

------------------------------------------------------------------------

o	Figure 2: The iico_data arc are essentially invisible after
	printing, as in the text on the following page is darker
	than these arcs.  I had similar difficulties with many
	of the other diagrams.

o	Figure 2: What does the "q" signify in the upper line of the
	uppermost event-c box ("R0:X1q=x")?  I get that we are reading
	register X1 and getting back the address of variable "x".  I am
	assuming that the "R0" means that process 0 is doing a read,
	but I cannot be sure.

	I am assuming that the "proc: P0 poi:0" means that this is
	the first instruction of process P0.  If this is incorrect,
	please let me know.

o	Figure 6 initializes X0, X1, X2, and X3, while Figure 4
	initializes only X0 and X3.  Is this difference meaningful?
	(My guess is that you have default-zero initialization so
	that it does not matter, but I figured that I should ask.)

o	Figure 6: The iico_ctrl arcs are easier to see on printed copy
	than the iico_data arcs, but it would be nice if they were a
	bit darker.  The rf-reg arcs are plainly visible.

o	Figure 6: Why is there no po arc to the CSEL instruction?

o	Section 1.3, "Swap instructions" paragraph.  Please supply
	a litmus-test figure to go along with Figure 12.

o	Figures 10 and 11: Having these on the same page was extremely
	helpful, thank you!

o	Figure 11: What does the "*" signify in the first line event "a:"
	("a: Rx*q=0")?	Why is there no "*" in the corresponding event
	in Figure 9?

o	Figure 11: The ca arcs are nicely visible, but I am coming up
	empty on hypotheses for their meaning.  Or is ca the new co?

o	Figure 11: Why two po arcs into the CAS instruction?  Due
	to independent register reads taht might proceed concurrently?
	If so, why no po arc to event g?

o	Figure 11: The connections between events a, f, and h lead me to
	believe that the hardware is permitted to rewrite register X3
	with the value previously read from X3 as opposed to the value
	read from [X1].  Or maybe omit the write entirely.

	I don't see anything wrong with taking this approach, but I
	figured I should check.

o	Section 2 I leave in Alan's capable hands.

o	Section 3.1, "Dependency through registers": A "PE" is a
	processing element or some such?

o	Section 3.1, "Dependency through registers", first bullet:
	The exclusion of Store Exclusive is to avoid ordering via
	the 0/1 status store, correct?

o	Section 3.1, "Address Dependency", second bullet, second
	sub-bullet: OK, I will bite.  The dependency from the Branching
	Effect is due to a load from the program counter or some such?
	Or are there some special-purpose ARMv8 branch instructions that
	I should look up.

o	Figure 27, "MOV W5, W0": It took me a bit to figure out that
	this instruction exists strictly for the benefit of the
	"exists" clause.  Or am I missing something subtle?

o	Section 4.1, "Interestingly, this notion of ``pick dependency...":
	I suggest using something like "require" instead of "proscribe",
	if that is what is meant.  The hamming distance between the
	antonyms "proscribe" and "prescribe" is quite small, which can
	result in errors both when writing and when reading.  :-(

o	Figure 30: The discarding of register X3 is intentional, correct?
	If so, it is indeed hard to imagine wanting ordering from this
	code sequence.  Though I might once again be suffering from a
	failure of imagination...

o	Figure 32: The reason for this litmus test being allowed is that
	the ordering through CSEL is sort of like a control dependency,
	and control dependencies to loads do not force ordering, correct?
	Or did I miss a turn in there somewhere?

o	Section 4.2, "Pick Basic dependency": Should the second and
	third bullets be indented under the first bullet?

It will take at least another pass to get my head around pick
dependencies, so I will stop here for the moment.

Again, good stuff, and great to see the additional definition!

							Thanx, Paul
