Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C9939E5C6
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFGRsX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 13:48:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:58774 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFGRsX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 13:48:23 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 157Hg905015041;
        Mon, 7 Jun 2021 12:42:09 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 157Hg6Fm015039;
        Mon, 7 Jun 2021 12:42:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 7 Jun 2021 12:42:06 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210607174206.GF18427@gate.crashing.org>
References: <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com> <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com> <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru> <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 03:38:06PM -0700, Linus Torvalds wrote:
> In the case of "volatile_if()", we actually would like to have not a
> memory clobber, but a "memory read". IOW, it would be a barrier for
> any writes taking place, but reads can move around it.
> 
> I don't know of any way to express that to the compiler. We've used
> hacks for it before (in gcc, BLKmode reads turn into that kind of
> barrier in practice, so you can do something like make the memory
> input to the asm be a big array). But that turned out to be fairly
> unreliable, so now we use memory clobbers even if we just mean "reads
> random memory".
> 
> Example: variable_test_bit(), which generates a "bt" instruction, does
> 
>                      : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
> 
> and the memory clobber is obviously wrong: 'bt' only *reads* memory,
> but since the whole reason we use it is that it's not just that word
> at address 'addr', in order to make sure that any previous writes are
> actually stable in memory, we use that "memory" clobber.

You can split the "I" version from the "r" version, it does not need
the memory clobber.  If you know the actual maximum bit offset used you
don't need the clobber for "r" either.  Or you could even write
  "m"(((unsigned long *)addr)[nr/32])
That should work for all cases.

> Anybody have ideas or suggestions for something like that?

Is it useful in general for the kernel to have separate "read" and
"write" clobbers in asm expressions?  And for other applications?


Segher
