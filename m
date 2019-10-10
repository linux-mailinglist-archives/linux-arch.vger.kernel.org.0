Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8AD2A8C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 15:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387664AbfJJNNA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 09:13:00 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34189 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfJJNNA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Oct 2019 09:13:00 -0400
Received: by mail-yb1-f193.google.com with SMTP id m1so1918448ybm.1;
        Thu, 10 Oct 2019 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g7iIHlFzTIGzONjGQDhY1DZUNBV3ZeDhylQVPImHYRg=;
        b=sMFhuMfBRMpzUHz+CYkqVrZdgWkei0A4Fad+TfuPR4Uy/NScdWJDQN7eQ+HEQV3bpu
         6Bh0xCrgBg5pSu7VTqty4xrXYCKmQ86fBki5YWb/cW9JQLNodVrYJbRAYGxzu1LAcYOI
         mf62EtqTs1cAV8tLKRODYuAlJxwxIN5zD4yIcBuJMdeoL38bYvQOS5sbqYaXibtCi6ee
         jhhSx+/8IetL47htvu7BCdSYhtEjn/Ty7b1G+HakdNvlgozR2I40k3IOpx73Cxo7BhFu
         iO+iDqHCtjdUXXA52IIm1MdX3PxRjI8tDbzRYq3Kq35hBpXOGueFCjxzBTXu6/I547af
         OVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g7iIHlFzTIGzONjGQDhY1DZUNBV3ZeDhylQVPImHYRg=;
        b=RGoUdZaxJibxt+iU36Pqh1GAF8snSlIYK1qKuEJNTdVU1Ozw2b+S15mvoBCQFaXgiE
         n4sjwC5PJYCAP4Phai9lRlJd+drAghEKjLvVvPdBgJkodz7723ph4DRI3/33NlXGXIqh
         Msh9sgZ2MMmVfxpKL0YU0yvnP646+8UhQPoFNaQYmXBzGIVt5L0Sg8RbFGAaHuQ5w8RQ
         jRzSsAR+sKhYd4TWYr+4BnuvtZwjg3egnX1iBLJdiR4I/3zQsrSti7/OMEAuoBmYWJ7B
         sFLA9udUzvPZfuGiFLGwFj+Udf0eKv2nukf5R0/WZLDufRhCq3wUyoGcdN9LWz5YAK1u
         CELw==
X-Gm-Message-State: APjAAAVEtnz2skaJYIvd+zjiNnJ4n6RQWwVZvSTaw7PLfAU4HWaAVx0t
        hPburJYTd7+j7JWDiem2DzU=
X-Google-Smtp-Source: APXvYqx5E3qUmv5XC3dFWZqwVZ3OFjslYLwBjhW0QjnM//IFgndffIyLzGAuvTZWF6Qt3GkRR4d+rA==
X-Received: by 2002:a25:d015:: with SMTP id h21mr6252013ybg.11.1570713178037;
        Thu, 10 Oct 2019 06:12:58 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id a64sm1402333ywe.92.2019.10.10.06.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 06:12:57 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:12:42 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
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
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20191010131242.GA3187@icarus>
References: <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
 <20191009170917.GG32742@smile.fi.intel.com>
 <CAMuHMdXyyrL4ibKvjMV6r8TuxpmK73=JxsWNEfcRk1NjwsnOjA@mail.gmail.com>
 <CAK7LNASVdqU_6+_iinWStb9ALqLw494pnZKr46fLW+WJ9nUo6A@mail.gmail.com>
 <CAHp75VeLkfNZkqhD8tedJdav81L+VA3Z50Kwcd9h4R7zMwjtvA@mail.gmail.com>
 <CAMuHMdVs=PgET6=-fKgznETOye_Bxqt6h16Ok0nu6J2vXG-r_w@mail.gmail.com>
 <CAHp75Vc8HX=hs2F2R_wOaFM7cFjaX0k_kENybdxSh742PpVkjw@mail.gmail.com>
 <CAMuHMdVrQyt=VJ8outiGEXW78-cY=YUWyeVXN-_MFg75erJ=Yg@mail.gmail.com>
 <20191010080750.GN32742@smile.fi.intel.com>
 <CAMuHMdVv_pYq7rVLvjAPhkoADLgXF-AFGWUBNqLjaumDPBYGaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVv_pYq7rVLvjAPhkoADLgXF-AFGWUBNqLjaumDPBYGaQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 10:21:45AM +0200, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Thu, Oct 10, 2019 at 10:08 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Oct 10, 2019 at 09:49:51AM +0200, Geert Uytterhoeven wrote:
