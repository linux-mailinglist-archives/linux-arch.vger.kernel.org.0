Return-Path: <linux-arch+bounces-1278-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D0823FC3
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 11:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F401B1C23D0F
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 10:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417D2232F;
	Thu,  4 Jan 2024 10:45:21 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2921A03;
	Thu,  4 Jan 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7F999C000A;
	Thu,  4 Jan 2024 10:45:08 +0000 (UTC)
Message-ID: <3b9fb9f0-86e8-4a76-be69-9f4598434c6c@ghiti.fr>
Date: Thu, 4 Jan 2024 11:45:08 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] riscv: enable MMU_GATHER_RCU_TABLE_FREE for SMP &&
 MMU
Content-Language: en-US
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20231219175046.2496-1-jszhang@kernel.org>
 <20231219175046.2496-4-jszhang@kernel.org>
 <e90f3b0f-95be-4ead-85cf-cca4378755f3@ghiti.fr> <ZZOBwt1ZBsPUshkY@xhacker>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZZOBwt1ZBsPUshkY@xhacker>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Jisheng,

On 02/01/2024 04:23, Jisheng Zhang wrote:
> On Sun, Dec 31, 2023 at 07:32:47AM +0100, Alexandre Ghiti wrote:
>> On 19/12/2023 18:50, Jisheng Zhang wrote:
>>> In order to implement fast gup we need to ensure that the page
>>> table walker is protected from page table pages being freed from
>>> under it.
>>>
>>> riscv situation is more complicated than other architectures: some
>>> riscv platforms may use IPI to perform TLB shootdown, for example,
>>> those platforms which support AIA, usually the riscv_ipi_for_rfence is
>>> true on these platforms; some riscv platforms may rely on the SBI to
>>> perform TLB shootdown, usually the riscv_ipi_for_rfence is false on
>>> these platforms. To keep software pagetable walkers safe in this case
>>> we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
>>> comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in
>>> include/asm-generic/tlb.h for more details.
>>>
>>> This patch enables MMU_GATHER_RCU_TABLE_FREE, then use
>>>
>>> *tlb_remove_page_ptdesc() for those platforms which use IPI to perform
>>> TLB shootdown;
>>>
>>> *tlb_remove_ptdesc() for those platforms which use SBI to perform TLB
>>> shootdown;
>>
>> Can you elaborate a bit more on what those functions do differently and why
>> we need to differentiate IPI vs SBI TLB shootdown? I don't understand this.
> Hi Alex,
>
> If IPI, the local_irq_save in lockless_pages_from_mm() of fast gup code
> path will block page table pages from being freed, I think the comments
> there is execellent.
>
> If SBI, the local_irq_save in lockless_pages_from_mm() can't acchieve
> the goal however. Because local_irq_save() only disable S-privilege IPI irq,
> it can't disable M-privilege's, which the SBI implementation use to
> shootdown TLB entry. So we need MMU_GATHER_RCU_TABLE_FREE helper for
> SBI case.


Ok, I get it now, can you add the following link to your commit 
description 
https://elixir.bootlin.com/linux/v6.6/source/mm/mmu_gather.c#L162 ? It 
describes the problem very clearly.


