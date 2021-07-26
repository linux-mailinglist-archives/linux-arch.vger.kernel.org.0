Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0623D5603
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 11:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhGZITw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 04:19:52 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60815 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhGZITv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 04:19:51 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1My2lr-1l9DeH1PAN-00zTQs for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021
 11:00:18 +0200
Received: by mail-wr1-f41.google.com with SMTP id l4so10145252wrs.4
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 02:00:18 -0700 (PDT)
X-Gm-Message-State: AOAM533UkybXGCkCjAKt+fLBrFV3i3AoxJrolBEnf3Eyk58T/QPrtSp3
        aX/aPFRt/A7ScJgmi4t6seTBoD+iIbcfRJxbEig=
X-Google-Smtp-Source: ABdhPJxD3kmd+3Yn7KHoC3yiTb6Qd1TFdSjk8uvNTx64Pnn6yblRxKtV0QBhTZ/0eYtoEeB6B45puPtrX7/blk50wCY=
X-Received: by 2002:a5d:65cb:: with SMTP id e11mr18704046wrw.105.1627290017793;
 Mon, 26 Jul 2021 02:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210724123617.3525377-1-chenhuacai@loongson.cn> <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
In-Reply-To: <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 26 Jul 2021 11:00:01 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3vBJFWH3XMVk+g9cT897sEarg5-2cNnG+EY8iy72a9qA@mail.gmail.com>
Message-ID: <CAK8P3a3vBJFWH3XMVk+g9cT897sEarg5-2cNnG+EY8iy72a9qA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:qQQEAjCmB2/XF+N3wku3UTqCXTyqXPlikwn/he/N155NCf6s6L9
 1jYebEhzvWBCPOtc7PmP06B7BMB05u0Pv7pOooHCSpa66Yj4q29B2qt2p/YWVtKS4dUQTwS
 nOltaH8ijVEQOKaq6Eb6RNEr3pQg75ProL9BRlZNtAm4eY2p+YhI85oLn4PtMnNKWbFifk6
 c3f7m9qUHd4QKL3+FnRrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KCmsQA0mNrs=:vMBqIrJsQmj9RnV2u+6jJv
 2hp7RGIro50fhDGEnpxH6CTadnPeoCtVbNH+HeqMcxZtPh+Cbk/O7nOZFlFZEGqrGVOOt65af
 u+LNJBzsGejrSkkrepv8WUol8PhDTJa3cG+6mp4qkkG6MvDADMe4tbjYPL3vodrHN9a4QBxfL
 7/dHNryzVMTQ/Y0XMV3Sy+MdZ4rqyD/nH6YYYfShnSAcrDvZtS8MRmP1VHOEIoFellT+RVXdD
 1CYYZTzInuIbEUeZO7gOJXpR7efq7RIoqesKhrSYH507DQoj9+42jgrKhtCZWhKWDQ5uZSpWo
 NGZhfyYPfWMSdyx3IyVUdzZDb3z40qPchyeLd85VMveA0MMkzY2PwNw2Nr/N2pNlINOsbgRYR
 PiSM9sVMlq6eJD0XCt5YPpeTZfG2j5yalh5AbhcR5/PctG0HqHhRF5Dy9mSeqTwrGJosVlGyz
 46k1vbdn5/5d7xMdgnlrZT1AeDGnzFaq4/kY+eKm1I026K14Vv9Afb84Oo7r6SbBst/KVTmOt
 mq4mOYirdGGDSY1CWma/4xKJhzG+5YVanVe3uG8vE6ecBdqip8HjoEkwyipIlACHznAlocswG
 sOJGh4BhI4QZUsN/PHkWlORKIFafPbPUGYt0Xs2oszA4vnCDrkLCow9AAbaRmvt2KUb2Bj3Ef
 6LCOdXAGiKtyLO503mV36bmPaJ6qUrNnN7jlKPXmYWWRP6B6B8pmuJ0yM32m0xYoJirpb/O2Y
 CY7qmmYQsDQJz89lMy2Dg9fYxJa2Q8b0EWxo3xkljfWttwX0e5fdGZ6TI0GnyYOX5dbJinx88
 ZujY2RRgtMnCWD4bEKrTPZLVzHzKZPnf8G1cwAHTbtu3+PbduKGVG5zZaaVY+L/ekQap3TPF2
 MF28gquDaIGZ5/0VVno0u+acF20NbIJBjeu4lB3+Jqx63C10NCvv8L5qDHybG6POwUifJww9p
 Et1KiFVGiQsIp1Nz1He3DAG0VdvC7I/hDbtiZZSWQLF3fAW8PV+VC
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 26, 2021 at 10:36 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
> >           An architecture should select this when it can successfully
> >           build and run with CONFIG_FORTIFY_SOURCE.
> >
> > +# Select if arch has hardware sub-word xchg/cmpxchg support
> > +config ARCH_HAS_HW_XCHG_SMALL
>
> What do you mean by "hardware"?
> Does a software fallback count?

Indeed, this needs to be clarified

> > --- a/arch/m68k/Kconfig
> > +++ b/arch/m68k/Kconfig
> > @@ -5,6 +5,7 @@ config M68K
> >         select ARCH_32BIT_OFF_T
> >         select ARCH_HAS_BINFMT_FLAT
> >         select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
> > +       select ARCH_HAS_HW_XCHG_SMALL
>
> M68k CPUs which support the CAS (Compare And Set) instruction do
> support this on 8-bit, 16-bit, and 32-bit quantities.
> M68k CPUs which lack CAS use a software implementation, which
> supports the same quantities.
>
> As CAS is used only if CONFIG_RMW_INSNS=y, perhaps this needs
> a dependency?

I would probably define that case as 'yes' then, defined as 'the 8-bit
and 16-bit cmpxchg/xchg helpers are no less atomic than the 32-bit
version'.

This would be in contrast to the MIPS versions that have native
32-bit and 64-bit cmpxchg() but only emulated 8-bit and 16-bit
versions.

Not sure about the parisc case, which only emulates the cmpxchg()
and xchg() based on spinlocks for any of the sizes, so they are not
atomic in regard to a concurrent READ_ONCE()/WRITE_ONCE().

       Arnd
