Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889543BC966
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhGFKVA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:21:00 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:58539 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKVA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:21:00 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mna0x-1lHzCb4BRF-00jbJz for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 12:18:21 +0200
Received: by mail-wm1-f53.google.com with SMTP id j39-20020a05600c1c27b029020028e48b8fso1337129wms.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:18:20 -0700 (PDT)
X-Gm-Message-State: AOAM5310u0Ifd9fPQxJVqLsdu1iHCts9oWj5ziN1ZcDDbg1zw+EOLAN+
        kpvXBRO+38MZhmMIyj5G6F26s2n4PQzFTtXRWIA=
X-Google-Smtp-Source: ABdhPJy3PAPMlhJaaFOH+rBGp4Qg6DocjuhXRxvZxuuRK2egXavJUwFC+M+bh8iq+33R5NrVbjHExEkVd19Pw6y/amM=
X-Received: by 2002:a05:600c:4101:: with SMTP id j1mr3967081wmi.84.1625566700718;
 Tue, 06 Jul 2021 03:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-19-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-19-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:18:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2444qoaDJFvp-t2EzrZ2W6T-m_DPJbDAdJeSB-auV8gA@mail.gmail.com>
Message-ID: <CAK8P3a2444qoaDJFvp-t2EzrZ2W6T-m_DPJbDAdJeSB-auV8gA@mail.gmail.com>
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
X-Provags-ID: V03:K1:s6C/4yDjgFIhzPp96V2o9xMG/HdurkENkJ2iSLItmGsgmsNsiAK
 NhAY4XnE5wBif8lg1SkN3TuJzokeuUZBkTF6Fy4XDHYBekfn49xuVEdTNO19uBh4iAnKBm/
 yPJ9lrFk0YT9xY8ur3b2qs95ggKO7Tv0qaf9O3692a5RAStS0AZY863XmrYeInlkiGsM9ZN
 vKDRrMe/KCQb3gkUD3ZyQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aOB/j8PnNqQ=:DgB1mFSgw0ucdh80J5Zumj
 rQwCiAvboTXPwyGSkcgmoyarvG+UccZl2FQEAeX8dnfUUYWUyVRJ+521yhwmXU5noqM0Sevr9
 GRR/5DQJKPbenKomnUfCcwcQ1f4DfltcWqJkwP4PAnlVBkgRJ19rmgZ9zDb3eu4ZwqWCjYdnj
 6NVOz6cAOnhjiNJnayURJ5XJG/ueQN4FjIw65N0J1piTG8vXOYohklw1OuRcSIvhtThsZStHh
 YMv3Z4D6LkuLeF5RsbNt98l8DThVxeo0rYf+eV+If05OIAO+EYkYw0xycoms1ILqIiyxJ3SeA
 LzKmPQNS7c6zay4NaflvBZXwNMZacZZK8Z/xhCkTYcu9tTQxUSdtNLEKkK1zSk8921vaQYtpl
 jwuhQsxRf4zWG8bfgq50UnR77Jj5F+9eDZnIKwls2YC2MpJcevnlujg8aD49vgLXX23fPlivM
 I9P4CmtLHhz0xEI8ccJJh1fuPjxNnSHZVn2PJCOywgGZq5jqNtlYJW0oEWWVlmQo2qy6nw0UL
 U7L//cEyebIg261a3gN2QjNXcbqKdlLosXk2kIglCpLKevKYTbmTV4WWXeDiWg9501pMvffkf
 ApSk7x24zg1Qf8+Ed9ETdYJSltJMtTAhhhJKlod/d6CAz/V3wBdytP1UuWeedIKufdF5nNh1I
 V25oj+6DNoqStMDrfMMgFM6utW3JepRga4UqXtjN7cVi6NOtP+5OaS3Q8KEy/JoJhdYWtWWi7
 nVC/bRRG/M02AnO+OdCT7vj8XkinwskdFtzExPSOWFSLMsI4/W07hHy6VPiaO6Jr/LV/HgxiC
 aowxJtx/GfIU51US1D1owPqfQjiwUZQbioVc6gBQ82ds/kwFtDtmirsXyFOQKksJV7VROmeGX
 l8WvhMtmbzFPquG/s3QJu9zes+XFmcfx03oAKG36MKSgs79r3nx3GP8iilfEGLu9/xkWG43vJ
 SfQAyT2/nJq2yaowo7YiZWYhp6uB5Zs5XT5r4qt2cekaav/Y3z7Qg
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
