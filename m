Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1021BD08
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 20:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgGJScG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 14:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgGJScG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 14:32:06 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 233202075D;
        Fri, 10 Jul 2020 18:32:01 +0000 (UTC)
Date:   Fri, 10 Jul 2020 19:31:59 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org,
        steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
Message-ID: <20200710183158.GE11839@gaia>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710094420.517-3-yezhenyu2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 05:44:20PM +0800, Zhenyu Ye wrote:
> Add __TLBI_VADDR_RANGE macro and rewrite __flush_tlb_range().
> 
> When cpu supports TLBI feature, the minimum range granularity is
> decided by 'scale', so we can not flush all pages by one instruction
> in some cases.
> 
> For example, when the pages = 0xe81a, let's start 'scale' from
> maximum, and find right 'num' for each 'scale':
> 
> 1. scale = 3, we can flush no pages because the minimum range is
>    2^(5*3 + 1) = 0x10000.
> 2. scale = 2, the minimum range is 2^(5*2 + 1) = 0x800, we can
>    flush 0xe800 pages this time, the num = 0xe800/0x800 - 1 = 0x1c.
>    Remaining pages is 0x1a;
> 3. scale = 1, the minimum range is 2^(5*1 + 1) = 0x40, no page
>    can be flushed.
> 4. scale = 0, we flush the remaining 0x1a pages, the num =
>    0x1a/0x2 - 1 = 0xd.
> 
> However, in most scenarios, the pages = 1 when flush_tlb_range() is
> called. Start from scale = 3 or other proper value (such as scale =
> ilog2(pages)), will incur extra overhead.
> So increase 'scale' from 0 to maximum, the flush order is exactly
> opposite to the example.
> 
> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
> ---
>  arch/arm64/include/asm/tlbflush.h | 138 +++++++++++++++++++++++-------
>  1 file changed, 109 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 39aed2efd21b..edfec8139ef8 100644
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
> @@ -73,9 +98,6 @@
>   * in asm/stage2_pgtable.h.
>   */
>  #define TLBI_TTL_MASK		GENMASK_ULL(47, 44)
> -#define TLBI_TTL_TG_4K		1
> -#define TLBI_TTL_TG_16K		2
> -#define TLBI_TTL_TG_64K		3
>  
>  #define __tlbi_level(op, addr, level) do {				\
>  	u64 arg = addr;							\
> @@ -83,19 +105,7 @@
>  	if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&		\
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
> @@ -108,6 +118,39 @@
>  		__tlbi_level(op, (arg | USER_ASID_FLAG), level);	\
>  } while (0)
>  
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
> +		__ta |= (unsigned long)(ttl & 3) << 37;		\
> +		__ta |= (unsigned long)(num & 31) << 39;	\
> +		__ta |= (unsigned long)(scale & 3) << 44;	\
> +		__ta |= (get_trans_granule() & 3) << 46;	\
> +		__ta |= (unsigned long)(asid) << 48;		\
> +		__ta;						\
> +	})

Nitpick: we don't need the additional masking here (e.g. ttl & 3) since
the values are capped anyway.

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
> @@ -232,32 +275,69 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
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

I think we can use strictly greater here rather than greater or equal.
MAX_TLBI_RANGE_PAGES can be encoded as num 31, scale 3.

>  
> -	/* Convert the stride into units of 4k */
> -	stride >>= 12;
> +	dsb(ishst);
>  
> -	start = __TLBI_VADDR(start, asid);
> -	end = __TLBI_VADDR(end, asid);
> +	/*
> +	 * When cpu does not support TLBI RANGE feature, we flush the tlb
> +	 * entries one by one at the granularity of 'stride'.
> +	 * When cpu supports the TLBI RANGE feature, then:
> +	 * 1. If pages is odd, flush the first page through non-RANGE
> +	 *    instruction;
> +	 * 2. For remaining pages: The minimum range granularity is decided
> +	 *    by 'scale', so we can not flush all pages by one instruction
> +	 *    in some cases.
> +	 *    Here, we start from scale = 0, flush corresponding pages
> +	 *    (from 2^(5*scale + 1) to 2^(5*(scale + 1) + 1)), and increase
> +	 *    it until no pages left.
> +	 */
> +	while (pages > 0) {

I did some simple checks on ((end - start) % stride) and never
triggered. I had a slight worry that pages could become negative (and
we'd loop forever since it's unsigned long) for some mismatched stride
and flush size. It doesn't seem like.

> +		if (!cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) ||
> +		    pages % 2 == 1) {
> +			addr = __TLBI_VADDR(start, asid);
> +			if (last_level) {
> +				__tlbi_level(vale1is, addr, tlb_level);
> +				__tlbi_user_level(vale1is, addr, tlb_level);
> +			} else {
> +				__tlbi_level(vae1is, addr, tlb_level);
> +				__tlbi_user_level(vae1is, addr, tlb_level);
> +			}
> +			start += stride;
> +			pages -= stride >> PAGE_SHIFT;
> +			continue;
> +		}
>  
> -	dsb(ishst);
> -	for (addr = start; addr < end; addr += stride) {
> -		if (last_level) {
> -			__tlbi_level(vale1is, addr, tlb_level);
> -			__tlbi_user_level(vale1is, addr, tlb_level);
> -		} else {
> -			__tlbi_level(vae1is, addr, tlb_level);
> -			__tlbi_user_level(vae1is, addr, tlb_level);
> +		num = __TLBI_RANGE_NUM(pages, scale) - 1;
> +		if (num >= 0) {
> +			addr = __TLBI_VADDR_RANGE(start, asid, scale,
> +						  num, tlb_level);
> +			if (last_level) {
> +				__tlbi(rvale1is, addr);
> +				__tlbi_user(rvale1is, addr);
> +			} else {
> +				__tlbi(rvae1is, addr);
> +				__tlbi_user(rvae1is, addr);
> +			}
> +			start += __TLBI_RANGE_PAGES(num, scale) << PAGE_SHIFT;
> +			pages -= __TLBI_RANGE_PAGES(num, scale);
>  		}
> +		scale++;
>  	}
>  	dsb(ish);

The logic looks fine to me now. I can fix the above nitpicks myself and
maybe adjust the comment a bit. I plan to push them into next to see if
anything explodes.

Thanks.

-- 
Catalin
