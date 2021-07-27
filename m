Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E03E3D6B87
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 03:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhG0Arg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 20:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhG0Arf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Jul 2021 20:47:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8CC860F90
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 01:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627349283;
        bh=pcu1FxkV3k+HeRHQ9TJNV2Qr/v60JATH0MXJHW9pl2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tZEVAqlqPL9K9wUkPXF3YZ/OVzUvLZF4T/6j/TTuopS5yPZVhfbtLuLFvstykH6Nk
         tmFz9I5yRDnWghCr6vvHRLdXTom0/MU9LZOF32U+J1sBwpq+SxXIDSyCXyEWTTgfDL
         NsCiTAVeOYzxbN5l5vRLNX0uc5MBZB1AUG8Rb3VCJAPbyzzc8EdyAnKAOMafN8z6zT
         iQg+9nm2Obh/7IBOvEuGvvmLJ1+Vw1fyDSPd4h/LLiAHWZHkemfiD8zjTLAhU2pKbS
         GI1BQ8g1T10pYMAwtttGyp079VbwDNC/twizLSy6YOdaMCz64oAEuEQW9GfYvBuwx9
         oBWudHhYJ7rzA==
Received: by mail-lf1-f44.google.com with SMTP id y34so18842113lfa.8
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 18:28:03 -0700 (PDT)
X-Gm-Message-State: AOAM531VHZ3/11NE4Fo0DeaDcXoWaTF+YFZVIVHpXNCHgJZjFFx16fSb
        8nCXfOLVEeotM3Q/RlIiLOR5XJpA8uf3pPpL8Ug=
X-Google-Smtp-Source: ABdhPJybyOl20o1TTFUEz1aU4HGDcWVi1n10WCL69ZpfD6AQ7QfVK/fjA0cZmpaJvMFBqwghjGgBDKEAs4yQs88obsw=
X-Received: by 2002:a19:6403:: with SMTP id y3mr6379846lfb.24.1627349282163;
 Mon, 26 Jul 2021 18:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux> <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux> <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
In-Reply-To: <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 27 Jul 2021 09:27:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQcmN0TdX2dMT5mqKBp2HJ15_7KzDnaM5VyHaCArrnfGA@mail.gmail.com>
Message-ID: <CAJF2gTQcmN0TdX2dMT5mqKBp2HJ15_7KzDnaM5VyHaCArrnfGA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Waiman Long <llong@redhat.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 5:21 AM Waiman Long <llong@redhat.com> wrote:
>
> On 7/26/21 1:03 PM, Boqun Feng wrote:
> > On Tue, Jul 27, 2021 at 12:41:34AM +0800, Guo Ren wrote:
> >> On Mon, Jul 26, 2021 at 6:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >>> On Mon, Jul 26, 2021 at 04:56:49PM +0800, Huacai Chen wrote:
> >>>> Hi, Geert,
> >>>>
> >>>> On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >>>>> Hi Huacai,
> >>>>>
> >>>>> On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >>>>>> Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
> >>>>>> has hardware sub-word xchg/cmpxchg support. This option will be used as
> >>>>>> an indicator to select the bit-field definition in the qspinlock data
> >>>>>> structure.
> >>>>>>
> >>>>>> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> >>>>> Thanks for your patch!
> >>>>>
> >>>>>> --- a/arch/Kconfig
> >>>>>> +++ b/arch/Kconfig
> >>>>>> @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
> >>>>>>            An architecture should select this when it can successfully
> >>>>>>            build and run with CONFIG_FORTIFY_SOURCE.
> >>>>>>
> >>>>>> +# Select if arch has hardware sub-word xchg/cmpxchg support
> >>>>>> +config ARCH_HAS_HW_XCHG_SMALL
> >>>>> What do you mean by "hardware"?
> >>>>> Does a software fallback count?
> >>>> This new option is supposed as an indicator to select bit-field
> >>>> definition of qspinlock, software fallback is not helpful in this
> >>>> case.
> >>>>
> >>> I don't think this is true. IIUC, the rationale of the config is that
> >>> for some architectures, since the architectural cmpxchg doesn't provide
> >>> forward-progress guarantee then using cmpxchg of machine-word to
> >>> implement xchg{8,16}() may cause livelock, therefore these architectures
> >>> don't want to provide xchg{8,16}(), as a result they cannot work with
> >>> qspinlock when _Q_PENDING_BITS is 8.
> >>>
> >>> So as long as an architecture can provide and has already provided an
> >>> implementation of xchg{8,16}() which guarantee forward-progress (even
> >>> though the implementation is using a machine-word size cmpxchg), the
> >>> architecture doesn't need to select ARCH_HAS_HW_XCHG_SMALL.
> >> Seems only atomic could provide forward progress, isn't it? And lr/sc
> >> couldn't implement xchg/cmpxchg primitive properly.
> >>
> > I'm missing you point here, a) ll/sc can provide forward progress and b)
> > ll/sc instructions are used to implement xchg/cmpxchg (see ARM64 and
> > PPC).
> >
> >> How to make CPU guarantee  "load + cmpxchg" forward-progress? Fusion
> >> these instructions and lock the snoop channel?
> >> Maybe hardware guys would think that it's easier to implement cas +
> >> dcas + amo(short & byte).
> >>
> > Please note that if _Q_PENDING_BITS == 1, then the xchg_tail() is
> > implemented as a "load + cmpxchg", so if "load + cmpxchg" implementation
> > of xchg16() doesn't provide forward-progress in an architecture, neither
> > does xchg_tail().
>
> Agreed. The xchg_tail() for the "_Q_PENDING_BITS == 1" case is a
> software emulation of xchg16(). Pure software emulation like that does
> not provide forward progress guarantee. This is usually not a big
> problem for non-RT kernel for which occasional long latency is
> acceptable, but it is not good for RT kernel.
"How to implement xchg_tail" shouldn't force with _Q_PENDING_BITS, but
the arch could choose.
But this will raise another topic, is qspinlock suitable for these
arches? Maybe you've answered here: "for the non-RT kernel, Yes".

I remember you are the person who doesn't against the patch I've sent [1]:
[1] https://lore.kernel.org/linux-riscv/b6466a43-6fb3-dc47-e0ef-d493e0930ab2@redhat.com/

>
> Cheers,
> Longman
>

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
