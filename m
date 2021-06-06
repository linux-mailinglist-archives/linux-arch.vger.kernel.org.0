Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4093C39D08F
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 21:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFFTDd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 15:03:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFFTDc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 15:03:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FB2961242;
        Sun,  6 Jun 2021 19:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623006101;
        bh=UD3d62ix8ea/AUYQ+cmn/M6Fqg8QN4yqiHh5zNX5+RQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WR8UrFejD170GPHmeIKJTHA2xXvauQPEb29SbNZrIACn3nPvAm7NtWjk6X0LuTrsF
         1bDfC11OTnq/qdf8P6M4AqiUqrIHEzDz5gqfu2WcfF4vPGaS8AUuw/a65DV23MoCo0
         w3tv1VtgbLxzLREG9prrrJCca85jGqxYrQFbwBFpknJV5Y2b33DsmkJjMWVZ1wL3na
         F4VADgGqkjxyh4RZajgOkgEpzsaQuMO4UGS9I5rAfOdBAbqYdSZDqiHD98FBP3pl8Y
         GEXCZE01qwhMd1kIk/JSY1lsurCy/mKsIQCc81YgKzbcEv7B7qJh0krxsX2AQqUvzs
         +6XkpRpdMVYXQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 536BF5C014A; Sun,  6 Jun 2021 12:01:41 -0700 (PDT)
Date:   Sun, 6 Jun 2021 12:01:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        will@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210606190141.GK4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net>
 <20210604153518.GD18427@gate.crashing.org>
 <YLpQj+S3vpTLX7cc@hirez.programming.kicks-ass.net>
 <20210604164047.GH18427@gate.crashing.org>
 <20210604185526.GW4397@paulmck-ThinkPad-P17-Gen-1>
 <20210604195301.GM18427@gate.crashing.org>
 <20210604204042.GZ4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606113651.GR18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606113651.GR18427@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 06:36:51AM -0500, Segher Boessenkool wrote:
> On Fri, Jun 04, 2021 at 01:40:42PM -0700, Paul E. McKenney wrote:
> > On Fri, Jun 04, 2021 at 02:53:01PM -0500, Segher Boessenkool wrote:
> > > On Fri, Jun 04, 2021 at 11:55:26AM -0700, Paul E. McKenney wrote:
> > > > On Fri, Jun 04, 2021 at 11:40:47AM -0500, Segher Boessenkool wrote:
> > > > > My point is that you ask compiler developers to paint themselves into a
> > > > > corner if you ask them to change such fundamental C syntax.
> > > > 
> > > > Once we have some experience with a language extension, the official
> > > > syntax for a standardized version of that extension can be bikeshedded.
> > > > Committees being what they are, what we use in the meantime will
> > > > definitely not be what is chosen, so there is not a whole lot of point
> > > > in worrying about the exact syntax in the meantime.  ;-)
> > > 
> > > I am only saying that it is unlikely any compiler that is used in
> > > production will want to experiment with "volatile if".
> > 
> > That unfortunately matches my experience over quite a few years.  But if
> > something can be implemented using existing extensions, the conversations
> > often get easier.  Especially given many more people are now familiar
> > with concurrency.
> 
> This was about the syntax "volatile if", not about the concept, let's
> call that "volatile_if".  And no, it was not me who brought this up :-)

I agree that it is likely that the syntax "volatile if" would be at best
a very reluctantly acquired taste among most of the committee.  But some
might point to the evolving semantics of "auto" as a counter-example,
to say nothing of the celebrated spaceship operator.  Me, I am not
all that worried about the exact syntax.

> > > > Which is exactly why these conversations are often difficult.  There is
> > > > a tension between pushing the as-if rule as far as possible within the
> > > > compiler on the one hand and allowing developers to write code that does
> > > > what is needed on the other.  ;-)
> > > 
> > > There is a tension between what users expect from the compiler and what
> > > actually is promised.  The compiler is not pushing the as-if rule any
> > > further than it always has: it just becomes better at optimising over
> > > time.  The as-if rule is and always has been absolute.
> > 
> > Heh!  The fact that the compiler has become better at optimizing
> > over time is exactly what has been pushing the as-if rule further.
> > 
> > The underlying problem is that it is often impossible to write large
> > applications (such as the Linux kernel) completely within the confines of
> > the standard.  Thus, most large applications, and especially concurrent
> > applications, are vulnerable to either the compiler becoming better
> > at optimizing or compilers pushing the as-if rule, however you want to
> > say it.
> 
> Oh definitely.  But there is nothing the compiler can do about most
> cases of undefined behaviour: it cannot detect it, and there is no way
> it *can* be handled sanely.  Take for example dereferencing a pointer
> that does not point to an object.

Almost.

The compiler's use of provenance allows detection in some cases.
For a stupid example, please see https://godbolt.org/z/z9cWvqdhE.

Less stupidly, this sort of thing can be quite annoying to people trying
to use ABA-tolerant concurrent algorithms.  See for example P1726R4
[1] (update in progress) and for an even more controversial proposal,
P2188R1 [2].  The Lifo Singly Linked Push algorithm described beginning
on page 14 of [1] is a simple example of an ABA-tolerant algorithm that
was already in use when I first programmed a computer.  ;-)

							Thanx, Paul

[1]	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p1726r4.pdf
[2]	http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p2188r1.html
