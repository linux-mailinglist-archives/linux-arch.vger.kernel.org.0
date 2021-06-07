Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A686839E67B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 20:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFGSYv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 14:24:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:33191 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230450AbhFGSYu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 14:24:50 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 157IIP9d017401;
        Mon, 7 Jun 2021 13:18:25 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 157IINkr017398;
        Mon, 7 Jun 2021 13:18:23 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 7 Jun 2021 13:18:23 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Alexander Monakov <amonakov@ispras.ru>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20210607181823.GH18427@gate.crashing.org>
References: <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com> <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com> <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru> <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com> <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru> <20210607175200.GG18427@gate.crashing.org> <alpine.LNX.2.20.13.2106072103320.7184@monopod.intra.ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.20.13.2106072103320.7184@monopod.intra.ispras.ru>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 09:07:58PM +0300, Alexander Monakov wrote:
> On Mon, 7 Jun 2021, Segher Boessenkool wrote:
> 
> > > So the barrier which is a compiler barrier but not a machine barrier is
> > > __atomic_signal_fence(model), but internally GCC will not treat it smarter
> > > than an asm-with-memory-clobber today.
> > 
> > It will do nothing for relaxed ordering, and do blockage for everything
> > else.  Can it do anything weaker than that?
> 
> It's a "blockage instruction" after transitioning to RTL, but before that,
> on GIMPLE, the compiler sees it properly as a corresponding built-in, and
> may optimize according to given memory model. And on RTL, well, if anyone
> cares they'll need to invent RTL representation for it, I guess.

My question was if anything weaker is *valid* :-)  (And if so, why!)


Segher
