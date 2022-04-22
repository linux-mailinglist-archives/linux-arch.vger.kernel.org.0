Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C170150AE67
	for <lists+linux-arch@lfdr.de>; Fri, 22 Apr 2022 05:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242898AbiDVDOQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Apr 2022 23:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242102AbiDVDOP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Apr 2022 23:14:15 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAC14CD59;
        Thu, 21 Apr 2022 20:11:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d14so4698109qtw.5;
        Thu, 21 Apr 2022 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B+l4XElmjbgWuxsFxm95+PlAoY+lFpSuxuxo0rKhTgE=;
        b=gBqOzKxDrbfKga/SiNfyIJuZe8Nl5IMEUtFjjUUynK0ykrPF2JEbcju4SvM1kv0uY9
         RYx7+lzLWijIqblQ5l2ikg0xFW/QAIi/nlrtMj5T3F7Uv++i0AtySWtD2RCYSQx1sput
         Dx+aOFRyS+pSJpVkL14nB6K12a7sJwNUDjIMCYpzSe/XdB7uDpNDHsKCELyZshW3XC8h
         A9h3vcTpCn7MWWpQE1R9SR9bwYMyn9hT/Tasea3gOymeWCLv8q8+k2RcgNmxu8/0Jmmi
         pFP5V26L8Qs5ELuW6E3J7LuUzxrduQh5JNTLvuUHNQt64lBa0bhBTfIuxFG9ApkrdHZs
         i7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B+l4XElmjbgWuxsFxm95+PlAoY+lFpSuxuxo0rKhTgE=;
        b=WI9xzr75tv0fgLJP6j/ik0FM+ITVWvfo92/x8EQUUEVPi5jf9xCr9JdAvqCBx8gS9L
         fp78XpUGm6DGq6DCAbAYR3ZQNvoL5HFTS4v6YZJtlkB0sgndBlwksYJkzQvwKPBM9l+9
         Map3GcmGhLDQClFIu9eLagN93LFlInZa2N3Rs3u3PkZaH3cJyHOH681DtroJD48KFl6o
         17beWFAJUduYtkdk6CJajxRGxl39KH0UF9iTwMwVQCA9lGcU6ApSEnwAOe0N0eCjmv30
         Ct1ZPq7lzyIiHcWhhzKh5a8axjZJN9xE7Q470Xo4F0LAFzDMLFi0wXjrmmlwj8ljWEzD
         Go5A==
X-Gm-Message-State: AOAM531kGBEjEFaFe+LknW+0bovY52nLvZ5J6aZFT1idXT9dzVvZWdcu
        BTD1LsmWDgjv5tIPPrmNllM=
X-Google-Smtp-Source: ABdhPJwlkAbtjOlhiVSEylVzDGdf4pUfSfgmWXQjp7WN0Fm0lxhjPQxGkKy89+QDEnTrRMsEnPfw4w==
X-Received: by 2002:ac8:59d0:0:b0:2f1:fc58:2fce with SMTP id f16-20020ac859d0000000b002f1fc582fcemr1823753qtf.290.1650597081984;
        Thu, 21 Apr 2022 20:11:21 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 15-20020ac8594f000000b002f200ea2518sm540355qtz.59.2022.04.21.20.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 20:11:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id C3A1227C0054;
        Thu, 21 Apr 2022 23:11:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 21 Apr 2022 23:11:19 -0400
X-ME-Sender: <xms:1xxiYtL2oZFzOo-L4gjymn_Pb-zEZjsJW1PtnCMDgA4W7qTZtQLKDg>
    <xme:1xxiYpLfRHOZqX2F_lW5Hfusyoy_wV4x3aZDB5BfQy-TuOQDIGu0ABeAKQiAdokDK
    CqxZEtdf1XDT501_Q>
X-ME-Received: <xmr:1xxiYlu1KKN45jBRoqGIxS0T0J7w6m2d0GmvrZ7Hu7BgtMEnQPGy2435LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdekhfduveeitdehueehfeekgfduhfetvdefhffhteejhfelvddtgefftddu
    feffnecuffhomhgrihhnpehthhgvrdgrqhdpkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhm
    thhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvd
    dqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:1xxiYuZlDGrPfCDQVPQpS-uzAy8YVytlor6p_kP_lbruApLR2hGeTQ>
    <xmx:1xxiYkbLH-vDNMI5pR0ZE1xbUrmkufQZIPuy-C2drDD6kUo1z82vCg>
    <xmx:1xxiYiANmUbmOySf3dM2n_bym1vggzAJ5P5KlYF9XomDJPHpy8vHlw>
    <xmx:1xxiYgQ-gV95yQI_siMc9VbsmiYIo0aKgczUG_o13j7kJdm9grstXg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Apr 2022 23:11:16 -0400 (EDT)
