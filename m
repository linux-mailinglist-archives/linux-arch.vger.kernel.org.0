Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9691EBB2D
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jun 2020 14:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgFBMGR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 Jun 2020 08:06:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5333 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbgFBMGR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Jun 2020 08:06:17 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 81E03B2E8FAAB54CD06E;
        Tue,  2 Jun 2020 20:06:15 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 20:06:09 +0800
Subject: Re: [RFC PATCH v4 2/2] arm64: tlb: Use the TLBI RANGE feature in
 arm64
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <suzuki.poulose@arm.com>, <maz@kernel.org>, <steven.price@arm.com>,
        <guohanjun@huawei.com>, <olof@lixom.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200601144713.2222-1-yezhenyu2@huawei.com>
 <20200601144713.2222-3-yezhenyu2@huawei.com>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <7f15f835-cf73-be5b-8bb0-cabb6e4eeed2@huawei.com>
Date:   Tue, 2 Jun 2020 20:06:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200601144713.2222-3-yezhenyu2@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

Some optimizations to the codes:

On 2020/6/1 22:47, Zhenyu Ye wrote:
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
>  

We flush a single page here, and below loop does the same thing
if cpu not support TLB RANGE feature.  So may we use a goto statement
to simplify the code.

> +	while (range_pages > 0) {
> +		if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
> +		    stride == PAGE_SIZE) {
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
> 

Just like:

--8<---
	if (range_pages %2 == 1)
		goto flush_single_tlb;

	while (range_pages > 0) {
		if (cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
		    stride == PAGE_SIZE) {
			num = ((range_pages >> 1) & TLB_RANGE_MASK) - 1;
			if (num >= 0) {
				addr = __TLBI_VADDR_RANGE(start, asid, scale,
							  num, 0);
				__tlbi_last_level(rvale1is, rvae1is, addr,
						  last_level);
				start += __TLBI_RANGE_SIZES(num, scale);
			}
			scale++;
			range_pages >>= TLB_RANGE_MASK_SHIFT;
			continue;
		}

flush_single_tlb:
		addr = __TLBI_VADDR(start, asid);
		__tlbi_last_level(vale1is, vae1is, addr, last_level);
		start += stride;
		range_pages -= stride >> PAGE_SHIFT;
	}
--8<---



