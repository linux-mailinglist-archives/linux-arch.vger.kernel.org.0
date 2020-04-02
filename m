Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C019C019
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 13:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbgDBLYV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 07:24:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12606 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388012AbgDBLYU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Apr 2020 07:24:20 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 30743A876D0C1A482D0C;
        Thu,  2 Apr 2020 19:24:13 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 19:24:06 +0800
Subject: Re: [RFC PATCH v5 4/8] mm: tlb: Pass struct mmu_gather to
 flush_pmd_tlb_range
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <mark.rutland@arm.com>, <will@kernel.org>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <akpm@linux-foundation.org>, <npiggin@gmail.com>, <arnd@arndb.de>,
        <rostedt@goodmis.org>, <maz@kernel.org>, <suzuki.poulose@arm.com>,
        <tglx@linutronix.de>, <yuzhao@google.com>, <Dave.Martin@arm.com>,
        <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>, <corbet@lwn.net>, <vgupta@synopsys.com>,
        <tony.luck@intel.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200331142927.1237-1-yezhenyu2@huawei.com>
 <20200331142927.1237-5-yezhenyu2@huawei.com>
 <20200331151331.GS20730@hirez.programming.kicks-ass.net>
 <fe12101e-8efe-22ad-0258-e6aeafc798cc@huawei.com>
 <20200401122004.GE20713@hirez.programming.kicks-ass.net>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <53675fb9-21c7-5309-07b8-1bbc1e775f9b@huawei.com>
Date:   Thu, 2 Apr 2020 19:24:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200401122004.GE20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On 2020/4/1 20:20, Peter Zijlstra wrote:
> On Wed, Apr 01, 2020 at 04:51:15PM +0800, Zhenyu Ye wrote:
>> On 2020/3/31 23:13, Peter Zijlstra wrote:
> 
>>> Instead of trying to retro-fit flush_*tlb_range() to take an mmu_gather
>>> parameter, please replace them out-right.
>>>
>>
>> I'm sorry that I'm not sure what "replace them out-right" means.  Do you
>> mean that I should define flush_*_tlb_range like this?
>>
>> #define flush_pmd_tlb_range(vma, addr, end)				\
>> 	do {								\
>> 		struct mmu_gather tlb;					\
>> 		tlb_gather_mmu(&tlb, (vma)->vm_mm, addr, end);		\
>> 		tlba.cleared_pmds = 1;					\
>> 		flush_tlb_range(&tlb, vma, addr, end);			\
>> 		tlb_finish_mmu(&tlb, addr, end);			\
>> 	} while (0)
>>
> 
> I was thinking to remove flush_*tlb_range() entirely (from generic
> code).
> 
> And specifically to not use them like the above; instead extend the
> mmu_gather API.
> 
> Specifically, if you wanted to express flush_pmd_tlb_range() in mmu
> gather, you'd write it like:
> 
> static inline void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long addr, unsigned long end)
> {
> 	struct mmu_gather tlb;
> 
> 	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> 	tlb_start_vma(&tlb, vma);
> 	tlb.cleared_pmds = 1;
> 	__tlb_adjust_range(addr, end - addr);
> 	tlb_end_vma(&tlb, vma);
> 	tlb_finish_mmu(&tlb, addr, end);
> }
> 
> Except of course, that the code between start_vma and end_vma is not a
> proper mmu_gather API.
> 
> So maybe add:
> 
>   tlb_flush_{pte,pmd,pud,p4d}_range()
> 
> Then we can write:
> 
> static inline void flush_XXX_tlb_range(struct vm_area_struct *vma, unsigned long addr, unsigned long end)
> {
> 	struct mmu_gather tlb;
> 
> 	tlb_gather_mmu(&tlb, vma->vm_mm, addr, end);
> 	tlb_start_vma(&tlb, vma);
> 	tlb_flush_XXX_range(&tlb, addr, end - addr);
> 	tlb_end_vma(&tlb, vma);
> 	tlb_finish_mmu(&tlb, addr, end);
> }
> 
> But when I look at the output of:
> 
>   git grep flush_.*tlb_range -- :^arch/
> 
> I doubt it makes sense to provide wrappers like the above.
> 

Thanks for your detailed explanation.  I notice that you used
`tlb_end_vma` replace `flush_tlb_range`, which will call `tlb_flush`,
then finally call `flush_tlb_range` in generic code.  However, some
architectures define tlb_end_vma|tlb_flush|flush_tlb_range themselves,
so this may cause problems.