Date:   Fri, 22 Apr 2022 11:11:04 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Dan Lustig <dlustig@nvidia.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V2 0/3] riscv: atomic: Optimize AMO instructions usage
Message-ID: <YmIcyAIXG+JLnU7e@tardis>
References: <YlbwOG46mCR8Q5tJ@tardis>
 <CAJF2gTRws6RqKmJHBdKsycWSkFgYna_MocJ+qp3Z9r1v7mQzsg@mail.gmail.com>
 <Ylt6zqPgimmKpJzg@tardis>
 <CAJF2gTTZnBh_z31VK81cYiBrTt5NRVpSahoPh35Zo4Ns5hCv7A@mail.gmail.com>
 <3f7dd397-2ccd-dfa3-a0ec-dcce6cbc0476@nvidia.com>
 <CAJF2gTQzPsM0X-gib3V0EYYU=weMFXMQZCEbru9y+dDbV+9eXQ@mail.gmail.com>
 <41e01514-74ca-84f2-f5cc-2645c444fd8e@nvidia.com>
 <CAJF2gTSD1CsMf2uFXbv4qekh72r6iY-0BVaBwA8Ntu0L6WcEPA@mail.gmail.com>
 <YmHhEY56jYXh68Q/@tardis>
 <CAJF2gTS2pqgb+0b3ug2wSEXkkbOb=jN2-2QzahZf0n2=ihESOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rFNHEmSRQ446Sd/1"
