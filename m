Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA23BC954
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbhGFKTc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:19:32 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43943 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhGFKTb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:19:31 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MKKd7-1ll5tT1I0F-00LlyU for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 12:16:52 +0200
Received: by mail-wr1-f44.google.com with SMTP id v5so25425219wrt.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:16:52 -0700 (PDT)
X-Gm-Message-State: AOAM532IDM60tFfn6xrNe40/vGQCeMtxUiCalJFfQUQMIZceABvX0m7h
        5gbngN04NLU8oPZDaLY5e0jIacqievyevX9p2k4=
X-Google-Smtp-Source: ABdhPJxdty5d2sVxPMrdcNMw2inDjER9G6kA0ZlRUlfV+HbvOQlBlixBPai9ud24plAba4KIoXE95TcRxtE9GzkGxvc=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr20806013wrn.99.1625566606967;
 Tue, 06 Jul 2021 03:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-7-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-7-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:16:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3UZE51FaqPHYf6_Qwyf+szVusezoceMZwHuvVTO6S39w@mail.gmail.com>
Message-ID: <CAK8P3a3UZE51FaqPHYf6_Qwyf+szVusezoceMZwHuvVTO6S39w@mail.gmail.com>
Subject: Re: [PATCH 06/19] LoongArch: Add exception/interrupt handling
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
X-Provags-ID: V03:K1:exAM8/ZNZUF611AYMX8Hi3mYJpbNzEPHy2GQEfz//q8f8u5OIh3
 9YHiiZ0GsZV/3+EAA/trx3yj47Eav3/z+PL8yv9VZLKLbZL/3YZL1M+hd4RfgHJlgarwT20
 QVnsmEUYE+c23oqvotFF0qW77HqE6juGL8v1H3LpWgx+GLgtG7Cpv7YWrfIF4MrwBTWyHa2
 7L2sM/Est30keMcyLx/oQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XEESP+VHi0s=:WIR3lQ6aVRLlKpWX38wPiF
 YItQl8AYvRGYbw5Nk2OCYjxxUKYoE3F8PW15rDP2lIAgcnTsW5/jGXsDUytU86Hwc7oiyyktT
 SsY4Q2iT+y0tM7AmaBtouaomacY6kyaBKds7GByg+xTg1CbcMruWuCBl7D4BE/vMzhGs6c8T7
 yvTkLhzkGwSGrsoNjP+k0n07SK5dWD7RngKGf+gg5pFb37mm2PkrR6Hi6/lo9UfBhR+8kcgU4
 rO3gnZMeabzMmkOUk8AcHL6KZqw5ybDPtx+0Nq13V5ExEx9Jb0OnNHxo7vL5/skNGbjj2ddHD
 5iyaHslm5EXKKRb4TwNJsDhMAoh9PR67yYSH99Azd8W+LiT/7maivmtNJuH6k/iOV3VqXMGf/
 c9HcVfhalT8Mrv17E7m4G0S7WENBu94PTMENTkyz9jFgBWyfOdDpBrihmKVSkAkuocviCqdW5
 XZ3cD657Ws4A8swScevcMoGQB6FjaW1N2AwftSZ2JvfzTkae1S9HmT8wBxp5C9bGI8G+7eP/b
 31fh53Gt90Mm4hd8uekJiad/CCdZS3j6wa9CAMYu3C8LzXQcfKOHVFejD4wASwC5+YFMOBycf
 0dfvPLICJoxtmSl55cri00JRjXm9yn0pAP51fJunSZKpgRyRYOseK0E7oiN7lp0kW0qJRnfV9
 ShG5+95GC5V1FKFJJfCLBX29ApaXE9EoTBr6xPna5aQmmlngGdDC9BIcY6Y1R1BoBF2poOOXB
 n4wxAQiye0WAY64ZT2Sspb9S7ZdhIgg1+leD1KS4UypB4dHhXUzVVY9MO8WTFncZiwWsdULif
 Bo89Hm8xX1Kd/plHNvjY6lK7ADwrdEbQpYYGaKAzsfkKCurB1unL2fDKmDcvoCmnDrE0mFfXx
 kA68mo6zSVpe3SO2+KbfSZNUlLNTSMgxw4/zUb6edc0Jn6dMvqeWPayl2t242CVtvm9ga5gIq
 q6fCJXsnivoA/p7FfsaktnBhthp7WR0TjigjEIumhsd2eBIHPIsHV
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:

> diff --git a/arch/loongarch/include/asm/break.h b/arch/loongarch/include/asm/break.h
> new file mode 100644
> index 000000000000..109d0c85c582
> --- /dev/null
> +++ b/arch/loongarch/include/asm/break.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_BREAK_H
> +#define __ASM_BREAK_H
> +
> +#include <uapi/asm/break.h>
> +
> +#endif /* __ASM_BREAK_H */

The file can be removed.

> --- /dev/null
> +++ b/arch/loongarch/include/asm/debug.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __LOONGARCH_ASM_DEBUG_H__
> +#define __LOONGARCH_ASM_DEBUG_H__
> +
> +#include <linux/dcache.h>
> +
> +/*
> + * loongarch_debugfs_dir corresponds to the "loongarch" directory at the top
> + * level of the DebugFS hierarchy. LoongArch-specific DebugFS entries should
> + * be placed beneath this directory.
> + */
> +extern struct dentry *loongarch_debugfs_dir;

I see this one is used for the alignment trap handling, which on other
architectures
is part of sysctl. Try to see what the most common implementation is
across architectures
and use that instead.

I think there also needs to be a discussion about how to handle alignment traps
in general, so maybe split out all alignment handling into a separate patch.

> diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/unaligned.c
> new file mode 100644
> index 000000000000..d66e453297da
> --- /dev/null
> +++ b/arch/loongarch/kernel/unaligned.c
> @@ -0,0 +1,461 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Handle unaligned accesses by emulation.

Can you explain in this comment what the CPU can or cannot do? Are all
memory accesses assumed to be naturally aligned? Is any of the CPU
implementation dependent?

        Arnd
