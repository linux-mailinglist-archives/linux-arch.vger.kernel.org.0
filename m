Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A103EA3F9
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 13:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhHLLq7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 07:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236979AbhHLLqz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Aug 2021 07:46:55 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36555C061799
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:46:30 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k3so6534251ilu.2
        for <linux-arch@vger.kernel.org>; Thu, 12 Aug 2021 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CvMOxgWqJ+R+5xprEOmRYm8KAY954TbkWQ7epYO/CZg=;
        b=Ghc4s7YGi8CWB/c0/inqHNJFQURTRFjDlngKjNxUPsXGgd3sV5F9FRyZnOsFynEni8
         B5iTllW1FY3zJVuRo/LU1IePHA5txadf9PJUwYLth8rvMqCfVOPEa81oFlTIuYwbHkeI
         r2+j0AgjiCQMQpytY7/AzBcf2vjnwdYEB+ux5nS1/AMzYJbqDHTRSZyMxwAOnq0PuPjp
         98G5nTS07FJokHj9lP+tHl/59tmTqWBQmzbzZxSdSAUu+7Fo74IqCbi7EQ3aLlGPQPZ5
         hJi1ZwBBN/1HUjkhVdQhwTGDDq8uC1WNOVTLNtPKp7ji+iju0VYCbVSpFKKEdyj25POZ
         RnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvMOxgWqJ+R+5xprEOmRYm8KAY954TbkWQ7epYO/CZg=;
        b=mlvseOaCsTrLQgeD++NaopkEfnqOvmMa3y4UGN8c4hV42YgsHeL0slZWRUQL33X/DB
         w/GDA7UrM3aYeUhwykGBDsAoYfb4h4Dfu3Fy0i/pdhdaQbDXP7K4ECl78nKFWne+r8jz
         AUY7Tj+ZzX3E8npA/TK6B4l4Hy2HgFywnH2qpgsGFBcmmmJkthWVU7N5ayyLtT13Ii/v
         7IdGJ48KHAcgcqyg14JRB8I/z76qqlnC2zchKFKIRmvTgMVybSKJK2d1qv+jakzUdQRu
         05fYvlpBN0clNZTGEcthGD4c93OZi1tJzPP3Tf6xbGHhtNtAdfvMwT6aVyykSC3KUrdN
         zPdg==
X-Gm-Message-State: AOAM533mhchWk7uesyV38IGUeJam+vOXRyqG7QfjRecny/02LfVh1Yiv
        4Xt7sCPuogSIVy+uF5g/7wUA2Nb0PefjIi0xJc0=
X-Google-Smtp-Source: ABdhPJwtOVEByLhqH91YkCSdz/U9Ljx6Qly21LV28ZxIlDczIVIZlhsXyUaqm68znbgGnrMx3Da8xROS9nLxq1oP14Y=
X-Received: by 2002:a92:ddcf:: with SMTP id d15mr2626804ilr.184.1628768789625;
 Thu, 12 Aug 2021 04:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-19-chenhuacai@loongson.cn> <CAK8P3a2444qoaDJFvp-t2EzrZ2W6T-m_DPJbDAdJeSB-auV8gA@mail.gmail.com>
In-Reply-To: <CAK8P3a2444qoaDJFvp-t2EzrZ2W6T-m_DPJbDAdJeSB-auV8gA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 12 Aug 2021 19:46:18 +0800
Message-ID: <CAAhV-H7NeOfWmnfp79xE2e7g-LX2kkCrqOr9KVB7SE-JH6o-dw@mail.gmail.com>
Subject: Re: [PATCH 18/19] LoongArch: Add Non-Uniform Memory Access (NUMA) support
To:     Arnd Bergmann <arnd@arndb.de>
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

Hi, Arnd,

On Tue, Jul 6, 2021 at 6:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> > +#ifdef CONFIG_SWIOTLB
> > +/*
> > + * Optional platform hook to call swiotlb_setup().
> > + */
> > +extern void plat_swiotlb_setup(void);
> > +
> > +#else
> > +
> > +static inline void plat_swiotlb_setup(void) {}
> > +
> > +#endif /* CONFIG_SWIOTLB */
>
> I guess this accidentally slipped into the wrong patch? It doesn't appear to be
> NUMA related.
This need to be improved.

>
> > diff --git a/arch/loongarch/loongson64/dma.c b/arch/loongarch/loongson64/dma.c
> > new file mode 100644
> > index 000000000000..f259f70c75fa
> > --- /dev/null
> > +++ b/arch/loongarch/loongson64/dma.c
> > @@ -0,0 +1,59 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> Same for this file.
We only need a custom dma.c in the NUMA case, because we need
phys_to_dma()/dma_to_phys() to convert between 48bit physical address
and 40bit DMA address. Without NUMA there is only one node, and its
physical address will not exceed 40bit.

Huacai
>
>
>          Arnd
