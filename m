Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1FBD21FF
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 09:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbfJJHmB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 03:42:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35840 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfJJHmB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 03:42:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so3129538pgk.3;
        Thu, 10 Oct 2019 00:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NURwLHdKTSUja8QJMkMZYKyjuSxICE5fd85HFToXHUo=;
        b=q1RVugoYID1AntkYDacABjtI5fJI2xoh0kTSCp11ZmTPy2LsAOnqdkLl0dgT/wt0Ek
         JiPGbQPc0bUJQCNscgMRBLCd2g4y6E6UPh7YTmevt5wTSP3McI3jGC0xuIWsiCZ72TA7
         qklewgxuJP+GT9GiJyZazmKqlg+3K8MDdsU1drkv2VslNNVYeaywlhRwa6lN+3MsG/Yx
         NAardTvdjDDzxhCGflO+ITcQs+MH5S6y9SJ5JfOFMsmHHLoWV04JLW5YMMbivlJGzr79
         VEKnWfxJQa2wECy3tgO0xtCbEFQMNn4Dqp0PJDdGXNhqNPfWfFNalY3Yh/3KfAQiVfZM
         g1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NURwLHdKTSUja8QJMkMZYKyjuSxICE5fd85HFToXHUo=;
        b=W2H6CtI8rFlFvKQGagb9QdozY4A/jgIVKsqNatB9XA8lqHMKVurm1lgWWFjnzCgQNQ
         NG64g5VuIYzdOmKoiUW2zqnWwUBBhvIKlIHIEJBZ9pkiReDADMmI8xid56TCODRTgR8l
         zzMaZ1fekzKZQ7POHJcbKhVPej/Xa2yg2frw9lp4ufk2Ply5PKFijQS8CDGePLLtE4S/
         NGAXWLMMrxCgp9dYSbNLMvQmxT8DowYbf5LtvAOTaLILb+A2RRMjPXbCw3TQhXpl9Ewn
         powMPlFJrU8karpQrYOASlw7uof0sX+Yza0Iv2k4hPzmkKv5UFVc1QMQWn4pDvFbJs+P
         rdKw==
X-Gm-Message-State: APjAAAUae8LJDZ+5xpsyaWdkypXwim17Y9aAK8/NLtovV3lde3ZpCCWX
        iArubk1ogRL/x5tnF7hlsbqM/spgmzAvUmpmfSk=
X-Google-Smtp-Source: APXvYqw0gPatkwLXJe/cmckF2C9gwUV1JDOD+a56x4smY8rrWTgJRDyoijvUakofMAVnEQkAbavjRoG2E7EnvtMD5Z0=
X-Received: by 2002:a17:90a:b391:: with SMTP id e17mr10016417pjr.132.1570693320245;
 Thu, 10 Oct 2019 00:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1570633189.git.vilhelm.gray@gmail.com> <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
 <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
 <20191009170917.GG32742@smile.fi.intel.com> <CAMuHMdXyyrL4ibKvjMV6r8TuxpmK73=JxsWNEfcRk1NjwsnOjA@mail.gmail.com>
 <CAK7LNASVdqU_6+_iinWStb9ALqLw494pnZKr46fLW+WJ9nUo6A@mail.gmail.com>
 <CAHp75VeLkfNZkqhD8tedJdav81L+VA3Z50Kwcd9h4R7zMwjtvA@mail.gmail.com> <CAMuHMdVs=PgET6=-fKgznETOye_Bxqt6h16Ok0nu6J2vXG-r_w@mail.gmail.com>
In-Reply-To: <CAMuHMdVs=PgET6=-fKgznETOye_Bxqt6h16Ok0nu6J2vXG-r_w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Oct 2019 10:41:49 +0300
Message-ID: <CAHp75Vc8HX=hs2F2R_wOaFM7cFjaX0k_kENybdxSh742PpVkjw@mail.gmail.com>
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Thu, Oct 10, 2019 at 9:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 10, 2019 at 7:49 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Oct 10, 2019 at 5:31 AM Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > > On Thu, Oct 10, 2019 at 3:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Wed, Oct 9, 2019 at 7:09 PM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > On Thu, Oct 10, 2019 at 01:28:08AM +0900, Masahiro Yamada wrote:
> > > > > > On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> > > > > > <vilhelm.gray@gmail.com> wrote:
> > > > > > >
> > > > > > > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > > > > > > within a bitmap memory region. For each iteration, "start" is set to the
> > > > > > > bit offset of the found clump, while the respective clump value is
> > > > > > > stored to the location pointed by "clump". Additionally, the
> > > > > > > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > > > > > > respectively get and set an 8-bit value in a bitmap memory region.
> > > > >
> > > > > > Why is the return type "unsigned long" where you know
> > > > > > it return the 8-bit value ?
> > > > >
> > > > > Because bitmap API operates on unsigned long type. This is not only
> > > > > consistency, but for sake of flexibility in case we would like to introduce
> > > > > more calls like clump16 or so.
> > > >
> > > > TBH, that doesn't convince me: those functions explicitly take/return an
> > > > 8-bit value, and have "8" in their name.  The 8-bit value is never
> > > > really related to, retrieved from, or stored in a full "unsigned long"
> > > > element of a bitmap, only to/from/in a part (byte) of it.
> > > >
> > > > Following your rationale, all of iowrite{8,16,32,64}*() should take an
> > > > "unsigned long" value, too.
> > > >
> > >
> > > +1
> > >
> > > Using u8/u16/u32/u64 looks more consistent with other bitmap helpers.
> > >
> > > void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned
> > > int nbits);
> > > void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits);
> > > static inline void bitmap_from_u64(unsigned long *dst, u64 mask);
> > >
> > >
> > >
> > > If you want to see more examples from other parts,
> >
> > Geert's and yours examples both are not related. They are about
> > fixed-width properies when we know that is the part of protocol.
> > Here we have no protocol which stricts us to the mentioned fixed-width types.
>
> Yes you have: they are functions to store/retrieve an 8-bit value from
> the middle of the bitmap, which is reflected in their names ("clump8",
> "value8").
> The input/output value is clearly separated from the actual bitmap,
> which is referenced by the "unsigned long *".
>
> If you add new "value16" functions, they will be intended to store/retrieve
> 16-bit values.

And if I add 4-bit, 12-bit or 24-bit values, what should I use?

> Besides, if retrieving an 8-bit value requires passing an
> "unsigned long *", the caller needs two variables: one unsigned long to
> pass the address of, and one u8 to copy the returned value into.

Why do you need a temporary variable? In some cases it might make
sense, but in general simple cases I don't see what you may achieve
with it.

I looked at bitmap.h and see few functions may have benefited of
actually eliminating a use of long -> u8 -> long conversion.

Here is the question what we are mostly doing after we got a clump out
of bitmap.

> > So, I can tell an opposite, your arguments didn't convince me.
> >
> > Imagine the function which does an or / and / xor operation on bitmap.
> > Now, when I supply unsigned long, I will see
> > operations on one type in _one_ function independently of the size.
> > Your proposal will make an unneded churn.
>
> Depends on what kind of value you will use to do the logical operation
> with the bitmap:
>   - Full bitmap => unsigned long * + size,
>   - Single bitmap "word" => unsigned long,
>   - 8-bit value => u8,
>   - 16-bit value => u16

-- 
With Best Regards,
Andy Shevchenko
