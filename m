Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45065D2241
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2019 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbfJJIH7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Oct 2019 04:07:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:43656 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733089AbfJJIH7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Oct 2019 04:07:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 01:07:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,279,1566889200"; 
   d="scan'208";a="197171942"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 10 Oct 2019 01:07:53 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1iITUE-0002L7-QG; Thu, 10 Oct 2019 11:07:50 +0300
Date:   Thu, 10 Oct 2019 11:07:50 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Subject: Re: [PATCH v17 01/14] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20191010080750.GN32742@smile.fi.intel.com>
References: <cover.1570633189.git.vilhelm.gray@gmail.com>
 <893c3b4f03266c9496137cc98ac2b1bd27f92c73.1570633189.git.vilhelm.gray@gmail.com>
 <CAK7LNATgW7bXUmqV=3QAaJ0Qu73Kox-TgDCQJb=s0=mwewSCUg@mail.gmail.com>
 <20191009170917.GG32742@smile.fi.intel.com>
 <CAMuHMdXyyrL4ibKvjMV6r8TuxpmK73=JxsWNEfcRk1NjwsnOjA@mail.gmail.com>
 <CAK7LNASVdqU_6+_iinWStb9ALqLw494pnZKr46fLW+WJ9nUo6A@mail.gmail.com>
 <CAHp75VeLkfNZkqhD8tedJdav81L+VA3Z50Kwcd9h4R7zMwjtvA@mail.gmail.com>
 <CAMuHMdVs=PgET6=-fKgznETOye_Bxqt6h16Ok0nu6J2vXG-r_w@mail.gmail.com>
 <CAHp75Vc8HX=hs2F2R_wOaFM7cFjaX0k_kENybdxSh742PpVkjw@mail.gmail.com>
 <CAMuHMdVrQyt=VJ8outiGEXW78-cY=YUWyeVXN-_MFg75erJ=Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVrQyt=VJ8outiGEXW78-cY=YUWyeVXN-_MFg75erJ=Yg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 10, 2019 at 09:49:51AM +0200, Geert Uytterhoeven wrote:
> On Thu, Oct 10, 2019 at 9:42 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Thu, Oct 10, 2019 at 9:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Thu, Oct 10, 2019 at 7:49 AM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Thu, Oct 10, 2019 at 5:31 AM Masahiro Yamada
> > > > <yamada.masahiro@socionext.com> wrote:
> > > > > On Thu, Oct 10, 2019 at 3:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Wed, Oct 9, 2019 at 7:09 PM Andy Shevchenko
> > > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > > On Thu, Oct 10, 2019 at 01:28:08AM +0900, Masahiro Yamada wrote:
> > > > > > > > On Thu, Oct 10, 2019 at 12:27 AM William Breathitt Gray
> > > > > > > > <vilhelm.gray@gmail.com> wrote:

> > > > > > > > Why is the return type "unsigned long" where you know
> > > > > > > > it return the 8-bit value ?
> > > > > > >
> > > > > > > Because bitmap API operates on unsigned long type. This is not only
> > > > > > > consistency, but for sake of flexibility in case we would like to introduce
> > > > > > > more calls like clump16 or so.
> > > > > >
> > > > > > TBH, that doesn't convince me: those functions explicitly take/return an
> > > > > > 8-bit value, and have "8" in their name.  The 8-bit value is never
> > > > > > really related to, retrieved from, or stored in a full "unsigned long"
> > > > > > element of a bitmap, only to/from/in a part (byte) of it.
> > > > > >
> > > > > > Following your rationale, all of iowrite{8,16,32,64}*() should take an
> > > > > > "unsigned long" value, too.
> > > > >
> > > > > Using u8/u16/u32/u64 looks more consistent with other bitmap helpers.
> > > > >
> > > > > void bitmap_from_arr32(unsigned long *bitmap, const u32 *buf, unsigned
> > > > > int nbits);
> > > > > void bitmap_to_arr32(u32 *buf, const unsigned long *bitmap, unsigned int nbits);
> > > > > static inline void bitmap_from_u64(unsigned long *dst, u64 mask);
> > > > >
> > > > > If you want to see more examples from other parts,
> > > >
> > > > Geert's and yours examples both are not related. They are about
> > > > fixed-width properies when we know that is the part of protocol.
> > > > Here we have no protocol which stricts us to the mentioned fixed-width types.
> > >
> > > Yes you have: they are functions to store/retrieve an 8-bit value from
> > > the middle of the bitmap, which is reflected in their names ("clump8",
> > > "value8").
> > > The input/output value is clearly separated from the actual bitmap,
> > > which is referenced by the "unsigned long *".
> > >
> > > If you add new "value16" functions, they will be intended to store/retrieve
> > > 16-bit values.
> >
> > And if I add 4-bit, 12-bit or 24-bit values, what should I use?
> 
> Whatever is needed to store that?
> I agree "unsigned long" is appropriate for a generic function to extract a
> bit field of 1 to BITS_PER_LONG bits.
> 
> > > Besides, if retrieving an 8-bit value requires passing an
> > > "unsigned long *", the caller needs two variables: one unsigned long to
> > > pass the address of, and one u8 to copy the returned value into.
> >
> > Why do you need a temporary variable? In some cases it might make
> > sense, but in general simple cases I don't see what you may achieve
> > with it.
> 
> Because find_next_clump8() takes a pointer to store the output value.

So does regmap_read().

8 appeared there during review when it has been proposed to optimize to 8-bit
clumps as most of the current users utilize it. The initial idea was to be
bit-width agnostic. And with current API it's possible to easy convert to other
formats later if we need.

> > I looked at bitmap.h and see few functions may have benefited of
> > actually eliminating a use of long -> u8 -> long conversion.
> >
> > Here is the question what we are mostly doing after we got a clump out
> > of bitmap.
> 
> If I call find_next_clump8() to extract a byte, I guess I want to process an u8
> aftwerwards?

Some functions may expect a width-(semi-)dependent types, like regmap_write().
Yes, it's possible to supply u8 there and have an implicit type cast.

-- 
With Best Regards,
Andy Shevchenko


