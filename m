Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3B5CDD22
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2019 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfJGIWD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Oct 2019 04:22:03 -0400
Received: from mga07.intel.com ([134.134.136.100]:26049 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbfJGIWD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Oct 2019 04:22:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 01:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,267,1566889200"; 
   d="scan'208";a="394267379"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 07 Oct 2019 01:21:58 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iHOHE-00057o-FW; Mon, 07 Oct 2019 11:21:56 +0300
Date:   Mon, 7 Oct 2019 11:21:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        geert@linux-m68k.org, preid@electromag.com.au, lukas@wunner.de,
        sean.nyekjaer@prevas.dk, morten.tiljeset@prevas.dk,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v16 01/14] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20191007082156.GL32742@smile.fi.intel.com>
References: <cover.1570374078.git.vilhelm.gray@gmail.com>
 <c0830858f19c852f6d124395a32410bc645ecd15.1570374078.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0830858f19c852f6d124395a32410bc645ecd15.1570374078.git.vilhelm.gray@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 06, 2019 at 11:10:58AM -0400, William Breathitt Gray wrote:
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.

Very much thank you for an update!
I have comments below.

> +/**
> + * bitmap_get_value8 - get an 8-bit value within a memory region

Since it's in find.h I would not collide with bitmap namespace.
How about

	find_and_get_value8()

> + * @addr: address to the bitmap memory region
> + * @start: bit offset of the 8-bit value; must be a multiple of 8
> + *
> + * Returns the 8-bit value located at the @start bit offset within the @addr
> + * memory region.
> + */
> +static inline unsigned long bitmap_get_value8(const unsigned long *addr,
> +					      unsigned long start)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;
> +
> +	return (addr[index] >> offset) & 0xFF;
> +}
> +
> +/**
> + * bitmap_set_value8 - set an 8-bit value within a memory region

	find_and_set_value8()

?

> + * @addr: address to the bitmap memory region
> + * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
> + * @start: bit offset of the 8-bit value; must be a multiple of 8
> + */
> +static inline void bitmap_set_value8(unsigned long *addr, unsigned long value,
> +				     unsigned long start)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;
> +
> +	addr[index] &= ~(0xFF << offset);
> +	addr[index] |= value << offset;
> +}

-- 
With Best Regards,
Andy Shevchenko


