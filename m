Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028B339CF5E
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 15:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhFFNtk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 09:49:40 -0400
Received: from netrider.rowland.org ([192.131.102.5]:55005 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230084AbhFFNtk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 09:49:40 -0400
Received: (qmail 1736554 invoked by uid 1000); 6 Jun 2021 09:47:49 -0400
Date:   Sun, 6 Jun 2021 09:47:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20210606134749.GB1736178@rowland.harvard.edu>
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606125955.GT18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606125955.GT18427@gate.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 07:59:55AM -0500, Segher Boessenkool wrote:
> On Sat, Jun 05, 2021 at 08:41:00PM -0700, Linus Torvalds wrote:
> > On Sat, Jun 5, 2021 at 6:29 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > Interesting.  And changing one of the branches from barrier() to __asm__
> > > __volatile__("nop": : :"memory") also causes a branch to be emitted.  So
> > > even though the compiler doesn't "look inside" assembly code, it does
> > > compare two pieces at least textually and apparently assumes if they are
> > > identical then they do the same thing.
> > 
> > That's actually a feature in some cases, ie the ability to do CSE on
> > asm statements (ie the "always has the same output" optimization that
> > the docs talk about).
> > 
> > So gcc has always looked at the asm string for that reason, afaik.
> 
> GCC does not pretend it can understand the asm.  But it can see when
> two asm statements are identical.

How similar do two asm strings have to be before they are considered 
identical?  For instance, do changes to the amount of leading or 
trailing whitespace matter?

Or what about including an empty assembly statement in one but not the 
other?

Alan
