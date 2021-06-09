Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D173A1B9F
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 19:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhFIRVm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 13:21:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:44663 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhFIRVl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 13:21:41 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 159HELK2003025;
        Wed, 9 Jun 2021 12:14:21 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 159HEJl9003023;
        Wed, 9 Jun 2021 12:14:19 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 9 Jun 2021 12:14:19 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210609171419.GI18427@gate.crashing.org>
References: <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru> <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com> <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1> <YL5Risa6sFgnvvnG@elver.google.com> <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com> <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net> <20210608152851.GX18427@gate.crashing.org> <CANpmjNPJaDT4vBqkTw8XaRfKgDuwh71qmrvNfq-vx-Zyp4ugNg@mail.gmail.com> <20210609153133.GF18427@gate.crashing.org> <CANpmjNPq3NBhi_pFpNd6TwXOVjw0LE2NuQ63dWZrYSfEet3ChQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPq3NBhi_pFpNd6TwXOVjw0LE2NuQ63dWZrYSfEet3ChQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 09, 2021 at 06:13:00PM +0200, Marco Elver wrote:
> On Wed, 9 Jun 2021 at 17:33, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> [...]
> > > An alternative design would be to use a statement attribute to only
> > > enforce (C) ("__attribute__((mustcontrol))" ?).
> >
> > Statement attributes only exist for empty statements.  It is unclear how
> > (and if!) we could support it for general statements.
> 
> Statement attributes can apply to anything -- Clang has had them apply
> to non-empty statements for a while.

First off, it is not GCC's problem if LLVM decides to use a GCC
extension in some non-compatible way.

It might be possible to extend statement attributes to arbitrary
statement expressions, or some subset of statement expressions, but that
then has to be written down as well; it isn't obvious at all what this
woould do.

> In fact, since C++20 [3], GCC will have to support statement
> attributes on non-empty statements, so presumably the parsing logic
> should already be there.
> [3] https://en.cppreference.com/w/cpp/language/attributes/likely

C++ attributes have different syntax *and semantics*.  With GCC
attributes it isn't clear what statement something belongs to (a
statement can contain a statement after all).

C++ requires all unknown attributes to be ignored without error, so can
this be useful at all here?

> > Some new builtin seems to fit the requirements better?  I haven't looked
> > too closely though.
> 
> I had a longer discussion with someone offline about it, and the
> problem with a builtin is similar to the "memory_order_consume
> implementation problem" -- you might have an expression that uses the
> builtin in some function without any control, and merely returns the
> result of the expression as a result. If that function is in another
> compilation unit, it then becomes difficult to propagate this
> information without somehow making it part of the type system.
> Therefore, by using a statement attribute on conditional control
> statements, we do not even have this problem. It seems cleaner
> syntactically than having a __builtin_() that is either approximate,
> or gives an error if used in the wrong context.

You would use the builtin to mark exactly where you are making the
control dependency.

(And what is a "conditional control statement"?  Yes of course I can
imagine things, but that is not good enough at all).

> Hence the suggestion for a very simple attribute, which also
> side-steps this problem.

And introduces many more problems :-(


Segher
