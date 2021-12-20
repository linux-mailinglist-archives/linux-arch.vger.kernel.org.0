Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D7547A978
	for <lists+linux-arch@lfdr.de>; Mon, 20 Dec 2021 13:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhLTMX5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Dec 2021 07:23:57 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:33875 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhLTMX5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Dec 2021 07:23:57 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JHdzT6c8PzcbMg;
        Mon, 20 Dec 2021 20:23:33 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 20:23:55 +0800
Received: from [10.174.179.5] (10.174.179.5) by dggpemm500002.china.huawei.com
 (7.185.36.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 20 Dec
 2021 20:23:55 +0800
Subject: Re: [PATCH] asm-generic: introduce io_stop_wc() and add
 implementation for ARM64
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <will@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <moyufeng@huawei.com>,
        <linux-arch@vger.kernel.org>
References: <20211217085611.111999-1-wangxiongfeng2@huawei.com>
 <Ybx7lEF4srH4vBmh@arm.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <b8245b7f-9c94-4715-6e9d-467b3a4cb5e1@huawei.com>
Date:   Mon, 20 Dec 2021 20:23:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <Ybx7lEF4srH4vBmh@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.5]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Catalin

On 2021/12/17 19:59, Catalin Marinas wrote:
> On Fri, Dec 17, 2021 at 04:56:11PM +0800, Xiongfeng Wang wrote:
>> For memory accesses with Normal-Non Cacheable attributes, the CPU may do
> 
> You may want to mention "arm64 Normal Non-Cacheable" as other
> architectures have a different meaning of NC.
> 
>> write combining. But in some situation, this is bad for the performance
>> because the prior access may wait too long just to be merged.
>>
>> We introduce io_stop_wc() to prevent the Normal-NC memory accesses before
>> this instruction to be merged with memory accesses after this
>> instruction.
>>
>> We add implementation for ARM64 using DGH instruction and provide NOP
>> implementation for other architectures.
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  Documentation/memory-barriers.txt |  9 +++++++++
>>  arch/arm64/include/asm/barrier.h  |  9 +++++++++
>>  include/asm-generic/barrier.h     | 11 +++++++++++
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
>> index 7367ada13208..b868b51b1801 100644
>> --- a/Documentation/memory-barriers.txt
>> +++ b/Documentation/memory-barriers.txt
>> @@ -1950,6 +1950,15 @@ There are some more advanced barrier functions:
>>       For load from persistent memory, existing read memory barriers are sufficient
>>       to ensure read ordering.
>>  
>> + (*) io_stop_wc();
>> +
>> +     For memory accesses with Normal-Non Cacheable attributes (e.g. those
>> +     returned by ioremap_wc()), the CPU may do write combining. But in some
>> +     situation, this is bad for the performance because the prior access may
>> +     wait too long just to be merged. io_stop_wc() can be used to prevent
>> +     merging memory accesses with Normal-Non Cacheable attributes before this
>> +     instruction with any memory accesses appearing after this instruction.
> 
> I'm fine with the patch in general but the comment here and in
> asm-generic/barrier.h should avoid Normal Non-Cacheable as that's an
> arm-specific term. Looking at Documentation/driver-api/device-io.rst, we
> could simply say "write-combining". Something like:
> 
>      For memory accesses with write-combining attributes (e.g. those
>      returned by ioremap_wc()), the CPU may wait for prior accesses to
>      be merged with subsequent ones. io_stop_wc() can be used to prevent
>      the merging of write-combining memory accesses before this macro
>      with those after it when such wait has performance implications.
> 
> (feel free to rephrase it but avoid Normal NC here)

Thanks for your advice! I will send another version soon.

Thanks,
Xiongfeng

> 
>> +
>>  ===============================
>>  IMPLICIT KERNEL MEMORY BARRIERS
>>  ===============================
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 1c5a00598458..62217be36217 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -26,6 +26,14 @@
>>  #define __tsb_csync()	asm volatile("hint #18" : : : "memory")
>>  #define csdb()		asm volatile("hint #20" : : : "memory")
>>  
>> +/*
>> + * Data Gathering Hint:
>> + * This instruction prevents merging memory accesses with Normal-NC or
>> + * Device-GRE attributes before the hint instruction with any memory accesses
>> + * appearing after the hint instruction.
>> + */
>> +#define dgh()		asm volatile("hint #6" : : : "memory")
> 
> This is fine, arm-specific code.
> 
>> +
>>  #ifdef CONFIG_ARM64_PSEUDO_NMI
>>  #define pmr_sync()						\
>>  	do {							\
>> @@ -46,6 +54,7 @@
>>  #define dma_rmb()	dmb(oshld)
>>  #define dma_wmb()	dmb(oshst)
>>  
>> +#define io_stop_wc()	dgh()
>>  
>>  #define tsb_csync()								\
>>  	do {									\
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index 640f09479bdf..083be6d34cb9 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
>> @@ -251,5 +251,16 @@ do {									\
>>  #define pmem_wmb()	wmb()
>>  #endif
>>  
>> +/*
>> + * ioremap_wc() maps I/O memory as memory with Normal-Non Cacheable attributes.
>> + * The CPU may do write combining for this kind of memory access. io_stop_wc()
>> + * prevents merging memory accesses with Normal-Non Cacheable attributes
>> + * before this instruction with any memory accesses appearing after this
>> + * instruction.
> 
> Please change this as well along the lines of my comment above.
> 
>> + */
>> +#ifndef io_stop_wc
>> +#define io_stop_wc do { } while (0)
>> +#endif
>> +
>>  #endif /* !__ASSEMBLY__ */
>>  #endif /* __ASM_GENERIC_BARRIER_H */
> 
> Thanks.
> 
