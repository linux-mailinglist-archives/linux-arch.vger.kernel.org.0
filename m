Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C049558F11
	for <lists+linux-arch@lfdr.de>; Fri, 24 Jun 2022 05:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiFXD2W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jun 2022 23:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXD2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2022 23:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C32755B3;
        Thu, 23 Jun 2022 20:28:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DC5962080;
        Fri, 24 Jun 2022 03:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F4FC3411D;
        Fri, 24 Jun 2022 03:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656041295;
        bh=c9U6w80bveiiYfVEMuFWvgGZfoYlrG/1ugxilGxqmO8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQfbUPjScXdQpyhNLKcAWtvkGVKlE0anvE9sGEySseEzoajRJUj0mETU5YY8LI6XB
         qD6ARaylp5KC0zDjT1D8iUVW1FCx8mBBCZhKT5rVgdAUAF4noIN2aliNBk/CL1e4Vb
         aKEbKv5mRXbKhZ0UkNJPRccVoEw0iqhFclCsktLVhK39vAAj8oP0tuQZoW9PbXBeR1
         PvX+fRjeMIa2uKIOO3lykpkaSYjyd0HqWe71YsKDLNry26mxfP2iWhaftfSzmyYtur
         UfYaycS5QuhMjkBRNZMO4JnsLWdWo4liiOjyK1sGqzG84kNX0jkuxQePkRuSzoXuSw
         d9hZ+MLhmoxHg==
Received: by mail-vs1-f53.google.com with SMTP id 184so1192297vsz.2;
        Thu, 23 Jun 2022 20:28:15 -0700 (PDT)
X-Gm-Message-State: AJIora/K73sRGs7O/bHfb5QJvE1sKWf4ZQmjwtCnCo9MT2GxVLP69yxZ
        u1RuS4j9GqZdqomQueQeBGrv9ByzZflXep2xvS4=
X-Google-Smtp-Source: AGRyM1t/233dGS6DZQp5WCb9eKwYgrndvwxcyjJsxngSEaCxashBoYuONEkhtUwmQE8wZJ9mrDzoN8Akj3kAeMovciQ=
X-Received: by 2002:a05:6102:f8b:b0:354:57e8:4c1b with SMTP id
 e11-20020a0561020f8b00b0035457e84c1bmr7741945vsv.8.1656041294040; Thu, 23 Jun
 2022 20:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAJF2gTQoSQq_S4UvAiXgMviT040Ls8+VkDszQSke1a0zbXZ82A@mail.gmail.com>
 <mhng-7a274375-0d99-41c8-98a3-853d110f62e9@palmer-ri-x1c9>
 <CAJF2gTTXO42_TsZudaQuB9Re0teu__EZ11JZ96nktMqsQkMYNA@mail.gmail.com> <20220614110258.GA32157@anparri>
