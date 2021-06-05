Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9D39C568
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 05:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFEDPw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 23:15:52 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59555 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229998AbhFEDPv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 23:15:51 -0400
Received: (qmail 1701512 invoked by uid 1000); 4 Jun 2021 23:14:03 -0400
Date:   Fri, 4 Jun 2021 23:14:03 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20210605031403.GA1701165@rowland.harvard.edu>
References: <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck>
 <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck>
 <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net>
 <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
 <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:09:26PM -0700, Linus Torvalds wrote:
> Side note: it is worth noting that my version of "volatile_if()" has
> an added little quirk: it _ONLY_ orders the stuff inside the
> if-statement.
> 
> I do think it's worth not adding new special cases (especially that
> "asm goto" hack that will generate worse code than the compiler could
> do), but it means that
> 
>     x = READ_ONCE(ptr);
>     volatile_if (x > 0)
>         WRITE_ONCE(*z, 42);
> 
> has an ordering, but if you write it as
> 
>     x = READ_ONCE(ptr);
>     volatile_if (x <= 0)
>         return;
>     WRITE_ONCE(*z, 42);
> 
> then I could in theory see teh compiler doing that WRITE_ONCE() as
> some kind of non-control dependency.

This may be a minor point, but can that loophole be closed as follows?

define volatile_if(x) \
	if ((({ _Bool __x = (x); BUILD_BUG_ON(__builtin_constant_p(__x)); __x; }) && \
		({ barrier(); 1; })) || ({ barrier(); 0; }))

(It's now a little later at night than when I usually think about this 
sort of thing, so my brain isn't firing on all its cylinders.  Forgive 
me if this is a dumb question.)

Alan

