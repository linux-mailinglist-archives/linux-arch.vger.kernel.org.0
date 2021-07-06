Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E33BCB35
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231504AbhGFLCE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 07:02:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231449AbhGFLCD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 07:02:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8720061A14
        for <linux-arch@vger.kernel.org>; Tue,  6 Jul 2021 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625569165;
        bh=tVtaM8z27KITOygRbvcEMEeePrYZbSGgKEc1FPnRQ/Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ixddJH3ZaLa6EVLphVjszxjHmRySVGqTSHwKWMOwuhavIBoxkicdldPB0Jgg4N05E
         gGDQLgkYeeBZ0eOOhJsNlGYCC3jsKQUhq+x3FeFFLum7ks4v54t8oQBX+Fji71p8Pe
         zu87wd4kYGZJ3Gnfcdz+TYOy+ATvji9l+To2XxDGTzaRAECKH35xqrttYiOWbD+FY0
         s4WFtuxTUqVsC3cFW9wof+NeSZLDz+tXlY2nUzdXloDUYjcebCY3Zf4mysbdQgs6B7
         vBONUpTk6isFRxn2aTFcfkLB7TWuOJSYVaCNQ6gAp81q61Ekhb6rZjazO7Ha2IcLjP
         KUleAHnWTVaFQ==
Received: by mail-wr1-f53.google.com with SMTP id t6so15628736wrm.9
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:59:25 -0700 (PDT)
X-Gm-Message-State: AOAM5335KQdWy2J+YQTwLcG5/DKcXv75QE73WNSwEbxsdikDkSihFpn0
        k8xlBxt0ygx/H829apq2BflSWIz2j7we0ZRkb3w=
X-Google-Smtp-Source: ABdhPJwayYNnjp5whAiOTItSD+GXAtZHe7Ca55ezeI/apbpTDAy8ac+CLFiRi1GsLT35jBVVwfFyqcDo1RlL/dP0OyY=
X-Received: by 2002:adf:fd8e:: with SMTP id d14mr21914697wrr.361.1625569164145;
 Tue, 06 Jul 2021 03:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-11-chenhuacai@loongson.cn> <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
In-Reply-To: <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 6 Jul 2021 12:59:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a18XN1X=mz+5TMmsvHuiggDybenyod18SMh0kQ2kwTqYA@mail.gmail.com>
Message-ID: <CAK8P3a18XN1X=mz+5TMmsvHuiggDybenyod18SMh0kQ2kwTqYA@mail.gmail.com>
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
>
> This patch adds signal handling support for LoongArch.
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Eric Biederman should review this part as well.

> --- /dev/null
> +++ b/arch/loongarch/include/asm/sigcontext.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_SIGCONTEXT_H
> +#define _ASM_SIGCONTEXT_H
> +
> +#include <uapi/asm/sigcontext.h>
> +
> +#endif /* _ASM_SIGCONTEXT_H */

Remove this file

> + */
> +#ifndef _UAPI_ASM_SIGINFO_H
> +#define _UAPI_ASM_SIGINFO_H
> +
> +#if _LOONGARCH_SZLONG == 32
> +#define __ARCH_SI_PREAMBLE_SIZE (3 * sizeof(int))
> +#else
> +#define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
> +#endif

These are no longer used.

> +
> +#ifndef _NSIG
> +#define _NSIG          128
> +#endif

Everything else uses 64 here, except for MIPS.


> +#define _NSIG_BPW      __BITS_PER_LONG
> +#define _NSIG_WORDS    (_NSIG / _NSIG_BPW)
> +
> +#define SIGHUP          1
> +#define SIGINT          2
> +#define SIGQUIT                 3
> +#define SIGILL          4
> +#define SIGTRAP                 5
> +#define SIGABRT                 6
> +#define SIGIOT          6
> +#define SIGBUS          7
> +#define SIGFPE          8
> +#define SIGKILL                 9
> +#define SIGUSR1                10
> +#define SIGSEGV                11
> +#define SIGUSR2                12
> +#define SIGPIPE                13
> +#define SIGALRM                14
> +#define SIGTERM                15
> +#define SIGSTKFLT      16
> +#define SIGCHLD                17
> +#define SIGCONT                18
> +#define SIGSTOP                19
> +#define SIGTSTP                20
> +#define SIGTTIN                21
> +#define SIGTTOU                22
> +#define SIGURG         23
> +#define SIGXCPU                24
> +#define SIGXFSZ                25
> +#define SIGVTALRM      26
> +#define SIGPROF                27
> +#define SIGWINCH       28
> +#define SIGIO          29
> +#define SIGPOLL                SIGIO
> +#define SIGPWR         30
> +#define SIGSYS         31
> +#define        SIGUNUSED       31

Please try to use the asm-generic version of these definitions instead
copying them. If you need something different, you can add an #ifdef there,
and then we can discuss whether the difference makes sense.

        Arnd
