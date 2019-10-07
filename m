Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38386CE73B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2019 17:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfJGPTK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Oct 2019 11:19:10 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46340 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbfJGPTK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Oct 2019 11:19:10 -0400
Received: by mail-yw1-f66.google.com with SMTP id h10so2241160ywm.13;
        Mon, 07 Oct 2019 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wiNFdskpw4yBMm9nyiqt5ftRnxZo6W3oQSMb5hEf9N0=;
        b=lb4bWWehvLkfbpod5kZF+pZetwwjP/Hl4QHssFZCruTsJ2+da6Y7y2IT76QjtCuIXY
         jcHRPM3UIIntO35bKebInFUzmiuZ2fCLpF9l2UqODiQa1nhnut99+IDTo02WkZee0Lqh
         HaVANCKIYksMAT+SUbHNB3LY2GtLN+X5ySty1pg7Pmm8erKDW95qj3gyiMeA/DPeDzUS
         gc8Ydvc7F24bWkxsLrDXbS6GVid127WHhbmMJ9GrMm/PXNMxymwLPg5f7X4KaMM2N72b
         YxuI3iw/0sU7ng+V57pPA2LWXWEFfEl4atDnE1D+y74Gm0Rpw27+7LS1nUaz/haerXsE
         hF+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wiNFdskpw4yBMm9nyiqt5ftRnxZo6W3oQSMb5hEf9N0=;
        b=DqDPZwncuBvDYND5AsN/v9nDW+UcLlf9IjTOSKbvyZkkPz+MU8uNCx3kbPdqX8ukrP
         73hkHfFUIS/mFYclNDa8wk9g/6l/618A8/ArjKiEfW66uMGwDWE1lxqLMSh2rnozSpdd
         MH680plw7azMwcsnMhOCingLr2aCbpCgeOh5EEt8jjl75mYPa4EzBzWkjjHLl3EeNoG4
         XQBHLUNqO/2reJ708df+V0OSZmRCLBN6+DiVC+5EliSkpgizf30vzqTL2l/1i3M1GqEt
         WxZpzjVMHk7UNXnSPpp68bHrhYZz5Z15wAsCCFRQsi583Og1P0p5TGP1ahVdlcC+QZnI
         5nBw==
X-Gm-Message-State: APjAAAWZQmxKOZ2kf5j3iVr+SUKorQQCNsW0snBVf/eWGF8xvgwKVEpK
        R62dmlinDD3aoQpj9otIZgk=
X-Google-Smtp-Source: APXvYqzRFRpv7XJTv8PKNwl6Ppt8cG35jqRtYU+F/E4Oee5d9CbO3gFPtNFJXNPBhZtX6QAVzod2Qw==
X-Received: by 2002:a0d:cccc:: with SMTP id o195mr18912544ywd.44.1570461547530;
        Mon, 07 Oct 2019 08:19:07 -0700 (PDT)
Received: from icarus (072-189-084-142.res.spectrum.com. [72.189.84.142])
        by smtp.gmail.com with ESMTPSA id g128sm3727806ywb.13.2019.10.07.08.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:19:06 -0700 (PDT)
Date:   Mon, 7 Oct 2019 11:18:51 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v16 01/14] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20191007151851.GA3494@icarus>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
 <c0830858f19c852f6d124395a32410bc645ecd15.1570374078.git.vilhelm.gray@gmail.com>
 <20191007082156.GL32742@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007082156.GL32742@smile.fi.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 07, 2019 at 11:21:56AM +0300, Andy Shevchenko wrote:
> On Sun, Oct 06, 2019 at 11:10:58AM -0400, William Breathitt Gray wrote:
> > This macro iterates for each 8-bit group of bits (clump) with set bits,
> > within a bitmap memory region. For each iteration, "start" is set to the
> > bit offset of the found clump, while the respective clump value is
> > stored to the location pointed by "clump". Additionally, the
> > bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> > respectively get and set an 8-bit value in a bitmap memory region.
> 
> Very much thank you for an update!
> I have comments below.
> 
> > +/**
> > + * bitmap_get_value8 - get an 8-bit value within a memory region
> 
> Since it's in find.h I would not collide with bitmap namespace.
> How about
> 
> 	find_and_get_value8()

We modeled the interface for these on the existing bitmap functions, so
perhaps it would be better to move bitmap_get_value8 and
bitmap_set_value8 to include/linux/bitmap.h so that they are with the
rest of the bitmap functions -- afterall, they are operating on bitmaps.

> > + * @addr: address to the bitmap memory region
> > + * @start: bit offset of the 8-bit value; must be a multiple of 8
> > + *
> > + * Returns the 8-bit value located at the @start bit offset within the @addr
> > + * memory region.
> > + */
> > +static inline unsigned long bitmap_get_value8(const unsigned long *addr,
> > +					      unsigned long start)
> > +{
> > +	const size_t index = BIT_WORD(start);
> > +	const unsigned long offset = start % BITS_PER_LONG;
> > +
> > +	return (addr[index] >> offset) & 0xFF;
> > +}
> > +
> > +/**
> > + * bitmap_set_value8 - set an 8-bit value within a memory region
> 
> 	find_and_set_value8()
> 
> ?
> 
> > + * @addr: address to the bitmap memory region
> > + * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
> > + * @start: bit offset of the 8-bit value; must be a multiple of 8
> > + */
> > +static inline void bitmap_set_value8(unsigned long *addr, unsigned long value,
> > +				     unsigned long start)
> > +{
> > +	const size_t index = BIT_WORD(start);
> > +	const unsigned long offset = start % BITS_PER_LONG;
> > +
> > +	addr[index] &= ~(0xFF << offset);
> > +	addr[index] |= value << offset;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko

The find_next_clump8 function can remain exposed via
include/linux/find.h since it fits in with the rest of the functions
there.

The reason I moved the definition to lib/find_bit.c is due to the
circular dependency that arose from the round_down macro. Should I try
to move the definition back to include/linux/find.h and reimplement it
without the round_down macro; or is it best to keep this simpler
implementation here in lib/find_bit.c?

William Breathitt Gray
