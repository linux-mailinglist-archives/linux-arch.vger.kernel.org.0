Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5488C39CBD1
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 02:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFFAQH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 5 Jun 2021 20:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230022AbhFFAQH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 5 Jun 2021 20:16:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72070613F3;
        Sun,  6 Jun 2021 00:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622938458;
        bh=5zAebfKw3wGjoJ9snXmpScoW0ytD1mv0Hz2fwhZpB/M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PuqKNynFwhPXp3oCxNFlJ12YpG0p5s5e6Bjs1K5I9MVmZvc1b4D0ZtKzAFWZvlE2Y
         3kPTw/sVtD3JLnb/i47qSvRD4uCoS+CHxSZQ8PdUmXgelA/pdQ11f1DzYQfVmlDTLD
         6SOXzg7wPGFa73BZqiGEvxXLcAuPvufifO1IkU2VwNnnsqLbXIzyQI4J08Msk4K7nw
         bihn6gYFkWlsA1s8prKb8aJ3rKwJRvouQp6OsstqT+NrhsOxmCEJPtOviP4SMHXl8z
         FNkhyzO+IrUny2mxJ97ZKsH0q3O8UYcvMa6Rjr2cHKJRhhNnY+ofVkdC7CHcHljKjo
         KwN4y3eD5T2Vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 2E0575C0991; Sat,  5 Jun 2021 17:14:18 -0700 (PDT)
Date:   Sat, 5 Jun 2021 17:14:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net>
 <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210605145739.GB1712909@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 05, 2021 at 10:57:39AM -0400, Alan Stern wrote:
> On Fri, Jun 04, 2021 at 03:19:11PM -0700, Linus Torvalds wrote:
> > Now, part of this is that I do think that in *general* we should never
> > use this very suble load-cond-store pattern to begin with. We should
> > strive to use more smp_load_acquire() and smp_store_release() if we
> > care about ordering of accesses. They are typically cheap enough, and
> > if there's much of an ordering issue, they are the right things to do.
> > 
> > I think the whole "load-to-store ordering" subtle non-ordered case is
> > for very very special cases, when you literally don't have a general
> > memory ordering, you just have an ordering for *one* very particular
> > access. Like some of the very magical code in the rw-semaphore case,
> > or that smp_cond_load_acquire().
> > 
> > IOW, I would expect that we have a handful of uses of this thing. And
> > none of them have that "the conditional store is the same on both
> > sides" pattern, afaik.
> > 
> > And immediately when the conditional store is different, you end up
> > having a dependency on it that orders it.
> > 
> > But I guess I can accept the above made-up example as an "argument",
> > even though I feel it is entirely irrelevant to the actual issues and
> > uses we have.
> 
> Indeed, the expansion of the currently proposed version of
> 
> 	volatile_if (A) {
> 		B;
> 	} else {
> 		C;
> 	}
> 
> is basically the same as
> 
> 	if (A) {
> 		barrier();
> 		B;
> 	} else {
> 		barrier();
> 		C;
> 	}
> 
> which is just about as easy to write by hand.  (For some reason my 
> fingers don't like typing "volatile_"; the letters tend to get 
> scrambled.)
> 
> So given that:
> 
> 	1. Reliance on control dependencies is uncommon in the kernel,
> 	   and
> 
> 	2. The loads in A could just be replaced with load_acquires
> 	   at a low penalty (or store-releases could go into B and C),
> 
> it seems that we may not need volatile_if at all!  The only real reason 
> for having it in the first place was to avoid the penalty of 
> load-acquire on architectures where it has a significant cost, when the 
> control dependency would provide the necessary ordering for free.  Such 
> architectures are getting less and less common.

That does sound good, but...

Current compilers beg to differ at -O2: https://godbolt.org/z/5K55Gardn

------------------------------------------------------------------------
#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
#define WRITE_ONCE(x, val) (READ_ONCE(x) = (val))
#define barrier() __asm__ __volatile__("": : :"memory")

int x, y;

int main(int argc, char *argv[])
{
    if (READ_ONCE(x)) {
        barrier();
        WRITE_ONCE(y, 1);
    } else {
        barrier();
        WRITE_ONCE(y, 1);
    }
    return 0;
}
------------------------------------------------------------------------

Both gcc and clang generate a load followed by a store, with no branch.
ARM gets the same results from both compilers.

As Linus suggested, removing one (but not both!) invocations of barrier()
does cause a branch to be emitted, so maybe that is a way forward.
Assuming it is more than just dumb luck, anyway.  :-/

							Thanx, Paul
