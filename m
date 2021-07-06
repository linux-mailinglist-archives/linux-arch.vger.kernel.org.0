Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED0B3BCB5A
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 13:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhGFLG0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhGFLG0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:06:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1AB261A1D
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 11:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569427;
        bh=ZQhTk2lvIp9cqLyHBWkEYQFYLvd4tZYhCDKDL1mQ+VE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hjc3++1mQ9ZgaW9fGf1EOxil6A75216ewPhTa26QC+c0NT5pGS7q5SitNE/Ntm0Da
         JZSDn7TvVd6Ogg9S4LhyjUFmjAWybpHNP30dDr6l1A22834knWSa55AA6Q5E/4k+7l
         oIR5/CMD02whI6wY02Gby4zSwpUkT8D8eOEvyLeESVRa+infVv/ulGK+AILeiDWt1/
         kJT1PWrnp5w7mvA0bNTf6m4eP5js5CzeG5Myzuvnrp08UwBI/Jh2qTw9AnWBybk8dT
         nZ/4Wbdjj6uj2wIotZPTrXXAc5gUj9St25F4fBjjbnrlUp39jJL/dr+VPdN6fAAEf7
         DaHuKnHO7ditw==
Received: by mail-wm1-f47.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so1944621wms.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 04:03:47 -0700 (PDT)
X-Gm-Message-State: AOAM533hrIFOP+eCPnVsDBss+R8gd2/lHumQ+zny8wmwEPCEgKk2r40X
        PMV3LjKAbymSB6mchjZ555EpI+dba1SVOjGomU8=
X-Google-Smtp-Source: ABdhPJy8hNNBBmG7UGKk5WkndIYnAppWBMpso8nxkoRoQPDTcUQUagmfv+s4PWyArQyPK6yV02gu8rz2Uj+2p5LaQOE=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr4181612wmb.142.1625569426313;
 Tue, 06 Jul 2021 04:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-19-chenhuacai@loongson.cn> <CAK8P3a2444qoaDJFvp-t2EzrZ2W6T-m_DPJbDAdJeSB-auV8gA@mail.gmail.com>
In-Reply-To: <CAK8P3a2444qoaDJFvp-t2EzrZ2W6T-m_DPJbDAdJeSB-auV8gA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 13:03:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Hus194DdnE9dBimET9ogqiZWKkgmNO0_z8c=O2-ic3Q@mail.gmail.com>
Message-ID: <CAK8P3a2Hus194DdnE9dBimET9ogqiZWKkgmNO0_z8c=O2-ic3Q@mail.gmail.com>
Subject: Re: [PATCH 18/19] LoongArch: Add Non-Uniform Memory Access (NUMA) support
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> +#ifdef CONFIG_SWIOTLB
> +/*
> + * Optional platform hook to call swiotlb_setup().
> + */
> +extern void plat_swiotlb_setup(void);
> +
> +#else
> +
> +static inline void plat_swiotlb_setup(void) {}
> +
> +#endif /* CONFIG_SWIOTLB */

I guess this accidentally slipped into the wrong patch? It doesn't appear to be
NUMA related.

> diff --git a/arch/loongarch/loongson64/dma.c b/arch/loongarch/loongson64/dma.c
> new file mode 100644
> index 000000000000..f259f70c75fa
> --- /dev/null
> +++ b/arch/loongarch/loongson64/dma.c
> @@ -0,0 +1,59 @@
> +// SPDX-License-Identifier: GPL-2.0

Same for this file.

         Arnd
