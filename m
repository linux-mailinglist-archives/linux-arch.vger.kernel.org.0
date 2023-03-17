Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD536BE994
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 13:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjCQMqs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 08:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCQMqr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 08:46:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4DE0AE11C;
        Fri, 17 Mar 2023 05:46:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F291D1480;
        Fri, 17 Mar 2023 05:47:26 -0700 (PDT)
Received: from [10.57.64.98] (unknown [10.57.64.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C16F3F64C;
        Fri, 17 Mar 2023 05:46:42 -0700 (PDT)
Message-ID: <2b41a6dd-130b-acf3-72fd-b996272c1710@arm.com>
Date:   Fri, 17 Mar 2023 12:46:40 +0000
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
 <fe743597-cefa-4bf8-aa3f-da9cc10bbd5f@arm.com>
 <f3ffe13c-321a-07f6-6a6f-1a67f585ffe2@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <f3ffe13c-321a-07f6-6a6f-1a67f585ffe2@intel.com>
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

On 17/03/2023 08:23, Yin, Fengwei wrote:
[...]

>>>>> FYI, I'm seeing a perf regression of about 1% when compiling the kernel on
>>>>> Ampere Altra (arm64) with this whole series on top of v6.3-rc1 (In a VM using
>>>>> ext4 filesystem). Looks like instruction aborts are taking much longer and a
>>>>> selection of syscalls are a bit slower. Still hunting down the root cause. Will
>>>>> report once I have conclusive diagnosis.
>>>>
>>>> I'm sorry - I'm struggling to find the exact cause. But its spending over 2x the
>>>> amount of time in the instruction abort handling code once patches 32-36 are
>>>> included. Everything in the flame graph is just taking longer. Perhaps we are
>>>> getting more instruction aborts somehow? I have the flamegraphs if anyone wants
>>>> them - just shout and I'll email them separately.
>>> Thanks a lot to Ryan for sharing the flamegraphs to me. I found the __do_fault()
>>> is called with patch 32-36 while no __do_fault() just with first 31 patches. I 
>>> suspect the folio_add_file_rmap_range() missed some PTEs population. Please give
>>> me few days to find the root cause and fix. Sorry for this.
>>
>> You're welcome. Give me a shout once you have a re-spin and I'll rerun the tests.
> Could you please help to try following changes? Thanks in advance.
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 40be33b5ee46..137011320c68 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3504,15 +3504,16 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  		if (!pte_none(vmf->pte[count]))
>  			goto skip;
>  
> -		if (vmf->address == addr)
> -			ret = VM_FAULT_NOPAGE;
> -
>  		count++;
>  		continue;
>  skip:
>  		if (count) {
>  			set_pte_range(vmf, folio, page, count, addr);
>  			folio_ref_add(folio, count);
> +			if ((vmf->address < (addr + count * PAGE_SIZE)) &&
> +					(vmf->address >= addr))
> +				ret = VM_FAULT_NOPAGE;
> +
>  		}
>  
>  		count++;
> @@ -3525,6 +3526,9 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  	if (count) {
>  		set_pte_range(vmf, folio, page, count, addr);
>  		folio_ref_add(folio, count);
> +		if ((vmf->address < (addr + count * PAGE_SIZE)) &&
> +				(vmf->address >= addr))
> +			ret = VM_FAULT_NOPAGE;
>  	}
>  
>  	vmf->pte = old_ptep;
> 

I'm afraid this hasn't fixed it, and I still see __do_fault(). I'll send the
flame graph over separately.

Given I'm running on ext4, I wasn't expecting to see any large page cache
folios? So I don't think we would have expected this patch to help anyway? (or
perhaps there are still THP folios? But I think they will get PMD mapped?).


> 
> Regards
> Yin, Fengwei
> 
>>
>>>
>>>
>>> Regards
>>> Yin, Fengwei
>>>
>>>>
>>>>>
>>>>> Thanks,
>>>>> Ryan
>>>>>
>>>>>
>>>>>> +			}
>>>>>> +
>>>>>> +			if (first)
>>>>>> +				nr++;
>>>>>> +		} while (page++, --nr_pages > 0);
>>>>>>  	} else if (folio_test_pmd_mappable(folio)) {
>>>>>>  		/* That test is redundant: it's for safety or to optimize out */
>>>>>>  
>>>>>> @@ -1354,6 +1362,30 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>>>>  	mlock_vma_folio(folio, vma, compound);
>>>>>>  }
>>>>>>  
>>>>>> +/**
>>>>>> + * page_add_file_rmap - add pte mapping to a file page
>>>>>> + * @page:	the page to add the mapping to
>>>>>> + * @vma:	the vm area in which the mapping is added
>>>>>> + * @compound:	charge the page as compound or small page
>>>>>> + *
>>>>>> + * The caller needs to hold the pte lock.
>>>>>> + */
>>>>>> +void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>>>>>> +		bool compound)
>>>>>> +{
>>>>>> +	struct folio *folio = page_folio(page);
>>>>>> +	unsigned int nr_pages;
>>>>>> +
>>>>>> +	VM_WARN_ON_ONCE_PAGE(compound && !PageTransHuge(page), page);
>>>>>> +
>>>>>> +	if (likely(!compound))
>>>>>> +		nr_pages = 1;
>>>>>> +	else
>>>>>> +		nr_pages = folio_nr_pages(folio);
>>>>>> +
>>>>>> +	folio_add_file_rmap_range(folio, page, nr_pages, vma, compound);
>>>>>> +}
>>>>>> +
>>>>>>  /**
>>>>>>   * page_remove_rmap - take down pte mapping from a page
>>>>>>   * @page:	page to remove mapping from
>>>>>
>>>>
>>
>>

