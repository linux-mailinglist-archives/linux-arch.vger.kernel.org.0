Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3B3F27FC
	for <lists+linux-arch@lfdr.de>; Fri, 20 Aug 2021 09:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhHTH40 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Aug 2021 03:56:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhHTH4Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Aug 2021 03:56:25 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M89bP-1mBmiX3wPr-005Ji4 for <linux-arch@vger.kernel.org>; Fri, 20 Aug 2021
 09:55:46 +0200
Received: by mail-wm1-f49.google.com with SMTP id a201-20020a1c7fd2000000b002e6d33447f9so6651334wmd.0
        for <linux-arch@vger.kernel.org>; Fri, 20 Aug 2021 00:55:46 -0700 (PDT)
X-Gm-Message-State: AOAM530akxes7GoDXExzPTOumV9Ocl9sYNppbybRK5OEZ4kOrqPzU381
        m+swkzpw9z2Kp20J86yFxD/EUt1PCjPAq6GpDTM=
X-Google-Smtp-Source: ABdhPJwDP9Dzfkcnaexibgq//WhgoLjd+e+stMTdponb+VM8J/vewKheXfer3u7cfvZmm6ZT/OlE7mpe4RkGXD6vgqQ=
X-Received: by 2002:a05:600c:510a:: with SMTP id o10mr2495130wms.84.1629446146649;
 Fri, 20 Aug 2021 00:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <CAK8P3a357Xgs7mdsP-NCmu5ukVqMHtV1Andte6vO1mEr2qoqbQ@mail.gmail.com>
 <CAAhV-H5byhzBLbw3ASk=-8Xvkws8SS4eS_0Q5EyhXuzUdM1=sQ@mail.gmail.com>
 <CAK8P3a2bq3p25dfhUEiTe57-i5SKwXJAEZ18=tpbXijqMrDpYQ@mail.gmail.com>
 <CAAhV-H45GFoFz1csEJigCN_QiCvq68__0BXrmDcsQFK6Nr17Aw@mail.gmail.com>
 <CAK8P3a15rj_vH2FN12+UVZ=YfPDTEJ_cN0PoNfyYFSz8KSOvzg@mail.gmail.com>
 <CAAhV-H5r7HBhepc-N_Qmr=Vdy-5nHg-0ZvFK-nVY2eFzYqpR5A@mail.gmail.com>
 <CAK8P3a1vMCHihjnu2wZsz0_JXhXr_pg0mN_x-b1X754BptReeA@mail.gmail.com>
 <CAAhV-H664mY-vQubEMX0yHdwHfH9kDrp6W=zHJvTE+yi31GpyQ@mail.gmail.com>
 <CAK8P3a0KLjGrfRnKQxCvULdL3PpMWCyjpx-tzcW1W5qqfiMbMw@mail.gmail.com>
 <CAAhV-H6rPc1qyoE6FRpUQs1GS_K+xASHu_q5o-yT13eu7DKzVQ@mail.gmail.com>
 <CAK8P3a1LMY+KschuMfLoXB1qXMcTLVWeP+s41sCfQMFdRujQjQ@mail.gmail.com> <CAAhV-H64k25rVqGrYJ4wZxQEQ0jp=TRcUZA+Co8JoL1epBBwVg@mail.gmail.com>
