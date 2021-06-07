Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59CF39E635
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 20:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFGSJz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 14:09:55 -0400
Received: from mail.ispras.ru ([83.149.199.84]:57022 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFGSJy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 14:09:54 -0400
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
        by mail.ispras.ru (Postfix) with ESMTPS id 5287940D403D;
        Mon,  7 Jun 2021 18:07:58 +0000 (UTC)
Date:   Mon, 7 Jun 2021 21:07:58 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Segher Boessenkool <segher@kernel.crashing.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
In-Reply-To: <20210607175200.GG18427@gate.crashing.org>
Message-ID: <alpine.LNX.2.20.13.2106072103320.7184@monopod.intra.ispras.ru>
References: <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com> <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com> <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com> <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com> <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru> <20210607175200.GG18427@gate.crashing.org>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 7 Jun 2021, Segher Boessenkool wrote:

> > So the barrier which is a compiler barrier but not a machine barrier is
> > __atomic_signal_fence(model), but internally GCC will not treat it smarter
> > than an asm-with-memory-clobber today.
> 
> It will do nothing for relaxed ordering, and do blockage for everything
> else.  Can it do anything weaker than that?

It's a "blockage instruction" after transitioning to RTL, but before that,
on GIMPLE, the compiler sees it properly as a corresponding built-in, and
may optimize according to given memory model. And on RTL, well, if anyone
cares they'll need to invent RTL representation for it, I guess.

Alexander
