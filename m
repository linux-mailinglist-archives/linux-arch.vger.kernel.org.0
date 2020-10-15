Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EBB28FB58
	for <lists+linux-arch@lfdr.de>; Fri, 16 Oct 2020 00:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbgJOWxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Oct 2020 18:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbgJOWxR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Oct 2020 18:53:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F68C061755;
        Thu, 15 Oct 2020 15:53:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t18so356261ilo.12;
        Thu, 15 Oct 2020 15:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFQtaxU4YUQNvbnqPeUAScf/xR6LM2zPZihZfrq6QrY=;
        b=U655etZm+uaA0qNlVHA6zGPJdrQfeVf1LMdkzKJmwIXq5IQ5KH9idqK8R3cSf3vzyd
         UM1uh2G2EjwGTZEOqP+7JbdPGP+HGw+uYQa5RLKV5+RbTsWE+NMqvIvCGHzdk/CXMiHB
         M3Y7a+NathuX6h70CY1KtCCQpWXx9fpYfZ3hEpxG2Swp94ZwUHOwld+CTnpZZ0prILod
         LzdkX37VJZiAo5ShXp8aEuIRDf6Ub6S3mkChRDTdPG710AOO8n0lesgl/Vao/xm2JIef
         hg+4FsfwB3cSgf/CT+/mu/M83eGPn7p9Moh8BOn8xxwtbTI80EcVyECNc2Dw5cbhMMDt
         AIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFQtaxU4YUQNvbnqPeUAScf/xR6LM2zPZihZfrq6QrY=;
        b=CQLflPoL9KyS9ZtEwTsllog60Nn1SfgaCj+9gGSu+FBAE3iH1uvK2V4CHNgXkF9OMW
         lOvexjQboJHt+0YY2f/0GjpfHy3bIg/CjIx7Pw+ZKkAI5AAUomVWiJj24qAJD+z6++O+
         Xuyox/U7vBDQdZpFywVjqot72ctoRuqFgudLqJAnyXthdW7dl4j0fz+pbAOJ8MashHpv
         p4grT7izh+EQ140IC960dWZOTCptCN0vcIfZjNG0Gr/Vca2a1NHgftqM74WNgYr7K3lV
         4lVMQk31+TEJWdulvwEbR0NihiwFvurUR+wKs8hoczX0ZrDmCl+Pme0pnSSzXN04Gw0R
         J9Ow==
X-Gm-Message-State: AOAM530ez0E6p1VU7/utvYMJGYeajl2E01boduHOgynmt7Iz+h77bAxv
        fpc0lrfjFhvxUNPi/d2pC3lmcO7uiQ0UDkd+pmAx7Vemwss=
X-Google-Smtp-Source: ABdhPJyzlS0eGSXgzAREEgAtyv//yvyCHgB5cEz7Myw4qlwyHN9TDbpmrskpw5XBd86AhgXAe80XzmDtTRrBprGcsx0=
X-Received: by 2002:a92:de0f:: with SMTP id x15mr631190ilm.164.1602802396528;
 Thu, 15 Oct 2020 15:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601974764.git.syednwaris@gmail.com> <33de236870f7d3cf56a55d747e4574cdd2b9686a.1601974764.git.syednwaris@gmail.com>
 <20201006112745.GG4077@smile.fi.intel.com>
In-Reply-To: <20201006112745.GG4077@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 16 Oct 2020 04:23:05 +0530
Message-ID: <CACG_h5pYL+HbJpPcCTp=dR8rDbm07RsRDaX8Uc0HYc2LG--w_Q@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] bitops: Introduce the for_each_set_clump macro
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 6, 2020 at 4:56 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 06, 2020 at 02:52:16PM +0530, Syed Nayyar Waris wrote:
> > This macro iterates for each group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to
> > the bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value() and bitmap_set_value() functions are introduced to
> > respectively get and set a value of n-bits in a bitmap memory region.
> > The n-bits can have any size less than or equal to BITS_PER_LONG.
> > Moreover, during setting value of n-bit in bitmap, if a situation arise
> > that the width of next n-bit is exceeding the word boundary, then it
> > will divide itself such that some portion of it is stored in that word,
> > while the remaining portion is stored in the next higher word. Similar
> > situation occurs while retrieving the value from bitmap.
>
> ...
>
> > @@ -75,7 +75,11 @@
> >   *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
> >   *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
> >   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
> > + *  bitmap_get_value(map, start, nbits)              Get bit value of size
> > + *                                           'nbits' from map at start
> >   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> > + *  bitmap_set_value(map, value, start, nbits)       Set bit value of size 'nbits'
> > + *                                           of map at start
>
> Formatting here is done with solely spaces, no TABs.

Okay. Done

>
> ...
>
> > +/**
> > + * bitmap_get_value - get a value of n-bits from the memory region
> > + * @map: address to the bitmap memory region
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
>
>
> > + *   nbits less than 1 or more than BITS_PER_LONG causes undefined behaviour.
>
> Please, detach this from field description and move to a main description.

Okay. Done.
>
> > + *
> > + * Returns value of nbits located at the @start bit offset within the @map
> > + * memory region.
> > + */
>
> ...
>
> > +             return (map[index] >> offset) & GENMASK(nbits - 1, 0);
>
> Have you considered to use rather BIT{_ULL}(nbits) - 1?
> It maybe better for code generation.

Yes I have considered using BIT{_ULL} in earlier versions of patchset.
It has a problem:

This macro when used in both bitmap_get_value and
bitmap_set_value functions, it will give unexpected results when nbits or clump
size is BITS_PER_LONG (32 or 64 depending on arch).

Actually when nbits (clump size) is 64 (BITS_PER_LONG is 64, for example),
(BIT(nbits) - 1)
gives a value of zero and when this zero is ANDed with any value, it
makes it full zero. This is unexpected, and incorrect calculation occurs.

What actually happens is in the macro expansion of BIT(64), that is 1
<< 64, the '1' overflows from leftmost bit position (most significant
bit) and re-enters at the rightmost bit position (least significant
bit), therefore 1 << 64 becomes '0x1', and when another '1' is
subtracted from this, the final result becomes 0.

This is undefined behavior in the C standard (section 6.5.7 in the N1124)

>
> ...
>
> > +/**
> > + * bitmap_set_value - set n-bit value within a memory region
> > + * @map: address to the bitmap memory region
> > + * @value: value of nbits
> > + * @start: bit offset of the n-bit value
> > + * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).
>
> > + *   nbits less than 1 or more than BITS_PER_LONG causes undefined behaviour.
>
> Please, detach this from field description and move to a main description.

Okay. Done

>
> > + */
>
> ...
>
> > +     value &= GENMASK(nbits - 1, 0);
>
> Ditto.
>
> > +             map[index] &= ~(GENMASK(nbits + offset - 1, offset));
>
> Last time I checked such GENMASK) use, it gave a lot of code when
> GENMASK(nbits - 1, 0) << offset works much better, but see also above.

Yes I have incorporated your suggestion to use the '<<' operator. Thank You.


>
> --
> With Best Regards,
> Andy Shevchenko
>
>
