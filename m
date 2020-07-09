Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFEC21A5E8
	for <lists+linux-arch@lfdr.de>; Thu,  9 Jul 2020 19:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgGIRgX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 13:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgGIRgX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 Jul 2020 13:36:23 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4CF62078B;
        Thu,  9 Jul 2020 17:36:19 +0000 (UTC)
Date:   Thu, 9 Jul 2020 18:36:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org,
        steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v1 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Message-ID: <20200709173616.GC6579@gaia>
References: <20200709091054.1698-1-yezhenyu2@huawei.com>
 <20200709091054.1698-3-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709091054.1698-3-yezhenyu2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 09, 2020 at 05:10:54PM +0800, Zhenyu Ye wrote:
> Add __TLBI_VADDR_RANGE macro and rewrite __flush_tlb_range().
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  arch/arm64/include/asm/tlbflush.h | 156 ++++++++++++++++++++++++------
>  1 file changed, 126 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 39aed2efd21b..30e52eae973b 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -60,6 +60,31 @@
>  		__ta;						\
>  	})
>  
> +/*
> + * Get translation granule of the system, which is decided by
> + * PAGE_SIZE.  Used by TTL.
> + *  - 4KB	: 1
> + *  - 16KB	: 2
> + *  - 64KB	: 3
> + */
> +#define TLBI_TTL_TG_4K		1
> +#define TLBI_TTL_TG_16K		2
> +#define TLBI_TTL_TG_64K		3
> +
> +static inline unsigned long get_trans_granule(void)
> +{
> +	switch (PAGE_SIZE) {
> +	case SZ_4K:
> +		return TLBI_TTL_TG_4K;
> +	case SZ_16K:
> +		return TLBI_TTL_TG_16K;
> +	case SZ_64K:
> +		return TLBI_TTL_TG_64K;
> +	default:
> +		return 0;
> +	}
> +}
> +
>  /*
>   * Level-based TLBI operations.
>   *
> @@ -73,29 +98,15 @@
>   * in asm/stage2_pgtable.h.
>   */
>  #define TLBI_TTL_MASK		GENMASK_ULL(47, 44)
> -#define TLBI_TTL_TG_4K		1
> -#define TLBI_TTL_TG_16K		2
> -#define TLBI_TTL_TG_64K		3
>  
>  #define __tlbi_level(op, addr, level) do {				\
>  	u64 arg = addr;							\
>  									\
>  	if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&		\
> +	    !cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&		\
>  	    level) {							\
>  		u64 ttl = level & 3;					\
> -									\
> -		switch (PAGE_SIZE) {					\
> -		case SZ_4K:						\
> -			ttl |= TLBI_TTL_TG_4K << 2;			\
> -			break;						\
> -		case SZ_16K:						\
> -			ttl |= TLBI_TTL_TG_16K << 2;			\
> -			break;						\
> -		case SZ_64K:						\
> -			ttl |= TLBI_TTL_TG_64K << 2;			\
> -			break;						\
> -		}							\
> -									\
> +		ttl |= get_trans_granule() << 2;			\
>  		arg &= ~TLBI_TTL_MASK;					\
>  		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
>  	}								\

I think checking for !ARM64_HAS_TLBI_RANGE here is incorrect. I can see
why you attempted this since the range and classic ops have a different
position for the level but now you are not passing the TTL at all for
the classic TLBI. It's also inconsistent to have the range ops get the
level in the addr argument while the classic ops added in the
__tlbi_level macro.

I'd rather have two sets of macros, __tlbi_level and __tlbi_range_level,
called depending on whether you use classic or range ops.

> @@ -108,6 +119,49 @@
>  		__tlbi_level(op, (arg | USER_ASID_FLAG), level);	\
>  } while (0)
>  
> +#define __tlbi_last_level(op1, op2, arg, last_level, tlb_level) do {	\
> +	if (last_level)	{						\
> +		__tlbi_level(op1, arg, tlb_level);			\
> +		__tlbi_user_level(op1, arg, tlb_level);			\
> +	} else {							\
> +		__tlbi_level(op2, arg, tlb_level);			\
> +		__tlbi_user_level(op2, arg, tlb_level);			\
> +	}								\
> +} while (0)

And you could drop this altogether. I know it's slightly more lines of
code but keeping it expanded in __flush_tlb_range() would be clearer.

> +
> +/*
> + * This macro creates a properly formatted VA operand for the TLBI RANGE.
> + * The value bit assignments are:
> + *
> + * +----------+------+-------+-------+-------+----------------------+
> + * |   ASID   |  TG  | SCALE |  NUM  |  TTL  |        BADDR         |
> + * +-----------------+-------+-------+-------+----------------------+
> + * |63      48|47  46|45   44|43   39|38   37|36                   0|
> + *
> + * The address range is determined by below formula:
> + * [BADDR, BADDR + (NUM + 1) * 2^(5*SCALE + 1) * PAGESIZE)
> + *
> + */
> +#define __TLBI_VADDR_RANGE(addr, asid, scale, num, ttl)		\
> +	({							\
> +		unsigned long __ta = (addr) >> PAGE_SHIFT;	\
> +		__ta &= GENMASK_ULL(36, 0);			\
> +		__ta |= (unsigned long)(ttl) << 37;		\
> +		__ta |= (unsigned long)(num) << 39;		\
> +		__ta |= (unsigned long)(scale) << 44;		\
> +		__ta |= get_trans_granule() << 46;		\
> +		__ta |= (unsigned long)(asid) << 48;		\
> +		__ta;						\
> +	})

