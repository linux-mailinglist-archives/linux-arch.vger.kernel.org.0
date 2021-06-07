Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F44639E6A6
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 20:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhFGS3n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 14:29:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:40897 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhFGS3m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 14:29:42 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 157INap3017668;
        Mon, 7 Jun 2021 13:23:36 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 157INZNS017666;
        Mon, 7 Jun 2021 13:23:35 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 7 Jun 2021 13:23:35 -0500
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
Message-ID: <20210607182335.GI18427@gate.crashing.org>
References: <20210606115336.GS18427@gate.crashing.org> <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com> <20210606184021.GY18427@gate.crashing.org> <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com> <20210606195242.GA18427@gate.crashing.org> <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com> <20210606202616.GC18427@gate.crashing.org> <20210606233729.GN4397@paulmck-ThinkPad-P17-Gen-1> <20210607141242.GD18427@gate.crashing.org> <20210607152712.GR4397@paulmck-ThinkPad-P17-Gen-1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607152712.GR4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 08:27:12AM -0700, Paul E. McKenney wrote:
> > > > > The barrier() thing can work - all we need to do is to simply make it
> > > > > impossible for gcc to validly create anything but a conditional
> > > > > branch.

> > > What would you suggest as a way of instructing the compiler to emit the
> > > conditional branch that we are looking for?
> > 
> > You write it in the assembler code.
> > 
> > Yes, it sucks.  But it is the only way to get a branch if you really
> > want one.  Now, you do not really need one here anyway, so there may be
> > some other way to satisfy the actual requirements.
> 
> Hmmm...  What do you see Peter asking for that is different than what
> I am asking for?  ;-)

I don't know what you are referring to, sorry?

I know what you asked for: literally some way to tell the compiler to
emit a conditional branch.  If that is what you want, the only way to
make sure that is what you get is by writing exactly that in assembler.


Segher
