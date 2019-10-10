Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA52D207F
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 07:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732800AbfJJFtX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 01:49:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33959 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbfJJFtX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 01:49:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id y35so2952415pgl.1;
        Wed, 09 Oct 2019 22:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RhxY1MPKMW6WR/zUFAC74xJM92OHmjB+kj8GPP9wIlw=;
        b=rN9RRE7cIrRHiqRZYHnHSbHLkLn8sEliKdKOykE1BAiQd6iUPmf/oYzt2zGUIJLtc1
         J/Hv96bumBiGBFwkKfJnzTskhdi2HR4zk98z5zCQoBtcrgdsvi4YEfsu8ALTj07La0Z2
         y5DSQdzRYQybpa8QuuYByRSJxvy99ZC+pOqw1RuDAryOAY9qmzzrEwX1sEvhtMP8mKu9
         Wn0659AVEQs+A8IfAtiI13X+kXbgHTJuPiITwSKFjVxmcEh8gBVFsbX9Dn7NegnpBsx5
         cBDj4qkHToVxQk92I5PH9cOFLPLVKWoqKmLZHyR3XAXJDbJ7Fw31c/i5VvJ2MaY8KCxQ
         A9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RhxY1MPKMW6WR/zUFAC74xJM92OHmjB+kj8GPP9wIlw=;
        b=F7nj+6YmpxvPdixuRntqvQz5inOmXb0mIoPiIzl1s8ayXxHPKynffNnJFCAgTRLjOP
         eq5X+vs8ZfEnOYrhRg0S6F0u7rXOhohTf1j6kEi/51d4QTD1nNtNWnMh2qoFq+LO+1G8
         bW8528f/+sgZIp/iJK3ToYwQVmQFKxhZTkPTxhitnJiNGI2Hm5CY5EOqyW4IrnF/mz/C
         32WAr/0uyYq/TkQLZYf4de9ZxhZbLmDfRxKMkEXTzZ9mJS71MPd39cSZ3kGAYmnYYXDp
         5IM1LEoLlnoIPUhZzMteeO886OXYCta7UVzPWmRz+/52WUaJdAlMKWjWsK1QjaicsW8v
         2Hhg==
X-Gm-Message-State: APjAAAVSK7r0LrdGueHgyXHvb0hHXvgpSXmg/exA0UZzjAFCU/UDwmaK
        p3HKKOxpdN/p7nZfLKpCoQd9/3z10d21jWssoSs=
X-Google-Smtp-Source: APXvYqxTWGaHrxna/RW71KUqM4PD44f4t6P+cJUv3cQo53Tkjbf14ZESvxDMrwfIJKmfQGqBt7rE4hOcImn0K/p+Em0=
X-Received: by 2002:a17:90a:db4a:: with SMTP id u10mr9179621pjx.30.1570686562156;
 Wed, 09 Oct 2019 22:49:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570633189.git.vilhelm.gray@gmail.com> <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
 <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
 <20191009170917.GG32742@smile.fi.intel.com> <CAMuHMdXyyrL4ibKvjMV6r8TuxpmK73=JxsWNEfcRk1NjwsnOjA@mail.gmail.com>
 <CAK7LNASVdqU_6+_iinWStb9ALqLw494pnZKr46fLW+WJ9nUo6A@mail.gmail.com>
In-Reply-To: <CAK7LNASVdqU_6+_iinWStb9ALqLw494pnZKr46fLW+WJ9nUo6A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Oct 2019 08:49:10 +0300
Message-ID: <CAHp75VeLkfNZkqhD8tedJdav81L+VA3Z50Kwcd9h4R7zMwjtvA@mail.gmail.com>
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Thu, Oct 10, 2019 at 5:31 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> On Thu, Oct 10, 2019 at 3:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Wed, Oct 9, 2019 at 7:09 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Oct 10, 2019 at 01:28:08AM +0900, Masahiro Yamada wrote:
> > > > On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> > > > <vilhelm.gray@gmail.com> wrote:
> > > > >
> > > > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > > > within a bitmap memory region. For each iteration, "start" is set to the
> > > > > bit offset of the found clump, while the respective clump value is
> > > > > stored to the location pointed by "clump". Additionally, the
> > > > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > > > respectively get and set an 8-bit value in a bitmap memory region.
> > >
> > > > Why is the return type "unsigned long" where you know
> > > > it return the 8-bit value ?
> > >
> > > Because bitmap API operates on unsigned long type. This is not only
> > > consistency, but for sake of flexibility in case we would like to introduce
> > > more calls like clump16 or so.
> >
> > TBH, that doesn't convince me: those functions explicitly take/return an
> > 8-bit value, and have "8" in their name.  The 8-bit value is never
> > really related to, retrieved from, or stored in a full "unsigned long"
> > element of a bitmap, only to/from/in a part (byte) of it.
> >
> > Following your rationale, all of iowrite{8,16,32,64}*() should take an
> > "unsigned long" value, too.
> >
>
> +1
>
> Using u8/u16/u32/u64 looks more consistent with other bitmap helpers.
>
> void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned
> int nbits);
> void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits);
> static inline void bitmap_from_u64(unsigned long *dst, u64 mask);
>
>
>
> If you want to see more examples from other parts,

Geert's and yours examples both are not related. They are about
fixed-width properies when we know that is the part of protocol.
Here we have no protocol which stricts us to the mentioned fixed-width types.

So, I can tell an opposite, your arguments didn't convince me.

Imagine the function which does an or / and / xor operation on bitmap.
Now, when I supply unsigned long, I will see
operations on one type in _one_ function independently of the size.
Your proposal will make an unneded churn.

-- 
With Best Regards,
Andy Shevchenko
