Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D024A11D712
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2019 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfLLTeI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Dec 2019 14:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730284AbfLLTeI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Dec 2019 14:34:08 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4714C21556;
        Thu, 12 Dec 2019 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576179247;
        bh=DSjzqa57tXjDkk2/y8MiZfkoGkXE5LuVpeVYvGkAzAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bagGZkrK6wzLHJnf7BiRRpPhzPo5i+riIBOcS9DBGw4Oq1ZBQzyhZGBHdGOlcaaTg
         WGFTIePbWzElznEfxHo/Qop3TWvFTUmiuMWZ2jloSXdTrYnKxApvRPSNaFF+bcowVa
         2obC/XfXaO4qVL9xjg4eYXE4cX3X0COaAkN7hatc=
Date:   Thu, 12 Dec 2019 19:34:01 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>, dja@axtens.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Message-ID: <20191212193401.GB19020@willie-the-truck>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au>
 <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck>
 <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck>
 <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

On Thu, Dec 12, 2019 at 10:43:05AM -0800, Linus Torvalds wrote:
> On Thu, Dec 12, 2019 at 10:06 AM Will Deacon <will@kernel.org> wrote:
> >
> > I'm currently trying to solve the issue by removing volatile from the bitop
> > function signatures
> 
> I really think that's the wrong thing to do.
> 
> The bitop signature really should be "volatile" (and it should be
> "const volatile" for test_bit, but I'm not sure anybody cares).

Agreed on the "const" part, although I do think the "volatile" aspect has
nasty side-effects despite being a visual indicator that we're eliding
locks. More below.

> Exactly because it's simply valid to say "hey, my data is volatile,
> but do an atomic test of this bit". So it might be volatile in the
> caller.

That's fair, although the cases I've run into so far for the bitops are
usually just that the functions have been wrapped, and volatile could easily
be dropped from the caller as well (e.g. assign_bit(), __node_clear(),
linkmode_test_bit()).

> Now, I generally frown on actual volatile data structures - because
> the data structure volatility often depends on _context_. The same
> data might be volatile in one context (when you do some optimistic
> test on it without locking), but 100% stable in another (when you do
> have a lock).

There are cases in driver code where it looks as though data members are
being declared volatile specifically because of the bitops type signatures
(e.g. 'wrapped' in 'struct mdp5_mdss', 'context_flag' in 'struct
drm_device', 'state' in 'struct s2io_nic'). Yeah, it's bogus, but I think
that having the modifier in the function signature is still leading people
astray.

> So I don't want to see "volatile" on data definitions ("jiffies" being
> the one traditional exception), but marking things volatile in code
> (because you know you're working with unlocked data) and then passing
> them down to various helper functions - including the bitops ones - is
> quite traditional and accepted.
> 
> In other words, 'volatile" should be treated the same way "const" is
> largely treated in C.
> 
> A pointer to "const" data doesn't mean that the data is read-only, or
> that it cannot be modified _elsewhere_, it means that within this
> particular context and this copy of the pointer we promise not to
> write to it.
> 
> Similarly, a pointer to "volatile" data doesn't mean that the data
> might not be stable once you take a lock, for example. So it's ok to
> have volatile pointers even if the data declaration itself isn't
> volatile - you're stating something about the context, not something
> fundamental about the data.
> 
> And in the context of the bit operations, "volatile" is the correct thing
> to do.

The root of my concern in all of this, and what started me looking at it in
the first place, is the interaction with 'typeof()'. Inheriting 'volatile'
for a pointer means that local variables in macros declared using typeof()
suddenly start generating *hideous* code, particularly when pointless stack
spills get stackprotector all excited. Even if we simplify READ_ONCE() back
to its old incantation, the acquire/release accessors will have the exact
same issues on architectures that implement them.

For example, consider this code on arm64:

void ool_store_release(unsigned long *ptr, unsigned long val)
{
	smp_store_release(ptr, val);
}

This compiles to a single instruction plus return, which is what we want:

0000000000000000 <ool_store_release>:
   0:   c89ffc01        stlr    x1, [x0]
   4:   d65f03c0        ret

Now, see what happens if we make the 'ptr' argument volatile:

void ool_store_release(volatile unsigned long *ptr, unsigned long val)
{
	smp_store_release(ptr, val);
}

0000000000000000 <ool_store_release>:
   0:   a9be7bfd        stp     x29, x30, [sp, #-32]!
   4:   90000002        adrp    x2, 0 <__stack_chk_guard>
   8:   91000042        add     x2, x2, #0x0
   c:   910003fd        mov     x29, sp
  10:   f9400043        ldr     x3, [x2]
  14:   f9000fa3        str     x3, [x29, #24]
  18:   d2800003        mov     x3, #0x0                        // #0
  1c:   c89ffc01        stlr    x1, [x0]
  20:   f9400fa1        ldr     x1, [x29, #24]
  24:   f9400040        ldr     x0, [x2]
  28:   ca000020        eor     x0, x1, x0
  2c:   b5000060        cbnz    x0, 38 <ool_store_release+0x38>
  30:   a8c27bfd        ldp     x29, x30, [sp], #32
  34:   d65f03c0        ret
  38:   94000000        bl      0 <__stack_chk_fail>

It's a mess, and fixing READ_ONCE() doesn't help this case, which is why
I was looking at getting rid of volatile where it's not strictly needed.
I'm certainly open to other suggestions, I just haven't managed to think
of anything else.

Will
