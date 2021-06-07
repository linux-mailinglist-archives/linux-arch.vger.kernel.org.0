Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D72839E9D8
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 00:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGXAv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 19:00:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:35597 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhFGXAv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 19:00:51 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 157MsaMr032654;
        Mon, 7 Jun 2021 17:54:36 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 157MsXQq032649;
        Mon, 7 Jun 2021 17:54:33 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 7 Jun 2021 17:54:33 -0500
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
Message-ID: <20210607225433.GR18427@gate.crashing.org>
References: <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com> <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com> <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru> <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com> <20210607174206.GF18427@gate.crashing.org> <CAHk-=wiOTcBuxx1pYj=mQz-f0dvhbxq2a=ricTuHH5xwUKE5Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiOTcBuxx1pYj=mQz-f0dvhbxq2a=ricTuHH5xwUKE5Yw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 01:31:24PM -0700, Linus Torvalds wrote:
> > Is it useful in general for the kernel to have separate "read" and
> > "write" clobbers in asm expressions?  And for other applications?
> 
> See above. It's actually not all that uncommon that you have a "this
> doesn't modify memory, but you can't move writes around it". It's
> usually very much about cache handling or memory ordering operations,
> and that bit test example was probably a bad example exactly because
> it made it look like it's about some controlled range.
> 
> The "write memory barroer" is likely the best and simplest example,
> but it's in not the only one.

Thanks for the examples!  I opened <https://gcc.gnu.org/PR100953> so
that we can easily track it.


Segher
