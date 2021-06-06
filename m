Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6909C39D197
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 23:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhFFVVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 17:21:17 -0400
Received: from mail.ispras.ru ([83.149.199.84]:57878 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhFFVVR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 17:21:17 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 6E7994076B33;
        Sun,  6 Jun 2021 21:19:23 +0000 (UTC)
Date:   Mon, 7 Jun 2021 00:19:23 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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
In-Reply-To: <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
Message-ID: <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com> <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com> <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com> <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On Sun, 6 Jun 2021, Linus Torvalds wrote:

> On Sun, Jun 6, 2021 at 11:59 AM Jakub Jelinek <jakub@redhat.com> wrote:
> >
> > I think just
> > #define barrier() __asm__ __volatile__("" : : "i" (__COUNTER__) : "memory")
> > should be enough
> 
> Oh, I like that. Much better.
> 
> It avoids all the issues with comments etc, and because it's not using
> __COUNTER__ as a string, it doesn't need the preprocessor games with
> double expansion either.
> 
> So yeah, that seems like a nice solution to the issue, and should make
> the barriers all unique to the compiler.

It also plants a nice LTO time-bomb (__COUNTER__ values will be unique
only within each LTO input unit, not across all of them).

Alexander
