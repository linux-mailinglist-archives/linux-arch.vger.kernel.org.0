Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041EB3A19EB
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 17:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbhFIPjd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 11:39:33 -0400
Received: from gate.crashing.org ([63.228.1.57]:47811 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234049AbhFIPjF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 11:39:05 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 159FVcVo029586;
        Wed, 9 Jun 2021 10:31:38 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 159FVXoX029584;
        Wed, 9 Jun 2021 10:31:33 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 9 Jun 2021 10:31:33 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210609153133.GF18427@gate.crashing.org>
References: <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru> <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com> <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru> <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com> <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1> <YL5Risa6sFgnvvnG@elver.google.com> <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com> <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net> <20210608152851.GX18427@gate.crashing.org> <CANpmjNPJaDT4vBqkTw8XaRfKgDuwh71qmrvNfq-vx-Zyp4ugNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPJaDT4vBqkTw8XaRfKgDuwh71qmrvNfq-vx-Zyp4ugNg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 09, 2021 at 02:44:08PM +0200, Marco Elver wrote:
> On Tue, 8 Jun 2021 at 17:30, Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> > This needs some work.
> 
> There is a valid concern that something at the level of the memory
> model requires very precise specification in terms of language
> semantics and not generated code.

Yup, exactly.  Especially because the meaning of generated code is hard
to describe, and even much more so if you do not limit yourself to a
single machine architecture.

> Otherwise it seems difficult to get
> compiler folks onboard.

It isn't just difficult to get us on board without it, we know it just
is impossible to do anything sensible without it.

> And coming up with such a specification may
> take a while,

Yes.

> especially if we have to venture in the realm of the
> C11/C++11 memory model while still trying to somehow make it work for
> the LKMM. That seems like a very tricky maze we may want to avoid.

Well, you only need to use the saner parts of the memory model (not the
full thing), and extensions are fine as well of course.

> An alternative design would be to use a statement attribute to only
> enforce (C) ("__attribute__((mustcontrol))" ?).

Statement attributes only exist for empty statements.  It is unclear how
(and if!) we could support it for general statements.

Some new builtin seems to fit the requirements better?  I haven't looked
too closely though.


Segher
