Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A36B6A2EAB
	for <lists+linux-arch@lfdr.de>; Sun, 26 Feb 2023 07:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjBZG4Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 26 Feb 2023 01:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZG4Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Feb 2023 01:56:25 -0500
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4A315572
        for <linux-arch@vger.kernel.org>; Sat, 25 Feb 2023 22:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1677394574; bh=mjBqnKny5y+K14d75FPmhA0VKZQ24cxqzaPncsJ7CN8=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Zj3wRTDVHGPVu9U6XGgcQs1WkvGuB+QxVtS0QGVQVPJaKyjtjelSVA+VumM++KMos
         T8n2j0JtPPFPJJ0IltVscr2jMLnw9SWfCbEZRSPVTTyX/nu1MHZDi2BqwbjVOr2KAi
         1C6Qdare3nTQqTU2XInBPHyubkvaZtjGJXgP+x3M=
Received: from [192.168.9.172] (unknown [114.93.192.93])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 43C08600BD;
        Sun, 26 Feb 2023 14:56:14 +0800 (CST)
Message-ID: <7b984c57-c45d-4d73-e21f-3e80a4651ddc@xen0n.name>
Date:   Sun, 26 Feb 2023 14:56:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 13/7] loongson: Implement the new page table range API
To:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        linux-arch@vger.kernel.org
References: <20230211033948.891959-1-willy@infradead.org>
 <20230215000446.1655635-1-willy@infradead.org>
 <20230215000446.1655635-5-willy@infradead.org>
 <Y/rhXjWLexvt5sPO@casper.infradead.org>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <Y/rhXjWLexvt5sPO@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On 2/26/23 12:34, Matthew Wilcox wrote:
