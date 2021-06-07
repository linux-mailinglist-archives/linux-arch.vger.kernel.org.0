Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A117239DE97
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 16:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhFGOXH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 10:23:07 -0400
Received: from gate.crashing.org ([63.228.1.57]:33204 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230211AbhFGOXE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 10:23:04 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 157EGxr9002306;
        Mon, 7 Jun 2021 09:16:59 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 157EGxho002305;
        Mon, 7 Jun 2021 09:16:59 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 7 Jun 2021 09:16:58 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20210607141658.GE18427@gate.crashing.org>
References: <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1> <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org> <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com> <20210606184021.GY18427@gate.crashing.org> <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com> <20210606195242.GA18427@gate.crashing.org> <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com> <20210606202616.GC18427@gate.crashing.org> <YL36XzUxfs2YGlnw@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL36XzUxfs2YGlnw@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 12:52:15PM +0200, Peter Zijlstra wrote:
> On Sun, Jun 06, 2021 at 03:26:16PM -0500, Segher Boessenkool wrote:
> > I am saying that if you depend on that some C code you write will result
> > in some particular machine code, without actually *forcing* the compiler
> > to output that exact machine code, then you will be disappointed.  Maybe
> > not today, and maybe it will take years, if you are lucky.
> > 
> > (s/forcing/instructing/ of course, compilers have feelings too!)
> 
> And hence the request for a language extension. Both compilers have a
> vast array of language extensions that are outside of the C spec (thank
> you!), so can we please get one more?

I don't see why not?  It will need to be well-defined, so that it *can*
be implemented.  And ideally it will be useful for other applications as
well.  Finally, it should "play nice" with other extensions and language
features.


Segher
