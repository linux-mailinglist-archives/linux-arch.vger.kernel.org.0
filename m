Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15520FDAA
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jun 2020 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgF3UaS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Jun 2020 16:30:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbgF3UaR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Jun 2020 16:30:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D9D20768;
        Tue, 30 Jun 2020 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593549016;
        bh=riLIoerWqEJyBrNNXh66ZrgcqlGhJPhnyVyuz3pbS7M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DZWNcctVGZb1GP4Q3/zbbYdw7d/SxPOxCNuLx/IYYUSbbRjM9YYnOSM+5P1GnmxHF
         DRLuIed6y3u6lbYYzr0bRfBa2YypwADNOjEjYrESyRMO0yTWyKocwHvkFEJ6MANgJw
         E46CB5czyZVqNvtaSluBcCKaeggVdm8Tx/DuVW1A=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 31AE13522640; Tue, 30 Jun 2020 13:30:16 -0700 (PDT)
Date:   Tue, 30 Jun 2020 13:30:16 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH 00/22] add support for Clang LTO
Message-ID: <20200630203016.GI9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630201243.GD4817@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 30, 2020 at 10:12:43PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 30, 2020 at 09:19:31PM +0200, Marco Elver wrote:
> > I was asked for input on this, and after a few days digging through some
> > history, thought I'd comment. Hope you don't mind.
> 
> Not at all, being the one that asked :-)
> 
> > First of all, I agree with the concerns, but not because of LTO.
> > 
> > To set the stage better, and summarize the fundamental problem again:
> > we're in the unfortunate situation that no compiler today has a way to
> > _efficiently_ deal with C11's memory_order_consume
> > [https://lwn.net/Articles/588300/]. If we did, we could just use that
> > and be done with it. But, sadly, that doesn't seem possible right now --
> > compilers just say consume==acquire.
> 
> I'm not convinced C11 memory_order_consume would actually work for us,
> even if it would work. That is, given:
> 
>   https://lore.kernel.org/lkml/20150520005510.GA23559@linux.vnet.ibm.com/
> 
> only pointers can have consume, but like I pointed out, we have code
> that relies on dependent loads from integers.

I agree that C11 memory_order_consume is not normally what we want,
given that it is universally promoted to memory_order_acquire.

However, dependent loads from integers are, if anything, more difficult
to defend from the compiler than are control dependencies.  This applies
doubly to integers that are used to index two-element arrays, in which
case you are just asking the compiler to destroy your dependent loads
by converting them into control dependencies.

> > Will suggests doing the same in the
> > kernel: https://lkml.kernel.org/r/20200630173734.14057-19-will@kernel.org
> 
> PowerPC would need a similar thing, it too will not preserve causality
> for control dependecies.
> 
> > What we're most worried about right now is the existence of compiler
> > transformations that could break data dependencies by e.g. turning them
> > into control dependencies.
> 
> Correct.
> 
> > If this is a real worry, I don't think LTO is the magical feature that
> > will uncover those optimizations. If these compiler transformations are
> > real, they also exist in a normal build! 
> 
> Agreed, _however_ with the caveat that LTO could make them more common.
> 
> After all, with whole program analysis, the compiler might be able to
> more easily determine that our pointer @ptr is only ever assigned the
> values of &A, &B or &C, while without that visibility it would not be
> able to determine this.
> 
> Once it knows @ptr has a limited number of determined values, the
> conversion into control dependencies becomes much more likely.

Which would of course break dependent loads.

> > And if we are worried about them, we need to stop relying on dependent
> > load ordering across the board; or switch to -O0 for everything.
> > Clearly, we don't want either.
> 
> Agreed.
> 
> > Why do we think LTO is special?
> 
> As argued above, whole-program analysis would make it more likely. But I
> agree the fundamental problem exists independent from LTO.
> 
> > But as far as we can tell, there is no evidence of the dreaded "data
> > dependency to control dependency" conversion with LTO that isn't there
> > in non-LTO builds, if it's even there at all. Has the data to control
> > dependency conversion been encountered in the wild? If not, is the
> > resulting reaction an overreaction? If so, we need to be careful blaming
> > LTO for something that it isn't even guilty of.
> 
> It is mostly paranoia; in a large part driven by the fact that even if
> such a conversion were to be done, it could go a very long time without
> actually causing problems, and longer still for such problems to be
> traced back to such an 'optimization'.
> 
> That is, the collective hurt from debugging too many ordering issues.
> 
> > So, we are probably better off untangling LTO from the story:
> > 
> > 1. LTO or no LTO does not matter. The LTO series should not get tangled
> >    up with memory model issues.
> > 
> > 2. The memory model question and problems need to be answered and
> >    addressed separately.
> > 
> > Thoughts?
> 
> How hard would it be to creates something that analyzes a build and
> looks for all 'dependent load -> control dependency' transformations
> headed by a volatile (and/or from asm) load and issues a warning for
> them?
> 
> This would give us an indication of how valuable this transformation is
> for the kernel. I'm hoping/expecting it's vanishingly rare, but what do
> I know.
> 

This could be quite useful!

							Thanx, Paul
