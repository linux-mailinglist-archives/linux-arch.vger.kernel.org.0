Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9737054AEFD
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jun 2022 13:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242930AbiFNLEG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jun 2022 07:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243277AbiFNLEE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jun 2022 07:04:04 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126A23EAA4;
        Tue, 14 Jun 2022 04:03:56 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so16383599ejj.10;
        Tue, 14 Jun 2022 04:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3qivlV79zdER8caslPsaNrs1/3I18RVucM2ZcSuWZy0=;
        b=JtGKhaAACq7J+ucB2crVZsY7vZFRyy9hUGV+zRv3ldGV64/ET7HD9ad2KMPWeVv9Qh
         lSrTs7Fh3QtirXahYEPgmgIcj123RoAnSvLtCZrjsVxE8hrGrYnw37SvXCOV+2VBVED9
         fgV1+nPgrkoo4FaECUy+Nz/7IK1LcFdgv5OLPRGlOMG1rwTDsht7pin1FvOjOdK7Won3
         9x1y6ggGdPuksp6oBmf6NRuUpBsRZsSWxJq4Wc/GsyQktg3CB2lz5X7lKqX0z8WAHZ80
         VzzQ2/Zn5iugIWHng/wm8fonqEAlB/nAgYM3LijtLwNyc+SXKG2LUsgXxCs2Kwa84757
         gF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3qivlV79zdER8caslPsaNrs1/3I18RVucM2ZcSuWZy0=;
        b=Cdv/2uokPLjOygqbsyVQCVk5EOMwmxnxFiKJFvBTRYXDAfDHH5XARa5DXabtGApz5m
         ASoJlSVBGS7M2r5F+Tfax2ImOqpo4eBmZkOWBg23Nt1ue8InQ0gucmtgTSKj4Ekk0S6M
         oy4U38gRX8fGtX1wiW7UWDbQHsBMqxCuvYEJT+ZC586HEajWrLEeIWfcs3p4GLdVKGwZ
         hoLvGOy5mfKCj7q5sfCShLlmXQB4CQ2V09XizSq/XIzVNM3icYQMAj67SxfJGEtQBjqo
         zznRAlj+f1yvDx2crGEH9E3WCagn6hEWA8vjTIvhjPQVrA9WlQy/PCtPwRZJ7zDpsKyk
         jIDA==
X-Gm-Message-State: AOAM5316J5KNKMEzj0AMVr7BFYSWFF0q0beHJeqgKfFWAp7Nqcwf7lCL
        /d5zCsuyxnuUf5FmqIT9TPs=
X-Google-Smtp-Source: AGRyM1vSWwHRvENbiwCmGp/Zh6ybJ9z9U6dZaXoP9qp2fu8BNFtk9iDSkrcJ4rQacn3SrNtXPleMVQ==
X-Received: by 2002:a17:907:7b85:b0:711:e42d:4955 with SMTP id ne5-20020a1709077b8500b00711e42d4955mr3774713ejc.482.1655204634336;
        Tue, 14 Jun 2022 04:03:54 -0700 (PDT)
Received: from anparri (host-79-55-35-126.retail.telecomitalia.it. [79.55.35.126])
        by smtp.gmail.com with ESMTPSA id kb17-20020a170907925100b006f3ef214e63sm4901193ejb.201.2022.06.14.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 04:03:53 -0700 (PDT)
Date:   Tue, 14 Jun 2022 13:03:47 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Guo Ren <guoren@kernel.org>
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
Subject: Re: [PATCH V4 5/5] riscv: atomic: Optimize LRSC-pairs atomic ops
 with .aqrl annotation
Message-ID: <20220614110258.GA32157@anparri>
References: <CAJF2gTQoSQq_S4UvAiXgMviT040Ls8+VkDszQSke1a0zbXZ82A@mail.gmail.com>
 <mhng-7a274375-0d99-41c8-98a3-853d110f62e9@palmer-ri-x1c9>
 <CAJF2gTTXO42_TsZudaQuB9Re0teu__EZ11JZ96nktMqsQkMYNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTXO42_TsZudaQuB9Re0teu__EZ11JZ96nktMqsQkMYNA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Guo,

