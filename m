Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4AA21C2B5
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jul 2020 08:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGKGvB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Jul 2020 02:51:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbgGKGvB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Jul 2020 02:51:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 104F5913F15158AB43CC;
        Sat, 11 Jul 2020 14:50:57 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.75) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 11 Jul 2020
 14:50:47 +0800
Subject: Re: [PATCH v2 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <suzuki.poulose@arm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <guohanjun@huawei.com>, <olof@lixom.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200710094420.517-1-yezhenyu2@huawei.com>
 <20200710094420.517-3-yezhenyu2@huawei.com> <20200710183158.GE11839@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <b34e3d42-faaa-73ba-9b54-8e4017514ee0@huawei.com>
Date:   Sat, 11 Jul 2020 14:50:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200710183158.GE11839@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

On 2020/7/11 2:31, Catalin Marinas wrote:
> On Fri, Jul 10, 2020 at 05:44:20PM +0800, Zhenyu Ye wrote:
>> -	if ((end - start) >= (MAX_TLBI_OPS * stride)) {
>> +	if ((!cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&
>> +	    (end - start) >= (MAX_TLBI_OPS * stride)) ||
>> +	    pages >= MAX_TLBI_RANGE_PAGES) {
>>  		flush_tlb_mm(vma->vm_mm);
>>  		return;
>>  	}
> 
> I think we can use strictly greater here rather than greater or equal.
> MAX_TLBI_RANGE_PAGES can be encoded as num 31, scale 3.

Sorry, we can't.
For a boundary value (such as 2^6), we have two way to express it
in TLBI RANGE operations:
1. scale = 0, num = 31.
2. scale = 1, num = 0.

I used the second way in following implementation.  However, for the
MAX_TLBI_RANGE_PAGES, we can only use scale = 3, num = 31.
So if use strictly greater here, ERROR will happen when range pages
equal to MAX_TLBI_RANGE_PAGES.

There are two ways to avoid this bug:
1. Just keep 'greater or equal' here.  The ARM64 specification does
not specify how we flush tlb entries in this case, flush_tlb_mm()
is also a good choice for such a wide range of pages.
2. Add check in the loop, just like: (this may cause the codes a bit ugly)

	num = __TLBI_RANGE_NUM(pages, scale) - 1;

	/* scale = 4, num = 0 is equal to scale = 3, num = 31. */
	if (scale == 4 && num == 0) {
		scale = 3;
		num = 31;
	}

	if (num >= 0) {
	...

Which one do you prefer and how do you want to fix this error? Just
a fix patch again?

> 
>>  
>> -	/* Convert the stride into units of 4k */
>> -	stride >>= 12;
>> +	dsb(ishst);
>>  
>> -	start = __TLBI_VADDR(start, asid);
>> -	end = __TLBI_VADDR(end, asid);
>> +	/*
>> +	 * When cpu does not support TLBI RANGE feature, we flush the tlb
>> +	 * entries one by one at the granularity of 'stride'.
>> +	 * When cpu supports the TLBI RANGE feature, then:
>> +	 * 1. If pages is odd, flush the first page through non-RANGE
>> +	 *    instruction;
>> +	 * 2. For remaining pages: The minimum range granularity is decided
>> +	 *    by 'scale', so we can not flush all pages by one instruction
>> +	 *    in some cases.
>> +	 *    Here, we start from scale = 0, flush corresponding pages
>> +	 *    (from 2^(5*scale + 1) to 2^(5*(scale + 1) + 1)), and increase
>> +	 *    it until no pages left.
>> +	 */
>> +	while (pages > 0) {
> 
> I did some simple checks on ((end - start) % stride) and never
> triggered. I had a slight worry that pages could become negative (and
> we'd loop forever since it's unsigned long) for some mismatched stride
> and flush size. It doesn't seem like.
> 

The start and end are round_down/up in the function:

	start = round_down(start, stride);
 	end = round_up(end, stride);

So the flush size and stride will never mismatch.

Thanks,
Zhenyu

