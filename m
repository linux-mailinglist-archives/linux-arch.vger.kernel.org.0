Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A99360715
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbhDOK1W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 06:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231726AbhDOK1V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 06:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618482417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8cpKb0ASp+K7zcTMzICSE9fwIk8Icc72x4Rwh+Gm6ZU=;
        b=QFMf5oW4xIJyS2VawWwWOVkd8oe0+qhYOVNmfBlqNoKWLxoPmAEFyFfPT+rrm34a23Wdfl
        2CSv75XJ848BPGxZlOH4zW6ahiKlH+cwcBICMhlOWEXEaureLRzZQnJfKky1sY5To+bGXw
        ayCmGCC8HFiERNZDCosNiICfklTSauo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-URXfQNzVP66_23WF3AdiUA-1; Thu, 15 Apr 2021 06:26:56 -0400
X-MC-Unique: URXfQNzVP66_23WF3AdiUA-1
Received: by mail-wr1-f70.google.com with SMTP id 91-20020adf92e40000b029010470a9ebc4so1460856wrn.14
        for <linux-arch@vger.kernel.org>; Thu, 15 Apr 2021 03:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=8cpKb0ASp+K7zcTMzICSE9fwIk8Icc72x4Rwh+Gm6ZU=;
        b=L4MlauikYORyM0mFbM8O9ybNumbuvCmRN6YZNlHHU0d3HfUa7ul1EV7/8ABn5JbLXU
         tpX9sSPcNKxU+ktm2RRhCXtXWRho/KGY1GROgjrs0iNo5RsDyQ5KIJDVhnoyxtAPW3T1
         2gDGEew86d9C7GGm6+H1YHbNGcu/n7mUlu0+7EgVnUSZoezNSm6YoqaE9c2DwgSmxZS7
         BoZqZfMVz6M77vLElCbKFF28TsNIb83hi/LNnMCzrJubStudFTyeDLAY0wObTdrxGsb/
         WpiKmUdr0ByjJ0x8D7jFzXw9O0KCEDSzu54hoonrzuMJgBp/e44bwBCgr/X18e6mKFXM
         lznA==
X-Gm-Message-State: AOAM533/rRtyMqOCCQm77oG3C9JcPiYXn8mROmYH0FQti/aRhsiTgDNn
        TCY6+PuJtL5sS7JgY0xdXs7Gc4FLHXHu/lVSVOCGWBCUdnNzjFJJ3NT8/6HD3C4k4/BJaA/F6+0
        HDWz4ATdHzvbtfdP2BJDwlQ==
X-Received: by 2002:adf:f186:: with SMTP id h6mr2569747wro.89.1618482415082;
        Thu, 15 Apr 2021 03:26:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv7Q012I0Vz8MHqIPLa4Xkx+hS8m+nH/TPxEyn3JS7V7NiE9yOuvehr7qVZbxLbS4BFGfVVQ==
X-Received: by 2002:adf:f186:: with SMTP id h6mr2569712wro.89.1618482414741;
        Thu, 15 Apr 2021 03:26:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6392.dip0.t-ipconnect.de. [91.12.99.146])
        by smtp.gmail.com with ESMTPSA id z17sm2386902wro.1.2021.04.15.03.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Apr 2021 03:26:54 -0700 (PDT)
From:   David Hildenbrand <david@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20210317110644.25343-1-david@redhat.com>
 <20210317110644.25343-3-david@redhat.com>
 <CAG48ez0BQ3Vd3nDLEvyiSU0XALgUQ=c-fAwcFVScUkgo_9qVuQ@mail.gmail.com>
 <2bab28c7-08c0-7ff0-c70e-9bf94da05ce1@redhat.com>
 <CAG48ez20rLRNPZj6hLHQ_PLT8H60kTac-uXRiLByD70Q7+qsdQ@mail.gmail.com>
 <26227fc6-3e7b-4e69-f69d-4dc2a67ecfe8@redhat.com>
 <54165ffe-dbf7-377a-a710-d15be4701f20@redhat.com>
 <5f49b60c-957d-8cb4-de7a-7c855dc72942@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault/prealloc memory