For example, in s390, it defines:

#define tlb_end_vma(tlb, vma)			do { } while (0)

And it doesn't define it's own flush_pmd_tlb_range().  So there will be
a mistake if we changed flush_pmd_tlb_range() using tlb_end_vma().

Is this really a problem or something I understand wrong ?



If true, I think there are three ways to solve this problem:

1. use `flush_tlb_range` rather than `tlb_end_vma` in flush_XXX_tlb_range;
   In this way, we still need retro-fit `flush_tlb_range` to take an mmu_gather
parameter.

2. use `tlb_flush` rather than `tlb_end_vma`.
   There is a constraint such like:

	#ifndef tlb_flush
	#if defined(tlb_start_vma) || defined(tlb_end_vma)
	#error Default tlb_flush() relies on default tlb_start_vma() and tlb_end_vma()
	#endif

   So all architectures that define tlb_{start|end}_vma have defined tlb_flush.
Also, we can add a constraint to flush_XXX_tlb_range such like:

	#ifndef flush_XXX_tlb_range
	#if defined(tlb_start_vma) || defined(tlb_end_vma)
	#error Default flush_XXX_tlb_range() relies on default tlb_start/end_vma()
	#endif

3. Define flush_XXX_tlb_range() architecture-self, and keep original define in
generic code, such as:

In arm64:
	#define flush_XXX_tlb_range flush_XXX_tlb_range

In generic:
	#ifndef flush_XXX_tlb_range
	#define flush_XXX_tlb_range flush_tlb_range


Which do you think is more appropriate?


> ( Also, we should probably remove the (addr, end) arguments from
> tlb_finish_mmu(), Will? )
> 

This can be changed quickly. If you want I can do this with a
separate patch.

> ---
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index f391f6b500b4..be5452a8efaa 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -511,6 +511,34 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
>  }
>  #endif
>  
> +static inline void tlb_flush_pte_range(struct mmu_gather *tlb,
> +				       unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_ptes = 1;
> +}
> +
> +static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
> +				       unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_pmds = 1;
> +}
> +
> +static inline void tlb_flush_pud_range(struct mmu_gather *tlb,
> +				       unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_puds = 1;
> +}
> +
> +static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
> +				       unsigned long address, unsigned long size)
> +{
> +	__tlb_adjust_range(tlb, address, size);
> +	tlb->cleared_p4ds = 1;
> +}
> +

By the way, I think the name of tlb_set_XXX_range() is more suitable, because
we don't do actual flush there.

>  #ifndef __tlb_remove_tlb_entry
>  #define __tlb_remove_tlb_entry(tlb, ptep, address) do { } while (0)
>  #endif
> @@ -524,8 +552,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
>   */
>  #define tlb_remove_tlb_entry(tlb, ptep, address)		\
>  	do {							\
> -		__tlb_adjust_range(tlb, address, PAGE_SIZE);	\
> -		tlb->cleared_ptes = 1;				\
> +		tlb_flush_pte_range(tlb, address, PAGE_SIZE);	\
>  		__tlb_remove_tlb_entry(tlb, ptep, address);	\
>  	} while (0)
>  
> @@ -550,8 +577,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
>  
>  #define tlb_remove_pmd_tlb_entry(tlb, pmdp, address)			\
>  	do {								\
> -		__tlb_adjust_range(tlb, address, HPAGE_PMD_SIZE);	\
> -		tlb->cleared_pmds = 1;					\
> +		tlb_flush_pmd_range(tlb, address, HPAGE_PMD_SIZE);	\
>  		__tlb_remove_pmd_tlb_entry(tlb, pmdp, address);		\
>  	} while (0)
>  
> @@ -565,8 +591,7 @@ static inline void tlb_end_vma(struct mmu_gather *tlb, struct vm_area_struct *vm
>  
>  #define tlb_remove_pud_tlb_entry(tlb, pudp, address)			\
>  	do {								\
> -		__tlb_adjust_range(tlb, address, HPAGE_PUD_SIZE);	\
> -		tlb->cleared_puds = 1;					\
> +		tlb_flush_pud_range(tlb, address, HPAGE_PUD_SIZE);	\
>  		__tlb_remove_pud_tlb_entry(tlb, pudp, address);		\
>  	} while (0)
>  
> 
> .
> 

