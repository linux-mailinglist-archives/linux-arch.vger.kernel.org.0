Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCFB6BD607
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 17:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCPQkf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjCPQkH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 12:40:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DFF42DCA63;
        Thu, 16 Mar 2023 09:39:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77BF82F4;
        Thu, 16 Mar 2023 09:39:44 -0700 (PDT)
Received: from [10.1.30.156] (C02CF1NRLVDN.cambridge.arm.com [10.1.30.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5D0A3F885;
        Thu, 16 Mar 2023 09:38:59 -0700 (PDT)
Message-ID: <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
Date:   Thu, 16 Mar 2023 16:38:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, will@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 16/03/2023 16:23, Yin, Fengwei wrote:
> 
> 
> On 3/15/2023 11:26 PM, Ryan Roberts wrote:
>> On 15/03/2023 05:14, Matthew Wilcox (Oracle) wrote:
>>> From: Yin Fengwei <fengwei.yin@intel.com>
>>>
>>> set_pte_range() allows to setup page table entries for a specific
>>> range.  It takes advantage of batched rmap update for large folio.
>>> It now takes care of calling update_mmu_cache_range().
>>>
>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>  Documentation/filesystems/locking.rst |  2 +-
>>>  include/linux/mm.h                    |  3 ++-
>>>  mm/filemap.c                          |  3 +--
>>>  mm/memory.c                           | 27 +++++++++++++++------------
>>>  4 files changed, 19 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>> index 7de7a7272a5e..922886fefb7f 100644
>>> --- a/Documentation/filesystems/locking.rst
>>> +++ b/Documentation/filesystems/locking.rst
>>> @@ -663,7 +663,7 @@ locked. The VM will unlock the page.
>>>  Filesystem should find and map pages associated with offsets from "start_pgoff"
>>>  till "end_pgoff". ->map_pages() is called with page table locked and must
>>>  not block.  If it's not possible to reach a page without blocking,
>>> -filesystem should skip it. Filesystem should use do_set_pte() to setup
>>> +filesystem should skip it. Filesystem should use set_pte_range() to setup
>>>  page table entry. Pointer to entry associated with the page is passed in
>>>  "pte" field in vm_fault structure. Pointers to entries for other offsets
>>>  should be calculated relative to "pte".
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index ee755bb4e1c1..81788c985a8c 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -1299,7 +1299,8 @@ static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>>>  }
>>>  
>>>  vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page);
>>> -void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr);
>>> +void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>>> +		struct page *page, unsigned int nr, unsigned long addr);
>>>  
>>>  vm_fault_t finish_fault(struct vm_fault *vmf);
>>>  vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index 6e2b0778db45..e2317623dcbf 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -3504,8 +3504,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>>  			ret = VM_FAULT_NOPAGE;
>>>  
>>>  		ref_count++;
>>> -		do_set_pte(vmf, page, addr);
>>> -		update_mmu_cache(vma, addr, vmf->pte);
>>> +		set_pte_range(vmf, folio, page, 1, addr);
>>>  	} while (vmf->pte++, page++, addr += PAGE_SIZE, ++count < nr_pages);
>>>  
>>>  	/* Restore the vmf->pte */
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 6aa21e8f3753..9a654802f104 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -4274,7 +4274,8 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>>>  }
>>>  #endif
>>>  
>>> -void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>>> +void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>>> +		struct page *page, unsigned int nr, unsigned long addr)
>>>  {
>>>  	struct vm_area_struct *vma = vmf->vma;
>>>  	bool uffd_wp = vmf_orig_pte_uffd_wp(vmf);
>>> @@ -4282,7 +4283,7 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>>>  	bool prefault = vmf->address != addr;
>>
>> I think you are changing behavior here - is this intentional? Previously this
>> would be evaluated per page, now its evaluated once for the whole range. The
>> intention below is that directly faulted pages are mapped young and prefaulted
>> pages are mapped old. But now a whole range will be mapped the same.
> 
> Yes. You are right here.
> 
> Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
> can avoid to handle vmf->address == addr specially. It's OK to 
> drop prefault and change the logic here a little bit to:
>   if (arch_wants_old_prefaulted_pte())
>       entry = pte_mkold(entry);
>   else
>       entry = pte_sw_mkyong(entry);
> 
> It's not necessary to use pte_sw_mkyong for vmf->address == addr
> because HW will set the ACCESS bit in page table entry.
> 
> Add Will Deacon in case I missed something here. Thanks.

I'll defer to Will's response, but not all arm HW supports HW access flag
management. In that case it's done by SW, so I would imagine that by setting
this to old initially, we will get a second fault to set the access bit, which
will slow things down. I wonder if you will need to split this into (up to) 3
calls to set_ptes()?

> 
> 
> Regards
> Yin, Fengwei
> 
>>
>> Thanks,
>> Ryan
>>
>>>  	pte_t entry;
>>>  
>>> -	flush_icache_page(vma, page);
>>> +	flush_icache_pages(vma, page, nr);
>>>  	entry = mk_pte(page, vma->vm_page_prot);
>>>  
>>>  	if (prefault && arch_wants_old_prefaulted_pte())
>>> @@ -4296,14 +4297,18 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
>>>  		entry = pte_mkuffd_wp(entry);
>>>  	/* copy-on-write page */
>>>  	if (write && !(vma->vm_flags & VM_SHARED)) {
>>> -		inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>> -		page_add_new_anon_rmap(page, vma, addr);
>>> -		lru_cache_add_inactive_or_unevictable(page, vma);
>>> +		add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr);
>>> +		VM_BUG_ON_FOLIO(nr != 1, folio);
>>> +		folio_add_new_anon_rmap(folio, vma, addr);
>>> +		folio_add_lru_vma(folio, vma);
>>>  	} else {
>>> -		inc_mm_counter(vma->vm_mm, mm_counter_file(page));
>>> -		page_add_file_rmap(page, vma, false);
>>> +		add_mm_counter(vma->vm_mm, mm_counter_file(page), nr);
>>> +		folio_add_file_rmap_range(folio, page, nr, vma, false);
>>>  	}
>>> -	set_pte_at(vma->vm_mm, addr, vmf->pte, entry);
>>> +	set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>>> +
>>> +	/* no need to invalidate: a not-present page won't be cached */
>>> +	update_mmu_cache_range(vma, addr, vmf->pte, nr);
>>>  }
>>>  
>>>  static bool vmf_pte_changed(struct vm_fault *vmf)
>>> @@ -4376,11 +4381,9 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
>>>  
>>>  	/* Re-check under ptl */
>>>  	if (likely(!vmf_pte_changed(vmf))) {
>>> -		do_set_pte(vmf, page, vmf->address);
>>> -
>>> -		/* no need to invalidate: a not-present page won't be cached */
>>> -		update_mmu_cache(vma, vmf->address, vmf->pte);
>>> +		struct folio *folio = page_folio(page);
>>>  
>>> +		set_pte_range(vmf, folio, page, 1, vmf->address);
>>>  		ret = 0;
>>>  	} else {
>>>  		update_mmu_tlb(vma, vmf->address, vmf->pte);
>>

