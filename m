Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DA639C183
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 22:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFDUpD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 16:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229913AbhFDUpD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 16:45:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7435C61287;
        Fri,  4 Jun 2021 20:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622839396;
        bh=Cxwuw6Sa1Plkd7To8z114JW5us72uxFhRTVu60Ncmgk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=STs4VvQav7n0qg/gh/cXEx1jFMFOEOvltkWvi/J8D/Tc7emKxUM7v2AcljwSDmDbA
         o06MbZ2dF3OBzVI0tnB7iCSz1WEA5zgTZKjF5pliEzij/iOh+0p65lTdQO3K7abNrN
         s5uMYjfPMHKnK8m6jissocERMuz0/MU9V9V7MbHK/qQMqAfBXtq/dtizjk0XZAx4+0
         iHdgUtsyPw/UDiFWaLyrvu7kMhMA1/Aq2frI+MzTlN9d/TBOQWywRwmuwndaMHySTF
         +SMBuLBWbhkpM8Aky4rpfL9R83BcSJYba0hIb98PoFqJLzajbogZO2GJoPgNoxl4fR
         7RL4cBZD10neg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4C4B05C02AB; Fri,  4 Jun 2021 13:43:16 -0700 (PDT)
Date:   Fri, 4 Jun 2021 13:43:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210604204316.GA4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
 <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net>
 <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
 <20210604172407.GJ18427@gate.crashing.org>
 <20210604191756.GE68208@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604191756.GE68208@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 09:17:56PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 12:24:07PM -0500, Segher Boessenkool wrote:
> > On Fri, Jun 04, 2021 at 10:10:29AM -0700, Linus Torvalds wrote:
> > > The compiler *cannot* just say "oh, I'll do that 'volatile asm
> > > barrier' whether the condition is true or not". That would be a
> > > fundamental compiler bug.
> > 
> > Yes.
> 
> So we can all agree on something like this?
> 
> #define volatile_if(x) \
> 	if (({ _Bool __x = (x); BUILD_BUG_ON(__builtin_constant_p(__x)); __x; }) && \
> 	    ({ barrier(); 1; }))

As long as this prevents compilers from causing trouble with things like
conditional-move instructions, I am good.  I don't know that this trouble
actually exists, but I never have been able to get official confirmation
one way or the other.  :-/

> Do we keep volatile_if() or do we like ctrl_dep_if() better?

I like ctrl_dep_if() because that is what it does, but I don't feel all
that strongly about it.

							Thanx, Paul
