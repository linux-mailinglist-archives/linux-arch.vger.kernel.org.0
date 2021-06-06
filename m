Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0A39CEB6
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 13:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhFFLnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 07:43:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:59079 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFLnP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 07:43:15 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 156Baslq023488;
        Sun, 6 Jun 2021 06:36:54 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 156BapHt023485;
        Sun, 6 Jun 2021 06:36:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 6 Jun 2021 06:36:51 -0500
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
Message-ID: <20210606113651.GR18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net> <20210604153518.GD18427@gate.crashing.org> <YLpQj+S3vpTLX7cc@hirez.programming.kicks-ass.net> <20210604164047.GH18427@gate.crashing.org> <20210604185526.GW4397@paulmck-ThinkPad-P17-Gen-1> <20210604195301.GM18427@gate.crashing.org> <20210604204042.GZ4397@paulmck-ThinkPad-P17-Gen-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604204042.GZ4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 01:40:42PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 04, 2021 at 02:53:01PM -0500, Segher Boessenkool wrote:
> > On Fri, Jun 04, 2021 at 11:55:26AM -0700, Paul E. McKenney wrote:
> > > On Fri, Jun 04, 2021 at 11:40:47AM -0500, Segher Boessenkool wrote:
> > > > My point is that you ask compiler developers to paint themselves into a
> > > > corner if you ask them to change such fundamental C syntax.
> > > 
> > > Once we have some experience with a language extension, the official
> > > syntax for a standardized version of that extension can be bikeshedded.
> > > Committees being what they are, what we use in the meantime will
> > > definitely not be what is chosen, so there is not a whole lot of point
> > > in worrying about the exact syntax in the meantime.  ;-)
> > 
> > I am only saying that it is unlikely any compiler that is used in
> > production will want to experiment with "volatile if".
> 
> That unfortunately matches my experience over quite a few years.  But if
> something can be implemented using existing extensions, the conversations
> often get easier.  Especially given many more people are now familiar
> with concurrency.

This was about the syntax "volatile if", not about the concept, let's
call that "volatile_if".  And no, it was not me who brought this up :-)

> > > Which is exactly why these conversations are often difficult.  There is
> > > a tension between pushing the as-if rule as far as possible within the
> > > compiler on the one hand and allowing developers to write code that does
> > > what is needed on the other.  ;-)
> > 
> > There is a tension between what users expect from the compiler and what
> > actually is promised.  The compiler is not pushing the as-if rule any
> > further than it always has: it just becomes better at optimising over
> > time.  The as-if rule is and always has been absolute.
> 
> Heh!  The fact that the compiler has become better at optimizing
> over time is exactly what has been pushing the as-if rule further.
> 
> The underlying problem is that it is often impossible to write large
> applications (such as the Linux kernel) completely within the confines of
> the standard.  Thus, most large applications, and especially concurrent
> applications, are vulnerable to either the compiler becoming better
> at optimizing or compilers pushing the as-if rule, however you want to
> say it.

Oh definitely.  But there is nothing the compiler can do about most
cases of undefined behaviour: it cannot detect it, and there is no way
it *can* be handled sanely.  Take for example dereferencing a pointer
that does not point to an object.


Segher