Content-Disposition: inline
In-Reply-To: <CAJF2gTS2pqgb+0b3ug2wSEXkkbOb=jN2-2QzahZf0n2=ihESOg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--rFNHEmSRQ446Sd/1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2022 at 09:56:21AM +0800, Guo Ren wrote:
> On Fri, Apr 22, 2022 at 6:56 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Thu, Apr 21, 2022 at 05:39:09PM +0800, Guo Ren wrote:
> > > Hi Dan,
> > >
> > > On Thu, Apr 21, 2022 at 1:03 AM Dan Lustig <dlustig@nvidia.com> wrote:
> > > >
> > > > On 4/20/2022 1:33 AM, Guo Ren wrote:
> > > > > Thx Dan,
> > > > >
> > > > > On Wed, Apr 20, 2022 at 1:12 AM Dan Lustig <dlustig@nvidia.com> w=
rote:
> > > > >>
> > > > >> On 4/17/2022 12:51 AM, Guo Ren wrote:
> > > > >>> Hi Boqun & Andrea,
> > > > >>>
> > > > >>> On Sun, Apr 17, 2022 at 10:26 AM Boqun Feng <boqun.feng@gmail.c=
om> wrote:
> > > > >>>>
> > > > >>>> On Sun, Apr 17, 2022 at 12:49:44AM +0800, Guo Ren wrote:
> > > > >>>> [...]
> > > > >>>>>
> > > > >>>>> If both the aq and rl bits are set, the atomic memory operati=
on is
> > > > >>>>> sequentially consistent and cannot be observed to happen befo=
re any
> > > > >>>>> earlier memory operations or after any later memory operation=
s in the
> > > > >>>>> same RISC-V hart and to the same address domain.
> > > > >>>>>                 "0:     lr.w     %[p],  %[c]\n"
> > > > >>>>>                 "       sub      %[rc], %[p], %[o]\n"
> > > > >>>>>                 "       bltz     %[rc], 1f\n".
> > > > >>>>> -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > > >>>>> +               "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > > > >>>>>                 "       bnez     %[rc], 0b\n"
> > > > >>>>> -               "       fence    rw, rw\n"
> > > > >>>>>                 "1:\n"
> > > > >>>>> So .rl + fence rw, rw is over constraints, only using sc.w.aq=
rl is more proper.
> > > > >>>>>
> > > > >>>>
> > > > >>>> Can .aqrl order memory accesses before and after it (not again=
st itself,
> > > > >>>> against each other), i.e. act as a full memory barrier? For ex=
ample, can
> > > > >>> From the RVWMO spec description, the .aqrl annotation appends t=
he same
> > > > >>> effect with "fence rw, rw" to the AMO instruction, so it's RCsc.
> > > > >>>
> > > > >>> Not only .aqrl, and I think the below also could be an RCsc when
> > > > >>> sc.w.aq is executed:
> > > > >>> A: Pre-Access
> > > > >>> B: lr.w.rl ADDR-0
> > > > >>> ...
> > > > >>> C: sc.w.aq ADDR-0
> > > > >>> D: Post-Acess
> > > > >>> Because sc.w.aq has overlap address & data dependency on lr.w.r=
l, the
> > > > >>> global memory order should be A->B->C->D when sc.w.aq is execut=
ed. For
> > > > >>> the amoswap
> > > > >>
> > > > >> These opcodes aren't actually meaningful, unfortunately.
> > > > >>
> > > > >> Quoting the ISA manual chapter 10.2: "Software should not set th=
e rl bit
> > > > >> on an LR instruction unless the aq bit is also set, nor should s=
oftware
> > > > >> set the aq bit on an SC instruction unless the rl bit is also se=
t."
> > > > > 1. Oh, I've missed the behind half of the ISA manual. But why can=
't we
> > > > > utilize lr.rl & sc.aq in software programming to guarantee the
> > > > > sequence?
> > > >
> > > > lr.aq and sc.rl map more naturally to hardware than lr.rl and sc.aq.
> > > > Plus, they just aren't common operations to begin with, e.g., there
> > > > is no smp_store_acquire() or smp_load_release(), nor are there
> > > > equivalents in C/C++ atomics.
> > > First, thx for pointing out that my patch violates the rules defined
> > > in the ISA manual. I've abandoned these parts in v3.
> > >
> > > It's easy to let hw support lr.rl & sc.aq (eg: our hardware supports
> > > them). I agree there are no equivalents in C/C++ atomics. But they are
> > > useful for LR/SC pairs to implement atomic_acqurie/release semantics.
> > > Compare below:
> > > A): fence rw, r; lr
> > > B): lr.rl
> > > The A has another "fence ,r" effect in semantics, it's over commit
> > > from a software design view.
> > >
> > > ps: Current definition has problems:
> > > #define RISCV_ACQUIRE_BARRIER           "\tfence r , rw\n"
> > > #define RISCV_RELEASE_BARRIER           "\tfence rw,  w\n"
> > >
> > > #define __cmpxchg_release(ptr, old, new, size)                       =
   \
> > > ...
> > >                 __asm__ __volatile__ (                               =
   \
> > >                         RISCV_RELEASE_BARRIER                        =
   \
> > >                         "0:     lr.w %0, %2\n"                       =
   \
> > >
> > > That means "fence rw, w" can't prevent lr.w beyond the fence, we need
> > > a "fence.rw. r" here. Here is the Fixup patch which I'm preparing:
> > >
> >
> > That's not true. Note that RELEASE semantics only applies to the
> > write/store part of a read-modify-write atomic, similarly, ACQUIRE only
> I just want to point out that the "atomic" mentioned here is only for
> RISC-V LR/SC AMO instructions. It has been clarified to tread AMO
> instruction as the whole part for other AMO instructions.
>=20
>      - .aq:   If the aq bit is set, then no later memory operations
>               in this RISC-V hart can be observed to take place
>               before the AMO.
>      - .rl:   If the rl bit is set, then other RISC-V harts will not
>               observe the AMO before memory accesses preceding the
>               AMO in this RISC-V hart.
>      - .aqrl: Setting both the aq and the rl bit on an AMO makes the
>               sequence sequentially consistent, meaning that it cannot
>               be reordered with earlier or later memory operations
>               from the same hart.
>=20
> > applies to the read/load part. For example, the following litmus test
> > can observe the exists clause being true.
> Thx for pointing out, that means changing "fence rw, w" to "fence rw.
> r" is more strict and it would lower performance, right?

Yes, I think it's more strict but honestly I don't know the performance
impact ;-)

