Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7972039BB80
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 17:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFDPPt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 11:15:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230105AbhFDPPt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 11:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFBBA613EA;
        Fri,  4 Jun 2021 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622819643;
        bh=BgofpLR6wCrzrMq7LSYJxxe3HeZuUiWYK7Ao7WgOsRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GeXqTrVh/VR0EcTiJ+tZAhP54EskZmDWTB61rY+hNkBRM9gkZdM0GLv9hIp6AF90M
         0B/iY7c7YPVCj5DvujbGHveQAEwrl91mIsmiru083cycGHx0w3ruzXL1/+y9/cLr2f
         xTuXSdvZ4MYE1ZD3VJrnh37e3y9M/mTPOIaOJVfbsE8Fu7U5rm9yqFbdtAlHhqyzM4
         kO+jqB+bvbfM41T1MyIWSMQWz79d+WIvSdyRo2syrBLA0JJqeltUBfYSDRKf6vELAW
         srabbFsxzRZb0TXNo6TkNjAOOO4iwVpCLu7tXxZ3DrNsx1JEKKRr8SstRkzR5K2I8x
         OHJqwkXSi3sYA==
Date:   Fri, 4 Jun 2021 16:13:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
        stern@rowland.harvard.edu, parri.andrea@gmail.com,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210604151356.GC2793@willie-the-truck>
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck>
 <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck>
 <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 04, 2021 at 03:56:16PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 04, 2021 at 02:44:22PM +0100, Will Deacon wrote:
> > On Fri, Jun 04, 2021 at 01:31:48PM +0200, Peter Zijlstra wrote:
> > > On Fri, Jun 04, 2021 at 11:44:00AM +0100, Will Deacon wrote:
> > > > On Fri, Jun 04, 2021 at 12:12:07PM +0200, Peter Zijlstra wrote:
> > > 
> > > > > Usage of volatile_if requires the @cond to be headed by a volatile load
> > > > > (READ_ONCE() / atomic_read() etc..) such that the compiler is forced to
> > > > > emit the load and the branch emitted will have the required
> > > > > data-dependency. Furthermore, volatile_if() is a compiler barrier, which
> > > > > should prohibit the compiler from lifting anything out of the selection
> > > > > statement.
> > > > 
> > > > When building with LTO on arm64, we already upgrade READ_ONCE() to an RCpc
> > > > acquire. In this case, it would be really good to avoid having the dummy
> > > > conditional branch somehow, but I can't see a good way to achieve that.
> > > 
> > > #ifdef CONFIG_LTO
> > > /* Because __READ_ONCE() is load-acquire */
> > > #define volatile_cond(cond)	(cond)
> > > #else
> > > ....
> > > #endif
> > > 
> > > Doesn't work? Bit naf, but I'm thinking it ought to do.
> > 
> > The problem is with relaxed atomic RMWs; we don't upgrade those to acquire
> > atm as they're written in asm, but we'd need volatile_cond() to work with
> > them. It's a shame, because we only have RCsc RMWs on arm64, so it would
> > be a bit more expensive.
> 
> Urgh, I see. Compiler can't really help in that case either I'm afraid.
> They'll never want to modify loads that originate in an asm(). They'll
> say to use the C11 _Atomic crud.

Indeed. That's partly what led me down the route of thinking about "control
ordering" to sit between relaxed and acquire. So you have READ_ONCE_CTRL()
instead of this, but then we can't play your asm goto trick.

If we could push the memory access _and_ the branch down into the new
volatile_if helper, a bit like we do for smp_cond_load_*(), that would
help but it makes the thing a lot harder to use.

In fact, maybe it's actually necessary to bundle the load and branch
together. I looked at some of the examples of compilers breaking control
dependencies from memory-barriers.txt and the "boolean short-circuit"
example seems to defeat volatile_if:

void foo(int *x, int *y)
{
        volatile_if (READ_ONCE(*x) || 1 > 0)
                WRITE_ONCE(*y, 42);
}  

Although we get a conditional branch emitted, it's headed by an immediate
move instruction and the result of the load is discarded:

  38:   d503233f        paciasp
  3c:   b940001f        ldr     wzr, [x0]
  40:   52800028        mov     w8, #0x1                        // #1
  44:   b5000068        cbnz    x8, 50 <foo+0x18>
  48:   d50323bf        autiasp
  4c:   d65f03c0        ret
  50:   d503249f        bti     j
  54:   52800548        mov     w8, #0x2a                       // #42
  58:   b9000028        str     w8, [x1]
  5c:   d50323bf        autiasp
  60:   d65f03c0        ret

Will