Message-ID: <273f9c4b-2a1a-23e7-53b9-0da5441895b3@redhat.com>
Date:   Thu, 15 Apr 2021 12:26:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <5f49b60c-957d-8cb4-de7a-7c855dc72942@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 07.04.21 12:31, David Hildenbrand wrote:
> On 30.03.21 18:31, David Hildenbrand wrote:
>> On 30.03.21 18:30, David Hildenbrand wrote:
>>> On 30.03.21 18:21, Jann Horn wrote:
>>>> On Tue, Mar 30, 2021 at 5:01 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>> +long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
>>>>>>> +                           unsigned long end, bool write, int *locked)
>>>>>>> +{
>>>>>>> +       struct mm_struct *mm = vma->vm_mm;
>>>>>>> +       unsigned long nr_pages = (end - start) / PAGE_SIZE;
>>>>>>> +       int gup_flags;
>>>>>>> +
>>>>>>> +       VM_BUG_ON(!PAGE_ALIGNED(start));
>>>>>>> +       VM_BUG_ON(!PAGE_ALIGNED(end));
>>>>>>> +       VM_BUG_ON_VMA(start < vma->vm_start, vma);
>>>>>>> +       VM_BUG_ON_VMA(end > vma->vm_end, vma);
>>>>>>> +       mmap_assert_locked(mm);
>>>>>>> +
>>>>>>> +       /*
>>>>>>> +        * FOLL_HWPOISON: Return -EHWPOISON instead of -EFAULT when we hit
>>>>>>> +        *                a poisoned page.
>>>>>>> +        * FOLL_POPULATE: Always populate memory with VM_LOCKONFAULT.
>>>>>>> +        * !FOLL_FORCE: Require proper access permissions.
>>>>>>> +        */
>>>>>>> +       gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK | FOLL_HWPOISON;
>>>>>>> +       if (write)
>>>>>>> +               gup_flags |= FOLL_WRITE;
>>>>>>> +
>>>>>>> +       /*
>>>>>>> +        * See check_vma_flags(): Will return -EFAULT on incompatible mappings
>>>>>>> +        * or with insufficient permissions.
>>>>>>> +        */
>>>>>>> +       return __get_user_pages(mm, start, nr_pages, gup_flags,
>>>>>>> +                               NULL, NULL, locked);
>>>>>>
>>>>>> You mentioned in the commit message that you don't want to actually
>>>>>> dirty all the file pages and force writeback; but doesn't
>>>>>> POPULATE_WRITE still do exactly that? In follow_page_pte(), if
>>>>>> FOLL_TOUCH and FOLL_WRITE are set, we mark the page as dirty:
>>>>>
>>>>> Well, I mention that POPULATE_READ explicitly doesn't do that. I
>>>>> primarily set it because populate_vma_page_range() also sets it.
>>>>>
>>>>> Is it safe to *not* set it? IOW, fault something writable into a page
>>>>> table (where the CPU could dirty it without additional page faults)
>>>>> without marking it accessed? For me, this made logically sense. Thus I
>>>>> also understood why populate_vma_page_range() set it.
>>>>
>>>> FOLL_TOUCH doesn't have anything to do with installing the PTE - it
>>>> essentially means "the caller of get_user_pages wants to read/write
>>>> the contents of the returned page, so please do the same things you
>>>> would do if userspace was accessing the page". So in particular, if
>>>> you look up a page via get_user_pages() with FOLL_WRITE|FOLL_TOUCH,
>>>> that tells the MM subsystem "I will be writing into this page directly
>>>> from the kernel, bypassing the userspace page tables, so please mark
>>>> it as dirty now so that it will be properly written back later". Part
>>>> of that is that it marks the page as recently used, which has an
>>>> effect on LRU pageout behavior, I think - as far as I understand, that
>>>> is why populate_vma_page_range() uses FOLL_TOUCH.
>>>>
>>>> If you look at __get_user_pages(), you can see that it is split up
>>>> into two major parts: faultin_page() for creating PTEs, and
>>>> follow_page_mask() for grabbing pages from PTEs. faultin_page()
>>>> ignores FOLL_TOUCH completely; only follow_page_mask() uses it.
>>>>
>>>> In a way I guess maybe you do want the "mark as recently accessed"
>>>> part that FOLL_TOUCH would give you without FOLL_WRITE? But I think
>>>> you very much don't want the dirtying that FOLL_TOUCH|FOLL_WRITE leads
>>>> to. Maybe the ideal approach would be to add a new FOLL flag to say "I
>>>> only want to mark as recently used, I don't want to dirty". Or maybe
>>>> it's enough to just leave out the FOLL_TOUCH entirely, I don't know.
>>>
>>> Any thoughts why populate_vma_page_range() does it?
>>
>> Sorry, I missed the explanation above - thanks!
> 
> Looking into the details, adjusting the FOLL_TOUCH logic won't make too
> much of a difference for MADV_POPULATE_WRITE I guess. AFAIKs, the
> biggest impact of FOLL_TOUCH is actually with FOLL_FORCE - which we are
> not using, but populate_vma_page_range() is.
> 
> 
> If a page was not faulted in yet,
> faultin_page(FOLL_WRITE)->handle_mm_fault(FAULT_FLAG_WRITE) will already
> mark the PTE/PMD/... dirty and accessed. One example is
> handle_pte_fault(). We will mark the page accessed again via FOLL_TOUCH,
> which doesn't seem to be strictly required.
> 
> 
> If the page was already faulted in, we have three cases:
> 
> 1. Page faulted in writable. The page should already be dirty (otherwise
> we would be in trouble I guess). We will mark it accessed.
> 
> 2. Page faulted in readable. handle_mm_fault() will fault it in writable
> and set the page dirty.
> 
> 3. Page faulted in readable and we have FOLL_FORCE. We mark the page
> dirty and accessed.
> 
> 
> So doing a MADV_POPULATE_WRITE, whereby we prefault page tables
> writable, doesn't seem to fly without marking the pages dirty. That's
> one reason why I included MADV_POPULATE_READ.
> 
> We could
> 
> a) Drop FOLL_TOUCH. We are not marking the page accessed, which would
> mean it gets evicted rather earlier than later.
> 
> b) Introduce FOLL_ACCESSED which won't do the dirtying. But then, the
> pages are already dirty as explained above, so there isn't a real
> observable change.
> 
> c) Keep it as is: Mark the page accessed and dirty. As it's already
> dirty, that does not seem to be a real issue.
> 
> Am I missing something obvious? Thanks!
> 

I did some more digging. I think there are cases for shared mappings 
where we can have pte_write() but not pte_dirty().

One example seems to be mm/memory.c:copy_present_pte() , used during fork.

IIUC, this means that the child process can write to these pages, but 
won't mark the PTEs dirty -- as there won't be a write fault. I'd assume 
we'd need pte_mkclean(pte_wrprotect(pte)), but I'm fairly new to that code.

(Similarly, we do an pte_mkold() without revoking any protection, 
meaning we won't catch read accesses.)


Maybe the logic here is that if the PTE was writable in some parent, it 
was also dirty in some parent (at least in the one originally mapping it 
writable). When evicting/writeback'ing file pages, we'll have go over 
the rmap and zap all entries of any page tables either way; it's 
sufficient if one PTE entry is dirty. I can spot that even 
zap_pte_range() will sync the dirty flag back to the page.

Am I right or is there some other magic going on? :)

-- 
Thanks,

David / dhildenb

