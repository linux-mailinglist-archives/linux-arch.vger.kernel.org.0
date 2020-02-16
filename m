Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3D971604BB
	for <lists+linux-arch@lfdr.de>; Sun, 16 Feb 2020 17:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgBPQQw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Feb 2020 11:16:52 -0500
Received: from netrider.rowland.org ([192.131.102.5]:56025 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1728362AbgBPQQv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Feb 2020 11:16:51 -0500
Received: (qmail 31448 invoked by uid 500); 16 Feb 2020 11:16:50 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Feb 2020 11:16:50 -0500
Date:   Sun, 16 Feb 2020 11:16:50 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     Boqun Feng <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-arch@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
In-Reply-To: <20200216120625.GF2935@paulmck-ThinkPad-P72>
Message-ID: <Pine.LNX.4.44L0.2002161113320.30459-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 16 Feb 2020, Paul E. McKenney wrote:

> On Sun, Feb 16, 2020 at 01:43:45PM +0800, Boqun Feng wrote:
> > On Sat, Feb 15, 2020 at 07:25:50AM -0800, Paul E. McKenney wrote:
> > > On Fri, Feb 14, 2020 at 10:27:44AM -0500, Alan Stern wrote:
> > > > On Fri, 14 Feb 2020, Boqun Feng wrote:
> > > > 
> > > > > A recent discussion raises up the requirement for having test cases for
> > > > > atomic APIs:
> > > > > 
> > > > > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > > > > 
> > > > > , and since we already have a way to generate a test module from a
> > > > > litmus test with klitmus[1]. It makes sense that we add more litmus
> > > > > tests for atomic APIs into memory-model.
> > > > 
> > > > It might be worth discussing this point a little more fully.  The 
> > > > set of tests in tools/memory-model/litmus-tests/ is deliberately rather 
> > > > limited.  Paul has a vastly more expansive set of litmus tests in a 
> > > > GitHub repository, and I am doubtful about how many new tests we want 
> > > > to keep in the kernel source.
> > > 
> > > Indeed, the current view is that the litmus tests in the kernel source
> > > tree are intended to provide examples of C-litmus-test-language features
> > > and functions, as opposed to exercising the full cross-product of
> > > Linux-kernel synchronization primitives.
> > > 
> > > For a semi-reasonable subset of that cross-product, as Alan says, please
> > > see https://github.com/paulmckrcu/litmus.
> > > 
> > > For a list of the Linux-kernel synchronization primitives currently
> > > supported by LKMM, please see tools/memory-model/linux-kernel.def.
> > > 
> > 
> > So how about I put those atomic API tests into a separate directory, say
> > Documentation/atomic/ ?
> > 
> > The problem I want to solve here is that people (usually who implements
> > the atomic APIs for new archs) may want some examples, which can help
> > them understand the API requirements and test the implementation. And
> > litmus tests are the perfect tool here (given that them can be
> > translated to test modules with klitmus). And I personally really think
> > this is something the LKMM group should maintain, that's why I put them
> > in the tools/memory-model/litmus-tests/. But I'm OK if we end up
> > deciding those should be put outside that directory.
> 
> Good point!
> 
> However, we should dicuss this with the proposed beneficiaries, namely
> the architecture maintainers.  Do they want it?  If so, where would
> they like it to be?  How should it be organized?
> 
> In the meantime, I am more than happy to accept litmus tests into the
> github archive.
> 
> So how would you like to proceed?

I think it makes sense to put Boqun's tests under Documentation/ rather
than tools/.  After all, their point is to document the memory model's
requirements for operations on atomic_t's.  They aren't meant to be
examples or demos showing how to use herd or write litmus tests.

Alan