>=20
> >
> >         {}
> >
> >         P0(int *x, int *y)
> >         {
> >                 int r0;
> >                 int r1;
> >
> >                 r0 =3D cmpxchg_acquire(x, 0, 1);
> >                 r1 =3D READ_ONCE(*y);
> Oh, READ_ONCE could be beyond the write/store part of cmpxchg_acquire,
> right? We shouldn't prevent it.

Right, the reordering is allowed by the API of Linux atomics and you
don't have to prevent it.

Regards,
Boqun

>=20
> >         }
> >
> >         P1(int *x, int *y)
> >         {
> >                 int r0;
> >
> >                 WRITE_ONCE(*y, 1);
> >                 smp_mb();
> >                 r0 =3D READ_ONCE(*x);
> >         }
> >
> >         exists (0:r0=3D0 /\ 0:r1=3D0 /\ 1:r0=3D0)
> >
> > Regards,
> > Boqun
> >
> > > From 14c93aca0c3b10cf134791cf491b459972a36ec4 Mon Sep 17 00:00:00 2001
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > > Date: Thu, 21 Apr 2022 16:44:48 +0800
> > > Subject: [PATCH] riscv: atomic: Fixup wrong __atomic_acquire/release_=
fence
> > >  implementation
> > >
> > > Current RISCV_ACQUIRE/RELEASE_BARRIER is for spin_lock not atomic.
> > >
> > > __cmpxchg_release(ptr, old, new, size)
> > > ...
> > >         __asm__ __volatile__ (
> > >                         RISCV_RELEASE_BARRIER
> > >                         "0:     lr.w %0, %2\n"
> > >
> > > The "fence rw, w -> lr.w" is invalid and lr would beyond fence, so
> > > we need "fence rw, r -> lr.w" here. Atomic acquire is the same.
> > >
> > > Fixes: 0123f4d76ca6 ("riscv/spinlock: Strengthen implementations with=
 fences")
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Andrea Parri <parri.andrea@gmail.com>
> > > Cc: Dan Lustig <dlustig@nvidia.com>
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  arch/riscv/include/asm/atomic.h  | 4 ++--
> > >  arch/riscv/include/asm/cmpxchg.h | 8 ++++----
> > >  arch/riscv/include/asm/fence.h   | 4 ++++
> > >  3 files changed, 10 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm=
/atomic.h
> > > index aef8aa9ac4f4..7cd66eba6ec3 100644
> > > --- a/arch/riscv/include/asm/atomic.h
> > > +++ b/arch/riscv/include/asm/atomic.h
> > > @@ -20,10 +20,10 @@
> > >  #include <asm/barrier.h>
> > >
> > >  #define __atomic_acquire_fence()                                    =
   \
> > > -       __asm__ __volatile__(RISCV_ACQUIRE_BARRIER "" ::: "memory")
> > > +       __asm__ __volatile__(RISCV_ATOMIC_ACQUIRE_BARRIER "":::"memor=
y")
> > >
> > >  #define __atomic_release_fence()                                    =
   \
> > > -       __asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
> > > +       __asm__ __volatile__(RISCV_ATOMIC_RELEASE_BARRIER"" ::: "memo=
ry");
> > >
> > >  static __always_inline int arch_atomic_read(const atomic_t *v)
> > >  {
> > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/as=
m/cmpxchg.h
> > > index 9269fceb86e0..605edc2fca3b 100644
> > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > @@ -217,7 +217,7 @@
> > >                         "       bne  %0, %z3, 1f\n"                  =
   \
> > >                         "       sc.w %1, %z4, %2\n"                  =
   \
> > >                         "       bnez %1, 0b\n"                       =
   \
> > > -                       RISCV_ACQUIRE_BARRIER                        =
   \
> > > +                       RISCV_ATOMIC_ACQUIRE_BARRIER                 =
   \
> > >                         "1:\n"                                       =
   \
> > >                         : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__p=
tr)    \
> > >                         : "rJ" ((long)__old), "rJ" (__new)           =
   \
> > > @@ -229,7 +229,7 @@
> > >                         "       bne %0, %z3, 1f\n"                   =
   \
> > >                         "       sc.d %1, %z4, %2\n"                  =
   \
> > >                         "       bnez %1, 0b\n"                       =
   \
> > > -                       RISCV_ACQUIRE_BARRIER                        =
   \
> > > +                       RISCV_ATOMIC_ACQUIRE_BARRIER                 =
   \
> > >                         "1:\n"                                       =
   \
> > >                         : "=3D&r" (__ret), "=3D&r" (__rc), "+A" (*__p=
tr)    \
> > >                         : "rJ" (__old), "rJ" (__new)                 =
   \
> > > @@ -259,7 +259,7 @@
> > >         switch (size) {                                              =
   \
> > >         case 4:                                                      =
   \
> > >                 __asm__ __volatile__ (                               =
   \
> > > -                       RISCV_RELEASE_BARRIER                        =
   \
> > > +                       RISCV_ATOMIC_RELEASE_BARRIER                 =
   \
> > >                         "0:     lr.w %0, %2\n"                       =
   \
> > >                         "       bne  %0, %z3, 1f\n"                  =
   \
> > >                         "       sc.w %1, %z4, %2\n"                  =
   \
> > > @@ -271,7 +271,7 @@
> > >                 break;                                               =
   \
> > >         case 8:                                                      =
   \
> > >                 __asm__ __volatile__ (                               =
   \
> > > -                       RISCV_RELEASE_BARRIER                        =
   \
> > > +                       RISCV_ATOMIC_RELEASE_BARRIER                 =
   \
> > >                         "0:     lr.d %0, %2\n"                       =
   \
> > >                         "       bne %0, %z3, 1f\n"                   =
   \
> > >                         "       sc.d %1, %z4, %2\n"                  =
   \
> > > diff --git a/arch/riscv/include/asm/fence.h b/arch/riscv/include/asm/=
fence.h
> > > index 2b443a3a487f..4e446d64f04f 100644
> > > --- a/arch/riscv/include/asm/fence.h
> > > +++ b/arch/riscv/include/asm/fence.h
> > > @@ -4,9 +4,13 @@
> > >  #ifdef CONFIG_SMP
> > >  #define RISCV_ACQUIRE_BARRIER          "\tfence r , rw\n"
> > >  #define RISCV_RELEASE_BARRIER          "\tfence rw,  w\n"
> > > +#define RISCV_ATOMIC_ACQUIRE_BARRIER   "\tfence w , rw\n"
> > > +#define RISCV_ATOMIC_RELEASE_BARRIER   "\tfence rw,  r\n"
> > >  #else
> > >  #define RISCV_ACQUIRE_BARRIER
> > >  #define RISCV_RELEASE_BARRIER
> > > +#define RISCV_ATOMIC_ACQUIRE_BARRIER
> > > +#define RISCV_ATOMIC_RELEASE_BARRIER
> > >  #endif
> > >
> > >  #endif /* _ASM_RISCV_FENCE_H */
> > >
> > >
> > > >
> > > > > 2. Using .aqrl to replace the fence rw, rw is okay to ISA manual,
> > > > > right? And reducing a fence instruction to gain better performanc=
e:
> > > > >                 "0:     lr.w     %[p],  %[c]\n"
> > > > >                  "       sub      %[rc], %[p], %[o]\n"
> > > > >                  "       bltz     %[rc], 1f\n".
> > > > >  -               "       sc.w.rl  %[rc], %[rc], %[c]\n"
> > > > >  +              "       sc.w.aqrl %[rc], %[rc], %[c]\n"
> > > > >                  "       bnez     %[rc], 0b\n"
> > > > >  -               "       fence    rw, rw\n"
> > > >
> > > > Yes, using .aqrl is valid.
> > > Thx and I think the below is also valid, right?
> > >
> > > -                       RISCV_RELEASE_BARRIER                        =
   \
> > > -                       "       amoswap.w %0, %2, %1\n"              =
   \
> > > +                       "       amoswap.w.rl %0, %2, %1\n"           =
   \
> > >
> > > -                       "       amoswap.d %0, %2, %1\n"              =
   \
> > > -                       RISCV_ACQUIRE_BARRIER                        =
   \
> > > +                       "       amoswap.d.aq %0, %2, %1\n"           =
   \
> > >
> > > >
> > > > Dan
> > > >
> > > > >>
> > > > >> Dan
> > > > >>
> > > > >>> The purpose of the whole patchset is to reduce the usage of
> > > > >>> independent fence rw, rw instructions, and maximize the usage o=
f the
> > > > >>> .aq/.rl/.aqrl aonntation of RISC-V.
> > > > >>>
> > > > >>>                 __asm__ __volatile__ (                         =
         \
> > > > >>>                         "0:     lr.w %0, %2\n"                 =
         \
> > > > >>>                         "       bne  %0, %z3, 1f\n"            =
         \
> > > > >>>                         "       sc.w.rl %1, %z4, %2\n"         =
         \
> > > > >>>                         "       bnez %1, 0b\n"                 =
         \
> > > > >>>                         "       fence rw, rw\n"                =
         \
> > > > >>>                         "1:\n"                                 =
         \
> > > > >>>
> > > > >>>> we end up with u =3D=3D 1, v =3D=3D 1, r1 on P0 is 0 and r1 on=
 P1 is 0, for the
> > > > >>>> following litmus test?
> > > > >>>>
> > > > >>>>     C lr-sc-aqrl-pair-vs-full-barrier
> > > > >>>>
> > > > >>>>     {}
> > > > >>>>
> > > > >>>>     P0(int *x, int *y, atomic_t *u)
> > > > >>>>     {
> > > > >>>>             int r0;
> > > > >>>>             int r1;
> > > > >>>>
> > > > >>>>             WRITE_ONCE(*x, 1);
> > > > >>>>             r0 =3D atomic_cmpxchg(u, 0, 1);
> > > > >>>>             r1 =3D READ_ONCE(*y);
> > > > >>>>     }
> > > > >>>>
> > > > >>>>     P1(int *x, int *y, atomic_t *v)
> > > > >>>>     {
> > > > >>>>             int r0;
> > > > >>>>             int r1;
> > > > >>>>
> > > > >>>>             WRITE_ONCE(*y, 1);
> > > > >>>>             r0 =3D atomic_cmpxchg(v, 0, 1);
> > > > >>>>             r1 =3D READ_ONCE(*x);
> > > > >>>>     }
> > > > >>>>
> > > > >>>>     exists (u=3D1 /\ v=3D1 /\ 0:r1=3D0 /\ 1:r1=3D0)
> > > > >>> I think my patchset won't affect the above sequence guarantee. =
Current
> > > > >>> RISC-V implementation only gives RCsc when the original value i=
s the
> > > > >>> same at least once. So I prefer RISC-V cmpxchg should be:
> > > > >>>
> > > > >>>
> > > > >>> -                       "0:     lr.w %0, %2\n"                 =
         \
> > > > >>> +                      "0:     lr.w.rl %0, %2\n"               =
           \
> > > > >>>                         "       bne  %0, %z3, 1f\n"            =
         \
> > > > >>>                         "       sc.w.rl %1, %z4, %2\n"         =
         \
> > > > >>>                         "       bnez %1, 0b\n"                 =
         \
> > > > >>> -                       "       fence rw, rw\n"                =
         \
> > > > >>>                         "1:\n"                                 =
         \
> > > > >>> +                        "       fence w, rw\n"                =
    \
> > > > >>>
> > > > >>> To give an unconditional RSsc for atomic_cmpxchg.
> > > > >>>
> > > > >>>>
> > > > >>>> Regards,
> > > > >>>> Boqun
> > > > >>>
> > > > >>>
> > > > >>>
> > > > >
> > > > >
> > > > >
> > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> > > ML: https://lore.kernel.org/linux-csky/
>=20
>=20
>=20
> --=20
> Best Regards
>  Guo Ren
>=20
> ML: https://lore.kernel.org/linux-csky/

--rFNHEmSRQ446Sd/1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAmJiHMMACgkQSXnow7UH
+rj20Qf+OggnPum9nhsiUtP9QYrFtFUxUddPq/Wk4p2iPJp+7z6/ERpjjgf7D2+l
Mj1XBUG3mjUQHXCrWdannEr54sUji3cfmLMJLA8rIQEGXCf8Lkj0+rP2z4mm3X4L
+BObGoOBepNjK0NjgnuDX6aF0q3SrZOMLPu0AhmgZsmHfxdw+biMkgBB+HkPM556
F9Z1KtoPdb5bFqLxRm34C/QLx2wH5WyEEnX98Dtl5EwbfzpR7Ya4Syr+hmG8CvSO
opad0eDMpLTLcOVsvHlSdn5CzlAicRh6AnC38PK6eint8oVd4tvBvkGykOT/QKlB
DyMksQ755yri5W5h60S0AwbUXLL45w==
=lOW+
-----END PGP SIGNATURE-----

--rFNHEmSRQ446Sd/1--
