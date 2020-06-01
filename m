Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC01EA516
	for <lists+linux-arch@lfdr.de>; Mon,  1 Jun 2020 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgFANgw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 Jun 2020 09:36:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgFANgw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 1 Jun 2020 09:36:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E5E2EC3AB97623A95A5;
        Mon,  1 Jun 2020 21:36:50 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 1 Jun 2020
 21:36:44 +0800
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
 <ddba6d98-29b5-0748-ba74-ec022f509270@huawei.com>
 <20200526145244.GG17051@gaia>
 <0c6f79e4-f29a-d373-2e43-c4f87cf78b49@huawei.com>
 <20200601115644.GA23419@gaia>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <b9521ed4-2845-8986-38ee-23c6aee8acd4@huawei.com>
Date:   Mon, 1 Jun 2020 21:36:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200601115644.GA23419@gaia>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020/6/1 19:56, Catalin Marinas wrote:
> Hi Zhenyu,
> 
> On Sat, May 30, 2020 at 06:24:21PM +0800, Zhenyu Ye wrote:
>> On 2020/5/26 22:52, Catalin Marinas wrote:
>>> On Mon, May 25, 2020 at 03:19:42PM +0800, Zhenyu Ye wrote:
>>>> tlb_flush_##_pxx##_range() is used to set tlb->cleared_*,
>>>> flush_##_pxx##_tlb_range() will actually flush the TLB entry.
>>>>
>>>> In arch64, tlb_flush_p?d_range() is defined as:
>>>>
>>>> 	#define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
>>>> 	#define flush_pud_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
>>>
>>> Currently, flush_p??_tlb_range() are generic and defined as above. I
>>> think in the generic code they can remain an alias for
>>> flush_tlb_range().
>>>
>>> On arm64, we can redefine them as:
>>>
>>> #define flush_pte_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 3)
>>> #define flush_pmd_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 2)
>>> #define flush_pud_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 1)
>>> #define flush_p4d_tlb_range(vma, addr, end)	__flush_tlb_range(vma, addr, end, 0)
>>>
>>> (unless the compiler optimises away all the mmu_gather stuff in your
>>> macro above but they don't look trivial to me)
>>
>> I changed generic code before considering that other structures may also
>> use this feature, such as Power9. And Peter may want to replace all
>> flush_tlb_range() by tlb_flush() in the future, see [1] for details.
>>
>> If only enable this feature on aarch64, your codes are better.
>>
>> [1] https://lore.kernel.org/linux-arm-kernel/20200402163849.GM20713@hirez.programming.kicks-ass.net/
> 
> But we change the semantics slightly if we implement these as
> mmu_gather. For example, tlb_end_vma() -> tlb_flush_mmu_tlbonly() ends
> up calling mmu_notifier_invalidate_range() which it didn't before. I
> think we end up invoking the notifier unnecessarily in some cases (see
> the comment in __split_huge_pmd()) or we end up calling the notifier
> twice (e.g. pmdp_huge_clear_flush_notify()).
> 

Yes, so only enable this feature on aarch64 may be better.
I will change this in V4 of this series. [the v3 only has some minor
changes and can be ignored :)]

>>> Also, I don't see the new flush_pte_* and flush_p4d_* macros used
>>> anywhere and I don't think they are needed. The pte equivalent is
>>> flush_tlb_page() (we need to make sure it's not used on a pmd in the
>>> hugetlb context).
>>
>> flush_tlb_page() is used to flush only one page.  If we add the
>> flush_pte_tlb_range(), then we can use it to flush a range of pages in
>> the future.
> 
> If we know flush_tlb_page() is only called on a small page, could we add
> TTL information here as well?
> 

Yes, we could. I will add this in flush_tlb_page().

>> But flush_pte_* and flush_p4d_* macros are really not used anywhere. I
>> will remove them in next version of series, and add them if someone
>> needs.
> 
> I think it makes sense.
> 

Thanks,
Zhenyu

