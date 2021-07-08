Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566F13C13C8
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jul 2021 15:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhGHNH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jul 2021 09:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhGHNHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jul 2021 09:07:25 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D445C061574
        for <linux-arch@vger.kernel.org>; Thu,  8 Jul 2021 06:04:44 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id k6so6522539ilo.3
        for <linux-arch@vger.kernel.org>; Thu, 08 Jul 2021 06:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZZs/jQW3zF4g0NWP+W7KfpidpABwMLYSHBH2t2Xoz8=;
        b=QiWX9Nq8k5qKAgqp6rQsqpClO8iBEtinEWIvb64N3YIMgQEoi0LOOPQCHSXI+jvLH+
         LBUo8I1Y7hfuUZM3difrmeINtTWzFy/PBbmLwxvtwFa0jbmkkxfyPSNNaOL0vINZQvxz
         pwX74svID+TOj8p4+yaYnp53purF3nPJi74QUvSg7J7NUGDbEm1DKAv9jYRBw6H14Kvb
         ArvqhHRvQSe00xtibklMJUEgMG/hcZSPHF7xrU0uhA/pWRjUOlgFDImN2joBk6ctariw
         tXA/hy7NS62JtACTPypZHEwUjNXLwmXtxfV7tbGLYHo2aF2OHHWqbb2Rs+b0bMm+PEhp
         fmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZZs/jQW3zF4g0NWP+W7KfpidpABwMLYSHBH2t2Xoz8=;
        b=UBdQGg0/pYkOTAn0Oej0oLlSsPYJE3esmzfLJJVg+xlBxWngmg1mw4bAqtlsLAQKCX
         27Nf9rfzNH8kKXNlbvMoq2MaUPFdG2TjXvjNcgGmSbje8wHGMZKs+uAf93B0TBPPqquS
         szJl6pwuwPYi5qFOM2KnmUn3ygG90PNYTctT6zZ7KUZ1pgV5qfFTT4ZRe7Cn0HBxcnMn
         lSfauMSMIFo9evhNy8HENso/QSaN/JaVcfQtQf65XYrAyawufnyfEiu7c+8x2HQvIsjt
         YqiqHSpxd0ynw1KyzR9qOY3jVPyC5g2hoQR/RbVp/mgm6ZTTdQDqE1ezGUR/6K/+jtRn
         ccOQ==
X-Gm-Message-State: AOAM533NJGTDqW8dX+NklXeRB1/mXeBWZ3CFVsd3YSCjMQCNeNVz+gop
        fgD/95p21KjPeNIMyQISZi/R1ap6CBcqdbNkys0=
X-Google-Smtp-Source: ABdhPJyl8IuDBgZShZUYGiUBbx1mttiGQihViF/q7anhmbf97zVMe//c8rPnceVmV+jQ4TnS3pZkS77LriZVQ6r0yOI=
X-Received: by 2002:a92:a00e:: with SMTP id e14mr22215656ili.126.1625749483754;
 Thu, 08 Jul 2021 06:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-11-chenhuacai@loongson.cn> <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
In-Reply-To: <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 8 Jul 2021 21:04:32 +0800
Message-ID: <CAAhV-H4WtGqgYF_zDhaS9+Ja7k=Zs8O2qWo5GqHDDf5cKw-zow@mail.gmail.com>
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
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
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd,

On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> >
> > This patch adds signal handling support for LoongArch.
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> Eric Biederman should review this part as well.
>
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/sigcontext.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2021 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_SIGCONTEXT_H
> > +#define _ASM_SIGCONTEXT_H
> > +
> > +#include <uapi/asm/sigcontext.h>
> > +
> > +#endif /* _ASM_SIGCONTEXT_H */
>
> Remove this file
OK, thanks.

>
> > + */
> > +#ifndef _UAPI_ASM_SIGINFO_H
> > +#define _UAPI_ASM_SIGINFO_H
> > +
> > +#if _LOONGARCH_SZLONG == 32
> > +#define __ARCH_SI_PREAMBLE_SIZE (3 * sizeof(int))
> > +#else
> > +#define __ARCH_SI_PREAMBLE_SIZE (4 * sizeof(int))
> > +#endif
>
> These are no longer used.
OK, thanks.

>
> > +
> > +#ifndef _NSIG
> > +#define _NSIG          128
> > +#endif
>
> Everything else uses 64 here, except for MIPS.
Once before we also wanted to use 64, but we also want to use LBT to
execute X86/MIPS/ARM binaries, so we chose the largest value (128).
Some applications, such as sighold02 in LTP, will fail if _NSIG is not
big enough.

Huacai
>
> > +#define _NSIG_BPW      __BITS_PER_LONG
> > +#define _NSIG_WORDS    (_NSIG / _NSIG_BPW)
> > +
> > +#define SIGHUP          1
> > +#define SIGINT          2
> > +#define SIGQUIT                 3
> > +#define SIGILL          4
> > +#define SIGTRAP                 5
> > +#define SIGABRT                 6
> > +#define SIGIOT          6
> > +#define SIGBUS          7
> > +#define SIGFPE          8
> > +#define SIGKILL                 9
> > +#define SIGUSR1                10
> > +#define SIGSEGV                11
> > +#define SIGUSR2                12
> > +#define SIGPIPE                13
> > +#define SIGALRM                14
> > +#define SIGTERM                15
> > +#define SIGSTKFLT      16
> > +#define SIGCHLD                17
> > +#define SIGCONT                18
> > +#define SIGSTOP                19
> > +#define SIGTSTP                20
> > +#define SIGTTIN                21
> > +#define SIGTTOU                22
> > +#define SIGURG         23
> > +#define SIGXCPU                24
> > +#define SIGXFSZ                25
> > +#define SIGVTALRM      26
> > +#define SIGPROF                27
> > +#define SIGWINCH       28
> > +#define SIGIO          29
> > +#define SIGPOLL                SIGIO
> > +#define SIGPWR         30
> > +#define SIGSYS         31
> > +#define        SIGUNUSED       31
>
> Please try to use the asm-generic version of these definitions instead
> copying them. If you need something different, you can add an #ifdef there,
> and then we can discuss whether the difference makes sense.
>
>
>         Arnd
