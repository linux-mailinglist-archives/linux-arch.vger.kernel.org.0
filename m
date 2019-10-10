Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 677C4D20C5
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 08:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfJJG3b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 02:29:31 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36687 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfJJG3b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 02:29:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so3945959oih.3;
        Wed, 09 Oct 2019 23:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Cx2nK6QRBgJuBNcUtpzK8FDH7ngKKIhRfZFf1NmTFQ=;
        b=kHPIj9KjP0SBjIgczu72EL/eRPNB35Ybua9nkVZSeG5OKbrLqXPWK4rRquBMLAluyK
         EVb5jjYJvHYTkt1XmoB+2kbtcVEDyuyVkaVu+YNHY65wkCjFVGVcIFbErLVIZlfdYFV1
         +ULDkchJXV5Sfe6wkuWn6PkGeAKVPvmutHcnlh1r6lQrEkraXax7ZbIpKXDpYbIGpOvn
         AmmKuugV6T3g9exwUOIJt3kK1/b5pj9oeFIYRfUJFMWwFxKyeGo4YJPR2yHaVDeKl1Jd
         UTVfZa725Oe45w1o7xout7BhvtvvIQ14ys0keOtbL9MgfVw5wCvybKXtT4okRea88r13
         RdiA==
X-Gm-Message-State: APjAAAXoF2R7ndOyiWKrqGvIFKAii27vIQwg76UOjN7hKgQxg1Vl7m4j
        JnXGqeWUZ1SiKlMt93PgcZqCZ8nxYu20fQP/rDc=
X-Google-Smtp-Source: APXvYqxmAwoB1fEOxz3+Xl/nikYsLddSYKE5o75tBiCX/ExRRXKw9htkShc664JHnVxtveTq0QU4eZt/Zpliy/z2V/0=
X-Received: by 2002:a05:6808:3b4:: with SMTP id n20mr5863396oie.131.1570688969834;
 Wed, 09 Oct 2019 23:29:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570633189.git.vilhelm.gray@gmail.com> <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
 <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
 <20191009170917.GG32742@smile.fi.intel.com> <CAMuHMdXyyrL4ibKvjMV6r8TuxpmK73=JxsWNEfcRk1NjwsnOjA@mail.gmail.com>
 <CAK7LNASVdqU_6+_iinWStb9ALqLw494pnZKr46fLW+WJ9nUo6A@mail.gmail.com> <CAHp75VeLkfNZkqhD8tedJdav81L+VA3Z50Kwcd9h4R7zMwjtvA@mail.gmail.com>
In-Reply-To: <CAHp75VeLkfNZkqhD8tedJdav81L+VA3Z50Kwcd9h4R7zMwjtvA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Oct 2019 08:29:17 +0200
Message-ID: <CAMuHMdVs=PgET6=-fKgznETOye_Bxqt6h16Ok0nu6J2vXG-r_w@mail.gmail.com>
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Thu, Oct 10, 2019 at 7:49 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Oct 10, 2019 at 5:31 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > On Thu, Oct 10, 2019 at 3:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Wed, Oct 9, 2019 at 7:09 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Oct 10, 2019 at 01:28:08AM +0900, Masahiro Yamada wrote:
> > > > > On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> > > > > <vilhelm.gray@gmail.com> wrote:
> > > > > >
> > > > > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > > > > within a bitmap memory region. For each iteration, "start" is set to the
> > > > > > bit offset of the found clump, while the respective clump value is
> > > > > > stored to the location pointed by "clump". Additionally, the
> > > > > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > > > > respectively get and set an 8-bit value in a bitmap memory region.
> > > >
> > > > > Why is the return type "unsigned long" where you know
> > > > > it return the 8-bit value ?
> > > >
> > > > Because bitmap API operates on unsigned long type. This is not only
> > > > consistency, but for sake of flexibility in case we would like to introduce
> > > > more calls like clump16 or so.
> > >
> > > TBH, that doesn't convince me: those functions explicitly take/return an
> > > 8-bit value, and have "8" in their name.  The 8-bit value is never
> > > really related to, retrieved from, or stored in a full "unsigned long"
> > > element of a bitmap, only to/from/in a part (byte) of it.
> > >
> > > Following your rationale, all of iowrite{8,16,32,64}*() should take an
> > > "unsigned long" value, too.
> > >
> >
> > +1
> >
> > Using u8/u16/u32/u64 looks more consistent with other bitmap helpers.
> >
> > void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned
> > int nbits);
> > void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits);
> > static inline void bitmap_from_u64(unsigned long *dst, u64 mask);
> >
> >
> >
> > If you want to see more examples from other parts,
>
> Geert's and yours examples both are not related. They are about
> fixed-width properies when we know that is the part of protocol.
> Here we have no protocol which stricts us to the mentioned fixed-width types.

Yes you have: they are functions to store/retrieve an 8-bit value from
the middle of the bitmap, which is reflected in their names ("clump8",
"value8").
The input/output value is clearly separated from the actual bitmap,
which is referenced by the "unsigned long *".

If you add new "value16" functions, they will be intended to store/retrieve
16-bit values.

Besides, if retrieving an 8-bit value requires passing an
"unsigned long *", the caller needs two variables: one unsigned long to
pass the address of, and one u8 to copy the returned value into.

> So, I can tell an opposite, your arguments didn't convince me.
>
> Imagine the function which does an or / and / xor operation on bitmap.
> Now, when I supply unsigned long, I will see
> operations on one type in _one_ function independently of the size.
> Your proposal will make an unneded churn.

Depends on what kind of value you will use to do the logical operation
with the bitmap:
  - Full bitmap => unsigned long * + size,
  - Single bitmap "word" => unsigned long,
  - 8-bit value => u8,
  - 16-bit value => u16

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