> > > On Thu, Oct 10, 2019 at 9:42 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Oct 10, 2019 at 9:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Thu, Oct 10, 2019 at 7:49 AM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Thu, Oct 10, 2019 at 5:31 AM Masahiro Yamada
> > > > > > <yamada.masahiro@socionext.com> wrote:
> > > > > > > On Thu, Oct 10, 2019 at 3:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > On Wed, Oct 9, 2019 at 7:09 PM Andy Shevchenko
> > > > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > > > On Thu, Oct 10, 2019 at 01:28:08AM +0900, Masahiro Yamada wrote:
> > > > > > > > > > On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> > > > > > > > > > <vilhelm.gray@gmail.com> wrote:
> >
> > > > > > > > > > Why is the return type "unsigned long" where you know
> > > > > > > > > > it return the 8-bit value ?
> > > > > > > > >
> > > > > > > > > Because bitmap API operates on unsigned long type. This is not only
> > > > > > > > > consistency, but for sake of flexibility in case we would like to introduce
> > > > > > > > > more calls like clump16 or so.
> > > > > > > >
> > > > > > > > TBH, that doesn't convince me: those functions explicitly take/return an
> > > > > > > > 8-bit value, and have "8" in their name.  The 8-bit value is never
> > > > > > > > really related to, retrieved from, or stored in a full "unsigned long"
> > > > > > > > element of a bitmap, only to/from/in a part (byte) of it.
> > > > > > > >
> > > > > > > > Following your rationale, all of iowrite{8,16,32,64}*() should take an
> > > > > > > > "unsigned long" value, too.
> > > > > > >
> > > > > > > Using u8/u16/u32/u64 looks more consistent with other bitmap helpers.
> > > > > > >
> > > > > > > void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned
> > > > > > > int nbits);
> > > > > > > void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits);
> > > > > > > static inline void bitmap_from_u64(unsigned long *dst, u64 mask);
> > > > > > >
> > > > > > > If you want to see more examples from other parts,
> > > > > >
> > > > > > Geert's and yours examples both are not related. They are about
> > > > > > fixed-width properies when we know that is the part of protocol.
> > > > > > Here we have no protocol which stricts us to the mentioned fixed-width types.
> > > > >
> > > > > Yes you have: they are functions to store/retrieve an 8-bit value from
> > > > > the middle of the bitmap, which is reflected in their names ("clump8",
> > > > > "value8").
> > > > > The input/output value is clearly separated from the actual bitmap,
> > > > > which is referenced by the "unsigned long *".
> > > > >
> > > > > If you add new "value16" functions, they will be intended to store/retrieve
> > > > > 16-bit values.
> > > >
> > > > And if I add 4-bit, 12-bit or 24-bit values, what should I use?
> > >
> > > Whatever is needed to store that?
> > > I agree "unsigned long" is appropriate for a generic function to extract a
> > > bit field of 1 to BITS_PER_LONG bits.
> > >
> > > > > Besides, if retrieving an 8-bit value requires passing an
> > > > > "unsigned long *", the caller needs two variables: one unsigned long to
> > > > > pass the address of, and one u8 to copy the returned value into.
> > > >
> > > > Why do you need a temporary variable? In some cases it might make
> > > > sense, but in general simple cases I don't see what you may achieve
> > > > with it.
> > >
> > > Because find_next_clump8() takes a pointer to store the output value.
> >
> > So does regmap_read().
> 
> I believe that one is different, as it is a generic function, and the
> width of the
> returned value depends on the regmap config.
> 
> > 8 appeared there during review when it has been proposed to optimize to 8-bit
> > clumps as most of the current users utilize it. The initial idea was to be
> > bit-width agnostic. And with current API it's possible to easy convert to other
> > formats later if we need.
> 
> "optimized for 8-bit clumps" and "out-of-line function that takes an
> unsigned long pointer for an output parameter" don't match well, IMHO.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

"Optimize" may not be the best way of describing it. I conceded to
introducing a restricted implementation (i.e. for_each_set_clump8) since
there were disagreements on the best approach for an implementation a
generic for_each_set_clump macro that could support any bit size. So I
settled for introducing just for_each_set_clump8 since it has an
implementation everyone could agree on and I didn't want to stall the
patchset for this introduction.

I'm hoping to propose the generic for_each_set_clump macro again in the
future after for_each_set_clump8 has had time to be utilized. There are
some files that I think might benefit from such a generic implementation
(e.g. gpio-thunderx with 64-bit ports and gpio-xilinx with variable size
channels). In such case, for_each_set_clump8 would likely be
reimplemented as a macro hardcoding an 8 passed to for_each_set_clump --
or perhaps just eliminated and replaced with for_each_set_clump directly
-- so maintaining clump as unsigned long pointer is useful since we
won't need to worry about redeclaring variables to match the datatype.

Though I admit that there are advantages in specifying the datatype as
u8 (or u16, u32, etc.). If we know the size then it's reasonable to
expect that the implementation can be optimized to not worry about
variable sizes and boundaries -- as exemplified by the simplicity of the
for_each_set_clump8 implementation. So that may be an argument for
keeping the for_each_set_clump8 implementation separate from the generic
for_each_set_clump implementation.

William Breathitt Gray
