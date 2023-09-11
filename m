Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E279B9F1
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbjIKVFx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjIKIdw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 04:33:52 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3589CFB;
        Mon, 11 Sep 2023 01:33:47 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A6B7E40003;
        Mon, 11 Sep 2023 08:33:39 +0000 (UTC)
Message-ID: <adb67b73-7b6b-edbd-81f2-2319999c1fd8@ghiti.fr>
Date:   Mon, 11 Sep 2023 10:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com>
 <0e101df0-397a-0d1a-0080-2e60c68c79b6@sholland.org>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <0e101df0-397a-0d1a-0080-2e60c68c79b6@sholland.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 09/09/2023 21:00, Samuel Holland wrote:
> Hi Alex,
>
> On 8/1/23 03:54, Alexandre Ghiti wrote:
>> This function used to simply flush the whole tlb of all harts, be more
>> subtile and try to only flush the range.
>>
>> The problem is that we can only use PAGE_SIZE as stride since we don't know
>> the size of the underlying mapping and then this function will be improved
>> only if the size of the region to flush is < threshold * PAGE_SIZE.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> ---
>>   arch/riscv/include/asm/tlbflush.h | 11 +++++-----
>>   arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++--------
>>   2 files changed, 31 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
>> index f5c4fb0ae642..7426fdcd8ec5 100644
>> --- a/arch/riscv/include/asm/tlbflush.h
>> +++ b/arch/riscv/include/asm/tlbflush.h
>> @@ -37,6 +37,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>>   void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr);
>>   void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>>   		     unsigned long end);
>> +void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>>   void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>> @@ -53,15 +54,15 @@ static inline void flush_tlb_range(struct vm_area_struct *vma,
>>   	local_flush_tlb_all();
>>   }
>>   
>> -#define flush_tlb_mm(mm) flush_tlb_all()
>> -#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
>> -#endif /* !CONFIG_SMP || !CONFIG_MMU */
>> -
>>   /* Flush a range of kernel pages */
>>   static inline void flush_tlb_kernel_range(unsigned long start,
>>   	unsigned long end)
>>   {
>> -	flush_tlb_all();
>> +	local_flush_tlb_all();
>>   }
>>   
>> +#define flush_tlb_mm(mm) flush_tlb_all()
>> +#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
>> +#endif /* !CONFIG_SMP || !CONFIG_MMU */
>> +
>>   #endif /* _ASM_RISCV_TLBFLUSH_H */
>> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
>> index 0c955c474f3a..687808013758 100644
>> --- a/arch/riscv/mm/tlbflush.c
>> +++ b/arch/riscv/mm/tlbflush.c
>> @@ -120,18 +120,27 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>>   			      unsigned long size, unsigned long stride)
>>   {
>>   	struct flush_tlb_range_data ftd;
>> -	struct cpumask *cmask = mm_cpumask(mm);
>> -	unsigned int cpuid;
>> +	struct cpumask *cmask, full_cmask;
>>   	bool broadcast;
>>   
>> -	if (cpumask_empty(cmask))
>> -		return;
>> +	if (mm) {
>> +		unsigned int cpuid;
>> +
>> +		cmask = mm_cpumask(mm);
>> +		if (cpumask_empty(cmask))
>> +			return;
>> +
>> +		cpuid = get_cpu();
>> +		/* check if the tlbflush needs to be sent to other CPUs */
>> +		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>> +	} else {
>> +		cpumask_setall(&full_cmask);
>> +		cmask = &full_cmask;
>> +		broadcast = true;
>> +	}
>>   
>> -	cpuid = get_cpu();
>> -	/* check if the tlbflush needs to be sent to other CPUs */
>> -	broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
>>   	if (static_branch_unlikely(&use_asid_allocator)) {
>> -		unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
>> +		unsigned long asid = mm ? atomic_long_read(&mm->context.id) & asid_mask : 0;
> I think the bug is here. Passing a value of 0 for the ASID is not the
> same as passing the ASID in register x0. Only in the latter case does
> the TLB flush apply to global mappings, which is what you need for
> flush_tlb_kernel_range().


Fantastic, thank you, I was miles away from finding this! Really nice 
catch, thanks again.

I'm fixing this and while doing so, I may be stepping a bit on your 
patchset (some code removal), sorry about that. I'll provide a new 
version quickly for Prabhakar to test, and we'll see how we'll rebase 
each other series.

Thanks again Samuel, well done!

Alex


> Regards,
> Samuel
>
>>   
>>   		if (broadcast) {
>>   			if (riscv_use_ipi_for_rfence()) {
>> @@ -165,7 +174,8 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>>   		}
>>   	}
>>   
>> -	put_cpu();
>> +	if (mm)
>> +		put_cpu();
>>   }
>>   
>>   void flush_tlb_mm(struct mm_struct *mm)
>> @@ -196,6 +206,12 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>>   
>>   	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
>>   }
>> +
>> +void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>> +{
>> +	__flush_tlb_range(NULL, start, end, PAGE_SIZE);
>> +}
>> +
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>>   			unsigned long end)
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
