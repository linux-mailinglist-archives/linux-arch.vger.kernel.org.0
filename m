Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1162539BDC9
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 18:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFDQ7G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 12:59:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:36210 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229864AbhFDQ7G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 12:59:06 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 154GqohH027719;
        Fri, 4 Jun 2021 11:52:50 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 154GqmG1027681;
        Fri, 4 Jun 2021 11:52:48 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 4 Jun 2021 11:52:42 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210604165242.GI18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com> <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 06:37:22PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 09:30:01AM -0700, Linus Torvalds wrote:
> > Why is "volatile_if()" not just
> > 
> >        #define barier_true() ({ barrier(); 1; })
> > 
> >        #define volatile_if(x) if ((x) && barrier_true())
> > 
> > because that should essentially cause the same thing - the compiler
> > should be *forced* to create one conditional branch (because "barrier"
> > is an asm that can't be done on the false side, so it can't do it with
> > arithmetic or other games), and after that we're done.
> > 
> > No need for per-architecture "asm goto" games. No new memory barriers.
> > No actual new code generation (except for the empty asm volatile that
> > is a barrier).
> 
> Because we weren't sure compilers weren't still allowed to optimize the
> branch away.

barrier_true is a volatile asm, so it should be executed on the real
machine exactly as often as on the abstract machine (and in order with
other side effects).  And the && short-circuits, so you will always have
the same effect as a branch.  But there of course is nothing that forces
there to be a branch (as a silly example, the compiler could convert
some control flow to go via computed return addresses).


Segher
