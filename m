Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1583B3B10AB
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 01:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhFVXiw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 19:38:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:60492 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhFVXiw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 19:38:52 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7A87820B83F2;
        Tue, 22 Jun 2021 16:36:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A87820B83F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624404995;
        bh=sbj5HIp4xJpRCiR6qVH+qNxqoKYrQm16hkrJ8Ci8owA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iETFZt5/lRZ/8BTZByARg+ERVKWkTbk+eqrO6mH7uWjdIqdt/rU7eHketabJGeRch
         eGMDrvb5bx3J4BbkeyaGrfFIjhgV8+ZUVq6I7CeT8/dyf94g3WA8rSUDJFYkFTkhxJ
         c2IKISNylmGLmTxemsFI32FvjdYBkBXsKMSj6Mfw=
Received: by mail-pl1-f178.google.com with SMTP id v12so111481plo.10;
        Tue, 22 Jun 2021 16:36:35 -0700 (PDT)
X-Gm-Message-State: AOAM531+QU0lbk39+aUbhBRa/4BJD8fBpmMRn9Xo9GP6yejuNsM9X70I
        aIKM2e5+EVbrlUPlEwu6t7MRCIsHK70P1I5AgkA=
X-Google-Smtp-Source: ABdhPJzJ/12H4j0kvVazrTUlwFMjCdoEf5U0mhOYx6FiB6v9DtkVqSO4D7wVK5OaLf5i8qBy3oCZnMdRev/C+dtZnBE=
X-Received: by 2002:a17:90b:4b49:: with SMTP id mi9mr6191693pjb.187.1624404994991;
 Tue, 22 Jun 2021 16:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-2-mcroce@linux.microsoft.com> <87f2cf0e98c5c5560cfb591b4f4b29c8@mailhost.ics.forth.gr>
In-Reply-To: <87f2cf0e98c5c5560cfb591b4f4b29c8@mailhost.ics.forth.gr>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Jun 2021 01:35:58 +0200
X-Gmail-Original-Message-ID: <CAFnufp0JuAvrOA89KDbcbhMeMvovoS96STVV+r53PLGJV4r0aw@mail.gmail.com>
Message-ID: <CAFnufp0JuAvrOA89KDbcbhMeMvovoS96STVV+r53PLGJV4r0aw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: optimized memcpy
To:     Nick Kossifidis <mick@ics.forth.gr>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 22, 2021 at 2:15 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> Hello Matteo and thanks for the patch,
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-06-17 18:27, Matteo Croce =CE=AD=CE=B3=CF=
=81=CE=B1=CF=88=CE=B5:
> >
> > @@ -0,0 +1,91 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * String functions optimized for hardware which doesn't
> > + * handle unaligned memory accesses efficiently.
> > + *
> > + * Copyright (C) 2021 Matteo Croce
> > + */
> > +
> > +#include <linux/types.h>
> > +#include <linux/module.h>
> > +
> > +/* Minimum size for a word copy to be convenient */
> > +#define MIN_THRESHOLD (BITS_PER_LONG / 8 * 2)
> > +
> > +/* convenience union to avoid cast between different pointer types */
> > +union types {
> > +     u8 *u8;
>
> You are using a type as a name, I'd go with as_bytes/as_ulong/as_uptr
> which makes it easier for the reader to understand what you are trying
> to do.
>

Makes sense

> > +     unsigned long *ulong;
> > +     uintptr_t uptr;
> > +};
> > +
> > +union const_types {
> > +     const u8 *u8;
> > +     unsigned long *ulong;
> > +};
> > +
>
> I suggest you define those unions inside the function body, no one else
> is using them.
>

They will be used in memset(), in patch 3/3

> > +void *__memcpy(void *dest, const void *src, size_t count)
> > +{
> > +     const int bytes_long =3D BITS_PER_LONG / 8;
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +     const int mask =3D bytes_long - 1;
> > +     const int distance =3D (src - dest) & mask;
>
> Why not unsigned ints ?
>

Ok.

> > +#endif
> > +     union const_types s =3D { .u8 =3D src };
> > +     union types d =3D { .u8 =3D dest };
> > +
> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>
> If you want to be compliant with memcpy you should check for overlapping
> regions here since "The memory areas must not overlap", and do nothing
> about it because according to POSIX this leads to undefined behavior.
> That's why recent libc implementations use memmove in any case (memcpy
> is an alias to memmove), which is the suggested approach.
>

Mmm which memcpy arch implementation does this check?
I guess that noone is currently doing it.

> > +     if (count < MIN_THRESHOLD)
> > +             goto copy_remainder;
> > +
> > +     /* copy a byte at time until destination is aligned */
> > +     for (; count && d.uptr & mask; count--)
> > +             *d.u8++ =3D *s.u8++;
> > +
>
> You should check for !IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) here.
>

I tought that only Little Endian RISC-V machines were supported in Linux.
Should I add a BUILD_BUG_ON()?
Anyway, if this is going in generic lib/, I'll take care of the endianness.

> > +     if (distance) {
> > +             unsigned long last, next;
> > +
> > +             /* move s backward to the previous alignment boundary */
> > +             s.u8 -=3D distance;
>
> It'd help here to explain that since s is distance bytes ahead relative
> to d, and d reached the alignment boundary above, s is now aligned but
> the data needs to be shifted to compensate for distance, in order to do
> word-by-word copy.
>
> > +
> > +             /* 32/64 bit wide copy from s to d.
> > +              * d is aligned now but s is not, so read s alignment wis=
e,
> > +              * and do proper shift to get the right value.
> > +              * Works only on Little Endian machines.
> > +              */
>
> This commend is misleading because s is aligned or else s.ulong[0]/[1]
> below would result an unaligned access.
>

Yes, those two comments should be rephrased, merged and put above.

> > +             for (next =3D s.ulong[0]; count >=3D bytes_long + mask; c=
ount -=3D
> > bytes_long) {
> > +                     last =3D next;
> > +                     next =3D s.ulong[1];
> > +
> > +                     d.ulong[0] =3D last >> (distance * 8) |
> > +                                  next << ((bytes_long - distance) * 8=
);
> > +
> > +                     d.ulong++;
> > +                     s.ulong++;
> > +             }
> > +
> > +             /* restore s with the original offset */
> > +             s.u8 +=3D distance;
> > +     } else
> > +#endif
> > +     {
> > +             /* if the source and dest lower bits are the same, do a s=
imple
> > +              * 32/64 bit wide copy.
> > +              */
>
> A while() loop would make more sense here.
>

Ok.

> > +             for (; count >=3D bytes_long; count -=3D bytes_long)
> > +                     *d.ulong++ =3D *s.ulong++;
> > +     }
> > +
> > +     /* suppress warning when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=
=3Dy */
> > +     goto copy_remainder;
> > +
> > +copy_remainder:
> > +     while (count--)
> > +             *d.u8++ =3D *s.u8++;
> > +
> > +     return dest;
> > +}
> > +EXPORT_SYMBOL(__memcpy);
> > +
> > +void *memcpy(void *dest, const void *src, size_t count) __weak
> > __alias(__memcpy);
> > +EXPORT_SYMBOL(memcpy);

Regards,
--=20
per aspera ad upstream