On Mon, Jun 13, 2022 at 07:49:50PM +0800, Guo Ren wrote:
> On Thu, Jun 2, 2022 at 1:59 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> >
> > On Sun, 22 May 2022 06:12:56 PDT (-0700), guoren@kernel.org wrote:
> > > On Sun, May 22, 2022 at 4:46 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
> > >>
> > >> On Wed, 04 May 2022 20:55:26 PDT (-0700), guoren@kernel.org wrote:
> > >> > From: Guo Ren <guoren@linux.alibaba.com>
> > >> >
> > >> > The current implementation is the same with 8e86f0b409a4
> > >> > ("arm64: atomics: fix use of acquire + release for full barrier
> > >> > semantics"). RISC-V could combine acquire and release into the SC
> > >> > instructions and it could reduce a fence instruction to gain better
> > >> > performance. Here is related descriptio from RISC-V ISA 10.2
> > >> > Load-Reserved/Store-Conditional Instructions:
> > >> >
> > >> >  - .aq:   The LR/SC sequence can be given acquire semantics by
> > >> >           setting the aq bit on the LR instruction.
> > >> >  - .rl:   The LR/SC sequence can be given release semantics by
> > >> >           setting the rl bit on the SC instruction.
> > >> >  - .aqrl: Setting the aq bit on the LR instruction, and setting
> > >> >           both the aq and the rl bit on the SC instruction makes
> > >> >           the LR/SC sequence sequentially consistent, meaning that
> > >> >           it cannot be reordered with earlier or later memory
> > >> >           operations from the same hart.
> > >> >
> > >> >  Software should not set the rl bit on an LR instruction unless
> > >> >  the aq bit is also set, nor should software set the aq bit on an
> > >> >  SC instruction unless the rl bit is also set. LR.rl and SC.aq
> > >> >  instructions are not guaranteed to provide any stronger ordering
> > >> >  than those with both bits clear, but may result in lower
> > >> >  performance.
> > >> >
> > >> > The only difference is when sc.w/d.aqrl failed, it would cause .aq
> > >> > effect than before. But it's okay for sematic because overlap
> > >> > address LR couldn't beyond relating SC.
> > >>
> > >> IIUC that's not accurate, or at least wasn't in 2018.  The ISA tends to
> > >> drift around a bit, so it's possible things have changed since then.
> > >> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> > > Thx for explaining, that why I suspected with the sentence in the comment:
> > > "which do not give full-ordering with .aqrl"
> >
> > Sorry, I'm not quite sure what you're saying here.  My understanding is
> > that this change results in mappings that violate LKMM, based on the
> > rationale in that previous commit.  IIUC that all still holds, but I'm
> > not really a memory model person so I frequently miss stuff around
> > there.
> 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with fences")
> is about fixup wrong spinlock/unlock implementation and not relate to
> this patch.

No.  The commit in question is evidence of the fact that the changes
you are presenting here (as an optimization) were buggy/incorrect at
the time in which that commit was worked out.


> Actually, sc.w.aqrl is very strong and the same with:
> fence rw, rw
> sc.w
> fence rw,rw
> 
> So "which do not give full-ordering with .aqrl" is not writen in
> RISC-V ISA and we could use sc.w/d.aqrl with LKMM.
> 
> >
> > >> describes the issue more specifically, that's when we added these
> > >> fences.  There have certainly been complains that these fences are too
> > >> heavyweight for the HW to go fast, but IIUC it's the best option we have
> > > Yeah, it would reduce the performance on D1 and our next-generation
> > > processor has optimized fence performance a lot.
> >
> > Definately a bummer that the fences make the HW go slow, but I don't
> > really see any other way to go about this.  If you think these mappings
> > are valid for LKMM and RVWMO then we should figure this out, but trying
> > to drop fences to make HW go faster in ways that violate the memory
> > model is going to lead to insanity.
> Actually, this patch is okay with the ISA spec, and Dan also thought
> it was valid.
> 
> ref: https://lore.kernel.org/lkml/41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com/raw

"Thoughts" on this regard have _changed_.  Please compare that quote
with, e.g.

  https://lore.kernel.org/linux-riscv/ddd5ca34-805b-60c4-bf2a-d6a9d95d89e7@nvidia.com/

So here's a suggestion:

Reviewers of your patches have asked:  How come that code we used to
consider as buggy is now considered "an optimization" (correct)?

Denying the evidence or going around it is not making their job (and
this upstreaming) easier, so why don't you address it?  Take time to
review previous works and discussions in this area, understand them,
and integrate such knowledge in future submissions.

  Andrea


> ------
> > 2. Using .aqrl to replace the fence rw, rw is okay to ISA manual,
> > right? And reducing a fence instruction to gain better performance:
> >                 "0:     lr.w     %[p],  %[c]\n"
> >                  "       sub      %[rc], %[p], %[o]\n"
> >                  "       bltz     %[rc], 1f\n".
> >  -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> >  +              "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> >                  "       bnez     %[rc], 0b\n"
> >  -               "       fence    rw, rw\n"
> 
> Yes, using .aqrl is valid.
> 
> Dan
> ------
> 
> 
> >
> > I can definately buy the argument that we have mappings of various
> > application memory models that are difficult to make fast given the ISA
> > encodings of RVWMO we have, but that's not really an issue we can fix in
> > the atomic mappings.
> >
> > >> given the current set of memory model primitives we implement in the
> > >> ISA (ie, there's more in RVWMO but no way to encode that).
> > >>
> > >> The others all look good, though, and as these are really all
> > >> independent cleanups I'm going to go ahead and put those three on
> > >> for-next.
> > >>
> > >> There's also a bunch of checkpatch errors.  The ones about "*" seem
> > >> spurious, but the alignment ones aren't.  Here's my fixups:
> > > Thx for the fixup.
> > >
> > >>
> > >>     diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> > >>     index 34f757dfc8f2..0bde499fa8bc 100644
> > >>     --- a/arch/riscv/include/asm/atomic.h
> > >>     +++ b/arch/riscv/include/asm/atomic.h
> > >>     @@ -86,9 +86,9 @@ ATOMIC_OPS(xor, xor,  i)
> > >>       * versions, while the logical ops only have fetch versions.
> > >>       */
> > >>      #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)   \
> > >>     -static __always_inline                                                     \
> > >>     -c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,                \
> > >>     -                                        atomic##prefix##_t *v)     \
> > >>     +static __always_inline c_type                                              \
> > >>     +arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,                       \
> > >>     +                                      atomic##prefix##_t *v)       \
> > >>      {                                                                  \
> > >>         register c_type ret;                                            \
> > >>         __asm__ __volatile__ (                                          \
> > >>     @@ -98,9 +98,9 @@ c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,               \
> > >>                 : "memory");                                            \
> > >>         return ret;                                                     \
> > >>      }                                                                  \
> > >>     -static __always_inline                                                     \
> > >>     -c_type arch_atomic##prefix##_fetch_##op##_acquire(c_type i,                \
> > >>     -                                        atomic##prefix##_t *v)     \
> > >>     +static __always_inline c_type                                              \
> > >>     +arch_atomic##prefix##_fetch_##op##_acquire(c_type i,                       \
> > >>     +                                      atomic##prefix##_t *v)       \
> > >>      {                                                                  \
> > >>         register c_type ret;                                            \
> > >>         __asm__ __volatile__ (                                          \
> > >>     @@ -110,9 +110,9 @@ c_type arch_atomic##prefix##_fetch_##op##_acquire(c_type i,             \
> > >>                 : "memory");                                            \
> > >>         return ret;                                                     \
> > >>      }                                                                  \
> > >>     -static __always_inline                                                     \
> > >>     -c_type arch_atomic##prefix##_fetch_##op##_release(c_type i,                \
> > >>     -                                        atomic##prefix##_t *v)     \
> > >>     +static __always_inline c_type                                              \
> > >>     +arch_atomic##prefix##_fetch_##op##_release(c_type i,                       \
> > >>     +                                      atomic##prefix##_t *v)       \
> > >>      {                                                                  \
> > >>         register c_type ret;                                            \
> > >>         __asm__ __volatile__ (                                          \
> > >>     @@ -122,8 +122,8 @@ c_type arch_atomic##prefix##_fetch_##op##_release(c_type i,             \
> > >>                 : "memory");                                            \
> > >>         return ret;                                                     \
> > >>      }                                                                  \
> > >>     -static __always_inline                                                     \
> > >>     -c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)   \
> > >>     +static __always_inline c_type                                              \
> > >>     +arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)  \
> > >>      {                                                                  \
> > >>         register c_type ret;                                            \
> > >>         __asm__ __volatile__ (                                          \
> > >>     @@ -135,28 +135,28 @@ c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)      \
> > >>      }
> > >>
> > >>      #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)    \
> > >>     -static __always_inline                                                     \
> > >>     -c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,               \
> > >>     -                                         atomic##prefix##_t *v)    \
> > >>     +static __always_inline c_type                                              \
> > >>     +arch_atomic##prefix##_##op##_return_relaxed(c_type i,                      \
> > >>     +                                       atomic##prefix##_t *v)      \
> > >>      {                                                                  \
> > >>     -        return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;    \
> > >>     +   return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I; \
> > >>      }                                                                  \
> > >>     -static __always_inline                                                     \
> > >>     -c_type arch_atomic##prefix##_##op##_return_acquire(c_type i,               \
> > >>     -                                         atomic##prefix##_t *v)    \
> > >>     +static __always_inline c_type                                              \
> > >>     +arch_atomic##prefix##_##op##_return_acquire(c_type i,                      \
> > >>     +                                       atomic##prefix##_t *v)      \
> > >>      {                                                                  \
> > >>     -        return arch_atomic##prefix##_fetch_##op##_acquire(i, v) c_op I;    \
> > >>     +   return arch_atomic##prefix##_fetch_##op##_acquire(i, v) c_op I; \
> > >>      }                                                                  \
> > >>     -static __always_inline                                                     \
> > >>     -c_type arch_atomic##prefix##_##op##_return_release(c_type i,               \
> > >>     -                                         atomic##prefix##_t *v)    \
> > >>     +static __always_inline c_type                                              \
> > >>     +arch_atomic##prefix##_##op##_return_release(c_type i,                      \
> > >>     +                                       atomic##prefix##_t *v)      \
> > >>      {                                                                  \
> > >>     -        return arch_atomic##prefix##_fetch_##op##_release(i, v) c_op I;    \
> > >>     +   return arch_atomic##prefix##_fetch_##op##_release(i, v) c_op I; \
> > >>      }                                                                  \
> > >>     -static __always_inline                                                     \
> > >>     -c_type arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)        \
> > >>     +static __always_inline c_type                                              \
> > >>     +arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)       \
> > >>      {                                                                  \
> > >>     -        return arch_atomic##prefix##_fetch_##op(i, v) c_op I;              \
> > >>     +   return arch_atomic##prefix##_fetch_##op(i, v) c_op I;           \
> > >>      }
> > >>
> > >>      #ifdef CONFIG_GENERIC_ATOMIC64
> > >>
> > >>
> > >> >
> > >> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > >> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > >> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > >> > Cc: Mark Rutland <mark.rutland@arm.com>
> > >> > Cc: Dan Lustig <dlustig@nvidia.com>
> > >> > Cc: Andrea Parri <parri.andrea@gmail.com>
> > >> > ---
> > >> >  arch/riscv/include/asm/atomic.h  | 24 ++++++++----------------
> > >> >  arch/riscv/include/asm/cmpxchg.h |  6 ++----
> > >> >  2 files changed, 10 insertions(+), 20 deletions(-)
> > >> >
> > >> > diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
> > >> > index 34f757dfc8f2..aef8aa9ac4f4 100644
> > >> > --- a/arch/riscv/include/asm/atomic.h
> > >> > +++ b/arch/riscv/include/asm/atomic.h
> > >> > @@ -269,9 +269,8 @@ static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int
> > >> >               "0:     lr.w     %[p],  %[c]\n"
> > >> >               "       beq      %[p],  %[u], 1f\n"
> > >> >               "       add      %[rc], %[p], %[a]\n"
> > >> > -             "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > >> > +             "       sc.w.aqrl  %[rc], %[rc], %[c]\n"
> > >> >               "       bnez     %[rc], 0b\n"
> > >> > -             "       fence    rw, rw\n"
> > >> >               "1:\n"
> > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > >> >               : [a]"r" (a), [u]"r" (u)
> > >> > @@ -290,9 +289,8 @@ static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a,
> > >> >               "0:     lr.d     %[p],  %[c]\n"
> > >> >               "       beq      %[p],  %[u], 1f\n"
> > >> >               "       add      %[rc], %[p], %[a]\n"
> > >> > -             "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > >> > +             "       sc.d.aqrl  %[rc], %[rc], %[c]\n"
> > >> >               "       bnez     %[rc], 0b\n"
> > >> > -             "       fence    rw, rw\n"
> > >> >               "1:\n"
> > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > >> >               : [a]"r" (a), [u]"r" (u)
> > >> > @@ -382,9 +380,8 @@ static __always_inline bool arch_atomic_inc_unless_negative(atomic_t *v)
> > >> >               "0:     lr.w      %[p],  %[c]\n"
> > >> >               "       bltz      %[p],  1f\n"
> > >> >               "       addi      %[rc], %[p], 1\n"
> > >> > -             "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > >> > +             "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > >> >               "       bnez      %[rc], 0b\n"
> > >> > -             "       fence     rw, rw\n"
> > >> >               "1:\n"
> > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > >> >               :
> > >> > @@ -402,9 +399,8 @@ static __always_inline bool arch_atomic_dec_unless_positive(atomic_t *v)
> > >> >               "0:     lr.w      %[p],  %[c]\n"
> > >> >               "       bgtz      %[p],  1f\n"
> > >> >               "       addi      %[rc], %[p], -1\n"
> > >> > -             "       sc.w.rl   %[rc], %[rc], %[c]\n"
> > >> > +             "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > >> >               "       bnez      %[rc], 0b\n"
> > >> > -             "       fence     rw, rw\n"
> > >> >               "1:\n"
> > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > >> >               :
> > >> > @@ -422,9 +418,8 @@ static __always_inline int arch_atomic_dec_if_positive(atomic_t *v)
> > >> >               "0:     lr.w     %[p],  %[c]\n"
> > >> >               "       addi     %[rc], %[p], -1\n"
> > >> >               "       bltz     %[rc], 1f\n"
> > >> > -             "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > >> > +             "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > >> >               "       bnez     %[rc], 0b\n"
> > >> > -             "       fence    rw, rw\n"
> > >> >               "1:\n"
> > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > >> >               :
> > >> > @@ -444,9 +439,8 @@ static __always_inline bool arch_atomic64_inc_unless_negative(atomic64_t *v)
> > >> >               "0:     lr.d      %[p],  %[c]\n"
> > >> >               "       bltz      %[p],  1f\n"
> > >> >               "       addi      %[rc], %[p], 1\n"
> > >> > -             "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > >> > +             "       sc.d.aqrl %[rc], %[rc], %[c]\n"
> > >> >               "       bnez      %[rc], 0b\n"
> > >> > -             "       fence     rw, rw\n"
> > >> >               "1:\n"
> > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > >> >               :
> > >> > @@ -465,9 +459,8 @@ static __always_inline bool arch_atomic64_dec_unless_positive(atomic64_t *v)
> > >> >               "0:     lr.d      %[p],  %[c]\n"
> > >> >               "       bgtz      %[p],  1f\n"
> > >> >               "       addi      %[rc], %[p], -1\n"
> > >> > -             "       sc.d.rl   %[rc], %[rc], %[c]\n"
> > >> > +             "       sc.d.aqrl %[rc], %[rc], %[c]\n"
> > >> >               "       bnez      %[rc], 0b\n"
> > >> > -             "       fence     rw, rw\n"
> > >> >               "1:\n"
> > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > >> >               :
> > >> > @@ -486,9 +479,8 @@ static __always_inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
> > >> >               "0:     lr.d     %[p],  %[c]\n"
> > >> >               "       addi      %[rc], %[p], -1\n"
> > >> >               "       bltz     %[rc], 1f\n"
> > >> > -             "       sc.d.rl  %[rc], %[rc], %[c]\n"
> > >> > +             "       sc.d.aqrl %[rc], %[rc], %[c]\n"
> > >> >               "       bnez     %[rc], 0b\n"
> > >> > -             "       fence    rw, rw\n"
> > >> >               "1:\n"
> > >> >               : [p]"=&r" (prev), [rc]"=&r" (rc), [c]"+A" (v->counter)
> > >> >               :
> > >> > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > >> > index 1af8db92250b..9269fceb86e0 100644
> > >> > --- a/arch/riscv/include/asm/cmpxchg.h
> > >> > +++ b/arch/riscv/include/asm/cmpxchg.h
> > >> > @@ -307,9 +307,8 @@
> > >> >               __asm__ __volatile__ (                                  \
> > >> >                       "0:     lr.w %0, %2\n"                          \
> > >> >                       "       bne  %0, %z3, 1f\n"                     \
> > >> > -                     "       sc.w.rl %1, %z4, %2\n"                  \
> > >> > +                     "       sc.w.aqrl %1, %z4, %2\n"                \
> > >> >                       "       bnez %1, 0b\n"                          \
> > >> > -                     "       fence rw, rw\n"                         \
> > >> >                       "1:\n"                                          \
> > >> >                       : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > >> >                       : "rJ" ((long)__old), "rJ" (__new)              \
> > >> > @@ -319,9 +318,8 @@
> > >> >               __asm__ __volatile__ (                                  \
> > >> >                       "0:     lr.d %0, %2\n"                          \
> > >> >                       "       bne %0, %z3, 1f\n"                      \
> > >> > -                     "       sc.d.rl %1, %z4, %2\n"                  \
> > >> > +                     "       sc.d.aqrl %1, %z4, %2\n"                \
> > >> >                       "       bnez %1, 0b\n"                          \
> > >> > -                     "       fence rw, rw\n"                         \
> > >> >                       "1:\n"                                          \
> > >> >                       : "=&r" (__ret), "=&r" (__rc), "+A" (*__ptr)    \
> > >> >                       : "rJ" (__old), "rJ" (__new)                    \
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 
> ML: https://lore.kernel.org/linux-csky/
