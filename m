Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6DF6BD5ED
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 17:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbjCPQgz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 12:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjCPQgS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 12:36:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F0EEE6FC5;
        Thu, 16 Mar 2023 09:35:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC2BB2F4;
        Thu, 16 Mar 2023 09:35:14 -0700 (PDT)
Received: from [10.1.30.156] (C02CF1NRLVDN.cambridge.arm.com [10.1.30.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 717313F885;
        Thu, 16 Mar 2023 09:34:30 -0700 (PDT)
Message-ID: <fe743597-cefa-4bf8-aa3f-da9cc10bbd5f@arm.com>
Date:   Thu, 16 Mar 2023 16:34:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 34/36] rmap: add folio_add_file_rmap_range()
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-35-willy@infradead.org>
 <387dc921-de2b-f244-985c-d1e6336d5909@arm.com>
 <01071d9c-483f-2d95-87a6-e1030acaf8dd@arm.com>
 <0f581d0d-3139-4007-2161-592a0a545b50@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <0f581d0d-3139-4007-2161-592a0a545b50@intel.com>
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

On 16/03/2023 16:27, Yin, Fengwei wrote:
> Hi Matthew,
> 
> On 3/16/2023 12:08 AM, Ryan Roberts wrote:
>> On 15/03/2023 13:34, Ryan Roberts wrote:
>>> On 15/03/2023 05:14, Matthew Wilcox (Oracle) wrote:
>>>> From: Yin Fengwei <fengwei.yin@intel.com>
>>>>
>>>> folio_add_file_rmap_range() allows to add pte mapping to a specific
>>>> range of file folio. Comparing to page_add_file_rmap(), it batched
>>>> updates __lruvec_stat for large folio.
>>>>
>>>> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
>>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>> ---
>>>>  include/linux/rmap.h |  2 ++
>>>>  mm/rmap.c            | 60 +++++++++++++++++++++++++++++++++-----------
>>>>  2 files changed, 48 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>> index b87d01660412..a3825ce81102 100644
>>>> --- a/include/linux/rmap.h
>>>> +++ b/include/linux/rmap.h
>>>> @@ -198,6 +198,8 @@ void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>>>>  		unsigned long address);
>>>>  void page_add_file_rmap(struct page *, struct vm_area_struct *,
>>>>  		bool compound);
>>>> +void folio_add_file_rmap_range(struct folio *, struct page *, unsigned int nr,
>>>> +		struct vm_area_struct *, bool compound);
>>>>  void page_remove_rmap(struct page *, struct vm_area_struct *,
>>>>  		bool compound);
>>>>  
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 4898e10c569a..a91906b28835 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1301,31 +1301,39 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>>>>  }
>>>>  
>>>>  /**
>>>> - * page_add_file_rmap - add pte mapping to a file page
>>>> - * @page:	the page to add the mapping to
>>>> + * folio_add_file_rmap_range - add pte mapping to page range of a folio
>>>> + * @folio:	The folio to add the mapping to
>>>> + * @page:	The first page to add
>>>> + * @nr_pages:	The number of pages which will be mapped
>>>>   * @vma:	the vm area in which the mapping is added
>>>>   * @compound:	charge the page as compound or small page
>>>>   *
>>>> + * The page range of folio is defined by [first_page, first_page + nr_pages)
>>>> + *
>>>>   * The caller needs to hold the pte lock.
>>>>   */
>>>> -void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>> -		bool compound)
>>>> +void folio_add_file_rmap_range(struct folio *folio, struct page *page,
>>>> +			unsigned int nr_pages, struct vm_area_struct *vma,
>>>> +			bool compound)
>>>>  {
>>>> -	struct folio *folio = page_folio(page);
>>>>  	atomic_t *mapped = &folio->_nr_pages_mapped;
>>>> -	int nr = 0, nr_pmdmapped = 0;
>>>> -	bool first;
>>>> +	unsigned int nr_pmdmapped = 0, first;
>>>> +	int nr = 0;
>>>>  
>>>> -	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
>>>> +	VM_WARN_ON_FOLIO(compound && !folio_test_pmd_mappable(folio), folio);
>>>>  
>>>>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>>>>  	if (likely(!compound)) {
>>>> -		first = atomic_inc_and_test(&page->_mapcount);
>>>> -		nr = first;
>>>> -		if (first && folio_test_large(folio)) {
>>>> -			nr = atomic_inc_return_relaxed(mapped);
>>>> -			nr = (nr < COMPOUND_MAPPED);
>>>> -		}
>>>> +		do {
>>>> +			first = atomic_inc_and_test(&page->_mapcount);
>>>> +			if (first && folio_test_large(folio)) {
>>>> +				first = atomic_inc_return_relaxed(mapped);
>>>> +				first = (nr < COMPOUND_MAPPED);
>>>
>>> This still contains the typo that Yin Fengwei spotted in the previous version:
>>> https://lore.kernel.org/linux-mm/20230228213738.272178-1-willy@infradead.org/T/#m84673899e25bc31356093a1177941f2cc35e5da8
>>>
>>> FYI, I'm seeing a perf regression of about 1% when compiling the kernel on
>>> Ampere Altra (arm64) with this whole series on top of v6.3-rc1 (In a VM using
>>> ext4 filesystem). Looks like instruction aborts are taking much longer and a
>>> selection of syscalls are a bit slower. Still hunting down the root cause. Will
>>> report once I have conclusive diagnosis.
>>
>> I'm sorry - I'm struggling to find the exact cause. But its spending over 2x the
>> amount of time in the instruction abort handling code once patches 32-36 are
>> included. Everything in the flame graph is just taking longer. Perhaps we are
>> getting more instruction aborts somehow? I have the flamegraphs if anyone wants
>> them - just shout and I'll email them separately.
> Thanks a lot to Ryan for sharing the flamegraphs to me. I found the __do_fault()
> is called with patch 32-36 while no __do_fault() just with first 31 patches. I 
> suspect the folio_add_file_rmap_range() missed some PTEs population. Please give
> me few days to find the root cause and fix. Sorry for this.

You're welcome. Give me a shout once you have a re-spin and I'll rerun the tests.

> 
> 
> Regards
> Yin, Fengwei
> 
>>
>>>
>>> Thanks,
>>> Ryan
>>>
>>>
>>>> +			}
>>>> +
>>>> +			if (first)
>>>> +				nr++;
>>>> +		} while (page++, --nr_pages > 0);
>>>>  	} else if (folio_test_pmd_mappable(folio)) {
>>>>  		/* That test is redundant: it's for safety or to optimize out */
>>>>  
>>>> @@ -1354,6 +1362,30 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>>  	mlock_vma_folio(folio, vma, compound);
>>>>  }
>>>>  
>>>> +/**
>>>> + * page_add_file_rmap - add pte mapping to a file page
>>>> + * @page:	the page to add the mapping to
>>>> + * @vma:	the vm area in which the mapping is added
>>>> + * @compound:	charge the page as compound or small page
>>>> + *
>>>> + * The caller needs to hold the pte lock.
>>>> + */
>>>> +void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>> +		bool compound)
>>>> +{
>>>> +	struct folio *folio = page_folio(page);
>>>> +	unsigned int nr_pages;
>>>> +
>>>> +	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
>>>> +
>>>> +	if (likely(!compound))
>>>> +		nr_pages = 1;
>>>> +	else
>>>> +		nr_pages = folio_nr_pages(folio);
>>>> +
>>>> +	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
>>>> +}
>>>> +
>>>>  /**
>>>>   * page_remove_rmap - take down pte mapping from a page
>>>>   * @page:	page to remove mapping from
>>>
>>

