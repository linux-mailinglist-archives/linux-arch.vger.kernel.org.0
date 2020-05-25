Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC061E07AA
	for <lists+linux-arch@lfdr.de>; Mon, 25 May 2020 09:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388951AbgEYHTz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 May 2020 03:19:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388948AbgEYHTz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 May 2020 03:19:55 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9EC1B2FB3E70016EC513;
        Mon, 25 May 2020 15:19:52 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 25 May 2020
 15:19:44 +0800
Subject: Re: [PATCH v2 5/6] mm: tlb: Provide flush_*_tlb_range wrappers
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <peterz@infradead.org>, <mark.rutland@arm.com>, <will@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <akpm@linux-foundation.org>,
        <npiggin@gmail.com>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200423135656.2712-1-yezhenyu2@huawei.com>
 <20200423135656.2712-6-yezhenyu2@huawei.com> <20200522154254.GD26492@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <ddba6d98-29b5-0748-ba74-ec022f509270@huawei.com>
Date:   Mon, 25 May 2020 15:19:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200522154254.GD26492@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/5/22 23:42, Catalin Marinas wrote:
> On Thu, Apr 23, 2020 at 09:56:55PM +0800, Zhenyu Ye wrote:
>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>> index 3d7c01e76efc..3eff199d3507 100644
>> --- a/mm/pgtable-generic.c
>> +++ b/mm/pgtable-generic.c
>> @@ -101,6 +101,28 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long address,
>>  
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>  
>> +#ifndef __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>> +
>> +#define FLUSH_Pxx_TLB_RANGE(_pxx)					\
>> +void flush_##_pxx##_tlb_range(struct vm_area_struct *vma,		\
>> +			      unsigned long addr, unsigned long end)	\
>> +{									\
>> +		struct mmu_gather tlb;					\
>> +									\
>> +		tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);		\
>> +		tlb_start_vma(&tlb, vma);				\
>> +		tlb_flush_##_pxx##_range(&tlb, addr, end - addr);	\
>> +		tlb_end_vma(&tlb, vma);					\
>> +		tlb_finish_mmu(&tlb, addr, end);			\
>> +}
> 
> I may have confused myself (flush_p??_tlb_* vs. tlb_flush_p??_*) but do
> actually need this whole tlb_gather thing here? IIUC (by grep'ing),
> flush_p?d_tlb_range() is only called on huge pages, so we should know
> the level already.
> 

tlb_flush_##_pxx##_range() is used to set tlb->cleared_*,
flush_##_pxx##_tlb_range() will actually flush the TLB entry.

In arch64, tlb_flush_p?d_range() is defined as:

	#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
	#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)

So even if we know the level here, we can not pass the value to tlbi
instructions (flush_tlb_range() is a common kernel interface and retro-fit it
needs lots of changes), according to Peter's suggestion, I finally decide to
pass the value of TTL by the tlb_gather_* frame.[1]

[1] https://lore.kernel.org/linux-arm-kernel/20200331142927.1237-1-yezhenyu2@huawei.com/

Thanks,
Zhenyu

