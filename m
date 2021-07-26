Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F1A3D55F9
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jul 2021 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhGZIQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jul 2021 04:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhGZIQe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jul 2021 04:16:34 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F139C061757
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 01:57:02 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h18so8159533ilc.5
        for <linux-arch@vger.kernel.org>; Mon, 26 Jul 2021 01:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWcxJeChjGHnbWsjQ7YbqIgOaeS7vM4qn7HPjIVu4ig=;
        b=Aoa4R+U43jzl+JUdBizPwc40DRANrJLgebdmlLxNFP6x/ea/cTHGrpVDrmPi0ckHHQ
         RxBgU9h1T+VcxLMbruC3s8wVejMDkrzXaAtwdhr2rCY16py1qOyHbTsLnuuPSFfTWlty
         xoPro9QmJW+YROW22Q4OM+pOxTvU132DxvMju/CUA2UhrEvLg42I33R5kIjGzhK1K+d6
         0nrxgwpzpdiBIgAVS+lj/XHpCjh8q3sTFZu2f58G8Jx6I8BjSskbYZ/aiL+Sykhc7jiu
         FRLhWFyUI6Sgw6XBauP9eoWjsOg4FOiJcwkRc9PC/fH0eH/4oBs9KFcxVFP8IZuafKnK
         3OMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWcxJeChjGHnbWsjQ7YbqIgOaeS7vM4qn7HPjIVu4ig=;
        b=rM1/wQ4ALmL5LOVQLL0SY6T3rknbJPHWEZ71CjkwrHwmzY4iYrnymNZPr10kgwH+hb
         INLRQBBn7kEb6g5Mv8SIDEXnnsq2PDtP6guyTZnLshZWZEQDK2UTUcBUOI9cXKgSvKXa
         hUmJ2PhnJ4hm96B4dt7mmMEOYhj5gDuZ746Y+TqakHGccu+BQrPqdoTfZqjwx4AVxBfU
         +3kg1D8z4zbO78IvhdbgSku4WLhi2srQRgffaQMFAJNCMJ6d9Fc2Vf7ZlXaJz9Ytwp18
         TVTfUFcuAwoi74e1kSrwq7iknK/h3kAIjK66t7PnZeaesMV8hLsYMgmqeisprLYsQbnv
         sqqg==
X-Gm-Message-State: AOAM5317Y1FA/empAWjKg7vpnfX7qlNKmp7ZtQLxtdSpIDw5+1ZiOZsP
        Xlp8k0K4+ToQYbzDDeoMs339/39PrdEl9D4geSU=
X-Google-Smtp-Source: ABdhPJwhiJlrGM/wLNTdljgt7ZqeiPkPSl83/cEtXdMqxDXVZ24rRLS14j0Jm1Lbi6kk1PkQUYMq5NaqdfXSCe0Avoc=
X-Received: by 2002:a92:dc10:: with SMTP id t16mr11724139iln.95.1627289821272;
 Mon, 26 Jul 2021 01:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210724123617.3525377-1-chenhuacai@loongson.cn> <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
In-Reply-To: <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Mon, 26 Jul 2021 16:56:49 +0800
Message-ID: <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Geert,

On Mon, Jul 26, 2021 at 4:36 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Huacai,
>
> On Sat, Jul 24, 2021 at 2:36 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > Introduce a new Kconfig option ARCH_HAS_HW_XCHG_SMALL, which means arch
> > has hardware sub-word xchg/cmpxchg support. This option will be used as
> > an indicator to select the bit-field definition in the qspinlock data
> > structure.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Thanks for your patch!
>
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -228,6 +228,10 @@ config ARCH_HAS_FORTIFY_SOURCE
> >           An architecture should select this when it can successfully
> >           build and run with CONFIG_FORTIFY_SOURCE.
> >
> > +# Select if arch has hardware sub-word xchg/cmpxchg support
> > +config ARCH_HAS_HW_XCHG_SMALL
>
> What do you mean by "hardware"?
> Does a software fallback count?
This new option is supposed as an indicator to select bit-field
definition of qspinlock, software fallback is not helpful in this
case.

>
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
OK, I think this dependency is needed.

Huacai

>
>    select ARCH_HAS_HW_XCHG_SMALL if RMW_INSNS
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
