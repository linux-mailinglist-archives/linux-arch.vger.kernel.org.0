Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3852774E
	for <lists+linux-arch@lfdr.de>; Sun, 15 May 2022 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiEOLm3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 15 May 2022 07:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiEOLm3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 15 May 2022 07:42:29 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346B6108A;
        Sun, 15 May 2022 04:42:28 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id t12so6255727vkt.5;
        Sun, 15 May 2022 04:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0QIIKjgXIHBycGsg2e3nh73aYUCNf0E8y4svNCOmUEM=;
        b=XwMI8qF01tzWluqrR3Cip6WZRsf8KARpiJXFU/IIKaqWLf+nD3L4YG1s5MWj/4Q/Vn
         UdtB9k6D+cE63dLyd2gQoLwDgfESbz9HGiDKUDo2D3SCJj1NOVwp3n9IhWJHEx5lQsN6
         YSZSMwDE4yy8LvXSLmKo2Sowu6zIOf8sH5grENVQAqjRlzblLBTcUGJhgJeQ9RHT5H5D
         aFPbhFRNslmwLuT5XgDqdoRNcnEPHp9jbFqeWOOPX1eG4HFRBY3p78Uq3SX8w0eU5Qzi
         quq2ByuGBCRqg1Dkv89p4+FjTjGxiunoM3mw4adqCoi9jZ4KUd0H3fGvXr8eNg0XBDGL
         ry3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0QIIKjgXIHBycGsg2e3nh73aYUCNf0E8y4svNCOmUEM=;
        b=V+J1w0TwXDkb3U2KZOz/q72NjbMLkcmI8lQNGtNl/lqIZ1mXOcP+OPZYjUhaKn3x4m
         my88hAHZHTiGabjdmbPs7mS3kAmoMMzQIRrzosnjKsDXQrOujeJV4rLD5ONZ4muTUctS
         jYjGlCrw3J4qWhOj3EFt1T09/biJJMB4OeyIVzhtqxU8nZp+XpWJb3A+0UUA1w64JjoK
         aW0c1n1JXs68bRNCtW/MVidoMqeHmZ0sb2/FgBEjN2J7K++HXRqXlBSPxM5WnwcGbG9g
         BknpMqPuEa3AkD1c4rapNfy3uSgwXDqR+2nMPkQ/thJp7AGoEVxHnOG2xPbKASs1Xjd8
         eTUw==
X-Gm-Message-State: AOAM532M8ZSsQoC9M0Ba4zmBWVXm7kCquToIbknkWNjsl98zMVfD3EkR
        ICfk8yyrjPLqShF9NBXN8dFZcOY2d8+ihEk8xtk=
X-Google-Smtp-Source: ABdhPJwoiFnUANCZHyZC+ZmHxdF25ImsKDG9CR2X431/4NEv8zCrRgXHvwdZGujZNtI068ikp2OK+z3CPlPz6fdB6xg=
X-Received: by 2002:a05:6122:179d:b0:34e:a817:dcb7 with SMTP id
 o29-20020a056122179d00b0034ea817dcb7mr4475775vkf.2.1652614946445; Sun, 15 May
 2022 04:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220514080402.2650181-1-chenhuacai@loongson.cn>
 <20220514080402.2650181-9-chenhuacai@loongson.cn> <YoBC2+2fvmNtcftr@zx2c4.com>
In-Reply-To: <YoBC2+2fvmNtcftr@zx2c4.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Sun, 15 May 2022 19:42:15 +0800
Message-ID: <CAAhV-H5+ypB8T9AtCoi5M7GuhMzCbn89GHt4f5XxQ9S++vH5WA@mail.gmail.com>
Subject: Re: [PATCH V10 08/22] LoongArch: Add other common headers
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
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
        Stephen Rothwell <sfr@canb.auug.org.au>
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

Hi, Jason,

On Sun, May 15, 2022 at 8:01 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Sat, May 14, 2022 at 04:03:48PM +0800, Huacai Chen wrote:
> > diff --git a/arch/loongarch/include/asm/timex.h b/arch/loongarch/include/asm/timex.h
> > new file mode 100644
> > index 000000000000..3f8db082f00d
> > --- /dev/null
> > +++ b/arch/loongarch/include/asm/timex.h
> > @@ -0,0 +1,31 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> > + */
> > +#ifndef _ASM_TIMEX_H
> > +#define _ASM_TIMEX_H
> > +
> > +#ifdef __KERNEL__
> > +
> > +#include <linux/compiler.h>
> > +
> > +#include <asm/cpu.h>
> > +#include <asm/cpu-features.h>
> > +
> > +/*
> > + * Standard way to access the cycle counter.
> > + * Currently only used on SMP for scheduling.
> > + *
> > + * We know that all SMP capable CPUs have cycle counters.
> > + */
> > +
> > +typedef unsigned long cycles_t;
> > +
> > +static inline cycles_t get_cycles(void)
> > +{
> > +     return drdtime();
> > +}
>
> Please add:
>
>     #define get_cycles get_cycles
>
> which is what other archs are getting for 5.19.
OK, thanks.

Huacai
>
> Jason
