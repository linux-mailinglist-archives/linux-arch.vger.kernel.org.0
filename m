Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE8D303C16
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jan 2021 12:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405250AbhAZLu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jan 2021 06:50:28 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11884 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405534AbhAZLti (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2021 06:49:38 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DQ4jV433Mz7Wyh;
        Tue, 26 Jan 2021 19:47:42 +0800 (CST)
Received: from [10.174.177.80] (10.174.177.80) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 19:48:46 +0800
Subject: Re: [PATCH v11 12/13] mm/vmalloc: Hugepage vmalloc mappings
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        <linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210126044510.2491820-1-npiggin@gmail.com>
 <20210126044510.2491820-13-npiggin@gmail.com>
 <0f360e6e-6d34-19ce-6c76-a17a5f4f7fc3@huawei.com>
 <1611653945.t3oot63nwn.astroid@bobo.none>
From:   Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <a84836bb-d913-eb58-cd16-b268f479bd8b@huawei.com>
Date:   Tue, 26 Jan 2021 19:48:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <1611653945.t3oot63nwn.astroid@bobo.none>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2021/1/26 17:47, Nicholas Piggin wrote:
> Excerpts from Ding Tianhong's message of January 26, 2021 4:59 pm:
>> On 2021/1/26 12:45, Nicholas Piggin wrote:
>>> Support huge page vmalloc mappings. Config option HAVE_ARCH_HUGE_VMALLOC
>>> enables support on architectures that define HAVE_ARCH_HUGE_VMAP and
>>> supports PMD sized vmap mappings.
>>>
>>> vmalloc will attempt to allocate PMD-sized pages if allocating PMD size
>>> or larger, and fall back to small pages if that was unsuccessful.
>>>
>>> Architectures must ensure that any arch specific vmalloc allocations
>>> that require PAGE_SIZE mappings (e.g., module allocations vs strict
>>> module rwx) use the VM_NOHUGE flag to inhibit larger mappings.
>>>
>>> When hugepage vmalloc mappings are enabled in the next patch, this
>>> reduces TLB misses by nearly 30x on a `git diff` workload on a 2-node
>>> POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%.
>>>
>>> This can result in more internal fragmentation and memory overhead for a
>>> given allocation, an option nohugevmalloc is added to disable at boot.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>  arch/Kconfig            |  11 ++
>>>  include/linux/vmalloc.h |  21 ++++
>>>  mm/page_alloc.c         |   5 +-
>>>  mm/vmalloc.c            | 215 +++++++++++++++++++++++++++++++---------
>>>  4 files changed, 205 insertions(+), 47 deletions(-)
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 24862d15f3a3..eef170e0c9b8 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -724,6 +724,17 @@ config HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>>>  config HAVE_ARCH_HUGE_VMAP
>>>  	bool
>>>  
>>> +#
>>> +#  Archs that select this would be capable of PMD-sized vmaps (i.e.,
>>> +#  arch_vmap_pmd_supported() returns true), and they must make no assumptions
>>> +#  that vmalloc memory is mapped with PAGE_SIZE ptes. The VM_NO_HUGE_VMAP flag
>>> +#  can be used to prohibit arch-specific allocations from using hugepages to
>>> +#  help with this (e.g., modules may require it).
>>> +#
>>> +config HAVE_ARCH_HUGE_VMALLOC
>>> +	depends on HAVE_ARCH_HUGE_VMAP
>>> +	bool
>>> +
>>>  config ARCH_WANT_HUGE_PMD_SHARE
>>>  	bool
>>>  
>>> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
>>> index 99ea72d547dc..93270adf5db5 100644
>>> --- a/include/linux/vmalloc.h
>>> +++ b/include/linux/vmalloc.h
>>> @@ -25,6 +25,7 @@ struct notifier_block;		/* in notifier.h */
>>>  #define VM_NO_GUARD		0x00000040      /* don't add guard page */
>>>  #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
>>>  #define VM_MAP_PUT_PAGES	0x00000100	/* put pages and free array in vfree */
>>> +#define VM_NO_HUGE_VMAP		0x00000200	/* force PAGE_SIZE pte mapping */
>>>
>>>  /*
>>>   * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALLOC.
>>> @@ -59,6 +60,9 @@ struct vm_struct {
>>>  	unsigned long		size;
>>>  	unsigned long		flags;
>>>  	struct page		**pages;
>>> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMALLOC
>>> +	unsigned int		page_order;
>>> +#endif
>>>  	unsigned int		nr_pages;
>>>  	phys_addr_t		phys_addr;
>>>  	const void		*caller;
>> Hi Nicholas:
>>
>> Give a suggestion :)
>>
>> The page order was only used to indicate the huge page flag for vm area, and only valid when
>> size bigger than PMD_SIZE, so can we use the vm flgas to instead of that, just like define the
>> new flag named VM_HUGEPAGE, it would not break the vm struct, and it is easier for me to backport the serious
>> patches to our own branches. (Base on the lts version).
> 
> Hmm, it might be possible. I'm not sure if 1GB vmallocs will be used any 
> time soon (or maybe they will for edge case configurations? It would be 
> trivial to add support for).
> 

1GB vmallocs is really crazy, but maybe used for future. :)

> The other concern I have is that Christophe IIRC was asking about 
> implementing a mapping for PPC which used TLB mappings that were 
> different than kernel page table tree size. Although I guess we could 
> deal with that when it comes.
> 

I didn't check the PPC platform, but a agree with you.

> I like the flexibility of page_order though. How hard would it be for 
> you to do the backport with VM_HUGEPAGE yourself?
> 

Yes, i can fix it with VM_HUGEPAGE for my own branch.

> I should also say, thanks for all the review and testing from the Huawei 
> team. Do you have an x86 patch?
I only enable and use it for x86 and aarch64 platform, this serious patches is
really help us a lot. Thanks.

Ding

> Thanks,
> Nick
> .
> 