As per above, I'd remove the ttl here and just add it in the
__tlbi_level_range(). For consistency, you could do the same with num
and scale, just leave the asid and addr, similar to __TLBI_VADDR (the
only difference is the shift by PAGE_SHIFT rather than 12).

> +
> +/* These macros are used by the TLBI RANGE feature. */
> +#define __TLBI_RANGE_PAGES(num, scale)	(((num) + 1) << (5 * (scale) + 1))
> +#define MAX_TLBI_RANGE_PAGES		__TLBI_RANGE_PAGES(31, 3)
> +
> +#define TLBI_RANGE_MASK			GENMASK_ULL(4, 0)
> +#define __TLBI_RANGE_NUM(range, scale)	\
> +	(((range) >> (5 * (scale) + 1)) & TLBI_RANGE_MASK)
> +
>  /*
>   *	TLB Invalidation
>   *	================
> @@ -232,32 +286,74 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>  				     unsigned long stride, bool last_level,
>  				     int tlb_level)
>  {
> +	int num = 0;
> +	int scale = 0;
>  	unsigned long asid = ASID(vma->vm_mm);
>  	unsigned long addr;
> +	unsigned long pages;
>  
>  	start = round_down(start, stride);
>  	end = round_up(end, stride);
> +	pages = (end - start) >> PAGE_SHIFT;
>  
> -	if ((end - start) >= (MAX_TLBI_OPS * stride)) {
> +	if ((!cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
> +	    (end - start) >= (MAX_TLBI_OPS * stride)) ||
> +	    pages >= MAX_TLBI_RANGE_PAGES) {
>  		flush_tlb_mm(vma->vm_mm);
>  		return;
>  	}
>  
> -	/* Convert the stride into units of 4k */
> -	stride >>= 12;
> -
> -	start = __TLBI_VADDR(start, asid);
> -	end = __TLBI_VADDR(end, asid);
> -
>  	dsb(ishst);
> -	for (addr = start; addr < end; addr += stride) {
> -		if (last_level) {
> -			__tlbi_level(vale1is, addr, tlb_level);
> -			__tlbi_user_level(vale1is, addr, tlb_level);
> -		} else {
> -			__tlbi_level(vae1is, addr, tlb_level);
> -			__tlbi_user_level(vae1is, addr, tlb_level);
> +
> +	/*
> +	 * When cpu does not support TLBI RANGE feature, we flush the tlb
> +	 * entries one by one at the granularity of 'stride'.
> +	 * When cpu supports the TLBI RANGE feature, then:
> +	 * 1. If pages is odd, flush the first page through non-RANGE
> +	 *    instruction;
> +	 * 2. For remaining pages: The minimum range granularity is decided
> +	 *    by 'scale', so we can not flush all pages by one instruction
> +	 *    in some cases.

This part can stay in the code. In addition, you could mention something
along the lines that it starts from scale 0 (covering num * 2 pages) and
increments it until no pages left.

> +	 *
> +	 * For example, when the pages = 0xe81a, let's start 'scale' from
> +	 * maximum, and find right 'num' for each 'scale':
> +	 *
> +	 *  When scale = 3, we can flush no pages because the minumum
> +	 * range is 2^(5*3 + 1) = 0x10000.
> +	 *  When scale = 2, the minimum range is 2^(5*2 + 1) = 0x800, we can
> +	 * flush 0xe800 pages this time, the num = 0xe800/0x800 - 1 = 0x1c.
> +	 * Remain pages is 0x1a;
> +	 *  When scale = 1, the minimum range is 2^(5*1 + 1) = 0x40, no page
> +	 * can be flushed.
> +	 *  When scale = 0, we flush the remaining 0x1a pages, the num =
> +	 * 0x1a/0x2 - 1 = 0xd.
> +	 *
> +	 * However, in most scenarios, the pages = 1 when flush_tlb_range() is
> +	 * called. Start from scale = 3 or other proper value (such as scale =
> +	 * ilog2(pages)), will incur extra overhead.
> +	 * So increase 'scale' from 0 to maximum, the flush order is exactly
> +	 * opposite to the example.
> +	 */

I'd drop the example from the code, just move it to the commit log.

> +	while (pages > 0) {
> +		if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
> +		    pages % 2 == 0) {
> +			num = __TLBI_RANGE_NUM(pages, scale) - 1;
> +			if (num >= 0) {
> +				addr = __TLBI_VADDR_RANGE(start, asid, scale,
> +							  num, tlb_level);
> +				__tlbi_last_level(rvale1is, rvae1is, addr,
> +						  last_level, tlb_level);
> +				start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
> +				pages -= __TLBI_RANGE_PAGES(num, scale);
> +			}
> +			scale++;
> +			continue;
>  		}
> +
> +		addr = __TLBI_VADDR(start, asid);
> +		__tlbi_last_level(vale1is, vae1is, addr, last_level, tlb_level);
> +		start += stride;
> +		pages -= stride >> PAGE_SHIFT;
>  	}
>  	dsb(ish);

As I mentioned above, just keep the "if (last_level)" expanded here in
both cases. Maybe you could place a "pages % 2 == 1" check first to
avoid the indentation. Something like:


	while (pages > 0) {
		if (!cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) ||
		    pages % 2 == 1) {
			...
			__tlbi_level();
			...
			continue;
		}

		num = __TLBI_RANGE_NUM(pages, scale) - 1;
		if (num >= 0) {
			...
		}
		scale++;
		continue;
	}

Thanks.

-- 
Catalin
