Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909FD3B1146
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 03:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhFWBRa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Jun 2021 21:17:30 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44100 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhFWBR3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Jun 2021 21:17:29 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4100C20B83DE;
        Tue, 22 Jun 2021 18:15:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4100C20B83DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1624410913;
        bh=l5w3e6a6uV45UCOPO09+HzRVeLGtrESc4iOLHXlLq40=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eeYWpJspNWBJwXVAAozA8nBj+r/ixX8Dlm+JJh+n64jeFEUJ7S/qji3vdmFeyzQbt
         o2riDk6C172kqvkolzAULl0Prm52N4EhZD+iNa6WslrYt/Zk2nv49Tgs7oXLEOlbUM
         SA+1cOODscth8UflP4gI2UwYnyL9Sma4U9qTv0kk=
Received: by mail-pj1-f51.google.com with SMTP id pf4-20020a17090b1d84b029016f6699c3f2so2830143pjb.0;
        Tue, 22 Jun 2021 18:15:13 -0700 (PDT)
X-Gm-Message-State: AOAM531HN9tl4pq5T/zalL6tlu0N2nme0etR/T3KGdk4iimkbQkexN5m
        l/CkOpe20Hnna7uOJt9X0VRF0oyayITVJ1mPTdk=
X-Google-Smtp-Source: ABdhPJzLLexTZpICwihNJqNqUYtS2rIt+NYxLY8qUvXTajsE+vUnH89AEaOgxElegimr8XtRQl94Vvtz1Ub5nK9dW5E=
X-Received: by 2002:a17:90a:650b:: with SMTP id i11mr6657767pjj.39.1624410912716;
 Tue, 22 Jun 2021 18:15:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210617152754.17960-1-mcroce@linux.microsoft.com>
 <20210617152754.17960-4-mcroce@linux.microsoft.com> <17cd289430f08f2b75b7f04242c646f6@mailhost.ics.forth.gr>
 <d0f11655f21243ad983bd24381cdc245@AcuMS.aculab.com>
In-Reply-To: <d0f11655f21243ad983bd24381cdc245@AcuMS.aculab.com>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 23 Jun 2021 03:14:36 +0200
X-Gmail-Original-Message-ID: <CAFnufp1XeKM-N1MdWsNpU6NnF-dYUgGXL1W9r_DDWazTMyRHVA@mail.gmail.com>
Message-ID: <CAFnufp1XeKM-N1MdWsNpU6NnF-dYUgGXL1W9r_DDWazTMyRHVA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: optimized memset
To:     David Laight <David.Laight@aculab.com>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>,
        Bin Meng <bmeng.cn@gmail.com>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 22, 2021 at 10:38 AM David Laight <David.Laight@aculab.com> wro=
te:
>
> From: Nick Kossifidis
> > Sent: 22 June 2021 02:08
> >
> > =CE=A3=CF=84=CE=B9=CF=82 2021-06-17 18:27, Matteo Croce =CE=AD=CE=B3=CF=
=81=CE=B1=CF=88=CE=B5:
> > > +
> > > +void *__memset(void *s, int c, size_t count)
> > > +{
> > > +   union types dest =3D { .u8 =3D s };
> > > +
> > > +   if (count >=3D MIN_THRESHOLD) {
> > > +           const int bytes_long =3D BITS_PER_LONG / 8;
> >
> > You could make 'const int bytes_long =3D BITS_PER_LONG / 8;'
>
> What is wrong with sizeof (long) ?
> ...

Nothing, I guess that BITS_PER_LONG is just (sizeof(long) * 8) anyway

> > > +           unsigned long cu =3D (unsigned long)c;
> > > +
> > > +           /* Compose an ulong with 'c' repeated 4/8 times */
> > > +           cu |=3D cu << 8;
> > > +           cu |=3D cu << 16;
> > > +#if BITS_PER_LONG =3D=3D 64
> > > +           cu |=3D cu << 32;
> > > +#endif
> > > +
> >
> > You don't have to create cu here, you'll fill dest buffer with 'c'
> > anyway so after filling up enough 'c's to be able to grab an aligned
> > word full of them from dest, you can just grab that word and keep
> > filling up dest with it.
>
> That will be a lot slower - especially if run on something like x86.
> A write-read of the same size is optimised by the store-load forwarder.
> But the byte write, word read will have to go via the cache.
>
> You can just write:
>         cu =3D (unsigned long)c * 0x0101010101010101ull;
> and let the compiler sort out the best way to generate the constant.
>

Interesting. I see that most compilers do an integer multiplication,
is it faster than three shift and three or?

clang on riscv generates even more instructions to create the immediate:

unsigned long repeat_shift(int c)
{
  unsigned long cu =3D (unsigned long)c;
  cu |=3D cu << 8;
  cu |=3D cu << 16;
  cu |=3D cu << 32;

  return cu;
}

unsigned long repeat_mul(int c)
{
  return (unsigned long)c * 0x0101010101010101ull;
}

repeat_shift:
  slli a1, a0, 8
  or a0, a0, a1
  slli a1, a0, 16
  or a0, a0, a1
  slli a1, a0, 32
  or a0, a0, a1
  ret

repeat_mul:
  lui a1, 4112
  addiw a1, a1, 257
  slli a1, a1, 16
  addi a1, a1, 257
  slli a1, a1, 16
  addi a1, a1, 257
  mul a0, a0, a1
  ret

> >
> > > +#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > > +           /* Fill the buffer one byte at time until the destination
> > > +            * is aligned on a 32/64 bit boundary.
> > > +            */
> > > +           for (; count && dest.uptr % bytes_long; count--)
> >
> > You could reuse & mask here instead of % bytes_long.
> >
> > > +                   *dest.u8++ =3D c;
> > > +#endif
> >
> > I noticed you also used CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on your
> > memcpy patch, is it worth it here ? To begin with riscv doesn't set it
> > and even if it did we are talking about a loop that will run just a few
> > times to reach the alignment boundary (worst case scenario it'll run 7
> > times), I don't think we gain much here, even for archs that have
> > efficient unaligned access.
>
> With CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS it probably isn't worth
> even checking the alignment.
> While aligning the copy will be quicker for an unaligned buffer they
> almost certainly don't happen often enough to worry about.
> In any case you'd want to do a misaligned word write to the start
> of the buffer - not separate byte writes.
> Provided the buffer is long enough you can also do a misaligned write
> to the end of the buffer before filling from the start.
>

I don't understand this one, a misaligned write here is ~30x slower
than an aligned one because it gets trapped and emulated in SBI.
How can this be convenient?

> I suspect you may need either barrier() or use a ptr to packed
> to avoid the perverted 'undefined behaviour' fubar.'
>

Which UB are you referring to?

Regards,
--
per aspera ad upstream
