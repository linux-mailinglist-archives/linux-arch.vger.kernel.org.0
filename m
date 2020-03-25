Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D758F191F6B
	for <lists+linux-arch@lfdr.de>; Wed, 25 Mar 2020 03:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYCrp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Mar 2020 22:47:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727253AbgCYCro (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Mar 2020 22:47:44 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D916CC1B1F67DC29052A;
        Wed, 25 Mar 2020 10:47:41 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Mar 2020
 10:47:32 +0800
Subject: Re: [RFC PATCH v4 3/6] arm64: Add level-hinted TLB invalidation
 helper to tlbi_user
To:     Marc Zyngier <maz@kernel.org>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>,
        <peterz@infradead.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
References: <20200324134534.1570-1-yezhenyu2@huawei.com>
 <20200324134534.1570-4-yezhenyu2@huawei.com> <20200324141939.51917225@why>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <8cf6c576-f0e2-9a52-6919-cb5e27d2ffb5@huawei.com>
Date:   Wed, 25 Mar 2020 10:47:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200324141939.51917225@why>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Marc,

On 2020/3/24 22:19, Marc Zyngier wrote:
> On Tue, 24 Mar 2020 21:45:31 +0800
> Zhenyu Ye <yezhenyu2@huawei.com> wrote:
> 
>> Add a level-hinted parameter to __tlbi_user, which only gets used
>> if ARMv8.4-TTL gets detected.
>>
>> ARMv8.4-TTL provides the TTL field in tlbi instruction to indicate
>> the level of translation table walk holding the leaf entry for the
>> address that is being invalidated.
>>
>> This patch set the default level value to 0.
>>
>> Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
>> ---
>>  arch/arm64/include/asm/tlbflush.h | 42 ++++++++++++++++++++++++++-----
>>  1 file changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
>> index a3f70778a325..d141c080e494 100644
>> --- a/arch/arm64/include/asm/tlbflush.h
>> +++ b/arch/arm64/include/asm/tlbflush.h
>> @@ -89,6 +89,36 @@
>>  		__tlbi(op,  arg);					\
>>  	} while(0)
>>  
>> +#define __tlbi_user_level(op, addr, level)				\
>> +	do {								\
>> +		u64 arg = addr;						\
>> +									\
>> +		if (!arm64_kernel_unmapped_at_el0())			\
>> +			break;						\
>> +									\
>> +		if (cpus_have_const_cap(ARM64_HAS_ARMv8_4_TTL) &&	\
>> +		    level) {						\
>> +			u64 ttl = level;				\
>> +									\
>> +			switch (PAGE_SIZE) {				\
>> +			case SZ_4K:					\
>> +				ttl |= 1 << 2;				\
>> +				break;					\
>> +			case SZ_16K:					\
>> +				ttl |= 2 << 2;				\
>> +				break;					\
>> +			case SZ_64K:					\
>> +				ttl |= 3 << 2;				\
>> +				break;					\
>> +			}						\
>> +									\
>> +			arg &= ~TLBI_TTL_MASK;				\
>> +			arg |= FIELD_PREP(TLBI_TTL_MASK, ttl);		\
>> +		}							\
>> +									\
>> +		__tlbi(op,  (arg) | USER_ASID_FLAG);
>> 	\
>> +	} while (0)
>> +
> 
> Isn't this just:
> 
> define __tlbi_user_level(op, addr, level)			\
> 	do {							\
> 		if (!arm64_kernel_unmapped_at_el0())		\
> 			break;					\
> 								\
> 		__tlbi_level(op, addr | USER_ASID_FLAG, level);	\
> 	} while (0)
> 
> Thanks,
> 
> 	M.
> 

Yeah, your code is more clear!  I will take it in next version. ;-)

Thanks,
zhenyu