> Thanks
>   
>>> Both case mean that disabling interrupts will block the free and
>>> protect the fast gup page walker.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> ---
>>>    arch/riscv/Kconfig               |  1 +
>>>    arch/riscv/include/asm/pgalloc.h | 23 ++++++++++++++++++-----
>>>    arch/riscv/include/asm/tlb.h     | 18 ++++++++++++++++++
>>>    3 files changed, 37 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 24c1799e2ec4..d3555173d9f4 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -147,6 +147,7 @@ config RISCV
>>>    	select IRQ_FORCED_THREADING
>>>    	select KASAN_VMALLOC if KASAN
>>>    	select LOCK_MM_AND_FIND_VMA
>>> +	select MMU_GATHER_RCU_TABLE_FREE if SMP && MMU
>>>    	select MODULES_USE_ELF_RELA if MODULES
>>>    	select MODULE_SECTIONS if MODULES
>>>    	select OF
>>> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
>>> index 3c5e3bd15f46..deaf971253a2 100644
>>> --- a/arch/riscv/include/asm/pgalloc.h
>>> +++ b/arch/riscv/include/asm/pgalloc.h
>>> @@ -102,7 +102,10 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>>>    		struct ptdesc *ptdesc = virt_to_ptdesc(pud);
>>>    		pagetable_pud_dtor(ptdesc);
>>> -		tlb_remove_page_ptdesc(tlb, ptdesc);
>>> +		if (riscv_use_ipi_for_rfence())
>>> +			tlb_remove_page_ptdesc(tlb, ptdesc);
>>> +		else
>>> +			tlb_remove_ptdesc(tlb, ptdesc);
>>>    	}
>>>    }
>>> @@ -136,8 +139,12 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>>>    static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>>>    				  unsigned long addr)
>>>    {
>>> -	if (pgtable_l5_enabled)
>>> -		tlb_remove_page_ptdesc(tlb, virt_to_ptdesc(p4d));
>>> +	if (pgtable_l5_enabled) {
>>> +		if (riscv_use_ipi_for_rfence())
>>> +			tlb_remove_page_ptdesc(tlb, virt_to_ptdesc(p4d));
>>> +		else
>>> +			tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
>>> +	}
>>>    }
>>>    #endif /* __PAGETABLE_PMD_FOLDED */
>>> @@ -169,7 +176,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>>>    	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
>>>    	pagetable_pmd_dtor(ptdesc);
>>> -	tlb_remove_page_ptdesc(tlb, ptdesc);
>>> +	if (riscv_use_ipi_for_rfence())
>>> +		tlb_remove_page_ptdesc(tlb, ptdesc);
>>> +	else
>>> +		tlb_remove_ptdesc(tlb, ptdesc);
>>>    }
>>>    #endif /* __PAGETABLE_PMD_FOLDED */
>>> @@ -180,7 +190,10 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
>>>    	struct ptdesc *ptdesc = page_ptdesc(pte);
>>>    	pagetable_pte_dtor(ptdesc);
>>> -	tlb_remove_page_ptdesc(tlb, ptdesc);
>>> +	if (riscv_use_ipi_for_rfence())
>>> +		tlb_remove_page_ptdesc(tlb, ptdesc);
>>> +	else
>>> +		tlb_remove_ptdesc(tlb, ptdesc);
>>>    }
>>>    #endif /* CONFIG_MMU */
>>> diff --git a/arch/riscv/include/asm/tlb.h b/arch/riscv/include/asm/tlb.h
>>> index 1eb5682b2af6..a0b8b853503f 100644
>>> --- a/arch/riscv/include/asm/tlb.h
>>> +++ b/arch/riscv/include/asm/tlb.h
>>> @@ -10,6 +10,24 @@ struct mmu_gather;
>>>    static void tlb_flush(struct mmu_gather *tlb);
>>> +#ifdef CONFIG_MMU
>>> +#include <linux/swap.h>
>>> +
>>> +/*
>>> + * While riscv platforms with riscv_ipi_for_rfence as true require an IPI to
>>> + * perform TLB shootdown, some platforms with riscv_ipi_for_rfence as false use
>>> + * SBI to perform TLB shootdown. To keep software pagetable walkers safe in this
>>> + * case we switch to RCU based table free (MMU_GATHER_RCU_TABLE_FREE). See the
>>> + * comment below 'ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE' in include/asm-generic/tlb.h


A direct link would be better, I did not find the comment you mention 
here and even though, it can still move around later.

And then you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Alex


>>> + * for more details.
>>> + */
>>> +static inline void __tlb_remove_table(void *table)
>>> +{
>>> +	free_page_and_swap_cache(table);
>>> +}
>>> +
>>> +#endif /* CONFIG_MMU */
>>> +
>>>    #define tlb_flush tlb_flush
>>>    #include <asm-generic/tlb.h>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

