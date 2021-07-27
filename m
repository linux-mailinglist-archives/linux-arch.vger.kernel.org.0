Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC9A3D6B6A
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 03:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhG0A13 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 20:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229528AbhG0A13 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 20:27:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A7E460F8F
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 01:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627348077;
        bh=41MWwNXUL2Gdjm4CsHGlCKmAJMzj5rNxn/RIhyJ8das=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C4oX9JU9OdTLo8PDg38DbYB42swTjXA3qLvz0nG3i59Fbd2bY9RvENUihYn3S4Nu6
         p0Px+aIj3qLTQAZlWsWQfeaj8IYRrC2HnpvO6Qb52C+sXa++3DzeNJzgWPWc/T4Ixf
         GRfxYzsPnymtf74Gp709xEd7x7zgMK++4J1JWzYqPDbW+J9sVebJ2cMpjy4Ci7f0s1
         s9mo+uKZm4w0JGp8vGO3f7Dvidsob4bEj/EbYzo54LDBRWPMF48H7KPDT/HpZbvTax
         wyKj/dtEyWOA2cANyxNsktr03482tc3/fNDe76nwFoXGNPDf7qdjk8bX1oKlEgVScd
         rnDwWcTRyYuFA==
Received: by mail-lf1-f44.google.com with SMTP id a26so18704801lfr.11
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 18:07:57 -0700 (PDT)
X-Gm-Message-State: AOAM533b98cNF7Hh8rP+GshSXg6DbxUbMGmteNJOQyoihfU/96nMD682
        Y6fcJD8mmo9ZYi1ZnQxaYz2S9+9DlF3TnGzxqoQ=
X-Google-Smtp-Source: ABdhPJxlkME5vu+xC4Bvu/Ddrpb56iYbr/I4GQHQDnQvbAsBu2nRdEyNQYPObqfX9aaqQPBH6f9WOppsLbqQTL1NHHM=
X-Received: by 2002:a19:c3c1:: with SMTP id t184mr10361602lff.41.1627348075609;
 Mon, 26 Jul 2021 18:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux> <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
In-Reply-To: <YP7q5GBweaeWgvcs@boqun-archlinux>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 27 Jul 2021 09:07:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSZdi_U6we4K7Y0M9XsL++Dppdc4jh-UZFxHR+dqBq6fQ@mail.gmail.com>
Message-ID: <CAJF2gTSZdi_U6we4K7Y0M9XsL++Dppdc4jh-UZFxHR+dqBq6fQ@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Huacai Chen <chenhuacai@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 1:03 AM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Tue, Jul 27, 2021 at 12:41:34AM +0800, Guo Ren wrote:
> > On Mon, Jul 26, 2021 at 6:39 PM Boqun Feng <boqun.feng@gmail.com> wrote=
:
> > >
> > > On Mon, Jul 26, 2021 at 04:56:49PM +0800, Huacai Chen wrote:
> > > > Hi, Geert,
> > > >
> > > > On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> > > > >
> > > > > Hi Huacai,
> > > > >
> > > > > On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.=
cn> wrote:
> > > > > > Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which me=
ans arch
> > > > > > has hardware sub-word xchg/cmpxchg support. This option will be=
 used as
