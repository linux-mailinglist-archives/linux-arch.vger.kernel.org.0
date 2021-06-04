Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47839C1B4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 22:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhFDU5r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 16:57:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:47544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhFDU5r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 16:57:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91DD1613F4;
        Fri,  4 Jun 2021 20:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622840160;
        bh=e830GszwZ4AiNOzI8s1RDpdaRyQtmNqr2T04dXYa/uY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=MMacPIiqA+ZqGAUkyIremGeum5RPxrYoaxWwFjuxfdn26RJZhek16nczmV/yV0/MD
         7vIC05Ce5Vid7jE5RqLGeQPUsb4WS0sAJxmlNLyv4U9VLwVwSiGLqgPY2dpS0Zw50A
         Cm5B/DWCd0gHCCxQT3whDUVkmO9gkK9vGOUb9HTseRaz5Rt2HPuUuL1NlvHya8GiPI
         MeJlaQ+tqlfPQbhAw7HW+cJ8eAZQZP7+c4ZCemNIqRCCOjfCODKj6FTpmE1c7p41mF
         sBe8dF7eojJx7d1oTxYlHd3Z8kWALicTm9XHWUqEQvhB8kXrXw9Ti6Mi8drZQNAmtf
         BVABoHVDcCl0w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 58D295C02AB; Fri,  4 Jun 2021 13:56:00 -0700 (PDT)
Date:   Fri, 4 Jun 2021 13:56:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210604134422.GA2793@willie-the-truck>
 <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck>
 <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net>
 <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
 <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 12:18:43PM -0700, Linus Torvalds wrote:
> On Fri, Jun 4, 2021 at 12:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Again, semantics do matter, and I don't see how the compiler could
> > actually break the fundamental issue of "load->conditional->store is a
> > fundamental ordering even without memory barriers because of basic
> > causality", because you can't just arbitrarily generate speculative
> > stores that would be visible to others.
> 
> This, after all, is why we trust that the *hardware* can't do it.
> 
> Even if the hardware mis-speculates and goes down the wrong branch,
> and speculatively does the store when it shouldn't have, we don't
> care: we know that such a speculative store can not possibly become
> semantically visible (*) to other threads.
> 
> For all the same reasons, I don't see how a compiler can violate
> causal ordering of the code (assuming, again, that the test is
> _meaningful_ - if we write nonsensical code, that's a different
> issue).

I am probably missing your point, but something like this:

	if (READ_ONCE(x))
		y = 42;
	else
		y = 1729;

Can in theory be transformed into something like this:

	y = 1729;
	if (READ_ONCE(x))
		y = 42;

The usual way to prevent it is to use WRITE_ONCE().

Fortunately, register sets are large, and gcc manages to do a single
store and use only %eax.

							Thanx, Paul

> If we have compilers that create speculative stores that are visible
> to other threads, we need to fix them.
> 
>                Linus
> 
> (*) By "semantically visible" I intend to avoid the whole timing/cache
> pattern kind of non-semantic visibility that is all about the spectre
> leakage kind of things.
