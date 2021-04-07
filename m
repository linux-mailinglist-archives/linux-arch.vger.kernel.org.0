Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0713569B6
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 12:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbhDGKbr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 06:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236558AbhDGKbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 06:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617791497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nJSxvPf+2fQxpcou71SA/t4hQw4etrSkU0eumEfbqCc=;
        b=NI6ODgu1MmOPKY8PDp/Bgak3yGjHnqcRNLZUHeluhPts6r0VEd/2K5JIz4qPs1nqwpuuEE
        nt+ojN18KMpaVGaRHNJACqUiRuADurvoRfRk/lL0mVbJ2KY/xxTe14UBmwFveS304Pgx3w
        au3YkvCqPBFixnLmKCEbtwih7Wabf4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-SMXER1lrNQy7RmmVKzJMWQ-1; Wed, 07 Apr 2021 06:31:35 -0400
X-MC-Unique: SMXER1lrNQy7RmmVKzJMWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D4221006C82;
        Wed,  7 Apr 2021 10:31:30 +0000 (UTC)
Received: from [10.36.114.68] (ovpn-114-68.ams2.redhat.com [10.36.114.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 624C871284;
        Wed,  7 Apr 2021 10:31:13 +0000 (UTC)
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
Organization: Red Hat GmbH
Subject: Re: [PATCH v1 2/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault/prealloc memory
Message-ID: <5f49b60c-957d-8cb4-de7a-7c855dc72942@redhat.com>
Date:   Wed, 7 Apr 2021 12:31:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <54165ffe-dbf7-377a-a710-d15be4701f20@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 30.03.21 18:31, David Hildenbrand wrote:
> On 30.03.21 18:30, David Hildenbrand wrote:
>> On 30.03.21 18:21, Jann Horn wrote:
>>> On Tue, Mar 30, 2021 at 5:01 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>> +long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
>>>>>> +                           unsigned long end, bool write, int *locked)
>>>>>> +{
>>>>>> +       struct mm_struct *mm = vma->vm_mm;
>>>>>> +       unsigned long nr_pages = (end - start) / PAGE_SIZE;
>>>>>> +       int gup_flags;
>>>>>> +
>>>>>> +       VM_BUG_ON(!PAGE_ALIGNED(start));
>>>>>> +       VM_BUG_ON(!PAGE_ALIGNED(end));
>>>>>> +       VM_BUG_ON_VMA(start < vma->vm_start, vma);
>>>>>> +       VM_BUG_ON_VMA(end > vma->vm_end, vma);
>>>>>> +       mmap_assert_locked(mm);
>>>>>> +
>>>>>> +       /*
>>>>>> +        * FOLL_HWPOISON: Return -EHWPOISON instead of -EFAULT when we hit
>>>>>> +        *                a poisoned page.
>>>>>> +        * FOLL_POPULATE: Always populate memory with VM_LOCKONFAULT.
>>>>>> +        * !FOLL_FORCE: Require proper access permissions.
>>>>>> +        */
>>>>>> +       gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK | FOLL_HWPOISON;
>>>>>> +       if (write)
>>>>>> +               gup_flags |= FOLL_WRITE;
>>>>>> +
>>>>>> +       /*
>>>>>> +        * See check_vma_flags(): Will return -EFAULT on incompatible mappings
>>>>>> +        * or with insufficient permissions.
>>>>>> +        */
>>>>>> +       return __get_user_pages(mm, start, nr_pages, gup_flags,
>>>>>> +                               NULL, NULL, locked);
>>>>>
>>>>> You mentioned in the commit message that you don't want to actually
>>>>> dirty all the file pages and force writeback; but doesn't
>>>>> POPULATE_WRITE still do exactly that? In follow_page_pte(), if
>>>>> FOLL_TOUCH and FOLL_WRITE are set, we mark the page as dirty:
>>>>
>>>> Well, I mention that POPULATE_READ explicitly doesn't do that. I
>>>> primarily set it because populate_vma_page_range() also sets it.
>>>>
>>>> Is it safe to *not* set it? IOW, fault something writable into a page
>>>> table (where the CPU could dirty it without additional page faults)
>>>> without marking it accessed? For me, this made logically sense. Thus I
>>>> also understood why populate_vma_page_range() set it.
>>>
>>> FOLL_TOUCH doesn't have anything to do with installing the PTE - it
>>> essentially means "the caller of get_user_pages wants to read/write
>>> the contents of the returned page, so please do the same things you
>>> would do if userspace was accessing the page". So in particular, if
>>> you look up a page via get_user_pages() with FOLL_WRITE|FOLL_TOUCH,
>>> that tells the MM subsystem "I will be writing into this page directly
>>> from the kernel, bypassing the userspace page tables, so please mark
>>> it as dirty now so that it will be properly written back later". Part
>>> of that is that it marks the page as recently used, which has an
>>> effect on LRU pageout behavior, I think - as far as I understand, that
>>> is why populate_vma_page_range() uses FOLL_TOUCH.
>>>
>>> If you look at __get_user_pages(), you can see that it is split up
>>> into two major parts: faultin_page() for creating PTEs, and
>>> follow_page_mask() for grabbing pages from PTEs. faultin_page()
>>> ignores FOLL_TOUCH completely; only follow_page_mask() uses it.
>>>
>>> In a way I guess maybe you do want the "mark as recently accessed"
>>> part that FOLL_TOUCH would give you without FOLL_WRITE? But I think
>>> you very much don't want the dirtying that FOLL_TOUCH|FOLL_WRITE leads
>>> to. Maybe the ideal approach would be to add a new FOLL flag to say "I
>>> only want to mark as recently used, I don't want to dirty". Or maybe
>>> it's enough to just leave out the FOLL_TOUCH entirely, I don't know.
>>
>> Any thoughts why populate_vma_page_range() does it?
> 
> Sorry, I missed the explanation above - thanks!

Looking into the details, adjusting the FOLL_TOUCH logic won't make too 
much of a difference for MADV_POPULATE_WRITE I guess. AFAIKs, the 
biggest impact of FOLL_TOUCH is actually with FOLL_FORCE - which we are 
not using, but populate_vma_page_range() is.


If a page was not faulted in yet, 
faultin_page(FOLL_WRITE)->handle_mm_fault(FAULT_FLAG_WRITE) will already 
mark the PTE/PMD/... dirty and accessed. One example is 
handle_pte_fault(). We will mark the page accessed again via FOLL_TOUCH, 
which doesn't seem to be strictly required.


If the page was already faulted in, we have three cases:

1. Page faulted in writable. The page should already be dirty (otherwise 
we would be in trouble I guess). We will mark it accessed.

2. Page faulted in readable. handle_mm_fault() will fault it in writable 
and set the page dirty.

3. Page faulted in readable and we have FOLL_FORCE. We mark the page 
dirty and accessed.


So doing a MADV_POPULATE_WRITE, whereby we prefault page tables 
writable, doesn't seem to fly without marking the pages dirty. That's 
one reason why I included MADV_POPULATE_READ.

We could

a) Drop FOLL_TOUCH. We are not marking the page accessed, which would 
mean it gets evicted rather earlier than later.

b) Introduce FOLL_ACCESSED which won't do the dirtying. But then, the 
pages are already dirty as explained above, so there isn't a real 
observable change.

c) Keep it as is: Mark the page accessed and dirty. As it's already 
dirty, that does not seem to be a real issue.

Am I missing something obvious? Thanks!

-- 
Thanks,

David / dhildenb