In-Reply-To: <20220614110258.GA32157@anparri>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 24 Jun 2022 11:28:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSJM-RNU_OC8WpWDYMdHk4kwRpW7L=KPv419=W9BvUnSg@mail.gmail.com>
Message-ID: <CAJF2gTSJM-RNU_OC8WpWDYMdHk4kwRpW7L=KPv419=W9BvUnSg@mail.gmail.com>
Subject: Re: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops with
 .aqrl annotation
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 14, 2022 at 7:03 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> Guo,
>
> On Mon, Jun 13, 2022 at 07:49:50PM +0800, Guo Ren wrote:
> > On Thu, Jun 2, 2022 at 1:59 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >
> > > On Sun, 22 May 2022 06:12:56 PDT (-0700), guoren@kernel.org wrote:
> > > > On Sun, May 22, 2022 at 4:46 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > > >>
> > > >> On Wed, 04 May 2022 20:55:26 PDT (-0700), guoren@kernel.org wrote:
> > > >> > From: Guo Ren <guoren@linux.alibaba.com>
> > > >> >
> > > >> > The current implementation is the same with 8e86f0b409a4
> > > >> > ("arm64: atomics: fix use of acquire + release for full barrier
> > > >> > semantics"). RISC-V could combine acquire and release into the SC
> > > >> > instructions and it could reduce a fence instruction to gain better
> > > >> > performance. Here is related descriptio from RISC-V ISA 10.2
> > > >> > Load-Reserved/Store-Conditional Instructions:
> > > >> >
> > > >> >  - .aq:   The LR/SC sequence can be given acquire semantics by
> > > >> >           setting the aq bit on the LR instruction.
> > > >> >  - .rl:   The LR/SC sequence can be given release semantics by
> > > >> >           setting the rl bit on the SC instruction.
> > > >> >  - .aqrl: Setting the aq bit on the LR instruction, and setting
> > > >> >           both the aq and the rl bit on the SC instruction makes
> > > >> >           the LR/SC sequence sequentially consistent, meaning that
> > > >> >           it cannot be reordered with earlier or later memory
> > > >> >           operations from the same hart.
> > > >> >
> > > >> >  Software should not set the rl bit on an LR instruction unless
> > > >> >  the aq bit is also set, nor should software set the aq bit on an
> > > >> >  SC instruction unless the rl bit is also set. LR.rl and SC.aq
> > > >> >  instructions are not guaranteed to provide any stronger ordering
> > > >> >  than those with both bits clear, but may result in lower
> > > >> >  performance.
> > > >> >
> > > >> > The only difference is when sc.w/d.aqrl failed, it would cause .aq
> > > >> > effect than before. But it's okay for sematic because overlap
> > > >> > address LR couldn't beyond relating SC.
> > > >>
> > > >> IIUC that's not accurate, or at least wasn't in 2018.  The ISA tends to
> > > >> drift around a bit, so it's possible things have changed since then.
> > > >> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> > > > Thx for explaining, that why I suspected with the sentence in the comment:
> > > > "which do not give full-ordering with .aqrl"
> > >
> > > Sorry, I'm not quite sure what you're saying here.  My understanding is
> > > that this change results in mappings that violate LKMM, based on the
> > > rationale in that previous commit.  IIUC that all still holds, but I'm
> > > not really a memory model person so I frequently miss stuff around
> > > there.
> > 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> > is about fixup wrong spinlock/unlock implementation and not relate to
> > this patch.
>
> No.  The commit in question is evidence of the fact that the changes
> you are presenting here (as an optimization) were buggy/incorrect at
> the time in which that commit was worked out.
I think I've mixed it with 0123f4d76ca6 ("riscv/spinlock: Strengthen
implementations with fences").

>
>
> > Actually, sc.w.aqrl is very strong and the same with:
> > fence rw, rw
> > sc.w
> > fence rw,rw
> >
> > So "which do not give full-ordering with .aqrl" is not writen in
> > RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
> >
> > >
> > > >> describes the issue more specifically, that's when we added these
> > > >> fences.  There have certainly been complains that these fences are too
> > > >> heavyweight for the HW to go fast, but IIUC it's the best option we have
> > > > Yeah, it would reduce the performance on D1 and our next-generation
> > > > processor has optimized fence performance a lot.
> > >
> > > Definately a bummer that the fences make the HW go slow, but I don't
> > > really see any other way to go about this.  If you think these mappings
> > > are valid for LKMM and RVWMO then we should figure this out, but trying
> > > to drop fences to make HW go faster in ways that violate the memory
> > > model is going to lead to insanity.
> > Actually, this patch is okay with the ISA spec, and Dan also thought
> > it was valid.
> >
> > ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw
>
> "Thoughts" on this regard have _changed_.  Please compare that quote
> with, e.g.
>
>   https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/
>
> So here's a suggestion:
>
> Reviewers of your patches have asked:  How come that code we used to
> consider as buggy is now considered "an optimization" (correct)?
>
> Denying the evidence or going around it is not making their job (and
> this upstreaming) easier, so why don't you address it?  Take time to
> review previous works and discussions in this area, understand them,
> and integrate such knowledge in future submissions.
>
>   Andrea
>
>
> > ------
> > > 2. Using .aqrl to replace the fence rw, rw is okay to ISA manual,
> > > right? And reducing a fence instruction to gain better performance:
> > >                 "0:     lr.w     %[p],  %[c]\n"
> > >                  "       sub      %[rc], %[p], %[o]\n"
> > >                  "       bltz     %[rc], 1f\n".
> > >  -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > >  +              "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > >                  "       bnez     %[rc], 0b\n"
> > >  -               "       fence    rw, rw\n"
> >
> > Yes, using .aqrl is valid.
> >
> > Dan
> > ------
> >
> >
> > >
> > > I can definately buy the argument that we have mappings of various
> > > application memory models that are difficult to make fast given the ISA
> > > encodings of RVWMO we have, but that's not really an issue we can fix in
> > > the atomic mappings.
> > >
> > > >> given the current set of memory model primitives we implement in the
> > > >> ISA (ie, there's more in RVWMO but no way to encode that).
> > > >>
> > > >> The others all look good, though, and as these are really all
> > > >> independent cleanups I'm going to go ahead and put those three on
> > > >> for-next.
> > > >>
> > > >> There's also a bunch of checkpatch errors.  The ones about "*" seem
> > > >> spurious, but the alignment ones aren't.  Here's my fixups:
> > > > Thx for the fixup.
> > > >
> > > >>
> > > >>     diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> > > >>     index 34f757dfc8f2..0bde499fa8bc 100644
> > > >>     --- a/arch/riscv/include/asm/atomic.h
> > > >>     +++ b/arch/riscv/include/asm/atomic.h
> > > >>     @@ -86,9 +86,9 @@ ATOMIC_OPS(xor, xor,  i)
> > > >>       * versions, while the logical ops only have fetch versions.
> > > >>       */
> > > >>      #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)   \
> > > >>     -static __always_inline                                                     \
> > > >>     -c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,                \
> > > >>     -                                        atomic##prefix##_t *v)     \
> > > >>     +static __always_inline c_type                                              \
> > > >>     +arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,                       \
> > > >>     +                                      atomic##prefix##_t *v)       \
> > > >>      {                                                                  \
> > > >>         register c_type ret;                                            \
> > > >>         __asm__ __volatile__ (                                          \
> > > >>     @@ -98,9 +98,9 @@ c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,               \
> > > >>                 : "memory");                                            \
> > > >>         return ret;                                                     \
> > > >>      }                                                                  \
> > > >>     -static __always_inline                                                     \
> > > >>     -c_type arch_atomic##prefix##_fetch_##op##_acquire(c_type i,                \
> > > >>     -                                        atomic##prefix##_t *v)     \
> > > >>     +static __always_inline c_type                                              \
> > > >>     +arch_atomic##prefix##_fetch_##op##_acquire(c_type i,                       \
> > > >>     +                                      atomic##prefix##_t *v)       \
> > > >>      {                                                                  \
> > > >>         register c_type ret;                                            \
> > > >>         __asm__ __volatile__ (                                          \
> > > >>     @@ -110,9 +110,9 @@ c_type arch_atomic##prefix##_fetch_##op##_acquire(c_type i,             \
> > > >>                 : "memory");                                            \
> > > >>         return ret;                                                     \
> > > >>      }                                                                  \
> > > >>     -static __always_inline                                                     \
> > > >>     -c_type arch_atomic##prefix##_fetch_##op##_release(c_type i,                \
> > > >>     -                                        atomic##prefix##_t *v)     \
> > > >>     +static __always_inline c_type                                              \
> > > >>     +arch_atomic##prefix##_fetch_##op##_release(c_type i,                       \
> > > >>     +                                      atomic##prefix##_t *v)       \
> > > >>      {                                                                  \
> > > >>         register c_type ret;                                            \
> > > >>         __asm__ __volatile__ (                                          \
> > > >>     @@ -122,8 +122,8 @@ c_type arch_atomic##prefix##_fetch_##op##_release(c_type i,             \
> > > >>                 : "memory");                                            \
> > > >>         return ret;                                                     \
> > > >>      }                                                                  \
> > > >>     -static __always_inline                                                     \
> > > >>     -c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)   \
> > > >>     +static __always_inline c_type                                              \
> > > >>     +arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)  \
> > > >>      {                                                                  \
> > > >>         register c_type ret;                                            \
> > > >>         __asm__ __volatile__ (                                          \
> > > >>     @@ -135,28 +135,28 @@ c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)      \
> > > >>      }
> > > >>
> > > >>      #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)    \
> > > >>     -static __always_inline                                                     \
> > > >>     -c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,               \
> > > >>     -                                         atomic##prefix##_t *v)    \
> > > >>     +static __always_inline c_type                                              \
> > > >>     +arch_atomic##prefix##_##op##_return_relaxed(c_type i,                      \
> > > >>     +                                       atomic##prefix##_t *v)      \
> > > >>      {                                                                  \
> > > >>     -        return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;    \
> > > >>     +   return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I; \
> > > >>      }                                                                  \
> > > >>     -static __always_inline                                                     \
> > > >>     -c_type arch_atomic##prefix##_##op##_return_acquire(c_type i,               \
> > > >>     -                                         atomic##prefix##_t *v)    \
> > > >>     +static __always_inline c_type                                              \
> > > >>     +arch_atomic##prefix##_##op##_return_acquire(c_type i,                      \
> > > >>     +                                       atomic##prefix##_t *v)      \
> > > >>      {                                                                  \
> > > >>     -        return arch_atomic##prefix##_fetch_##op##_acquire(i, v) c_op I;    \
> > > >>     +   return arch_atomic##prefix##_fetch_##op##_acquire(i, v) c_op I; \
> > > >>      }                                                                  \
> > > >>     -static __always_inline                                                     \
> > > >>     -c_type arch_atomic##prefix##_##op##_return_release(c_type i,               \
> > > >>     -                                         atomic##prefix##_t *v)    \
> > > >>     +static __always_inline c_type                                              \
> > > >>     +arch_atomic##prefix##_##op##_return_release(c_type i,                      \
> > > >>     +                                       atomic##prefix##_t *v)      \
> > > >>      {                                                                  \
> > > >>     -        return arch_atomic##prefix##_fetch_##op##_release(i, v) c_op I;    \
> > > >>     +   return arch_atomic##prefix##_fetch_##op##_release(i, v) c_op I; \
> > > >>      }                                                                  \
> > > >>     -static __always_inline                                                     \
> > > >>     -c_type arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)        \
> > > >>     +static __always_inline c_type                                              \
> > > >>     +arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)       \
> > > >>      {                                                                  \
> > > >>     -        return arch_atomic##prefix##_fetch_##op(i, v) c_op I;              \
> > > >>     +   return arch_atomic##prefix##_fetch_##op(i, v) c_op I;           \
> > > >>      }
> > > >>
> > > >>      #ifdef CONFIG_GENERIC_ATOMIC64
> > > >>
> > > >>
> > > >> >
> > > >> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > >> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > >> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > >> > Cc: Mark Rutland <mark.rutland@arm.com>
> > > >> > Cc: Dan Lustig <dlustig@nvidia.com>
> > > >> > Cc: Andrea Parri <parri.andrea@gmail.com>
> > > >> > ---
> > > >> >  arch/riscv/include/asm/atomic.h  | 24 ++++++++----------------
> > > >> >  arch/riscv/include/asm/cmpxchg.h |  6 ++----
> > > >> >  2 files changed, 10 insertions(+), 20 deletions(-)
> > > >> >
> > > >> > diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> > > >> > index 34f757dfc8f2..aef8aa9ac4f4 100644
> > > >> > --- a/arch/riscv/include/asm/atomic.h
> > > >> > +++ b/arch/riscv/include/asm/atomic.h
> > > >> > @@ -269,9 +269,8 @@ static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int
> > > >> >               "0:     lr.w     %[p],  %[c]\n"
> > > >> >               "       beq      %[p],  %[u], 1f\n"
> > > >> >               "       add      %[rc], %[p], %[a]\n"
> > > >> > -             "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > >> > +             "       sc.w.aqrl  %[rc], %[rc], %[c]\n"
> > > >> >               "       bnez     %[rc], 0b\n"
> > > >> > -             "       fence    rw, rw\n"
> > > >> >               "1:\n"
> > > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > > >> >               : [a]"r" (a), [u]"r" (u)
> > > >> > @@ -290,9 +289,8 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
> > > >> >               "0:     lr.d     %[p],  %[c]\n"
> > > >> >               "       beq      %[p],  %[u], 1f\n"
> > > >> >               "       add      %[rc], %[p], %[a]\n"
> > > >> > -             "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > > >> > +             "       sc.d.aqrl  %[rc], %[rc], %[c]\n"
> > > >> >               "       bnez     %[rc], 0b\n"
> > > >> > -             "       fence    rw, rw\n"
> > > >> >               "1:\n"
> > > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > > >> >               : [a]"r" (a), [u]"r" (u)
> > > >> > @@ -382,9 +380,8 @@ static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
> > > >> >               "0:     lr.w      %[p],  %[c]\n"
> > > >> >               "       bltz      %[p],  1f\n"
> > > >> >               "       addi      %[rc], %[p], 1\n"
> > > >> > -             "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > > >> > +             "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > > >> >               "       bnez      %[rc], 0b\n"
> > > >> > -             "       fence     rw, rw\n"
> > > >> >               "1:\n"
> > > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > > >> >               :
> > > >> > @@ -402,9 +399,8 @@ static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
> > > >> >               "0:     lr.w      %[p],  %[c]\n"
> > > >> >               "       bgtz      %[p],  1f\n"
> > > >> >               "       addi      %[rc], %[p], -1\n"
> > > >> > -             "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > > >> > +             "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > > >> >               "       bnez      %[rc], 0b\n"
> > > >> > -             "       fence     rw, rw\n"
> > > >> >               "1:\n"
> > > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > > >> >               :
> > > >> > @@ -422,9 +418,8 @@ static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
> > > >> >               "0:     lr.w     %[p],  %[c]\n"
> > > >> >               "       addi     %[rc], %[p], -1\n"
> > > >> >               "       bltz     %[rc], 1f\n"
> > > >> > -             "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > >> > +             "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > > >> >               "       bnez     %[rc], 0b\n"
> > > >> > -             "       fence    rw, rw\n"
> > > >> >               "1:\n"
> > > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > > >> >               :
> > > >> > @@ -444,9 +439,8 @@ static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
> > > >> >               "0:     lr.d      %[p],  %[c]\n"
> > > >> >               "       bltz      %[p],  1f\n"
> > > >> >               "       addi      %[rc], %[p], 1\n"
> > > >> > -             "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > > >> > +             "       sc.d.aqrl %[rc], %[rc], %[c]\n"
> > > >> >               "       bnez      %[rc], 0b\n"
> > > >> > -             "       fence     rw, rw\n"
> > > >> >               "1:\n"
> > > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > > >> >               :
> > > >> > @@ -465,9 +459,8 @@ static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
> > > >> >               "0:     lr.d      %[p],  %[c]\n"
> > > >> >               "       bgtz      %[p],  1f\n"
> > > >> >               "       addi      %[rc], %[p], -1\n"
> > > >> > -             "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > > >> > +             "       sc.d.aqrl %[rc], %[rc], %[c]\n"
> > > >> >               "       bnez      %[rc], 0b\n"
> > > >> > -             "       fence     rw, rw\n"
> > > >> >               "1:\n"
> > > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > > >> >               :
> > > >> > @@ -486,9 +479,8 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
> > > >> >               "0:     lr.d     %[p],  %[c]\n"
> > > >> >               "       addi      %[rc], %[p], -1\n"
> > > >> >               "       bltz     %[rc], 1f\n"
> > > >> > -             "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > > >> > +             "       sc.d.aqrl %[rc], %[rc], %[c]\n"
> > > >> >               "       bnez     %[rc], 0b\n"
> > > >> > -             "       fence    rw, rw\n"
> > > >> >               "1:\n"
> > > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > > >> >               :
> > > >> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > > >> > index 1af8db92250b..9269fceb86e0 100644
> > > >> > --- a/arch/riscv/include/asm/cmpxchg.h
> > > >> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > >> > @@ -307,9 +307,8 @@
> > > >> >               __asm__ __volatile__ (                                  \
> > > >> >                       "0:     lr.w %0, %2\n"                          \
> > > >> >                       "       bne  %0, %z3, 1f\n"                     \
> > > >> > -                     "       sc.w.rl %1, %z4, %2\n"                  \
> > > >> > +                     "       sc.w.aqrl %1, %z4, %2\n"                \
> > > >> >                       "       bnez %1, 0b\n"                          \
> > > >> > -                     "       fence rw, rw\n"                         \
> > > >> >                       "1:\n"                                          \
> > > >> >                       : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > > >> >                       : "rJ" ((long)__old), "rJ" (__new)              \
> > > >> > @@ -319,9 +318,8 @@
> > > >> >               __asm__ __volatile__ (                                  \
> > > >> >                       "0:     lr.d %0, %2\n"                          \
> > > >> >                       "       bne %0, %z3, 1f\n"                      \
> > > >> > -                     "       sc.d.rl %1, %z4, %2\n"                  \
> > > >> > +                     "       sc.d.aqrl %1, %z4, %2\n"                \
> > > >> >                       "       bnez %1, 0b\n"                          \
> > > >> > -                     "       fence rw, rw\n"                         \
> > > >> >                       "1:\n"                                          \
> > > >> >                       : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > > >> >                       : "rJ" (__old), "rJ" (__new)                    \
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
