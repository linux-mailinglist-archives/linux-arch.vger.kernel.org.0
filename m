Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0233CCEB4
	for <lists+linux-arch@lfdr.de>; Mon, 19 Jul 2021 09:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhGSHqi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Jul 2021 03:46:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:51682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233759AbhGSHqh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Jul 2021 03:46:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A8056109E
        for <linux-arch@vger.kernel.org>; Mon, 19 Jul 2021 07:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626680618;
        bh=x+abu/zf7wALqS3BxwxkcPH14k9QI2BPBLIcIASmlk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iuPx0mpkhm44LpOcVzsab9cRy6NylH5yGgbIBu4EdgEhytZQn4hX1/wBlp9WK1nSm
         pzgyATszQrkpsowOLcspvzh0H6xKZzMQIQ7JX31kvTIpS1Vm8jK2ugaLhrNx8NzvDQ
         HQCqNZK/dMg4H5xXLPo+gJ0RJEbeS0ctQ8CY5rwaYv92KuPrDiAEC1atCxTZxd/cMn
         bcJ24A6NaSxDGufbXg5Ylq9X3zAV1sjOMgUuewmFUdbgtDW73E2lJZnMOZeW/r0xMn
         tQnusNTfJrMxGtfUBvWiytY9gKRkczEbSnXpmchubyGb4as2y7X1UH8SiMk+R/QKKt
         ss5ElAMVZIL1A==
Received: by mail-wm1-f41.google.com with SMTP id p15-20020a05600c358fb0290245467f26a4so1624391wmq.0
        for <linux-arch@vger.kernel.org>; Mon, 19 Jul 2021 00:43:38 -0700 (PDT)
X-Gm-Message-State: AOAM5320OwwseAxsfjmiUZGKU/VnhSVBu5ovknqllMSPin9DA11j5WiB
        X1Hq/IRtL64lF2PMVGnQ3jzf/NvgipZiLzgCEv0=
X-Google-Smtp-Source: ABdhPJx2EoeVgfVl38yWrk3sFd1kJb+IvR1WzApPp9iCEK+lJkuOWBX50L2OJx6x+7jGaRTOHQsCzUynt0/W2bMT6KQ=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr30577134wmh.120.1626680617033;
 Mon, 19 Jul 2021 00:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-4-chenhuacai@loongson.cn> <CAK8P3a0RHFvzvGXMrJ369gDVC7fpH5XJp+AX-ZiAu0JskTzZqg@mail.gmail.com>
 <CAAhV-H796UQNaRkiaJhYRHsO-36KE_5d6sT=sJaKXCKfHtP-Mg@mail.gmail.com>
In-Reply-To: <CAAhV-H796UQNaRkiaJhYRHsO-36KE_5d6sT=sJaKXCKfHtP-Mg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 19 Jul 2021 09:43:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1kX_wHz_BpdD=pB-Fd2Cy3_xDvTsRKVvKR+_9GP0NSmA@mail.gmail.com>
Message-ID: <CAK8P3a1kX_wHz_BpdD=pB-Fd2Cy3_xDvTsRKVvKR+_9GP0NSmA@mail.gmail.com>
Subject: Re: [PATCH 03/19] LoongArch: Add build infrastructure
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 19, 2021 at 3:26 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Tue, Jul 6, 2021 at 6:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >  Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > --- /dev/null
> > > +++ b/arch/loongarch/Kbuild
> > > @@ -0,0 +1,21 @@
> > > +# Fail on warnings - also for files referenced in subdirs
> > > +# -Werror can be disabled for specific files using:
> > > +# CFLAGS_<file.o> := -Wno-error
> > > +ifeq ($(W),)
> > > +subdir-ccflags-y := -Werror
> > > +endif
> >
> > This tends to break building with 'make W=12' or similar, I would recommend not
> > adding -Werror. It is a good idea though to have your CI systems build
> > with -Werror
> > enabled on the command line though.
> If we use W=???, corresponding flags will be used; if we don't use
> W=???, -Werrer flag is used here. So it seems not break the building.

The thing is that we get three new compiler releases every year, one gcc
and two llvm. Usually every release introduces new warnings, so even if
you quickly address those in mainline kernels, anyone using an older kernel
will find themselves unable to build it with a newer compiler.

> > > +       select ARCH_MIGHT_HAVE_PC_PARPORT
> > > +       select ARCH_MIGHT_HAVE_PC_SERIO
> > > +       select GENERIC_ISA_DMA
> > > +       select ISA
> >
> > Do you actually have ISA-style add-on cards? If not, then
> > remove the ISA options. If you do, which drivers are they?
> Yes, there is an LPC controller in LS7A, and superio is connected on
> it for laptops.

CONFIG_ISA only refers to actual 16-bit add-on cards, not LPC
style on-board devices. Sometimes the options are used inconsistently,
but unless you need an original Soundblaster or NE2000 card, this
should not be needed. Note that some older x86-64 and arm64 have
LPC as well, but do not support CONFIG_ISA.

For GENERIC_ISA_DMA, I suppose that could be used for the parallel
port driver, but even if you have one of those, it might be easier to leave
it out and just no longer support Zip drives or dot matrix printers attached
to them.

ARCH_MIGHT_HAVE_PC_SERIO is probably needed if this is how
you attach your keyboard and trackball, but it should work without the
others.

       Arnd
