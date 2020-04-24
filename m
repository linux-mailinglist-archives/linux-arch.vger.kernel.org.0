Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E30D1B78B8
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDXPBA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 11:01:00 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:39685 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgDXPBA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2020 11:01:00 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 91F8030004668;
        Fri, 24 Apr 2020 17:00:58 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 688DBE011F; Fri, 24 Apr 2020 17:00:58 +0200 (CEST)
Date:   Fri, 24 Apr 2020 17:00:58 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        arnd@arndb.de, Linus Walleij <linus.walleij@linaro.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] bitops: Introduce the the for_each_set_clump macro
Message-ID: <20200424150058.xadjxaga3csh3br6@wunner.de>
References: <20200424122521.GA5552@syed>
 <20200424141037.ersebbfe7xls37be@wunner.de>
 <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACG_h5prcXVdk6ecn2WoT1jas3K6UF+KCrxAM9u4_ZLSyPKCEA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 24, 2020 at 08:22:38PM +0530, Syed Nayyar Waris wrote:
> On Fri, Apr 24, 2020 at 7:40 PM Lukas Wunner <lukas@wunner.de> wrote:
> >
> > On Fri, Apr 24, 2020 at 05:55:21PM +0530, Syed Nayyar Waris wrote:
> > > +static inline void bitmap_set_value(unsigned long *map,
> > > +                                 unsigned long value,
> > > +                                 unsigned long start, unsigned long nbits)
> > > +{
> > > +     const size_t index = BIT_WORD(start);
> > > +     const unsigned long offset = start % BITS_PER_LONG;
> > > +     const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> > > +     const unsigned long space = ceiling - start;
> > > +
> > > +     value &= GENMASK(nbits - 1, 0);
> > > +
> > > +     if (space >= nbits) {
> > > +             map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> > > +             map[index] |= value << offset;
> > > +     } else {
> > > +             map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> > > +             map[index] |= value << offset;
> > > +             map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> > > +             map[index + 1] |= (value >> space);
> > > +     }
> > > +}
> >
> > Sorry but what's the advantage of using this complicated function
> > as a replacement for the much simpler bitmap_set_value8()?
> >
> > The drivers calling bitmap_set_value8() *know* that 8-bit accesses
> > are possible and take advantage of that knowledge by using a small,
> > speed-optimized function.  Replacing that with a more complicated
> > (potentially less performant) function doesn't seem to be a step
> > forward.
> 
> Actually this generic function can work with n-bits of any size (less
> than equal to BITS_PER_LONG), while the earlier bitmap_set_value8
> worked with n-bits having size of 8 bits only.
> 
> In the case when n-bits is 8-bits, this new bitmap_set_value()
> function would behave very similar to the earlier bitmap_set_value8()
> function. For example,  in case of n-bits being 8-bits it will always
> execute the 'if' condition and not the 'else' condition, hence
> offering the same performance (because of encountering similar code
> statements) as earlier bitmap_set_value8() function, most probably.
> 
> There is an additional advantage (this can happen when n-bits is not 8
> bits): during setting value of n-bit in bitmap, if a situation arise
> that the width of next n-bit is exceeding the word boundary, then it
> will divide itself such that some portion of it is stored in that
> word, while the remaining portion is stored in the next higher word.
> 
> So, this function preserves the behaviour of earlier
> bitmap_set_value8() function and also adds extra functionality to
> that.

Please leave drivers as is which use exclusively 8-bit accesses,
e.g. gpio-max3191x.c and gpio-74x164.c.  I'm fearing a performance
regression if your new generic variant is used.  They work perfectly
fine the way they are and I don't see any benefit this series may have
for them.

If there are other drivers which benefit from the flexibility of your
generic variant then I'm not opposed to changing those.

Thanks,

Lukas
