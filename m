Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BCA03BC961
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 12:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbhGFKUP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 06:20:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:59951 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbhGFKUM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 06:20:12 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MrOq7-1lMxGY1YsZ-00oXuu for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021
 12:17:29 +0200
Received: by mail-wr1-f42.google.com with SMTP id v5so25427363wrt.3
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 03:17:29 -0700 (PDT)
X-Gm-Message-State: AOAM532o94GWLybr+tfDrYAu38b/JIOlol1A4WHc1hXGwr28aNE9yNUK
        GQlo0j4Z4v3qM31TUxBHYARzd3+bZYEB8pNu4wI=
X-Google-Smtp-Source: ABdhPJyef2lUiUA47yC2SruceTXxcQmfZGYDeWaSvvzvQMuwE1QGolOMSTAvC/Hw932h4ThjVemPchvi/9RM5VLAvgg=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr20809751wrn.99.1625566648987;
 Tue, 06 Jul 2021 03:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn> <20210706041820.1536502-11-chenhuacai@loongson.cn>
In-Reply-To: <20210706041820.1536502-11-chenhuacai@loongson.cn>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 12:17:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
Message-ID: <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
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
X-Provags-ID: V03:K1:6w7b1syhW3VaaeQ+nJ/6N2wNRoZgsbranYhJaGeN8KGQtAW8K6I
 BwgQYFyYKafeuF4gU/qATRYa9SSimj9P9RXtIOxSwA6GEFxqSSzuvnnNt1F29eE+aOMsH9n
 is20ffL+kqZvYxrWt6biMul4ENW1zE2tYs3/yPfsJPWmcK0i8ZFnWfFeWyRe8PyuvlUsdDp
 IW75kYZ3WRno6C3XbTbOw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iReEbFvVvZ8=:5fdN8sq9ymtFJwOuTwVqat
 qLJqz5MylhJ+8PyU8FvxU/g4k/ufRkPJppd17xca1mwK1jHbN2HnDZThni1CQjrRhuDe6saGg
 wtjgpK64nETngz5FwVXgs0ERndkM1tpy0TuePdykayUaXlpnr5EWPy3BR95VsBXu5EKw0rP3w
 uSkb2wM7RL49OTrSYyhqPk5TSj8dwOI3CyJH07GxHeZkp16i3kAuGdJt84NCeeaH9Zbt3kWhD
 GhMSZNVCUsnjMZlSuz5Wo56r3mxlo/jTnSnH+MUnumCY2KSFm3Tw3dfMk1Aw4tNqHLP5ZASa9
 C3gbwrLCEoPGA87cZA/CeZk3n31Cnb85LYvgSJMfqp2V0iag3x7vv9COlNgATxekZLHtwu8QT
 wOaUiCZmu1G0IeRODsy/MDuYgRuXyjQDvRtZlv1genyNK3/voLj2dQavHh7RuCjHrP37Ky3Hq
 ALGpz4M4IqGa+AdDLk0rci0FtLMg0gM7yhPKiTRYteMCNiXgaQJ4RxsEuDeEycRt6xztV6HTn
 GE8YnWdff2Afz6pCxLnkLqtEiqC6UnJ0CcfEoo9fsf6kfEcJkPXXx4ObmPuc7XxAExuCNNbsC
 m9YMX5zaChptc8eeqECKrpKpoABI8mJ0Ue9z1c1SWG3iElHCLKFpBIY8SXzW6oSZe3X8n/DdZ
 v5gfCFk1qleVGMGZKLZEawCOVzCKlx2TGAEnPgfhi8XfLuo2yy/Fo7PVG6c98njqhF+NvrFyg
 CoCcgy9DEHejUNpQ4dHSo/yAtRbeeFMLZObsGdrJMDzpkEVOhcF5lSeJl14v8xEcrJ1xFOCIq
 VSOCEICJCgJttlj+UY3WagErr0OVlm54C4xkDi3TxkHkygURMfc6SDcmNzkrqhV4HqOTllGrm
 KUo35EBIFOMMwsQr4Nll4DMhvUOtA2E2MgG886T0JE9YfBM7hDXKgxnIM8IQjb94RftAAPzBQ
 SX3yAGXYK0+4xiOQXXmpPSCJx6kh32DEaEEkcbmu79SyIybkuByNV
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
