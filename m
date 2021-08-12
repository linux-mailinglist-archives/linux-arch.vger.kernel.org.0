Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6833EA4E1
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236983AbhHLMtE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 08:49:04 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:40903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhHLMtE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 08:49:04 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MHoZS-1mI2HQ1BbS-00ExTh for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021
 14:48:38 +0200
Received: by mail-wm1-f44.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso7044561wmq.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 05:48:38 -0700 (PDT)
X-Gm-Message-State: AOAM5332HsGciORREMUEBVo87NEToE4IqS9htmuuzTVnP7oeQGuCJSG0
        rb6nqt+VITu7EelhfvTDRkXIICFfGr1jjA0Jw8M=
X-Google-Smtp-Source: ABdhPJw0Ncm8J0ErtIKOmxwTh/ChDrcLOC4uW3SsYBauc8pkhW4txt1NdH/biXEiUPkQvQ67Pw4HMY6o6kIww3Z7YFw=
X-Received: by 2002:a05:600c:3641:: with SMTP id y1mr3776514wmq.43.1628772517884;
 Thu, 12 Aug 2021 05:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-19-chenhuacai@loongson.cn> <CAK8P3a2444qoaDJFvp-t2EzrZ2W6T-m_DPJbDAdJeSB-auV8gA@mail.gmail.com>
 <CAAhV-H7NeOfWmnfp79xE2e7g-LX2kkCrqOr9KVB7SE-JH6o-dw@mail.gmail.com>
In-Reply-To: <CAAhV-H7NeOfWmnfp79xE2e7g-LX2kkCrqOr9KVB7SE-JH6o-dw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Aug 2021 14:48:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a032Tg3tLbMFFoGAGU3qT=YnuVocQc20D1ibbzC+w5J=Q@mail.gmail.com>
Message-ID: <CAK8P3a032Tg3tLbMFFoGAGU3qT=YnuVocQc20D1ibbzC+w5J=Q@mail.gmail.com>
Subject: Re: [PATCH 18/19] LoongArch: Add Non-Uniform Memory Access (NUMA) support
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
X-Provags-ID: V03:K1:j1AfEdTC5IB32yqBgMsWZ3TtY7bXf1FT0aQJTOXrmeiz4pOSeO4
 xibW4a8lIo8/VoVKzoH7iwYVZOSJMS5ihebhn1MKuajflK1McmDeJqHdtwuf4v04rQgQtLy
 aH4N4xX2vB46NR2cF0L5BRxSbI1WY0JQy9ftmMumVqZ7pj7nSXFZsaOPWJjtfhwyhdCHQH2
 RYpWzmL0Te0p2qJTyfZ5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FKUKCzxRAfE=:hmbghXBh0mviR/LzL6/lWF
 QR8KIPLM7fqE0E5qFbLR0uZQReEVT+PXgmDvrUXBNEc1JXL0EwgOgURm1XOcp8AS1Ld73hAKh
 G6/b1z2aajsGOKKvNjDONx+aTrdN2ZN0Ug4FiPQYQ2IM9WiD1UmF59K1jIunm2PR+GshcbZfE
 p+Dl3AysoLNVwSrirnUX7difjMNCS6aRMIEQh7aa+U++j8IfKWhN86Nzx2nTmpp/V4hB5DQ6a
 XyqaJQsKrGwa+O4vnXZA3VIdcHVWe/rWyXqY8D1fJ5+ky2Sk4kNwMNZx3Cr4eFdnWwV+a2DhD
 URObv6Bt1M7zH9LEKiR1pK3LGb+bhdV5M6e/nh5CWydkIa9MiS0Hw3luq8KN3HjMNBS+BYFES
 Cqsf+k53MmhXkFA9QdIyIGopbmOlI3O3D6BvzvKPz9OT9WWMF8scIFc82wrTHhdMn4xFnU7Fs
 IvflL1V5Dc98ecVaPxVBITNyau6d7z6qCDnJB/OgJUm35pDQ+Gs3vjomiv7AnnXqAnxK4t7sg
 X67lY7mpm9r8jTmwVpWI6lX39uVR5pQNHzRMl8jNRr4IRtzqAndD9CJpJkE8avllUrXqmwoF4
 FtxKI5RTD+UipLhCEU1XFRFLUC03mw79f8E6mr2MY8siJYuy3OUddeBTMtrTbBoS5KH40QJFx
 uvmFfgUDuCtkBK+qhMrb7xcPOOpzj/LgVvgUfZKAmKaaKVSPrBfUNEYYGxkHPoGuuhOSWo2EO
 JNR2Qlm55aOHOnqHuxSmQazu42l8s/mGUlrpgkudda5SUvbWyEUkv69EhmzlB7FHSUIybk7Fq
 c+2qPCf1eQv7cGT5cYNmVs5w0CuXe8cPZB+k7GbaOqH+0R6s0XcJTwyfXp8w6VkA78GikPuFP
 0ti49uTRzvXffMjL5ix8FQP2zsf5F6uU80aJQH+T5McWCkojBkG8UmI06Prcqx6RY9qczwmPE
 /8+YTZ2guW8pa8R8JbrzXBIPbd6a7D/S3vTsnyD4WAq4vJrx3iK8u
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 12, 2021 at 1:46 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > diff --git a/arch/loongarch/loongson64/dma.c b/arch/loongarch/loongson64/dma.c
> > > new file mode 100644
> > > index 000000000000..f259f70c75fa
> > > --- /dev/null
> > > +++ b/arch/loongarch/loongson64/dma.c
> > > @@ -0,0 +1,59 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> >
> > Same for this file.
> We only need a custom dma.c in the NUMA case, because we need
> phys_to_dma()/dma_to_phys() to convert between 48bit physical address
> and 40bit DMA address. Without NUMA there is only one node, and its
> physical address will not exceed 40bit.

Ok, makes sense.

        Arnd