In-Reply-To: <CAAhV-H64k25rVqGrYJ4wZxQEQ0jp=TRcUZA+Co8JoL1epBBwVg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Aug 2021 09:55:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0HZGv-uL=QOGkVxsRUEre49j+wZ1L4TtF0MJx-4qKBaQ@mail.gmail.com>
Message-ID: <CAK8P3a0HZGv-uL=QOGkVxsRUEre49j+wZ1L4TtF0MJx-4qKBaQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
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
X-Provags-ID: V03:K1:13rjwP85uu+RIZq5G2FszklT8HONc0ofB2mbw/Fic0Zu7pfo6lk
 JFMUT5lfdMiyThE6ES/7GAuxW5WVY4iSbxRHi9syMw/Xdx3AzrV4NYDH6bJeGUpgaI95mCC
 H6JAMt4nCFC1QTy0JyxA/r1KT5wnEnxAd1pjJZNFjVQlWrEO8aaw7GhjGvnXG+fgasBcfDh
 tRroMuitKY0+VGHUvAFKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1B/zQJh5sDc=:H4psXdtk81P7Z0FJPznJTV
 J6bU7CB/OEHFH55XiqqJ/VXqS5voF5Uew3hOwfehoZ07DKwgsJtAHF4jMXVIr2Ga3PJC+oykU
 L/eyOXuygIrJAOCFwg60vd52JKF3+ct375Ed0ZK6oyJmseAmrH8SRH3JDHcT2nSSoGLhXhsTm
 LHlhCfISsifgsHT/P/S1tf8ZTuMBD+DnVNN16rBDMs2quxShVyLifNrBkg/14GdhH1URG6Qkh
 yljmxWCLCP14ZCnpuc5/1P6pg1y5jTq4ueGIbJtudj9mgOWCtqQu4MphMQROIPjxh8LTN884v
 BFU9HdkNVvto4pxBKdgSJOQbbT51VQPrY36urqsvnTTGJtWGOWWx4Le+aB2qFS/KT/FsB0Ahf
 FuTXlhr3Ugj9jA7GqojYzX+pC2ANNp17nXxyHFbpMkcCBtnmiAAJMXkDyFbtdjMjePOZDccMH
 2RF9SU98HalXZhRv3XLmP/MWi5YeusRZEm6zaon6XgW35Bi+Eh4bgOuUj5rEhfdeN3/lFDugn
 j3OKPkUjl32KyQNQGt9U1y59/xkMHZG4UUUslpMpO89BzRbUXZzFwcfOcylHm9tPKUJu4r4mG
 Yk2OpOUUdnEDxxmMGU75uirhm458cqVxG5fM1wOxb6XrnhQjxu3FA5fQg/yzFIvfzAJrjusDn
 SyhSeJ9I0LIGn9rzJ6NIaO969drTg7GKm29oZPBKurKcCKm5c81sFZy4lkGVCPlmm4nGhiW9g
 eqhgRbUiHUB28aKdFg2TWFH02ty1C0aRVrAlG1Y3QUGSeA5y3j+K5coHPMVEB+OfKnZKizBPa
 1hNqozzUJloPcXGABh3sCYh5270CJqkyAdOQO7PFMP0hQJtOWkCLrUas3VeXOvIeaYfxmp0
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 20, 2021 at 6:00 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Wed, Aug 18, 2021 at 5:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > How common are Loongarch64 CPUs that limit the virtual address space
> > > > to 40 bits instead of the full 48 bits? What is the purpose of limiting the
> > > > CPU this way?
> > > We have some low-end 64bits CPU whose VA is 40bits, this can reduce
> > > the internal address bus width, so save some hardware cost and
> > > complexity.
> >
> > Ok. So I could understand making CONFIG_VA_BITS_40 hardcode the
> > VA size at compile time, but if you always support the fallback to any
> > size at runtime, just allow using the high addresses.
> Define a larger VA_BITS and fallback to a smaller one (TASKSIZE64) if
> hardware doesn't support it? If so, there will be a problem: we should
> define a 4-level page table, but the fallback only needs a 2-level or
> 3-level page table.

The number of levels is usually hardcoded based on the configuration,
though I think at least x86 and s390 have code to do this dynamically,
either depending on the CPU capability, or the largest address used
in a task.

The easiest example to replicate would be arch/arm64, which lets you
pick the page size first, and then offers different VA_BITS options that
depend on this page size.

Another method is to have a single 'choice' statement in Kconfig that
simply enumerates all the sensible options, such as

4K-3level (39 bits)
4K-4level (48 bits)
4K-5level (56 bits)
16K-2level (36 bits)
16K-3level (47 bits)
64K-2level (42 bits)
64K-3level (55 bits)

You might prefer to offer the order-1 PGD versions of these to get
to 40/48/56 bits instead of 39/47/55, or just offer both alternatives.

       Arnd
