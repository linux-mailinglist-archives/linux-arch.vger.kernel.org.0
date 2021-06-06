Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F46539CF5C
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 15:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhFFNrY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 09:47:24 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33349 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230091AbhFFNrY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 09:47:24 -0400
Received: (qmail 1736478 invoked by uid 1000); 6 Jun 2021 09:45:32 -0400
Date:   Sun, 6 Jun 2021 09:45:32 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
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
Message-ID: <20210606134532.GA1736178@rowland.harvard.edu>
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606115336.GS18427@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 06:53:36AM -0500, Segher Boessenkool wrote:
> On Sat, Jun 05, 2021 at 09:29:03PM -0400, Alan Stern wrote:
> > Interesting.  And changing one of the branches from barrier() to __asm__ 
> > __volatile__("nop": : :"memory") also causes a branch to be emitted.  So 
> > even though the compiler doesn't "look inside" assembly code, it does 
> > compare two pieces at least textually and apparently assumes if they are 
> > identical then they do the same thing.
> 
> And that is a simple fact, since the same assembler code (at the same
> spot in the program) will do the same thing no matter how that ended up
> there.

Sure.  But the same assembler code at two different spots in the program 
might not do the same thing.  (Think of code that stores the current EIP 
register's value into a variable.)

So while de-duplicating such code may be allowed, it will give rise to 
observable results at execution time.

Alan

> And the compiler always is allowed to duplicate, join, delete, you name
> it, inline assembler code.  The only thing that it cares about is
> semantics of the code, just like for any other code.
> 
> 
> Segher
