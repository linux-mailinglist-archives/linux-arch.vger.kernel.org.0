Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560541F9966
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jun 2020 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgFON4e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jun 2020 09:56:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:41361 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgFON4d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jun 2020 09:56:33 -0400
IronPort-SDR: xsgUCWypnEjeYc4gJuthrZfMKxu2LGLGLn5BXRMQCsE1PA//FACNCR8qDmqytbRboDROgUOBdQ
 T85FDNXeQ5EA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 06:56:30 -0700
IronPort-SDR: bzGQ6brRlmu8LL6l1aFfQCGVKmV6QkpNPX1n9Gdkr+MiLZv4Vyyv7YMaTY/MSPIqIpCI5qEU7a
 kYK8Vqegpfog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="276565199"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2020 06:56:29 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jkpbD-00DaIE-KU; Mon, 15 Jun 2020 16:56:31 +0300
Date:   Mon, 15 Jun 2020 16:56:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     linus.walleij@linaro.org, akpm@linux-foundation.org,
        vilhelm.gray@gmail.com, arnd@arndb.de, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/4] bitops: Introduce the for_each_set_clump macro
Message-ID: <20200615135631.GF2428291@smile.fi.intel.com>
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
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
> Changes in v8:
>  - No change.
> 
> Changes in v7:
>  - No change.
> 
> Changes in v6:
>  - No change.
> 
> Changes in v5:
>  - No change.
> 
> Changes in v4:
>  - No change.
> 
> Changes in v3:
>  - No change.
> 
> Changes in v2:
>  - No change.
> 
>  include/asm-generic/bitops/find.h | 19 ++++++++++
>  include/linux/bitmap.h            | 61 +++++++++++++++++++++++++++++++
>  include/linux/bitops.h            | 13 +++++++
>  lib/find_bit.c                    | 14 +++++++
>  4 files changed, 107 insertions(+)
> 
> diff --git a/include/asm-generic/bitops/find.h b/include/asm-generic/bitops/find.h
> index 9fdf21302fdf..4e6600759455 100644
> --- a/include/asm-generic/bitops/find.h
> +++ b/include/asm-generic/bitops/find.h
> @@ -97,4 +97,23 @@ extern unsigned long find_next_clump8(unsigned long *clump,
>  #define find_first_clump8(clump, bits, size) \
>  	find_next_clump8((clump), (bits), (size), 0)
>  
> +/**
> + * find_next_clump - find next clump with set bits in a memory region
> + * @clump: location to store copy of found clump
> + * @addr: address to base the search on
> + * @size: bitmap size in number of bits
> + * @offset: bit offset at which to start searching
> + * @clump_size: clump size in bits
> + *
> + * Returns the bit offset for the next set clump; the found clump value is
> + * copied to the location pointed by @clump. If no bits are set, returns @size.
> + */
> +extern unsigned long find_next_clump(unsigned long *clump,
> +				      const unsigned long *addr,
> +				      unsigned long size, unsigned long offset,
> +				      unsigned long clump_size);
> +
> +#define find_first_clump(clump, bits, size, clump_size) \
> +	find_next_clump((clump), (bits), (size), 0, (clump_size))
> +
>  #endif /*_ASM_GENERIC_BITOPS_FIND_H_ */
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 99058eb81042..7ab2c65fc964 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -75,7 +75,11 @@
>   *  bitmap_from_arr32(dst, buf, nbits)          Copy nbits from u32[] buf to dst
>   *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
>   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
> + *  bitmap_get_value(map, start, nbits)		Get bit value of size
> + *						'nbits' from map at start
>   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> + *  bitmap_set_value(map, value, start, nbits)	Set bit value of size 'nbits'
> + *						of map at start
>   *
>   * Note, bitmap_zero() and bitmap_fill() operate over the region of
>   * unsigned longs, that is, bits behind bitmap till the unsigned long
> @@ -563,6 +567,34 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
>  	return (map[index] >> offset) & 0xFF;
>  }
>  
> +/**
> + * bitmap_get_value - get a value of n-bits from the memory region
> + * @map: address to the bitmap memory region
> + * @start: bit offset of the n-bit value
> + * @nbits: size of value in bits
> + *
> + * Returns value of nbits located at the @start bit offset within the @map
> + * memory region.
> + */
> +static inline unsigned long bitmap_get_value(const unsigned long *map,
> +					      unsigned long start,
> +					      unsigned long nbits)
> +{
> +	const size_t index = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;
> +	const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> +	const unsigned long space = ceiling - start;
> +	unsigned long value_low, value_high;
> +
> +	if (space >= nbits)
> +		return (map[index] >> offset) & GENMASK(nbits - 1, 0);

Andrew, note that this requires to have GENMASK() fix [1] applied.

[1]: https://lore.kernel.org/lkml/20200608221823.35799-1-rikard.falkeborn@gmail.com/

> +	else {
> +		value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> +		value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> +		return (value_low >> offset) | (value_high << space);
> +	}
> +}
> +
>  /**
>   * bitmap_set_value8 - set an 8-bit value within a memory region
>   * @map: address to the bitmap memory region
> @@ -579,6 +611,35 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
>  	map[index] |= value << offset;
>  }
>  
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
> +
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
> +
>  #endif /* __ASSEMBLY__ */
>  
>  #endif /* __LINUX_BITMAP_H */
> diff --git a/include/linux/bitops.h b/include/linux/bitops.h
> index 9acf654f0b19..41c2d9ce63e7 100644
> --- a/include/linux/bitops.h
> +++ b/include/linux/bitops.h
> @@ -62,6 +62,19 @@ extern unsigned long __sw_hweight64(__u64 w);
>  	     (start) < (size); \
>  	     (start) = find_next_clump8(&(clump), (bits), (size), (start) + 8))
>  
> +/**
> + * for_each_set_clump - iterate over bitmap for each clump with set bits
> + * @start: bit offset to start search and to store the current iteration offset
> + * @clump: location to store copy of current 8-bit clump
> + * @bits: bitmap address to base the search on
> + * @size: bitmap size in number of bits
> + * @clump_size: clump size in bits
> + */
> +#define for_each_set_clump(start, clump, bits, size, clump_size) \
> +	for ((start) = find_first_clump(&(clump), (bits), (size), (clump_size)); \
> +	     (start) < (size); \
> +	     (start) = find_next_clump(&(clump), (bits), (size), (start) + (clump_size), (clump_size)))
> +
>  static inline int get_bitmask_order(unsigned int count)
>  {
>  	int order;
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 49f875f1baf7..1341bd39b32a 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -190,3 +190,17 @@ unsigned long find_next_clump8(unsigned long *clump, const unsigned long *addr,
>  	return offset;
>  }
>  EXPORT_SYMBOL(find_next_clump8);
> +
> +unsigned long find_next_clump(unsigned long *clump, const unsigned long *addr,
> +			       unsigned long size, unsigned long offset,
> +			       unsigned long clump_size)
> +{
> +	offset = find_next_bit(addr, size, offset);
> +	if (offset == size)
> +		return size;
> +
> +	offset = rounddown(offset, clump_size);
> +	*clump = bitmap_get_value(addr, offset, clump_size);
> +	return offset;
> +}
> +EXPORT_SYMBOL(find_next_clump);
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


