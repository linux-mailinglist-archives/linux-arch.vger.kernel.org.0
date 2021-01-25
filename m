Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3493024D8
	for <lists+linux-arch@lfdr.de>; Mon, 25 Jan 2021 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbhAYMT3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 25 Jan 2021 07:19:29 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48345 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbhAYMS4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 Jan 2021 07:18:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPTLF5mjtz9tytf;
        Mon, 25 Jan 2021 13:13:57 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id fjwqXeu-7KdQ; Mon, 25 Jan 2021 13:13:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPTLF4vfBz9tytY;
        Mon, 25 Jan 2021 13:13:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 06A1A8B79B;
        Mon, 25 Jan 2021 13:14:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id g4AmfjdBibuV; Mon, 25 Jan 2021 13:14:02 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B35128B75F;
        Mon, 25 Jan 2021 13:14:02 +0100 (CET)
Subject: Re: [PATCH v10 11/12] mm/vmalloc: Hugepage vmalloc mappings
To:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20210124082230.2118861-1-npiggin@gmail.com>
 <20210124082230.2118861-12-npiggin@gmail.com>
 <933352bd-dcf3-c483-4d7a-07afe1116cf1@csgroup.eu>
 <1611574637.k9njsi2um5.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a3b26f6e-6f33-a606-6d60-5671e5ee395f@csgroup.eu>
Date:   Mon, 25 Jan 2021 13:13:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1611574637.k9njsi2um5.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 25/01/2021 à 12:37, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of January 25, 2021 7:14 pm:
>>
>>
>> Le 24/01/2021 à 09:22, Nicholas Piggin a écrit :
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
>>>    arch/Kconfig            |  10 +++
>>>    include/linux/vmalloc.h |  18 ++++
>>>    mm/page_alloc.c         |   5 +-
>>>    mm/vmalloc.c            | 192 ++++++++++++++++++++++++++++++----------
>>>    4 files changed, 177 insertions(+), 48 deletions(-)
>>>
>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index 0377e1d059e5..eef61e0f5170 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>
>>> @@ -2691,15 +2746,18 @@ EXPORT_SYMBOL_GPL(vmap_pfn);
>>>    #endif /* CONFIG_VMAP_PFN */
>>>    
>>>    static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>>> -				 pgprot_t prot, int node)
>>> +				 pgprot_t prot, unsigned int page_shift,
>>> +				 int node)
>>>    {
>>>    	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
>>> -	unsigned int nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
>>> -	unsigned long array_size;
>>> -	unsigned int i;
>>> +	unsigned int page_order = page_shift - PAGE_SHIFT;
>>> +	unsigned long addr = (unsigned long)area->addr;
>>> +	unsigned long size = get_vm_area_size(area);
>>> +	unsigned int nr_small_pages = size >> PAGE_SHIFT;
>>>    	struct page **pages;
>>> +	unsigned int i;
>>>    
>>> -	array_size = (unsigned long)nr_pages * sizeof(struct page *);
>>> +	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
>>
>> array_size() is a function in include/linux/overflow.h
>>
>> For some reason, it breaks the build with your series.
> 
> What config? I haven't seen it.
> 

Several configs I believe. I saw it this morning in 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20210124082230.2118861-13-npiggin@gmail.com/

Though the reports have all disappeared now.
