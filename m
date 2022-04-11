Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469944FBCED
	for <lists+linux-arch@lfdr.de>; Mon, 11 Apr 2022 15:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346412AbiDKNWd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Apr 2022 09:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346456AbiDKNWb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Apr 2022 09:22:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B03B54E;
        Mon, 11 Apr 2022 06:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 303D160C97;
        Mon, 11 Apr 2022 13:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CA6C385AC;
        Mon, 11 Apr 2022 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649683216;
        bh=OcuAr1GyreyhXIjEC+zFg2u+H+LlTNXbW2xcHQviwNo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LHpLidWDKMn62IY5RtSLIcvb5iTdhAE3IkUmKRZVYovRANbKuUZ7uNQ82ooYELuMp
         uvnkBumUXMwoq5giJoO/Srly4V6s9XuycpJEa6nA4ht8+qAoH4kJNBtG6lBXMyfecr
         dIM+ZZaGYoXRkLhSPRIVv15j84+cBkMjrByQXrw+YPNNTANE/4cg5t3b5L7+XzStlc
         DFrcSJuCBRcQNjHUKp3YW/m1qQy8PxxP1PW5HXwuS9Ue4X+oxgHa+qoXPdYAQ57QNx
         5sLxj2YuNgirEfqnlGVjBeQqARm9SSfaAfJcl6k9KJ4OjxgzhJpXGQprsOQzz+dhKt
         i96/9/D/h1/jw==
Received: by mail-vk1-f172.google.com with SMTP id e2so2664418vkn.4;
        Mon, 11 Apr 2022 06:20:16 -0700 (PDT)
X-Gm-Message-State: AOAM5316mipcJ2rDMhOYI9a2USW4yBhatEDiMGdvgN50VY0Pel/dRsND
        PMsuG+B6K29ZvDgt0zZclCrvDGQV/T+tgUGucG8=
X-Google-Smtp-Source: ABdhPJwsSThv12gIf4xS7sRqeyXoiBFfR3mAsFsOo3kX+636iDMKX1X+qwTN1V7goEmYj6lIwX+DaE06dkRkvgW27Sk=
X-Received: by 2002:a05:6122:2016:b0:345:99ff:7151 with SMTP id
 l22-20020a056122201600b0034599ff7151mr1365843vkd.2.1649683215477; Mon, 11 Apr
 2022 06:20:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220406120405.660354-1-guoren@kernel.org> <YlP2PIPrUS89LuFR@FVFF77S0Q05N>
In-Reply-To: <YlP2PIPrUS89LuFR@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 11 Apr 2022 21:20:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSAxpAi=LbAdu7jntZRUa=-dJwL0VfmDfBV5MHB=rcZ-w@mail.gmail.com>
Message-ID: <CAJF2gTSAxpAi=LbAdu7jntZRUa=-dJwL0VfmDfBV5MHB=rcZ-w@mail.gmail.com>
Subject: Re: [PATCH] riscv: Optimize AMO acquire/release usage
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mark,

