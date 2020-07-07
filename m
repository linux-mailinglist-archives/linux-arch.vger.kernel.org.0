Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEC9217553
	for <lists+linux-arch@lfdr.de>; Tue,  7 Jul 2020 19:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGGRgY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Jul 2020 13:36:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbgGGRgX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 7 Jul 2020 13:36:23 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F170B20672;
        Tue,  7 Jul 2020 17:36:19 +0000 (UTC)
Date:   Tue, 7 Jul 2020 18:36:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zhenyu Ye <yezhenyu2@huawei.com>
Cc:     will@kernel.org, suzuki.poulose@arm.com, maz@kernel.org,
        steven.price@arm.com, guohanjun@huawei.com, olof@lixom.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org, arm@kernel.org,
        xiexiangyou@huawei.com, prime.zeng@hisilicon.com,
        zhangshaokun@hisilicon.com, kuhn.chenqun@huawei.com
Subject: Re: [RFC PATCH v4 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
Message-ID: <20200707173617.GA32331@gaia>
References: <20200601144713.2222-1-yezhenyu2@huawei.com>
 <20200601144713.2222-3-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601144713.2222-3-yezhenyu2@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 01, 2020 at 10:47:13PM +0800, Zhenyu Ye wrote:
> @@ -59,6 +69,47 @@
>  		__ta;						\
>  	})
>  
> +/*
> + * __TG defines translation granule of the system, which is decided by
> + * PAGE_SHIFT.  Used by TTL.
> + *  - 4KB	: 1
> + *  - 16KB	: 2
> + *  - 64KB	: 3
> + */
> +#define __TG	((PAGE_SHIFT - 12) / 2 + 1)

Nitpick: maybe something like __TLBI_TG to avoid clashes in case someone
else defines a __TG macro.

> @@ -181,32 +232,55 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
>  				     unsigned long start, unsigned long end,
>  				     unsigned long stride, bool last_level)
>  {
> +	int num = 0;
> +	int scale = 0;
>  	unsigned long asid = ASID(vma->vm_mm);
>  	unsigned long addr;
> +	unsigned long range_pages;
>  
>  	start = round_down(start, stride);
>  	end = round_up(end, stride);
> +	range_pages = (end - start) >> PAGE_SHIFT;
>  
>  	if ((end - start) >= (MAX_TLBI_OPS * stride)) {
>  		flush_tlb_mm(vma->vm_mm);
>  		return;
>  	}
>  
> -	/* Convert the stride into units of 4k */
> -	stride >>= 12;
> +	dsb(ishst);
>  
> -	start = __TLBI_VADDR(start, asid);
> -	end = __TLBI_VADDR(end, asid);
> +	/*
> +	 * The minimum size of TLB RANGE is 2 pages;
> +	 * Use normal TLB instruction to handle odd pages.
> +	 * If the stride != PAGE_SIZE, this will never happen.
> +	 */
> +	if (range_pages % 2 == 1) {
> +		addr = __TLBI_VADDR(start, asid);
> +		__tlbi_last_level(vale1is, vae1is, addr, last_level);
> +		start += 1 << PAGE_SHIFT;
> +		range_pages >>= 1;
> +	}

Shouldn't this be range_pages-- or -= stride >> 12? Your goto follow-up
fixes this, though I'm not a big fan of gotos jumping in the middle of a
loop.

> -	dsb(ishst);
> -	for (addr = start; addr < end; addr += stride) {
> -		if (last_level) {
> -			__tlbi(vale1is, addr);
> -			__tlbi_user(vale1is, addr);
> -		} else {
> -			__tlbi(vae1is, addr);
> -			__tlbi_user(vae1is, addr);
> +	while (range_pages > 0) {
> +		if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
> +		    stride == PAGE_SIZE) {

I think we could have the odd range_pages check here:

		if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
		    stride == PAGE_SIZE && range_pages % 2 == 0) {

and avoid the one outside the loop.

> +			num = (range_pages & TLB_RANGE_MASK) - 1;
> +			if (num >= 0) {
> +				addr = __TLBI_VADDR_RANGE(start, asid, scale,
> +							  num, 0);
> +				__tlbi_last_level(rvale1is, rvae1is, addr,
> +						  last_level);
> +				start += __TLBI_RANGE_SIZES(num, scale);
> +			}
> +			scale++;
> +			range_pages >>= TLB_RANGE_MASK_SHIFT;
> +			continue;
>  		}
> +
> +		addr = __TLBI_VADDR(start, asid);
> +		__tlbi_last_level(vale1is, vae1is, addr, last_level);
> +		start += stride;
> +		range_pages -= stride >> 12;
>  	}
>  	dsb(ish);
>  }
> -- 
> 2.19.1

-- 
Catalin
