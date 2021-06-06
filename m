Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E13B39D07D
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 20:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFFSqd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 14:46:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:58396 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229697AbhFFSqc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 14:46:32 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 156IePOX009871;
        Sun, 6 Jun 2021 13:40:25 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 156IeMmW009868;
        Sun, 6 Jun 2021 13:40:22 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 6 Jun 2021 13:40:21 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210606184021.GY18427@gate.crashing.org>
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com> <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com> <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org> <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 11:04:49AM -0700, Linus Torvalds wrote:
>     if (READ_ONCE(a)) {
>         barrier();
>         WRITE_ONCE(b,1);
>    } else {
>         barrier();
>         WRITE_ONCE(b, 1);
>     }
> 
> and currently because gcc thinks "same exact code", it will actually
> optimize this to (pseudo-asm):
> 
>     LD A
>     "empty asm"
>     ST $1,B
> 
> which is very much NOT equivalent to
> 
>     LD A
>     BEQ over
>     "empty asm"
>     ST $1,B
>     JMP join
> 
> over:
>     "empty asm"
>     ST $1,B
> 
> join:
> 
> and that's the whole point of the barriers.

You didn't use a barrier with these semantics though.  There is nothing
in that code that guarantees a branch.

> See, but it VIOLATES the semantics of the code.

The code violates your expectations of the code.

> You can't join those two empty asm's (and then remove the branch),
> because the semantics of the code really aren't the same any more if
> you do. Truly.

You truly should have written a branch in tthe asm if you truly wanted
a branch instruction.


Segher
