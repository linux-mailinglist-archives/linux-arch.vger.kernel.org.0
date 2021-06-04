Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F2B39C0DB
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFDT7F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 15:59:05 -0400
Received: from gate.crashing.org ([63.228.1.57]:55270 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhFDT7E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 15:59:04 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 154Jr3qC010194;
        Fri, 4 Jun 2021 14:53:03 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 154Jr1JO010190;
        Fri, 4 Jun 2021 14:53:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 4 Jun 2021 14:53:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        will@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604195301.GM18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net> <20210604153518.GD18427@gate.crashing.org> <YLpQj+S3vpTLX7cc@hirez.programming.kicks-ass.net> <20210604164047.GH18427@gate.crashing.org> <20210604185526.GW4397@paulmck-ThinkPad-P17-Gen-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604185526.GW4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 11:55:26AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 04, 2021 at 11:40:47AM -0500, Segher Boessenkool wrote:
> > My point is that you ask compiler developers to paint themselves into a
> > corner if you ask them to change such fundamental C syntax.
> 
> Once we have some experience with a language extension, the official
> syntax for a standardized version of that extension can be bikeshedded.
> Committees being what they are, what we use in the meantime will
> definitely not be what is chosen, so there is not a whole lot of point
> in worrying about the exact syntax in the meantime.  ;-)

I am only saying that it is unlikely any compiler that is used in
production will want to experiment with "volatile if".

> > I would love to see something that meshes well with the rest of C.  But
> > there is no 1-1 translation from C code to machine code (not in either
> > direction), so anything that more or less depends on that will always
> > be awkward.  If you can actually express the dependency in your source
> > code that will get us 95% to where we want to be.

^^^

> > > Data dependencies, control dependencies and address dependencies, C
> > > doesn't really like them, we rely on them. It would be awesome if we can
> > > fix this.
> > 
> > Yes.  The problem is that C is a high-level language.  All C semantics
> > are expressed on a an "as-if" level, never as "do this, then that" --
> > well, of course that *is* what it says, it's an imperative language just
> > like most, but that is just how you *think* about things on a conceptual
> > level, there is nothing that says the machine code has to do the same
> > thing in the same order as you wrote!
> 
> Which is exactly why these conversations are often difficult.  There is
> a tension between pushing the as-if rule as far as possible within the
> compiler on the one hand and allowing developers to write code that does
> what is needed on the other.  ;-)

There is a tension between what users expect from the compiler and what
actually is promised.  The compiler is not pushing the as-if rule any
further than it always has: it just becomes better at optimising over
time.  The as-if rule is and always has been absolute.

What is needed to get any progress is for user expectations to be
feasible and not contradict existing requirements.  See "^^^" above.


Segher
