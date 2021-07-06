Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB133BCB12
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhGFK7p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:59:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231516AbhGFK7p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 06:59:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20961619F1
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569027;
        bh=LmxEK85ZlHQvIsHOeKU443Ouv/MnOGHkYSbny2fs6Vw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FnQ8fStL7AHYLZdlpWUGrsbkexxTUZcalof8nd+kz66bgWeUOuNRWT1CqpQP7ienr
         nipxY0GrupQDfaNOGvWC39ME2j3ngEXenWoWfh7aa/5rdEj7o/QjGQQ2Z8K+ZXw7Ay
         rsVfzIo+hOsr7Sb90ZijnTiN/mVZlYbyjrl0SHZhGuPPZWmhYtnWlIoDq4c9//K94/
         TlQnPHR48BQ7NQCF9LIbBZN3070qvtULN8yVf/gBPeZiTuaEMYOvFUE719F+VtUYj/
         QpR/lK+DsgblC8YQzHXkdyAzkPLB2MjNjoh3rQDcTF2MI3ipLBzppC/jjhaKK209n/
         rVaMLI17sMytg==
Received: by mail-wr1-f50.google.com with SMTP id l5so8806873wrv.7
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:57:07 -0700 (PDT)
X-Gm-Message-State: AOAM531AvIsP7WbtODzgwoQYVWvEwh+lg30KiMiPHFrAAPp6N54uW7HL
        qlONMWF4g8jlmRLD5tCfqwiOvEtWnYaiidKx5Nw=
X-Google-Smtp-Source: ABdhPJwj4oNr1Bn7DHLF2dhAof/eSE3cUrCSqTg5+puUWADI3qdWBUZbsiAX0pnexbt0DJB13FFkaB274831i64kZTk=
X-Received: by 2002:adf:e107:: with SMTP id t7mr21120756wrz.165.1625569025734;
 Tue, 06 Jul 2021 03:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-7-chenhuacai@loongson.cn> <CAK8P3a3UZE51FaqPHYf6_Qwyf+szVusezoceMZwHuvVTO6S39w@mail.gmail.com>
In-Reply-To: <CAK8P3a3UZE51FaqPHYf6_Qwyf+szVusezoceMZwHuvVTO6S39w@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 12:56:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=CnMm0+cZVrfEm+aub1dqcoF=O=+E8p3SUnXaCAbFsw@mail.gmail.com>
Message-ID: <CAK8P3a1=CnMm0+cZVrfEm+aub1dqcoF=O=+E8p3SUnXaCAbFsw@mail.gmail.com>
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
across architectures and use that instead.

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
