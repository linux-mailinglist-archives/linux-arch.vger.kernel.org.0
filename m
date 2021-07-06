Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065913BC958
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGFKTs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:19:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:34787 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbhGFKTs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:19:48 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MLRI3-1lk0V52pV5-00IQXB for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021
 12:17:08 +0200
Received: by mail-wr1-f50.google.com with SMTP id t6so15486045wrm.9
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:17:08 -0700 (PDT)
X-Gm-Message-State: AOAM532Lt1JmPWkxiWiXDgcHjEfVB1POs7kfyWuO9fkzjPELTicVwvQZ
        0IWZALBnLh5uJfIvq+cFWvZzSSSYeXekPK98ESQ=
X-Google-Smtp-Source: ABdhPJxSSRGEkOTBwRyc83HoZfff9aIidMO/vDnjHhdpAbxlk36ybOHy/Gy5VKls8tTuCCmQnRVhrbPx9OB9TquWdm0=
X-Received: by 2002:a5d:6485:: with SMTP id o5mr21542838wri.286.1625566628331;
 Tue, 06 Jul 2021 03:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-9-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-9-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:16:52 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Hr7TbuO6LBVC5p5AghWc3j-NCSi8rwd3aq5o8g=Jk1w@mail.gmail.com>
Message-ID: <CAK8P3a2Hr7TbuO6LBVC5p5AghWc3j-NCSi8rwd3aq5o8g=Jk1w@mail.gmail.com>
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
X-Provags-ID: V03:K1:jq+n9LgDVteEdiuwzDDJ0+pvSgdnMD2V9lez2ZFxgZE6VsAYPwf
 FRZdcl6pccs6ynb2KP6Ia6fVAOHrZ8Qv34Pw0t3mj7pNtaVAdDjX6PwUOnERqDuqAtR1SwI
 mjjG3DZL2HDUUVkb1ostLQRrnwMbjnBOALKo8IDBetgfAHUA/4fZowdGZ4srWet+xdf1Qo8
 e0YCONS35jLjqR+6rYGMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:xRgO3ie1NS8=:2aARujORU6teoMj5Z3OZip
 8m2ubTqnc9Qoe3HdS/a9isacN/Pkfgm0YNulEZWzqUyKrjD3MUMwoAg4JUPl7IBE3zUynAYFG
 43NffkQdOPacBuUBs+yX9Yf9jM9/mI2S9rCSfzuzUDKNrkLkblSpwUreQLCH06VPBfB2ilkoi
 i7HuArTYanXGvocMFKgQNS8l1ncyMzZlbS2utiwe7kegq1gsBzlhS9c23RBHiv2lVjmOi3JKO
 FQK1ec/ZHpr5LtdadvAxmxAn3nC2eBOU6+OqvG39mm+0Jn+oDF5lKfk0fP/z6sHWjFTyUu3M9
 QqVnmae+Per7wLpbwJ/RF034mpxZH9XcqvM94A9XIk5F27wHGTiovasoBNdJjG0pflmzrRB3z
 reKjs1n889yl6OFZdcERzR1sKgjFqQXu7+US3/hbrfBHnM3EGEHNdXeRNHlZ1A1Jh/piDkNHl
 TJqyJ4q3Up2WasPhhKhHn4zBI1UCvhb48rAqkxyfsBJrJext6VX/6t/j4e7xFouVTHxizWftM
 Jx6Fc3r7z+5eQ2wZQAqmXNfRDk+XQUSsqUK7j0JwTAM9Qqw2QQ/51oSPZD390kf+WhFp6ltY2
 rDhZXRVj15I/s9Hjh5leacWODaEvdCWdTcqALMjgje5mZY5zy2xxaVbiD/HzH6EBTpYjrj1sC
 CRnqE0RG5z+QYcIEQ3Yyl/a3DQOyxgeZBzhCwZT2PSo9d8pLj/KAx5rxx/EWXhf88Gnd3Df9J
 boX1qMZ+uLn/T5nK/61LIeGc60aiP1E8qsoZq3PNCPQU1EIwYlERUPiWyDSdL6AGaDvICAJ7U
 wzoYvYLeg7qle05d2daXmDPFC5icvBkY6EpakaXpWPF6j7/58WEp2w58j2ueDuIIaOwk5GM/Q
 9D0/epuA7B6vp4Y4YczYHCq8wk3KJ5Z3NcG4pLwiKO3ryJVI6Pylpm9i7iuZXiHfKMhE4yWZN
 L3z0j3oiVyo5NvEafoGCvSpo2f5ZrIHTQtMaLPpV14VrhhgjU0Pdn
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
