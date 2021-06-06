Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2104F39CF4F
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhFFNXv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 09:23:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:54877 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhFFNXv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 09:23:51 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 156DHgDq028954;
        Sun, 6 Jun 2021 08:17:42 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 156DHeno028953;
        Sun, 6 Jun 2021 08:17:40 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 6 Jun 2021 08:17:40 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210606131740.GU18427@gate.crashing.org>
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com> <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com> <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com> <20210606044333.GI4397@paulmck-ThinkPad-P17-Gen-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606044333.GI4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 05, 2021 at 09:43:33PM -0700, Paul E. McKenney wrote:
> So gcc might some day note a do-nothing asm and duplicate it for
> the sole purpose of collapsing the "then" and "else" clauses.  I
> guess I need to keep my paranoia for the time being, then.  :-/

Or a "do-something" asm, even.  What it does is make sure it is executed
on the real machine exactly like on the abstract machine.  That is how C
is defined, what a compiler *does*.

The programmer does not have any direct control over the generated code.

> Of course, there is no guarantee that gcc won't learn about
> assembler constants.  :-/

I am not sure what you call an "assembler constant" here.  But you can
be sure that GCC will not start doing anything here.  GCC does not try
to understand what you wrote in an inline asm, it just fills in the
operands and that is all.  It can do all the same things to it that it
can do to any other code of course: duplicate it, deduplicate it,
frobnicate it, etc.


Segher
