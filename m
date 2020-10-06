Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4647E284AD0
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 13:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgJFL0o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 07:26:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:15831 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFL0o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Oct 2020 07:26:44 -0400
IronPort-SDR: bJoaSJxzNRq/GyiiDnkmLuaBE7jywuLDROT9PXFQ2oJEZM3lmkq/R8HLDSQjII9sZmqB7PA/hM
 ZYGi2TsqMGhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="144359212"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="144359212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 04:26:44 -0700
IronPort-SDR: eWViaGj6rPWvahSYh8gVy4qS0yigTBvcTVl1GfMEgjDifJ8y9AQy9oqXBA2gwc2MQKdtUsrtIk
 KFLGLG14FIrA==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="518237515"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 04:26:42 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kPl8D-0007J8-6r; Tue, 06 Oct 2020 14:27:45 +0300
Date:   Tue, 6 Oct 2020 14:27:45 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        vilhelm.gray@gmail.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/4] bitops: Introduce the for_each_set_clump macro
Message-ID: <20201006112745.GG4077@smile.fi.intel.com>
References: <cover.1601974764.git.syednwaris@gmail.com>
 <33de236870f7d3cf56a55d747e4574cdd2b9686a.1601974764.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33de236870f7d3cf56a55d747e4574cdd2b9686a.1601974764.git.syednwaris@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 06, 2020 at 02:52:16PM +0530, Syed Nayyar Waris wrote:
> This macro iterates for each group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to
> the bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value() and bitmap_set_value() functions are introduced to
> respectively get and set a value of n-bits in a bitmap memory region.
> The n-bits can have any size less than or equal to BITS_PER_LONG.
> Moreover, during setting value of n-bit in bitmap, if a situation arise
> that the width of next n-bit is exceeding the word boundary, then it
> will divide itself such that some portion of it is stored in that word,
> while the remaining portion is stored in the next higher word. Similar
> situation occurs while retrieving the value from bitmap.

...

> @@ -75,7 +75,11 @@
>   *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
>   *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
>   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
> + *  bitmap_get_value(map, start, nbits)		Get bit value of size
> + *						'nbits' from map at start
>   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> + *  bitmap_set_value(map, value, start, nbits)	Set bit value of size 'nbits'
> + *						of map at start

Formatting here is done with solely spaces, no TABs.

...

> +/**
> + * bitmap_get_value - get a value of n-bits from the memory region
> + * @map: address to the bitmap memory region
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).


> + *	nbits less than 1 or more than BITS_PER_LONG causes undefined behaviour.

Please, detach this from field description and move to a main description.

> + *
> + * Returns value of nbits located at the @start bit offset within the @map
> + * memory region.
> + */

...

> +		return (map[index] >> offset) & GENMASK(nbits - 1, 0);

Have you considered to use rather BIT{_ULL}(nbits) - 1?
It maybe better for code generation.

...

> +/**
> + * bitmap_set_value - set n-bit value within a memory region
> + * @map: address to the bitmap memory region
> + * @value: value of nbits
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits (must be between 1 and BITS_PER_LONG inclusive).

> + *	nbits less than 1 or more than BITS_PER_LONG causes undefined behaviour.

Please, detach this from field description and move to a main description.

> + */

...

> +	value &= GENMASK(nbits - 1, 0);

Ditto.

> +		map[index] &= ~(GENMASK(nbits + offset - 1, offset));

Last time I checked such GENMASK) use, it gave a lot of code when
GENMASK(nbits - 1, 0) << offset works much better, but see also above.

-- 
With Best Regards,
Andy Shevchenko


