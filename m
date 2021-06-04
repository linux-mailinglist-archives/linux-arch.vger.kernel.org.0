Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFB39BD7F
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 18:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhFDQqu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 12:46:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:35910 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDQqu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 12:46:50 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 154GemFV026057;
        Fri, 4 Jun 2021 11:40:48 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 154GelkX026054;
        Fri, 4 Jun 2021 11:40:47 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 4 Jun 2021 11:40:47 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, will@kernel.org,
        paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604164047.GH18427@gate.crashing.org>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net> <YLoSJaOVbzKXU4/7@hirez.programming.kicks-ass.net> <20210604153518.GD18427@gate.crashing.org> <YLpQj+S3vpTLX7cc@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLpQj+S3vpTLX7cc@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 06:10:55PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 10:35:18AM -0500, Segher Boessenkool wrote:
> > On Fri, Jun 04, 2021 at 01:44:37PM +0200, Peter Zijlstra wrote:
> > > On naming (sorry Paul for forgetting that in the initial mail); while I
> > > think using the volatile qualifier for the language feature (can we haz
> > > plz, kthxbai) makes perfect sense, Paul felt that we might use a
> > > 'better' name for the kernel use, ctrl_dep_if() was proposed.
> > 
> > In standard C statements do not have qualifiers.  Unless you can
> > convince the ISO C committee to have them on "if", you will have a very
> > hard time convincing any serious compiler to do this.
> 
> While some people like talking to the Committee, I would much rather
> explore language extensions with the compiler communities. Such
> extensions can then make their way into the Committee once they show
> their usefulness.

My point is that you ask compiler developers to paint themselves into a
corner if you ask them to change such fundamental C syntax.

> If you have another proposal on how to express this; one you'd rather
> see implemented, I'm all ears.

I would love to see something that meshes well with the rest of C.  But
there is no 1-1 translation from C code to machine code (not in either
direction), so anything that more or less depends on that will always
be awkward.  If you can actually express the dependency in your source
code that will get us 95% to where we want to be.

> Data dependencies, control dependencies and address dependencies, C
> doesn't really like them, we rely on them. It would be awesome if we can
> fix this.

Yes.  The problem is that C is a high-level language.  All C semantics
are expressed on a an "as-if" level, never as "do this, then that" --
well, of course that *is* what it says, it's an imperative language just
like most, but that is just how you *think* about things on a conceptual
level, there is nothing that says the machine code has to do the same
thing in the same order as you wrote!


Segher