> > > > > > an indicator to select the bit-field definition in the qspinloc=
k data
> > > > > > structure.
> > > > > >
> > > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > > --- a/arch/Kconfig
> > > > > > +++ b/arch/Kconfig
> > > > > > @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
> > > > > >           An architecture should select this when it can succes=
sfully
> > > > > >           build and run with CONFIG_FORTIFY_SOURCE.
> > > > > >
> > > > > > +# Select if arch has hardware sub-word xchg/cmpxchg support
> > > > > > +config ARCH_HAS_HW_XCHG_SMALL
> > > > >
> > > > > What do you mean by "hardware"?
> > > > > Does a software fallback count?
> > > > This new option is supposed as an indicator to select bit-field
> > > > definition of qspinlock, software fallback is not helpful in this
> > > > case.
> > > >
> > >
> > > I don't think this is true. IIUC, the rationale of the config is that
> > > for some architectures, since the architectural cmpxchg doesn't provi=
de
> > > forward-progress guarantee then using cmpxchg of machine-word to
> > > implement xchg{8,16}() may cause livelock, therefore these architectu=
res
> > > don't want to provide xchg{8,16}(), as a result they cannot work with
> > > qspinlock when _Q_PENDING_BITS is 8.
> > >
> > > So as long as an architecture can provide and has already provided an
> > > implementation of xchg{8,16}() which guarantee forward-progress (even
> > > though the implementation is using a machine-word size cmpxchg), the
> > > architecture doesn't need to select ARCH_HAS_HW_XCHG_SMALL.
> > Seems only atomic could provide forward progress, isn't it? And lr/sc
> > couldn't implement xchg/cmpxchg primitive properly.
> >
>
> I'm missing you point here, a) ll/sc can provide forward progress and b)
> ll/sc instructions are used to implement xchg/cmpxchg (see ARM64 and
> PPC).
I don't think arm64 could provide fwd guarantee with ll/sc, otherwise,
they wouldn't add ARM64_HAS_LSE_ATOMICS for large systems.

>
> > How to make CPU =C3=A7  "load + cmpxchg" forward-progress? Fusion
> > these instructions and lock the snoop channel?
> > Maybe hardware guys would think that it's easier to implement cas +
> > dcas + amo(short & byte).
> >
>
> Please note that if _Q_PENDING_BITS =3D=3D 1, then the xchg_tail() is
> implemented as a "load + cmpxchg", so if "load + cmpxchg" implementation
> of xchg16() doesn't provide forward-progress in an architecture, neither
> does xchg_tail().
That's the problem of "_Q_PENDING_BITS =3D=3D 1", no hardware could
provide "load + ALU + cas" fwd guarantee!

A simple example, atomic a++:
c =3D READ_ONCE(g_value);
new =3D c + 1;
while ((old =3D cmpxchg(&g_value, c, new)) !=3D c) {
    c =3D old;
    new =3D c + 1;
}

Q: When it runs on CPU0(500Mhz) & CPU1(2Ghz) in one SMP, how do we
prevent CPU1 from starving CPU0?
A: I think the answer is using AMO-add instruction:
atomic_add(1, &g_value);
(If the arch hasn't atomic instructions and using cmpxchg or lr/sc
implement atomic, it's the same problem.)

>
> Regards,
> Boqun
>
> > >
> > > Regards,
> > > Boqun
> > >
> > > > >
> > > > > > --- a/arch/m68k/Kconfig
> > > > > > +++ b/arch/m68k/Kconfig
> > > > > > @@ -5,6 +5,7 @@ config M68K
> > > > > >         select ARCH_32BIT_OFF_T
> > > > > >         select ARCH_HAS_BINFMT_FLAT
> > > > > >         select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && =
!COLDFIRE
> > > > > > +       select ARCH_HAS_HW_XCHG_SMALL
> > > > >
> > > > > M68k CPUs which support the CAS (Compare And Set) instruction do
> > > > > support this on 8-bit, 16-bit, and 32-bit quantities.
> > > > > M68k CPUs which lack CAS use a software implementation, which
> > > > > supports the same quantities.
> > > > >
> > > > > As CAS is used only if CONFIG_RMW_INSNS=3Dy, perhaps this needs
> > > > > a dependency?
> > > > OK, I think this dependency is needed.
> > > >
> > > > Huacai
> > > >
> > > > >
> > > > >    select ARCH_HAS_HW_XCHG_SMALL if RMW_INSNS
> > > > >
> > > > > Gr{oetje,eeting}s,
> > > > >
> > > > >                         Geert
> > > > >
> > > > > --
> > > > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@=
linux-m68k.org
> > > > >
> > > > > In personal conversations with technical people, I call myself a =
hacker. But
> > > > > when I'm talking to journalists I just say "programmer" or someth=
ing like that.
> > > > >                                 -- Linus Torvalds
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
