Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9BC1FAAE2
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jun 2020 10:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFPIOa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Jun 2020 04:14:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:63987 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgFPIO2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Jun 2020 04:14:28 -0400
IronPort-SDR: VjF7EhjUJZC/gDac0uLwgddFY/LmBl0lzFa09CLc/oRPKpdFHWRS5Y4DwV+WMIuZUcH3ImsM9s
 +TPs++Ds6bNg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 01:14:27 -0700
IronPort-SDR: iVknjRVF13XZH0gD8Jhr/izjiPVFRea5kevTpSrhIL3CDBHqaAWBOMfZ+S1kS7FViiDdc3O5rX
 kYCDPvJO4xOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="476351950"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jun 2020 01:14:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jl6jk-00Dmpc-EB; Tue, 16 Jun 2020 11:14:28 +0300
Date:   Tue, 16 Jun 2020 11:14:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        vilhelm.gray@gmail.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/4] bitops: Introduce the for_each_set_clump macro
Message-ID: <20200616081428.GP2428291@smile.fi.intel.com>
References: <cover.1592224128.git.syednwaris@gmail.com>
 <fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 15, 2020 at 06:21:18PM +0530, Syed Nayyar Waris wrote:
> This macro iterates for each group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to
> the bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value and bitmap_set_value functions are introduced to
> respectively get and set a value of n-bits in a bitmap memory region.
> The n-bits can have any size less than or equal to BITS_PER_LONG.
> Moreover, during setting value of n-bit in bitmap, if a situation arise
> that the width of next n-bit is exceeding the word boundary, then it
> will divide itself such that some portion of it is stored in that word,
> while the remaining portion is stored in the next higher word. Similar
> situation occurs while retrieving value of n-bits from bitmap.

On the second view...

> +static inline unsigned long bitmap_get_value(const unsigned long *map,
> +					      unsigned long start,
> +					      unsigned long nbits)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;

> +	const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);

This perhaps should use round_up()

> +	const unsigned long space = ceiling - start;

And I think I see a scenario to complain.

If start == 0, then ceiling will be 64.
space == 64. Not good.

> +	unsigned long value_low, value_high;
> +
> +	if (space >= nbits)
> +		return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> +	else {
> +		value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> +		value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> +		return (value_low >> offset) | (value_high << space);
> +	}
> +}

...

> +/**
> + * bitmap_set_value - set n-bit value within a memory region
> + * @map: address to the bitmap memory region
> + * @value: value of nbits
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits
> + */
> +static inline void bitmap_set_value(unsigned long *map,
> +				    unsigned long value,
> +				    unsigned long start, unsigned long nbits)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;

> +	const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> +	const unsigned long space = ceiling - start;

Ditto for both lines.

> +	value &= GENMASK(nbits - 1, 0);
> +
> +	if (space >= nbits) {
> +		map[index] &= ~(GENMASK(nbits + offset - 1, offset));
> +		map[index] |= value << offset;
> +	} else {
> +		map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
> +		map[index] |= value << offset;
> +		map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
> +		map[index + 1] |= (value >> space);
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


