Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D58B5D229D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733312AbfJJIV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 04:21:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36118 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733269AbfJJIV6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 04:21:58 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so4177793oih.3;
        Thu, 10 Oct 2019 01:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dc5RA2BPKZVYGXJLYtKKxLVdHq6Dac4u37aEDEUkLQM=;
        b=DHfArRrkuDjQXYob8Lw47pqT7FpGLO3GzFoGIG4uahhSnTK01APmr63DFxVyPUMF9M
         3KekuOiGOLQGQlsHJPINfnYMaEoO8oH7vvDSQ3D782Eu6QJIzQw+ZOESPV165k1suM/q
         mCdDvgFn+N0YWjiOO4vd5HUQbEB0dtvmpES5TLEoCGNSc8ALolmKN+AgmzyzeiYTCYwx
         qBmmg6x3JMY9fy5oh6/4I38nDvR2DSakyqXIg091/+7T6cEulp95VbPTY1oxPC5Ulmvf
         FDXcVa96udIjaf9nWPrv6JUBXiq6yXBqdxqWAk5WxCZ9VCsMzjeplrVSKMkaNISJA5wU
         cgZw==
X-Gm-Message-State: APjAAAXhxIECF093MrNyvztttwiNc+b31SFLnrqLH48n+NJfQSb6E56L
        a9xoCW8l/YiZQsc6h1HiDgQm9G+i20VvtnUFiv0=
X-Google-Smtp-Source: APXvYqxtgx03+B0HB6RKN9jHyeCpS8CcGrjyRFWnknFz7FyEGnnntki6sJN+xgX/b9Aj5CRhCziqQeixZ7YTrOe0LG8=
X-Received: by 2002:aca:4bd2:: with SMTP id y201mr6665365oia.102.1570695716750;
 Thu, 10 Oct 2019 01:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570633189.git.vilhelm.gray@gmail.com> <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
 <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
 <20191009170917.GG32742@smile.fi.intel.com> <CAMuHMdXyyrL4ibKvjMV6r8TuxpmK73=JxsWNEfcRk1NjwsnOjA@mail.gmail.com>
 <CAK7LNASVdqU_6+_iinWStb9ALqLw494pnZKr46fLW+WJ9nUo6A@mail.gmail.com>
 <CAHp75VeLkfNZkqhD8tedJdav81L+VA3Z50Kwcd9h4R7zMwjtvA@mail.gmail.com>
 <CAMuHMdVs=PgET6=-fKgznETOye_Bxqt6h16Ok0nu6J2vXG-r_w@mail.gmail.com>
 <CAHp75Vc8HX=hs2F2R_wOaFM7cFjaX0k_kENybdxSh742PpVkjw@mail.gmail.com>
 <CAMuHMdVrQyt=VJ8outiGEXW78-cY=YUWyeVXN-_MFg75erJ=Yg@mail.gmail.com> <20191010080750.GN32742@smile.fi.intel.com>
In-Reply-To: <20191010080750.GN32742@smile.fi.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Oct 2019 10:21:45 +0200
Message-ID: <CAMuHMdVv_pYq7rVLvjAPhkoADLgXF-AFGWUBNqLjaumDPBYGaQ@mail.gmail.com>
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Phil Reid <preid@electromag.com.au>,
        Lukas Wunner <lukas@wunner.de>, sean.nyekjaer@prevas.dk,
        morten.tiljeset@prevas.dk, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Andy,

On Thu, Oct 10, 2019 at 10:08 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Oct 10, 2019 at 09:49:51AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Oct 10, 2019 at 9:42 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Thu, Oct 10, 2019 at 9:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Thu, Oct 10, 2019 at 7:49 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Thu, Oct 10, 2019 at 5:31 AM Masahiro Yamada
> > > > > <yamada.masahiro@socionext.com> wrote:
> > > > > > On Thu, Oct 10, 2019 at 3:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > On Wed, Oct 9, 2019 at 7:09 PM Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > On Thu, Oct 10, 2019 at 01:28:08AM +0900, Masahiro Yamada wrote:
> > > > > > > > > On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> > > > > > > > > <vilhelm.gray@gmail.com> wrote:
>
> > > > > > > > > Why is the return type "unsigned long" where you know
> > > > > > > > > it return the 8-bit value ?
> > > > > > > >
> > > > > > > > Because bitmap API operates on unsigned long type. This is not only
> > > > > > > > consistency, but for sake of flexibility in case we would like to introduce
> > > > > > > > more calls like clump16 or so.
> > > > > > >
> > > > > > > TBH, that doesn't convince me: those functions explicitly take/return an
> > > > > > > 8-bit value, and have "8" in their name.  The 8-bit value is never
> > > > > > > really related to, retrieved from, or stored in a full "unsigned long"
> > > > > > > element of a bitmap, only to/from/in a part (byte) of it.
> > > > > > >
> > > > > > > Following your rationale, all of iowrite{8,16,32,64}*() should take an
> > > > > > > "unsigned long" value, too.
> > > > > >
> > > > > > Using u8/u16/u32/u64 looks more consistent with other bitmap helpers.
> > > > > >
> > > > > > void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned
> > > > > > int nbits);
> > > > > > void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits);
> > > > > > static inline void bitmap_from_u64(unsigned long *dst, u64 mask);
> > > > > >
> > > > > > If you want to see more examples from other parts,
> > > > >
> > > > > Geert's and yours examples both are not related. They are about
> > > > > fixed-width properies when we know that is the part of protocol.
> > > > > Here we have no protocol which stricts us to the mentioned fixed-width types.
> > > >
> > > > Yes you have: they are functions to store/retrieve an 8-bit value from
> > > > the middle of the bitmap, which is reflected in their names ("clump8",
> > > > "value8").
> > > > The input/output value is clearly separated from the actual bitmap,
> > > > which is referenced by the "unsigned long *".
> > > >
> > > > If you add new "value16" functions, they will be intended to store/retrieve
> > > > 16-bit values.
> > >
> > > And if I add 4-bit, 12-bit or 24-bit values, what should I use?
> >
> > Whatever is needed to store that?
> > I agree "unsigned long" is appropriate for a generic function to extract a
> > bit field of 1 to BITS_PER_LONG bits.
> >
> > > > Besides, if retrieving an 8-bit value requires passing an
> > > > "unsigned long *", the caller needs two variables: one unsigned long to
> > > > pass the address of, and one u8 to copy the returned value into.
> > >
> > > Why do you need a temporary variable? In some cases it might make
> > > sense, but in general simple cases I don't see what you may achieve
> > > with it.
> >
> > Because find_next_clump8() takes a pointer to store the output value.
>
> So does regmap_read().

I believe that one is different, as it is a generic function, and the
width of the
returned value depends on the regmap config.

> 8 appeared there during review when it has been proposed to optimize to 8-bit
> clumps as most of the current users utilize it. The initial idea was to be
> bit-width agnostic. And with current API it's possible to easy convert to other
> formats later if we need.

"optimized for 8-bit clumps" and "out-of-line function that takes an
unsigned long pointer for an output parameter" don't match well, IMHO.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
