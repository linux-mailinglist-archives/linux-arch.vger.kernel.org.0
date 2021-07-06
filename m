Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCCA83BCB32
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbhGFLAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:00:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231624AbhGFLAh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:00:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DCD461A13
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 10:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569079;
        bh=hJY1Oi87z5nVpLZPo80y9ahGtk4jCtrE4y2y6zS8hik=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cDpwOYuqqSAOXdTjiKvSqd3/8uV9ETulW9Wr8SUGYCbqaTqE2tl9pi9iDg6HL9/CW
         I5+X3hAjEj/355XcTLwi4YdfthnKul8LYSMgXNtZEf8BEAh6tBf5N83LPBmmdZaFi1
         Dz/yJlsjZg+VGUs+g0cNupZU+NzyMbD3hpdCjaVEpc6jjgKgJM7EYMnB+GEEnBevya
         8ydUxxMnDKjux2kDDjOt8xN4qIlF57Bf4z0G6p4rLBByeL8xuk417eqryidgqF3FHg
         atp7G0nEVtIWFTbRyOX81FB60+8Y4y0Q0/vFOoDKv5aaX2RJp4wJcXLiwX5mjhJT1U
         WYAXn0YpALKoA==
Received: by mail-wm1-f44.google.com with SMTP id k16-20020a05600c1c90b02901f4ed0fcfe7so1934052wms.5
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:57:59 -0700 (PDT)
X-Gm-Message-State: AOAM5312QbNAcTmZymW7/cCXmWsJc4kAc6DVHAUhmojD4NUkZv4oPrEi
        bHOGAv/VPJVA/kyBYabkYykI1Nb6zgCzXDLK070=
X-Google-Smtp-Source: ABdhPJzBl/YnPvFODqRsKFOD+Te6UZyJXGtr8qufvv9p9vFppNYJk+oGg0cUiWjWcjxpRY+94eO5/aaMkGlyo1FNRYI=
X-Received: by 2002:a1c:4e0c:: with SMTP id g12mr4097328wmh.120.1625569077730;
 Tue, 06 Jul 2021 03:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-9-chenhuacai@loongson.cn> <CAK8P3a2Hr7TbuO6LBVC5p5AghWc3j-NCSi8rwd3aq5o8g=Jk1w@mail.gmail.com>
In-Reply-To: <CAK8P3a2Hr7TbuO6LBVC5p5AghWc3j-NCSi8rwd3aq5o8g=Jk1w@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 12:57:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0EMO9AD157n6VtRR0VCj5tASgdQ5BHEEaX9Rn7LtG=WQ@mail.gmail.com>
Message-ID: <CAK8P3a0EMO9AD157n6VtRR0VCj5tASgdQ5BHEEaX9Rn7LtG=WQ@mail.gmail.com>
Subject: Re: [PATCH 08/19] LoongArch: Add memory management
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

> diff --git a/arch/loongarch/include/asm/kmalloc.h b/arch/loongarch/include/asm/kmalloc.h
> new file mode 100644
> index 000000000000..b318c41520d8
> --- /dev/null
> +++ b/arch/loongarch/include/asm/kmalloc.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_KMALLOC_H
> +#define __ASM_KMALLOC_H
> +
> +#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
> +
> +#endif /* __ASM_KMALLOC_H */

You wrote elsewhere that DMA is cache-coherent, so this should not
be needed at all.

> diff --git a/arch/loongarch/include/asm/shmparam.h b/arch/loongarch/include/asm/shmparam.h
> new file mode 100644
> index 000000000000..f726ac537710
> --- /dev/null
> +++ b/arch/loongarch/include/asm/shmparam.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_SHMPARAM_H
> +#define _ASM_SHMPARAM_H
> +
> +#define __ARCH_FORCE_SHMLBA    1
> +
> +#define        SHMLBA  (4 * PAGE_SIZE)          /* attach addr a multiple of this */
> +
> +#endif /* _ASM_SHMPARAM_H */

I think this needs to be defined in a way that is independent of the configured
page size to minimize the differences between kernel configuration visible to
user space.

Maybe make it always 64KB?

> diff --git a/arch/loongarch/include/asm/sparsemem.h b/arch/loongarch/include/asm/sparsemem.h
> new file mode 100644
> index 000000000000..9b57dc69f523
> --- /dev/null
> +++ b/arch/loongarch/include/asm/sparsemem.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LOONGARCH_SPARSEMEM_H
> +#define _LOONGARCH_SPARSEMEM_H
> +
> +#ifdef CONFIG_SPARSEMEM
> +
> +/*
> + * SECTION_SIZE_BITS           2^N: how big each section will be
> + * MAX_PHYSMEM_BITS            2^N: how much memory we can have in that space
> + */
> +#define SECTION_SIZE_BITS      29
> +#define MAX_PHYSMEM_BITS       48

Maybe add a comment to explain how you got to '29'?

> +
> +#ifdef CONFIG_PAGE_SIZE_4KB
> +#define PAGE_SHIFT      12
> +#endif
> +#ifdef CONFIG_PAGE_SIZE_16KB
> +#define PAGE_SHIFT      14
> +#endif
> +#ifdef CONFIG_PAGE_SIZE_64KB
> +#define PAGE_SHIFT      16
> +#endif

Shouldn't these be defined in some header?

        Arnd
