Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707EE3D64C5
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 18:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhGZQBl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 12:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231646AbhGZQBS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 12:01:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8059960F6B
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 16:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627317707;
        bh=spfQSbIbG/dEabyzVnNh6etSmGofBgaYcYQY6DeO7tI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b3Q7scC+FJ9D/ASXNtUZUn0SUd9hLVP2URhpHrhB0lRjR9P/W2oYtZVYQQUokPDhG
         eawZqmgDN3mf8GGtdCwtiXQ6B6YWM/mr6dIvgX2XD0pc3Og56U8WG06xmNpi82//e3
         l83XtITUZxCgPxkPm0Ay+Q6HnGSOffEYjWbIh2iR5OgH+EDlBKgmhJ+lxpAafSJ1te
         5nG7CA+ScjOzh8G9TkY0GWy0v8S1VI2XXifn8rUJr9RD4OMFPeMe4HlPAivuZOevit
         Q9y15VxBWeww6YGJ+dgC3LMdB4yiKKYvvfpNdw2EtH66kjUuGBS8YXfWtPaslQg7zc
         9cYSUL9UvxEXQ==
Received: by mail-lf1-f41.google.com with SMTP id d17so16687436lfv.0
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 09:41:47 -0700 (PDT)
X-Gm-Message-State: AOAM5323h531m886Z2UZxqHcc1m++isrbsIV0mLa8FGefDmdMj6p15zB
        5KmZCG+CgJpSEJh44jKswLoL1ayFPPo71HWG1B0=
X-Google-Smtp-Source: ABdhPJz57z35Lc2sghQK1ixuPhEJMOVnDcwzWtrXAlFzBDgzpytyZViu7HJoUXgiCrjMW52I7qBDrL6DN4Fk58uvpOs=
X-Received: by 2002:a19:c3c1:: with SMTP id t184mr9137646lff.41.1627317705883;
 Mon, 26 Jul 2021 09:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com> <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
In-Reply-To: <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 27 Jul 2021 00:41:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
Message-ID: <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
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
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 26, 2021 at 6:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Mon, Jul 26, 2021 at 04:56:49PM +0800, Huacai Chen wrote:
> > Hi, Geert,
> >
> > On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >
> > > Hi Huacai,
> > >
> > > On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
> > > > has hardware sub-word xchg/cmpxchg support. This option will be used as
> > > > an indicator to select the bit-field definition in the qspinlock data
> > > > structure.
> > > >
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/arch/Kconfig
> > > > +++ b/arch/Kconfig
> > > > @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
> > > >           An architecture should select this when it can successfully
> > > >           build and run with CONFIG_FORTIFY_SOURCE.
> > > >
> > > > +# Select if arch has hardware sub-word xchg/cmpxchg support
> > > > +config ARCH_HAS_HW_XCHG_SMALL
> > >
> > > What do you mean by "hardware"?
> > > Does a software fallback count?
> > This new option is supposed as an indicator to select bit-field
> > definition of qspinlock, software fallback is not helpful in this
> > case.
> >
>
> I don't think this is true. IIUC, the rationale of the config is that
> for some architectures, since the architectural cmpxchg doesn't provide
> forward-progress guarantee then using cmpxchg of machine-word to
> implement xchg{8,16}() may cause livelock, therefore these architectures
> don't want to provide xchg{8,16}(), as a result they cannot work with
> qspinlock when _Q_PENDING_BITS is 8.
>
> So as long as an architecture can provide and has already provided an
> implementation of xchg{8,16}() which guarantee forward-progress (even
> though the implementation is using a machine-word size cmpxchg), the
> architecture doesn't need to select ARCH_HAS_HW_XCHG_SMALL.
Seems only atomic could provide forward progress, isn't it? And lr/sc
couldn't implement xchg/cmpxchg primitive properly.

How to make CPU guarantee  "load + cmpxchg" forward-progress? Fusion
these instructions and lock the snoop channel?
Maybe hardware guys would think that it's easier to implement cas +
dcas + amo(short & byte).

>
> Regards,
> Boqun
>
> > >
> > > > --- a/arch/m68k/Kconfig
> > > > +++ b/arch/m68k/Kconfig
> > > > @@ -5,6 +5,7 @@ config M68K
> > > >         select ARCH_32BIT_OFF_T
> > > >         select ARCH_HAS_BINFMT_FLAT
> > > >         select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
> > > > +       select ARCH_HAS_HW_XCHG_SMALL
> > >
> > > M68k CPUs which support the CAS (Compare And Set) instruction do
> > > support this on 8-bit, 16-bit, and 32-bit quantities.
> > > M68k CPUs which lack CAS use a software implementation, which
> > > supports the same quantities.
> > >
> > > As CAS is used only if CONFIG_RMW_INSNS=y, perhaps this needs
> > > a dependency?
> > OK, I think this dependency is needed.
> >
> > Huacai
> >
> > >
> > >    select ARCH_HAS_HW_XCHG_SMALL if RMW_INSNS
> > >
> > > Gr{oetje,eeting}s,
> > >
> > >                         Geert
> > >
> > > --
> > > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > >
> > > In personal conversations with technical people, I call myself a hacker. But
> > > when I'm talking to journalists I just say "programmer" or something like that.
> > >                                 -- Linus Torvalds



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
