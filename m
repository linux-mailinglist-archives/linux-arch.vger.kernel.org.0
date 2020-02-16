Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A93C11603EC
	for <lists+linux-arch@lfdr.de>; Sun, 16 Feb 2020 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBPMGc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Feb 2020 07:06:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbgBPMGb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Feb 2020 07:06:31 -0500
Received: from paulmck-ThinkPad-P72.home (unknown [12.246.51.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76BB320857;
        Sun, 16 Feb 2020 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581854790;
        bh=5vJUzMFXgL+4htCa+i0lvCczJshCVNG4PgJkkf3GTn0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=G4v58wtDrELJRfS6Y38HFJ/9cGmG8sXllwsX+m3TSNbAJoIyXj/LPU5HbBBLnqYWl
         aokWpFNpGiKSCEyCF5l3RhxdQFZWKrTGF6fUbhm4EvOvkxBxb4DlYKTaAegV9gTP9k
         ut4Yll6I+C/pvicdDRM3vUtgmWZ2l4EFUhdGUWqk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E3ECB352168B; Sun, 16 Feb 2020 04:06:25 -0800 (PST)
Date:   Sun, 16 Feb 2020 04:06:25 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Message-ID: <20200216120625.GF2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141024141.1579-100000@iolanthe.rowland.org>
 <20200215152550.GA13636@paulmck-ThinkPad-P72>
 <20200216054345.GA69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216054345.GA69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 16, 2020 at 01:43:45PM +0800, Boqun Feng wrote:
> On Sat, Feb 15, 2020 at 07:25:50AM -0800, Paul E. McKenney wrote:
> > On Fri, Feb 14, 2020 at 10:27:44AM -0500, Alan Stern wrote:
> > > On Fri, 14 Feb 2020, Boqun Feng wrote:
> > > 
> > > > A recent discussion raises up the requirement for having test cases for
> > > > atomic APIs:
> > > > 
> > > > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > > > 
> > > > , and since we already have a way to generate a test module from a
> > > > litmus test with klitmus[1]. It makes sense that we add more litmus
> > > > tests for atomic APIs into memory-model.
> > > 
> > > It might be worth discussing this point a little more fully.  The 
> > > set of tests in tools/memory-model/litmus-tests/ is deliberately rather 
> > > limited.  Paul has a vastly more expansive set of litmus tests in a 
> > > GitHub repository, and I am doubtful about how many new tests we want 
> > > to keep in the kernel source.
> > 
> > Indeed, the current view is that the litmus tests in the kernel source
> > tree are intended to provide examples of C-litmus-test-language features
> > and functions, as opposed to exercising the full cross-product of
> > Linux-kernel synchronization primitives.
> > 
> > For a semi-reasonable subset of that cross-product, as Alan says, please
> > see https://github.com/paulmckrcu/litmus.
> > 
> > For a list of the Linux-kernel synchronization primitives currently
> > supported by LKMM, please see tools/memory-model/linux-kernel.def.
> > 
> 
> So how about I put those atomic API tests into a separate directory, say
> Documentation/atomic/ ?
> 
> The problem I want to solve here is that people (usually who implements
> the atomic APIs for new archs) may want some examples, which can help
> them understand the API requirements and test the implementation. And
> litmus tests are the perfect tool here (given that them can be
> translated to test modules with klitmus). And I personally really think
> this is something the LKMM group should maintain, that's why I put them
> in the tools/memory-model/litmus-tests/. But I'm OK if we end up
> deciding those should be put outside that directory.

Good point!

However, we should dicuss this with the proposed beneficiaries, namely
the architecture maintainers.  Do they want it?  If so, where would
they like it to be?  How should it be organized?

In the meantime, I am more than happy to accept litmus tests into the
github archive.

So how would you like to proceed?

							Thanx, Paul

> Regards,
> Boqun
> 
> > > Perhaps it makes sense to have tests corresponding to all the examples
> > > in Documentation/, perhaps not.  How do people feel about this?
> > 
> > Agreed, we don't want to say that the set of litmus tests in the kernel
> > source tree is limited for all time to the set currently present, but
> > rather that the justification for adding more would involve useful and
> > educational examples of litmus-test features and techniques rather than
> > being a full-up LKMM test suite.
> > 
> > I would guess that there are litmus-test tricks that could usefully
> > be added to tools/memory-model/litmus-tests.  Any nomination?  Perhaps
> > handling CAS loops while maintaining finite state space?  Something else?
> > 
> > 							Thanx, Paul
