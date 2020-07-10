Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7CA21AF23
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 08:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgGJGHs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 02:07:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbgGJGHr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jul 2020 02:07:47 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id F1D5F97A1F5DAAF31D88;
        Fri, 10 Jul 2020 14:07:41 +0800 (CST)
Received: from [127.0.0.1] (10.174.186.75) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Jul 2020
 14:07:34 +0800
Subject: Re: [PATCH v1 2/2] arm64: tlb: Use the TLBI RANGE feature in arm64
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <suzuki.poulose@arm.com>, <maz@kernel.org>,
        <steven.price@arm.com>, <guohanjun@huawei.com>, <olof@lixom.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200709091054.1698-1-yezhenyu2@huawei.com>
 <20200709091054.1698-3-yezhenyu2@huawei.com> <20200709173616.GC6579@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <8ada2e1b-19d8-58cc-e9cb-e52ddeafd876@huawei.com>
Date:   Fri, 10 Jul 2020 14:07:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200709173616.GC6579@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Catalin,

On 2020/7/10 1:36, Catalin Marinas wrote:
> On Thu, Jul 09, 2020 at 05:10:54PM +0800, Zhenyu Ye wrote:
>>  #define __tlbi_level(op, addr, level) do {				\
>>  	u64 arg = addr;							\
>>  									\
>>  	if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&		\
>> +	    !cpus_have_const_cap(ARM64_HAS_TLBI_RANGE) &&		\
>>  	    level) {							\
>>  		u64 ttl = level & 3;					\
>> -									\
>> -		switch (PAGE_SIZE) {					\
>> -		case SZ_4K:						\
>> -			ttl |= TLBI_TTL_TG_4K << 2;			\
>> -			break;						\
>> -		case SZ_16K:						\
>> -			ttl |= TLBI_TTL_TG_16K << 2;			\
>> -			break;						\
>> -		case SZ_64K:						\
>> -			ttl |= TLBI_TTL_TG_64K << 2;			\
>> -			break;						\
>> -		}							\
>> -									\
>> +		ttl |= get_trans_granule() << 2;			\
>>  		arg &= ~TLBI_TTL_MASK;					\
>>  		arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);			\
>>  	}								\
> 
> I think checking for !ARM64_HAS_TLBI_RANGE here is incorrect. I can see
> why you attempted this since the range and classic ops have a different
> position for the level but now you are not passing the TTL at all for
> the classic TLBI. It's also inconsistent to have the range ops get the
> level in the addr argument while the classic ops added in the
> __tlbi_level macro.
> 

You are right, this is really a serious problem.  But this can be avoided
after removing the check for ARM64_HAS_TLBI_RANGE and dropping the
__tlbi_last_level.
Just call __tlbi() and __tlbi_user() when doing range ops.

> I'd rather have two sets of macros, __tlbi_level and __tlbi_range_level,
> called depending on whether you use classic or range ops.
> 

Then we have to add __tlbi_user_range_level, too. And if we move the num
and scale out of __TLBI_VADDR_RANGE, the __TLBI_VADDR_RANGE macro will make
little sense (addr and asid also can be moved out).

__TLBI_VADDR macro is defined to create a properly formatted VA operand for
the TLBI, then how about add the level to __TLBI_VADDR, just like:

	#define __TLBI_VADDR(addr, asid, level)				\
	({								\
		unsigned long __ta = (addr) >> 12;			\
		__ta &= GENMASK_ULL(43, 0);				\
		__ta |= (unsigned long)(asid) << 48;			\
		if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL)) {	\
			u64 ttl = get_trans_granule() << 2 + level & 3;	\
			__ta |= ttl << 44;				\
		}							\
		__ta;							\
	})

Then we should make sure __TLBI_VADDR is used for all TLBI operands. But
the related code has changed a lot in this merge window, so I perfer to
do this in the future, after all below be merged:

git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/el2-obj-v4.1
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/pre-nv-5.9
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/tlbi

Currently, keep the range ops get the level in the addr argument, the classic
ops added the level in the __tlbi_level macro.

>> @@ -108,6 +119,49 @@
>>  		__tlbi_level(op, (arg | USER_ASID_FLAG), level);	\
>>  } while (0)
>>  
>> +#define __tlbi_last_level(op1, op2, arg, last_level, tlb_level) do {	\
>> +	if (last_level)	{						\
>> +		__tlbi_level(op1, arg, tlb_level);			\
>> +		__tlbi_user_level(op1, arg, tlb_level);			\
>> +	} else {							\
>> +		__tlbi_level(op2, arg, tlb_level);			\
>> +		__tlbi_user_level(op2, arg, tlb_level);			\
>> +	}								\
>> +} while (0)
> 
> And you could drop this altogether. I know it's slightly more lines of
> code but keeping it expanded in __flush_tlb_range() would be clearer.

Thanks,
Zhenyu

