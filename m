Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7CF52BFEE
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240551AbiERQ4P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240586AbiERQyk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 12:54:40 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF479201394;
        Wed, 18 May 2022 09:54:36 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id 90so1053905uam.8;
        Wed, 18 May 2022 09:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olguYhICHMpk2ctYiMxEpCHQEQIGnr/VO6tDtpsZhI4=;
        b=evhgvtGZikjzHZh4O3xNSDiWD6D3AEmA1+RNqZ2K5y0E2agNcv001H7iUC3Zhd8+dF
         L4xGeCtgjofqz9ru806hEF2EtlPJMeUmYAaDejjxeSZJCUafH4+sg7a6axt5Xc1aSkVN
         0AYRnM1mUmxpN1t3BPNGjm7fZA7kvI6pJ0CasVvL/VmhZJUxi602KGVb96aBlAeKSrE2
         nPCz2PvfbwOnEQG9Lem5EsX2Wa7e/ugBA29UDPJV+7aqd1ZALnWg50DJJvQ/83dareaC
         CBLSBAaYaNewA3NqSn+pbBd2vkd1MCvptA67T+4OeyQBXNdrXdhV9QcK8gpbaCD1luUP
         riXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olguYhICHMpk2ctYiMxEpCHQEQIGnr/VO6tDtpsZhI4=;
        b=Ed1fUtRpaIqhP0+KvUeYYMbu7hCxOtn4a4jFSAY+eJfnu0f7d0UcLriTtheUXWWfCn
         k+hZIseC5TkE/JdEF5YpElkZoSIxCE8UzwLipJP6Fkt8qcECu3xEWov4rXSSCLK/Is9S
         UNew9iEAZmGlNLHFqdhZQ1JGqP+rLTyoHKB2ogSlmXbCPWOlBEi4/aq0+4DkDBlbb8A0
         bHrTDJ75DrgtZBFnT8CGfDcLgoddi/A9ydqf7cYsHqMKtKyRwjBpFs1iAJ0DcpoB8ir8
         FUaTFobc2it+EiGFYq2BF3OENL2gPTKRW2Q0SmpWo908dWGjSonAaXMEJc7tWJW77M7n
         uo4A==
X-Gm-Message-State: AOAM532xxouWGlEdrCxGWmFtwjiFxh7tBU0AT3z9PYf0u2+ZXzp3MutY
        XJB8LOUU5ubX6tEmX7WqywKzlF9/d0pQWeaI1EE=
X-Google-Smtp-Source: ABdhPJxpr0Ba9x+SyqQxWYIRxlCA23EeQik362azVIbx1zBWRraLxOhiRXdlHoXPu29Z75Xqghi+NXJQGEDikvRW/88=
X-Received: by 2002:ab0:72d5:0:b0:368:aad4:5ef8 with SMTP id
 g21-20020ab072d5000000b00368aad45ef8mr373535uap.27.1652892876048; Wed, 18 May
 2022 09:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220518092619.1269111-1-chenhuacai@loongson.cn>
 <20220518092619.1269111-15-chenhuacai@loongson.cn> <87ilq294mg.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ilq294mg.fsf@email.froward.int.ebiederm.org>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 19 May 2022 00:54:24 +0800
Message-ID: <CAAhV-H5Aov1NVsbNWZa9psPhBiNssYWWEzNOyLooeXGKsYxN+w@mail.gmail.com>
Subject: Re: [PATCH V11 14/22] LoongArch: Add signal handling support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Eric,

On Thu, May 19, 2022 at 12:40 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Huacai Chen <chenhuacai@loongson.cn> writes:
>
> > Add ucontext/sigcontext definition and signal handling support for
> > LoongArch.
> >
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  arch/loongarch/include/uapi/asm/sigcontext.h |  44 ++
> >  arch/loongarch/include/uapi/asm/signal.h     |  13 +
> >  arch/loongarch/include/uapi/asm/ucontext.h   |  35 ++
> >  arch/loongarch/kernel/signal.c               | 566 +++++++++++++++++++
> >  4 files changed, 658 insertions(+)
> >  create mode 100644 arch/loongarch/include/uapi/asm/sigcontext.h
> >  create mode 100644 arch/loongarch/include/uapi/asm/signal.h
> >  create mode 100644 arch/loongarch/include/uapi/asm/ucontext.h
> >  create mode 100644 arch/loongarch/kernel/signal.c
> >
> > diff --git a/arch/loongarch/include/uapi/asm/sigcontext.h b/arch/loongarch/include/uapi/asm/sigcontext.h
> > new file mode 100644
> > index 000000000000..be3d3c6ac83e
> > --- /dev/null
> > +++ b/arch/loongarch/include/uapi/asm/sigcontext.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > +/*
> > + * Author: Hanlu Li <lihanlu@loongson.cn>
> > + *         Huacai Chen <chenhuacai@loongson.cn>
> > + *
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _UAPI_ASM_SIGCONTEXT_H
> > +#define _UAPI_ASM_SIGCONTEXT_H
> > +
> > +#include <linux/types.h>
> > +#include <linux/posix_types.h>
> > +
> > +/* FP context was used */
> > +#define SC_USED_FP           (1 << 0)
> > +/* Address error was due to memory load */
> > +#define SC_ADDRERR_RD                (1 << 30)
> > +/* Address error was due to memory store */
> > +#define SC_ADDRERR_WR                (1 << 31)
> > +
> > +struct sigcontext {
> > +     __u64   sc_pc;
> > +     __u64   sc_regs[32];
> > +     __u32   sc_flags;
> > +     __u64   sc_extcontext[0] __attribute__((__aligned__(16)));
> > +};
> > +
> > +#define CONTEXT_INFO_ALIGN   16
> > +struct _ctxinfo {
> > +     __u32   magic;
> > +     __u32   size;
> > +     __u64   padding;        /* padding to 16 bytes */
> > +};
>
> This is probably something I a missing but what is struct _ctxinfo and
> why is it in a uapi header?
>
> I don't see anything else in the uapi implementation using it.
This is used by get_ctx_through_ctxinfo() in signal.c and I think
similar function is also needed by userspace.

Its name is once before called context_info but conflict with another
software, then I want to use ctx_info but conflict with another kernel
struct. :(
>
> Symbols that start with an underscore "_" are reserved and should not
> be used in general, and especially not in uapi header files.
Then, maybe we can use sctx_info here?

Huacai
>
> Eric
