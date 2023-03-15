Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFE96BB923
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 17:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjCOQJS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 12:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjCOQIs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 12:08:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 09E5C6189;
        Wed, 15 Mar 2023 09:08:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 322B04B3;
        Wed, 15 Mar 2023 09:08:49 -0700 (PDT)
Received: from [10.57.64.236] (unknown [10.57.64.236])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B3C7B3F67D;
        Wed, 15 Mar 2023 09:08:04 -0700 (PDT)
Message-ID: <01071d9c-483f-2d95-87a6-e1030acaf8dd@arm.com>
Date:   Wed, 15 Mar 2023 16:08:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 34/36] rmap: add folio_add_file_rmap_range()
Content-Language: en-US
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-35-willy@infradead.org>
 <387dc921-de2b-f244-985c-d1e6336d5909@arm.com>
In-Reply-To: <387dc921-de2b-f244-985c-d1e6336d5909@arm.com>
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

On 15/03/2023 13:34, Ryan Roberts wrote:
> On 15/03/2023 05:14, Matthew Wilcox (Oracle) wrote:
>> From: Yin Fengwei <fengwei.yin@intel.com>
>>
>> folio_add_file_rmap_range() allows to add pte mapping to a specific
>> range of file folio. Comparing to page_add_file_rmap(), it batched
>> updates __lruvec_stat for large folio.
>>
>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> ---
>>  include/linux/rmap.h |  2 ++
>>  mm/rmap.c            | 60 +++++++++++++++++++++++++++++++++-----------
>>  2 files changed, 48 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index b87d01660412..a3825ce81102 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -198,6 +198,8 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>>  		unsigned long address);
>>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>>  		bool compound);
>> +void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
>> +		struct vm_area_struct *, bool compound);
>>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>>  		bool compound);
>>  
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 4898e10c569a..a91906b28835 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1301,31 +1301,39 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>  }
>>  
>>  /**
>> - * page_add_file_rmap - add pte mapping to a file page
>> - * @page:	the page to add the mapping to
>> + * folio_add_file_rmap_range - add pte mapping to page range of a folio
>> + * @folio:	The folio to add the mapping to
>> + * @page:	The first page to add
>> + * @nr_pages:	The number of pages which will be mapped
>>   * @vma:	the vm area in which the mapping is added
>>   * @compound:	charge the page as compound or small page
>>   *
>> + * The page range of folio is defined by [first_page, first_page + nr_pages)
>> + *
>>   * The caller needs to hold the pte lock.
>>   */
>> -void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>> -		bool compound)
>> +void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>> +			unsigned int nr_pages, struct vm_area_struct *vma,
>> +			bool compound)
>>  {
>> -	struct folio *folio = page_folio(page);
>>  	atomic_t *mapped = &folio->_nr_pages_mapped;
>> -	int nr = 0, nr_pmdmapped = 0;
>> -	bool first;
>> +	unsigned int nr_pmdmapped = 0, first;
>> +	int nr = 0;
>>  
>> -	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
>> +	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
>>  
>>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>>  	if (likely(!compound)) {
>> -		first = atomic_inc_and_test(&page->_mapcount);
>> -		nr = first;
>> -		if (first && folio_test_large(folio)) {
>> -			nr = atomic_inc_return_relaxed(mapped);
>> -			nr = (nr < COMPOUND_MAPPED);
>> -		}
>> +		do {
>> +			first = atomic_inc_and_test(&page->_mapcount);
>> +			if (first && folio_test_large(folio)) {
>> +				first = atomic_inc_return_relaxed(mapped);
>> +				first = (nr < COMPOUND_MAPPED);
> 
> This still contains the typo that Yin Fengwei spotted in the previous version:
> https://lore.kernel.org/linux-mm/20230228213738.272178-1-willy@infradead.org/T/#m84673899e25bc31356093a1177941f2cc35e5da8
> 
> FYI, I'm seeing a perf regression of about 1% when compiling the kernel on
> Ampere Altra (arm64) with this whole series on top of v6.3-rc1 (In a VM using
> ext4 filesystem). Looks like instruction aborts are taking much longer and a
> selection of syscalls are a bit slower. Still hunting down the root cause. Will
> report once I have conclusive diagnosis.

I'm sorry - I'm struggling to find the exact cause. But its spending over 2x the
amount of time in the instruction abort handling code once patches 32-36 are
included. Everything in the flame graph is just taking longer. Perhaps we are
getting more instruction aborts somehow? I have the flamegraphs if anyone wants
them - just shout and I'll email them separately.

> 
> Thanks,
> Ryan
> 
> 
>> +			}
>> +
>> +			if (first)
>> +				nr++;
>> +		} while (page++, --nr_pages > 0);
>>  	} else if (folio_test_pmd_mappable(folio)) {
>>  		/* That test is redundant: it's for safety or to optimize out */
>>  
>> @@ -1354,6 +1362,30 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>  	mlock_vma_folio(folio, vma, compound);
>>  }
>>  
>> +/**
>> + * page_add_file_rmap - add pte mapping to a file page
>> + * @page:	the page to add the mapping to
>> + * @vma:	the vm area in which the mapping is added
>> + * @compound:	charge the page as compound or small page
>> + *
>> + * The caller needs to hold the pte lock.
>> + */
>> +void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>> +		bool compound)
>> +{
>> +	struct folio *folio = page_folio(page);
>> +	unsigned int nr_pages;
>> +
>> +	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
>> +
>> +	if (likely(!compound))
>> +		nr_pages = 1;
>> +	else
>> +		nr_pages = folio_nr_pages(folio);
>> +
>> +	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
>> +}
>> +
>>  /**
>>   * page_remove_rmap - take down pte mapping from a page
>>   * @page:	page to remove mapping from
> 