On Mon, Apr 11, 2022 at 5:35 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Guo,
>
> On Wed, Apr 06, 2022 at 08:04:05PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Using RISCV_ACQUIRE/RELEASE_BARRIER is over expensive for
> > xchg/cmpxchg_acquire/release than nature instructions' .aq/rl.
> > The patch fixed these issues under RISC-V Instruction Set Manual,
> > Volume I: RISC-V User-Level ISA =E2=80=9CA=E2=80=9D Standard Extension =
for Atomic
> > Instructions, Version 2.1.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > ---
> >  arch/riscv/include/asm/atomic.h  | 70 ++++++++++++++++++++++++++++++--
> >  arch/riscv/include/asm/cmpxchg.h | 30 +++++---------
> >  2 files changed, 76 insertions(+), 24 deletions(-)
>
> I'll leave the bulk of this to Palmer, but I spotted something below whic=
h
> doesn't look right.
>
> > @@ -315,12 +379,11 @@ static __always_inline int arch_atomic_sub_if_pos=
itive(atomic_t *v, int offset)
> >         int prev, rc;
> >
> >       __asm__ __volatile__ (
> > -             "0:     lr.w     %[p],  %[c]\n"
> > +             "0:     lr.w.aq  %[p],  %[c]\n"
> >               "       sub      %[rc], %[p], %[o]\n"
> >               "       bltz     %[rc], 1f\n"
> >               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> >               "       bnez     %[rc], 0b\n"
> > -             "       fence    rw, rw\n"
> >               "1:\n"
> >               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> >               : [o]"r" (offset)
>
> I believe in this case the existing code here is correct, and this optimi=
zation
> is broken.
Yes, you are right, My patch would break the memory consistency of
riscv between acquire & release. Thx for your corrections.

>
> I believe the existing code is using RELEASE + FULL-BARRIER to ensure ful=
l
> ordering, since separate ACQUIRE+RELEASE cannot. For a description of the
> problem, see the commit message for:
I've another question: The RELEASE(prevent ACCESS-A after stlxr) +
FULL-BARRIER is for arm64 because there is no "stlaxr" for arm64,
right? We could use sc.w.aqrl directly for riscv to reduce a release
fence.

New patch:
       __asm__ __volatile__ (
              "0:     lr.w     %[p],  %[c]\n"
               "       sub      %[rc], %[p], %[o]\n"
               "       bltz     %[rc], 1f\n"
-              "       sc.w.rl  %[rc], %[rc], %[c]\n"
+              "       sc.w.aqrl  %[rc], %[rc], %[c]\n"
               "       bnez     %[rc], 0b\n"
 -             "       fence    rw, rw\n"
               "1:\n"
               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counter)
               : [o]"r" (offset)

(It surprises me that seems lr.w.aq is useless for the real world.)

>
>   8e86f0b409a44193 ("arm64: atomics: fix use of acquire + release for ful=
l barrier semantics")
>
> The gist is that HW can re-order:
>
>         ACCESS-A
>         ACQUIRE
>         RELEASE
>         ACCESS-B
>
> ... to:
>
>         ACQUIRE
>         ACCESS-B
>         ACCESS-A
>         RELEASE
>
> ... violating FULL ordering semantics.
>
> This will apply for *any* operation where FULL orderingis required, which=
 I
> suspect applies to some more cases below.


>
> > @@ -337,12 +400,11 @@ static __always_inline s64 arch_atomic64_sub_if_p=
ositive(atomic64_t *v, s64 offs
> >         long rc;
> >
> >       __asm__ __volatile__ (
> > -             "0:     lr.d     %[p],  %[c]\n"
> > +             "0:     lr.d.aq  %[p],  %[c]\n"
> >               "       sub      %[rc], %[p], %[o]\n"
> >               "       bltz     %[rc], 1f\n"
> >               "       sc.d.rl  %[rc], %[rc], %[c]\n"
> >               "       bnez     %[rc], 0b\n"
> > -             "       fence    rw, rw\n"
> >               "1:\n"
> >               : [p]"=3D&r" (prev), [rc]"=3D&r" (rc), [c]"+A" (v->counte=
r)
> >               : [o]"r" (offset)
>
> My comment for arch_atomic_sub_if_positive() applies here too.
>
>
> [...]
>
> > @@ -309,11 +301,10 @@
> >       switch (size) {                                                 \
> >       case 4:                                                         \
> >               __asm__ __volatile__ (                                  \
> > -                     "0:     lr.w %0, %2\n"                          \
> > +                     "0:     lr.w.aq %0, %2\n"                       \
> >                       "       bne  %0, %z3, 1f\n"                     \
> >                       "       sc.w.rl %1, %z4, %2\n"                  \
> >                       "       bnez %1, 0b\n"                          \
> > -                     "       fence rw, rw\n"                         \
> >                       "1:\n"                                          \
> >                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> >                       : "rJ" ((long)__old), "rJ" (__new)              \
> > @@ -321,11 +312,10 @@
> >               break;                                                  \
> >       case 8:                                                         \
> >               __asm__ __volatile__ (                                  \
> > -                     "0:     lr.d %0, %2\n"                          \
> > +                     "0:     lr.d.aq %0, %2\n"                       \
> >                       "       bne %0, %z3, 1f\n"                      \
> >                       "       sc.d.rl %1, %z4, %2\n"                  \
> >                       "       bnez %1, 0b\n"                          \
> > -                     "       fence rw, rw\n"                         \
> >                       "1:\n"                                          \
> >                       : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__ptr) =
   \
> >                       : "rJ" (__old), "rJ" (__new)                    \
>
> I don't have enough context to say for sure, but I suspect these are expe=
cting
> FULL ordering too, and would be broken, as above.
>
> Thanks,
> Mark.



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
