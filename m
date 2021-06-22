Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054A93B0FC3
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 00:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhFVWDB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 18:03:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48778 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhFVWC7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 18:02:59 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id A6A9B20B83F5;
        Tue, 22 Jun 2021 15:00:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6A9B20B83F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624399242;
        bh=t0zy+aEJbbWfr+b93GwBhrR1JhR/zUqTNz5gXaWTwg0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SthROkxDDu/QhydPs+YRpFqCj5N7QPI564vrNLrGm2nU8AvseLaV1Hpft4Ul4nWkb
         jU9o73zefEx59IGK6yNySyKHHfaJtm+q76mAUOd4OS9rKIUBo8HEinBp76qGvYa+qL
         8ntS0oZORP+7/XTu1pGZr7lINneFoErlFY+KFfCg=
Received: by mail-pl1-f180.google.com with SMTP id m17so11425plx.7;
        Tue, 22 Jun 2021 15:00:42 -0700 (PDT)
X-Gm-Message-State: AOAM5339bJcHDNBiW42PW5sybvHNYF2YGI8Ad1wtBJOj5YGQQqPURx1I
        Mlc03melbrjL+UoPejPhJXjQrcjG6n/2nXu8LkE=
X-Google-Smtp-Source: ABdhPJyv1SBZhrTityd2+MnaNiG0YScqu6u6GGO+94AaR/jITunJ/1zxDMO/c+aBvN9vVivCQaTUKtAo1Zcegix/+ug=
X-Received: by 2002:a17:902:e9d5:b029:124:926:7971 with SMTP id
 21-20020a170902e9d5b029012409267971mr13690483plk.19.1624399242143; Tue, 22
 Jun 2021 15:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-2-mcroce@linux.microsoft.com> <YNChl0tkofSGzvIX@infradead.org>
In-Reply-To: <YNChl0tkofSGzvIX@infradead.org>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Jun 2021 00:00:06 +0200
X-Gmail-Original-Message-ID: <CAFnufp2UaAEq8FCxSeX5xCOZYu4wJ783gy35RZF-D626XiF8MQ@mail.gmail.com>
Message-ID: <CAFnufp2UaAEq8FCxSeX5xCOZYu4wJ783gy35RZF-D626XiF8MQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: optimized memcpy
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 21, 2021 at 4:26 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Jun 17, 2021 at 05:27:52PM +0200, Matteo Croce wrote:
> > +extern void *memcpy(void *dest, const void *src, size_t count);
> > +extern void *__memcpy(void *dest, const void *src, size_t count);
>
> No need for externs.
>

Right.

> > +++ b/arch/riscv/lib/string.c
>
> Nothing in her looks RISC-V specific.  Why doesn't this go into lib/ so
> that other architectures can use it as well.
>

Technically it could go into lib/ and be generic.
If you think it's worth it, I have just to handle the different
left/right shift because of endianness.

> > +#include <linux/module.h>
>
> I think you only need export.h.
>

Nice.

> > +void *__memcpy(void *dest, const void *src, size_t count)
> > +{
> > +     const int bytes_long = BITS_PER_LONG / 8;
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +     const int mask = bytes_long - 1;
> > +     const int distance = (src - dest) & mask;
> > +#endif
> > +     union const_types s = { .u8 = src };
> > +     union types d = { .u8 = dest };
> > +
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +     if (count < MIN_THRESHOLD)
>
> Using IS_ENABLED we can avoid a lot of the mess in this
> function.
>
>         int distance = 0;
>
>         if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
>                 if (count < MIN_THRESHOLD)
>                         goto copy_remainder;
>
>                 /* copy a byte at time until destination is aligned */
>                 for (; count && d.uptr & mask; count--)
>                         *d.u8++ = *s.u8++;
>                 distance = (src - dest) & mask;
>         }
>

Cool. What about putting this check in the very start:

        if (count < MIN_THRESHOLD)
                goto copy_remainder;

And since count is at least twice bytes_long, remove count from the check below?
Also, setting distance after d is aligned is as simple as getting the
lower bits of s:

        if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)) {
                /* Copy a byte at time until destination is aligned. */
                for (; d.uptr & mask; count--)
                        *d.u8++ = *s.u8++;

                distance = s.uptr & mask;
        }

>         if (distance) {
>                 ...
>
> > +             /* 32/64 bit wide copy from s to d.
> > +              * d is aligned now but s is not, so read s alignment wise,
> > +              * and do proper shift to get the right value.
> > +              * Works only on Little Endian machines.
> > +              */
>
> Normal kernel comment style always start with a:
>

Right, I was used to netdev ones :)

>                 /*
>
>
> > +             for (next = s.ulong[0]; count >= bytes_long + mask; count -= bytes_long) {
>
> Please avoid the pointlessly overlong line.  And (just as a matter of
> personal preference) I find for loop that don't actually use a single
> iterator rather confusing.  Wjy not simply:
>
>                 next = s.ulong[0];
>                 while (count >= bytes_long + mask) {
>                         ...
>                         count -= bytes_long;
>                 }

My fault, in a previous version it was:

    next = s.ulong[0];
    for (; count >= bytes_long + mask; count -= bytes_long) {

So to have a single `count` counter for the loop.

Regards,
-- 
per aspera ad upstream
