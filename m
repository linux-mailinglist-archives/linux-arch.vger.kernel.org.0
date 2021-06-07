Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C852439E16A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 18:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFGQEu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 12:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230294AbhFGQEu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 12:04:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3CB76108E;
        Mon,  7 Jun 2021 16:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623081779;
        bh=QS7X75IN+igUoh1ptcIfo9XF7KyeMHZPP9cfmN4i6vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ByQC6QohKF5NbpdJsLjBDos9tGrBfUNfROouf5Wv6sJwMLkrKDcIVUkFbcwBDzxe3
         GaJnCcYKqaW3reykXCzDW5fZX3tYWWg8RWmuWG0ZOR3YPEr6Tgp3Ttng6lusnts3WO
         AJB7x2NEAIqqwGmQjYf1oPtFMoCn26YrE2+uu1rDDGvZZtgwu6qtrNDUmYx6nFwCdI
         edvob/e1tS0HkyCOZ4LVCz5HHMycMEdOHu2VP3mtoF/Qb2l9li42+Y5GEPv05LHO5l
         oKGNF3C1cKbPEz6+DnWxroKBChCTvQcwArfAa2JiFDR0/eyN9OyDNjZZO5t2mtxRez
         ShSt1jop8LwPQ==
Date:   Mon, 7 Jun 2021 17:02:53 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20210607160252.GA7580@willie-the-truck>
References: <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606182213.GA1741684@rowland.harvard.edu>
 <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
 <YL34NZ12mKoiSLvu@hirez.programming.kicks-ass.net>
 <20210607115234.GA7205@willie-the-truck>
 <20210607152533.GQ4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607152533.GQ4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

On Mon, Jun 07, 2021 at 08:25:33AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 07, 2021 at 12:52:35PM +0100, Will Deacon wrote:
> > It's the conditional instructions that are more fun. For example, the CSEL
> > instruction:
> > 
> > 	CSEL	X0, X1, X2, <cond>
> > 
> > basically says:
> > 
> > 	if (cond)
> > 		X0 = X1;
> > 	else
> > 		X0 = X2;
> > 
> > these are just register-register operations, but the idea is that the CPU
> > can predict that "branching event" inside the CSEL instruction and
> > speculatively rename X0 while waiting for the condition to resolve.
> > 
> > So then you can add loads and stores to the mix along the lines of:
> > 
> > 	LDR	X0, [X1]		// X0 = *X1
> > 	CMP	X0, X2
> > 	CSEL	X3, X4, X5, EQ		// X3 = (X0 == X2) ? X4 : X5
> > 	STR	X3, [X6]		// MUST BE ORDERED AFTER THE LOAD
> > 	STR	X7, [X8]		// Can be reordered
> > 
> > (assuming X1, X6, X8 all point to different locations in memory)
> > 
> > So now we have a dependency from the load to the first store, but the
> > interesting part is that the last store is _not_ ordered wrt either of the
> > other two memory accesses, whereas it would be if we used a conditional
> > branch instead of the CSEL. Make sense?
> 
> And if I remember correctly, this is why LKMM orders loads in the
> "if" condition only with stores in the "then" and "else" clauses,
> not with stores after the end of the "if" statement.  Or is there
> some case that I am missing?

It's not clear to me that such a restriction prevents the compiler from
using any of the arm64 conditional instructions in place of the conditional
branch in such a way that you end up with an "independent" store in the
assembly output constructed from two stores on the "then" and "else" paths
which the compiler determined where the same.

> > Now, obviously the compiler is blissfully unaware that conditional
> > data processing instructions can give rise to dependencies than
> > conditional branches, so the question really is how much do we need to
> > care in the kernel?
> > 
> > My preference is to use load-acquire instead of control dependencies so
> > that we don't have to worry about this, or any future relaxations to the
> > CPU architecture, at all.
> 
> From what I can see, ARMv8 has DMB(LD) and DMB(ST).  Does it have
> something like a DMB(LD,ST) that would act something like powerpc lwsync?
> 
> Or are you proposing rewriting the "if" conditions to upgrade
> READ_ONCE() to smp_load_acquire()?  Or something else?
> 
> Just trying to find out exactly what you are proposing.  ;-)

Some options are:

 (1) Do nothing until something actually goes wrong (and hope we spot/debug it)

 (2) Have volatile_if force a conditional branch, assuming that it solves
     the problem and doesn't hurt codegen (I still haven't convinced myself
     for either case)

 (3) Upgrade READ_ONCE() to RCpc acquire, relaxed atomic RMWs to RCsc
     acquire on arm64

 (4) Introduce e.g. READ_ONCE_CTRL(), atomic_add_return_ctrl() etc
     specifically for control dependencies and upgrade only those for
     arm64

 (5) Work to get toolchain support for dependency ordering and use that

I'm suggesting (3) or (4) because, honestly, it feels like we're being
squeezed from both sides with both the compiler and the hardware prepared
to break control dependencies.

Will
