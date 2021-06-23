Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC743B10F4
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 02:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFWALY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 20:11:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:36300 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFWALX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 20:11:23 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by linux.microsoft.com (Postfix) with ESMTPSA id C888620B83F8;
        Tue, 22 Jun 2021 17:09:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C888620B83F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624406946;
        bh=u2Kpz6rC+qyNeuxX3/et2fXCG3LMTAAce/YCvewjL6E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F4AOWiKu4E4h8PeZ+1b5zD/OPMJjF/iErqq054eAH9I+TQGvhmgXZUSDaiVHWwNzp
         S2hkjc5K50UVLhNClLCdYeM1Bt4539F+/WDkIIQvSO3k0drL6oSZmsJrHuvpJKC2Hu
         88/YaHSeaNArfCVE5ZApQK2rM6mUG/cPgaci2rT0=
Received: by mail-pl1-f170.google.com with SMTP id y21so161262plb.4;
        Tue, 22 Jun 2021 17:09:06 -0700 (PDT)
X-Gm-Message-State: AOAM533g27J4Oe94/ICrLtt1qy8a6vX+g0DnOKfOa4DytwHMUvzFfCe3
        WUXzNmmpSqACCto2ZDMAccgXhuPYsXVBZ+7UtC4=
X-Google-Smtp-Source: ABdhPJxADUAYw2fWMz82whP6EvMifZHPYm6r/owIfLNMTB5E0CccJG2Rjp2DhW6xHkiWbi/cyVI7XdSkrm/6g3tmaSo=
X-Received: by 2002:a17:903:304e:b029:11d:75ff:c304 with SMTP id
 u14-20020a170903304eb029011d75ffc304mr24509944pla.33.1624406946257; Tue, 22
 Jun 2021 17:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-4-mcroce@linux.microsoft.com> <17cd289430f08f2b75b7f04242c646f6@mailhost.ics.forth.gr>
In-Reply-To: <17cd289430f08f2b75b7f04242c646f6@mailhost.ics.forth.gr>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Jun 2021 02:08:30 +0200
X-Gmail-Original-Message-ID: <CAFnufp2w1TGtaBjfTtsBpDatgAtATRZbB4MURV3tLh1fi-W1JQ@mail.gmail.com>
Message-ID: <CAFnufp2w1TGtaBjfTtsBpDatgAtATRZbB4MURV3tLh1fi-W1JQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: optimized memset
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

On Tue, Jun 22, 2021 at 3:07 AM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-06-17 18:27, Matteo Croce =CE=AD=CE=B3=CF=
=81=CE=B1=CF=88=CE=B5:
> > +
> > +void *__memset(void *s, int c, size_t count)
> > +{
> > +     union types dest =3D { .u8 =3D s };
> > +
> > +     if (count >=3D MIN_THRESHOLD) {
> > +             const int bytes_long =3D BITS_PER_LONG / 8;
>
> You could make 'const int bytes_long =3D BITS_PER_LONG / 8;' and 'const
> int mask =3D bytes_long - 1;' from your memcpy patch visible to memset as
> well (static const...) and use them here (mask would make more sense to
> be named as word_mask).
>

I'll do

> > +             unsigned long cu =3D (unsigned long)c;
> > +
> > +             /* Compose an ulong with 'c' repeated 4/8 times */
> > +             cu |=3D cu << 8;
> > +             cu |=3D cu << 16;
> > +#if BITS_PER_LONG =3D=3D 64
> > +             cu |=3D cu << 32;
> > +#endif
> > +
>
> You don't have to create cu here, you'll fill dest buffer with 'c'
> anyway so after filling up enough 'c's to be able to grab an aligned
> word full of them from dest, you can just grab that word and keep
> filling up dest with it.
>

I tried that, but this way I have to wait 8 bytes more before starting
the memset.
And, the machine code needed to generate 'cu' is just 6 instructions on ris=
cv:

slli a5,a0,8
or a5,a5,a0
slli a0,a5,16
or a0,a0,a5
slli a5,a0,32
or a0,a5,a0

so probably it's not worth it.

> > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > +             /* Fill the buffer one byte at time until the destination
> > +              * is aligned on a 32/64 bit boundary.
> > +              */
> > +             for (; count && dest.uptr % bytes_long; count--)
>
> You could reuse & mask here instead of % bytes_long.
>

Sure, even if the machine code will be the same.

> > +                     *dest.u8++ =3D c;
> > +#endif
>
> I noticed you also used CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on your
> memcpy patch, is it worth it here ? To begin with riscv doesn't set it
> and even if it did we are talking about a loop that will run just a few
> times to reach the alignment boundary (worst case scenario it'll run 7
> times), I don't think we gain much here, even for archs that have
> efficient unaligned access.

It doesn't _now_, but maybe in the future we will have a CPU which
handles unaligned accesses correctly!

--=20
per aspera ad upstream