> On Wed, Feb 15, 2023 at 12:04:46AM +0000, Matthew Wilcox (Oracle) wrote:
>> Add set_ptes() and update_mmu_cache_range().
>>
>> THIS PATCH IS INCOMPLETE.  I DO NOT KNOW WHAT TO DO IN __update_tlb()
> Help?  This is the only remaining architecture to fix; I have all the
> others converted now.
Sorry for the late reply, it seems Huacai is busy with other things on 
hand, and I've been busy in my daily job recently.
>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>   arch/loongarch/include/asm/cacheflush.h |  2 ++
>>   arch/loongarch/include/asm/pgtable.h    | 30 ++++++++++++++++---------
>>   arch/loongarch/mm/tlb.c                 |  4 +++-
>>   3 files changed, 25 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/loongarch/include/asm/cacheflush.h b/arch/loongarch/include/asm/cacheflush.h
>> index 0681788eb474..7907eb42bfbd 100644
>> --- a/arch/loongarch/include/asm/cacheflush.h
>> +++ b/arch/loongarch/include/asm/cacheflush.h
>> @@ -47,8 +47,10 @@ void local_flush_icache_range(unsigned long start, unsigned long end);
>>   #define flush_cache_vmap(start, end)			do { } while (0)
>>   #define flush_cache_vunmap(start, end)			do { } while (0)
>>   #define flush_icache_page(vma, page)			do { } while (0)
>> +#define flush_icache_pages(vma, page)			do { } while (0)
>>   #define flush_icache_user_page(vma, page, addr, len)	do { } while (0)
>>   #define flush_dcache_page(page)				do { } while (0)
>> +#define flush_dcache_folio(folio)			do { } while (0)
>>   #define flush_dcache_mmap_lock(mapping)			do { } while (0)
>>   #define flush_dcache_mmap_unlock(mapping)		do { } while (0)
>>   
>> diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
>> index d28fb9dbec59..0f5fa7c40c52 100644
>> --- a/arch/loongarch/include/asm/pgtable.h
>> +++ b/arch/loongarch/include/asm/pgtable.h
>> @@ -334,12 +334,20 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>>   	}
>>   }
>>   
>> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>> -			      pte_t *ptep, pte_t pteval)
>> -{
>> -	set_pte(ptep, pteval);
>> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>> +		pte_t *ptep, pte_t pte, unsigned int nr)
>> +{
>> +	for (;;) {
>> +		set_pte(ptep, pte);
>> +		if (--nr == 0)
>> +			break;
>> +		ptep++;
>> +		pte_val(pte) += 1 << _PFN_SHIFT;
>> +	}
>>   }
>>   
>> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
>> +
>>   static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
>>   {
>>   	/* Preserve global status for the pair */
>> @@ -442,14 +450,16 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>   		     (pgprot_val(newprot) & ~_PAGE_CHG_MASK));
>>   }
>>   
>> -extern void __update_tlb(struct vm_area_struct *vma,
>> -			unsigned long address, pte_t *ptep);
>> +extern void __update_tlb(struct vm_area_struct *vma, unsigned long address,
>> +		pte_t *ptep, unsigned int nr);
>>   
>> -static inline void update_mmu_cache(struct vm_area_struct *vma,
>> -			unsigned long address, pte_t *ptep)
>> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
>> +		unsigned long address, pte_t *ptep, unsigned int nr)
>>   {
>> -	__update_tlb(vma, address, ptep);
>> +	__update_tlb(vma, address, ptep, nr);
>>   }
>> +#define update_mmu_cache(vma, addr, ptep) \
>> +	update_mmu_cache_range(vma, addr, ptep, 1)
>>   
>>   #define __HAVE_ARCH_UPDATE_MMU_TLB
>>   #define update_mmu_tlb	update_mmu_cache
>> @@ -457,7 +467,7 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>>   static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
>>   			unsigned long address, pmd_t *pmdp)
>>   {
>> -	__update_tlb(vma, address, (pte_t *)pmdp);
>> +	__update_tlb(vma, address, (pte_t *)pmdp, 1);
>>   }
>>   
>>   static inline unsigned long pmd_pfn(pmd_t pmd)
>> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
>> index 8bad6b0cff59..ac0b19dbd1dc 100644
>> --- a/arch/loongarch/mm/tlb.c
>> +++ b/arch/loongarch/mm/tlb.c
>> @@ -162,7 +162,8 @@ static void __update_hugetlb(struct vm_area_struct *vma, unsigned long address,
>>   #endif
>>   }
>>   
>> -void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
>> +void __update_tlb(struct vm_area_struct *vma, unsigned long address,
>> +		pte_t *ptep, unsigned int nr)
>>   {
>>   	int idx;
>>   	unsigned long flags;
>> @@ -187,6 +188,7 @@ void __update_tlb(struct vm_area_struct *vma, unsigned long address, pte_t *ptep
>>   	write_csr_entryhi(address);
>>   	tlb_probe();
>>   	idx = read_csr_tlbidx();
>> +// I have no idea what to do here

AFAIK you probably can't make __update_tlb do this, at least not 
directly. The underlying LoongArch instructions __update_tlb wraps 
(TLBWR or TLBFILL [1]) only update one TLB entry, and one entry consists 
of just two consecutive pages, like MIPS. The CSRs the hardware's gonna 
read [2] also don't seem to support expressing the "page number".  IMO 
you need to wrap this helper in some loop to provide the desired semantics.

(The current implementation of LoongArch TLB very much resembles, if not 
*identical to* MIPS, if that helps. It's said future generations of 
LoongArch hardware would feature hardware-managed TLBs though, but I'm 
personally/generally wary of such claims.)

Huacai may want to supply more details (or correct me) once he gets to this.

[1]: 
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_tlbwr
[2]: 
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#control-and-status-registers-related-to-mapped-address-translation

>>   	write_csr_pagesize(PS_DEFAULT_SIZE);
>>   	write_csr_entrylo0(pte_val(*ptep++));
>>   	write_csr_entrylo1(pte_val(*ptep));
>> -- 
>> 2.39.1
>>
-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

