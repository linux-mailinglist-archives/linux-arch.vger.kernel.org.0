Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83634EB6E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 17:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhC3PCK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 11:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30865 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232101AbhC3PBf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 30 Mar 2021 11:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617116494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzP1g+GUvlZpxTdO2HB7tamONjnsQRZSupLZMmaOVwY=;
        b=RWUaTGktJwC5eOzR9Sz0LX64YI4ww9PLng3RGsL3rulwtaMp4/utBNr7KgSZGs5r49vvm6
        eOqHQxhH2TjqdH/SDBVInCbM+C6kPovDEgbUndLyLSWK0MDgBoC6VsCi/xa6kb4Pvte8Tk
        Py8QwzAvmo7/Aa4PWtIjplFlcb1K07k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-mjH4sJKpOe6RHhSFm9bO_w-1; Tue, 30 Mar 2021 11:01:29 -0400
X-MC-Unique: mjH4sJKpOe6RHhSFm9bO_w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9585281621;
        Tue, 30 Mar 2021 15:01:25 +0000 (UTC)
Received: from [10.36.114.210] (ovpn-114-210.ams2.redhat.com [10.36.114.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 906CB19C44;
        Tue, 30 Mar 2021 15:01:09 +0000 (UTC)
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: [PATCH v1 2/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault/prealloc memory
Message-ID: <2bab28c7-08c0-7ff0-c70e-9bf94da05ce1@redhat.com>
Date:   Tue, 30 Mar 2021 17:01:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0BQ3Vd3nDLEvyiSU0XALgUQ=c-fAwcFVScUkgo_9qVuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[...]

>>
>> Let's introduce MADV_POPULATE_READ and MADV_POPULATE_WRITE with the
>> following semantics:
>> 1. MADV_POPULATE_READ can be used to preallocate backend memory and
>>     prefault page tables just like manually reading each individual page.
>>     This will not break any COW mappings -- e.g., it will populate the
>>     shared zeropage when applicable.
> 
> Please clarify what is meant by "backend memory". As far as I can tell
> from looking at the code, MADV_POPULATE_READ on file mappings will
> allocate zeroed memory in the page cache, and map it as readonly pages
> into userspace, but any attempt to actually write to that memory will
> trigger the filesystem's ->page_mkwrite handler; and e.g. ext4 will
> only try to allocate disk blocks at that point, which may fail. So as
> far as I can tell, for files on filesystems like ext4, the current
> implementation of MADV_POPULATE_READ does not replace fallocate(). Am
> I missing something?

Thanks for pointing that out, I guess I was blinded by tmpfs/hugetlbfs 
behavior. There might be cases (!tmpfs, !hugetlbfs) where we indeed need 
fallocate()+MADV_POPULATE_READ on file mappings.

The logic is essentially what mlock()/MAP_POPULATE does via 
populate_vma_page_range() on shared mappings, so I assumed it would 
always properly allocate backend memory.

/*
  * We want to touch writable mappings with a write fault in order
  * to break COW, except for shared mappings because these don't COW
  * and we would not want to dirty them for nothing.
  */

My tests with MADV_POPULATE_READ:
1. MAP_SHARED on tmpfs: memory in the file is allocated
2. MAP_PRIVATE on tmpfs: memory in the file is allocated
3. MAP_SHARED on hugetlbfs: memory in the file is allocated
4. MAP_PRIVATE on hugetlbfs: memory in the file is *not* allocated
5. MAP_SHARED on ext4: memory in the file is *not* allocated
6. MAP_PRIVATE on ext4: memory in the file is *not* allocated

1..4 are also the reason why it works with memfd as expected.

For 4 and 6 it's not bad: writing to the private mapping will not result 
in backend storage/blocks having to get allocated. So the backend 
storage is actually RAM (although we don't allocate backend storage here 
but use the shared zero page, but that's a different story).

For 5. we indeed need fallocate() before MADV_POPULATE_READ in case we 
could have holes.

Thanks for pointing that out.

> 
> If the desired semantics are that disk blocks should be preallocated,
> I think you may have to look up the ->vm_file and then internally call
> vfs_fallocate() to address this, kinda like in madvise_remove()?

Does not sound too complicated, but devil might be in the details. At 
least for MAP_SHARED this might be the right thing to do. As discussed 
above, for MAP_PRIVATE we usually don't want to do that (and SHMEM is 
just weird).

I honestly do wonder if breaking with MAP_POPULATE semantics is 
beneficial. For my use cases, doing fallocate() plus MADV_POPULATE_READ 
on shared, file-backed mappings would certainly be sufficient. But 
having a simple, consistent behavior would be much nicer.

I'll give it a thought!

>> 2. If MADV_POPULATE_READ succeeds, all page tables have been populated
>>     (prefaulted) readable once.
>> 3. MADV_POPULATE_WRITE can be used to preallocate backend memory and
>>     prefault page tables just like manually writing (or
>>     reading+writing) each individual page. This will break any COW
>>     mappings -- e.g., the shared zeropage is never populated.
>> 4. If MADV_POPULATE_WRITE succeeds, all page tables have been populated
>>     (prefaulted) writable once.
>> 5. MADV_POPULATE_READ and MADV_POPULATE_WRITE cannot be applied to special
>>     mappings marked with VM_PFNMAP and VM_IO. Also, proper access
>>     permissions (e.g., PROT_READ, PROT_WRITE) are required. If any such
>>     mapping is encountered, madvise() fails with -EINVAL.
>> 6. If MADV_POPULATE_READ or MADV_POPULATE_WRITE fails, some page tables
>>     might have been populated. In that case, madvise() fails with
>>     -ENOMEM.
> 
> AFAICS that's not true (or misphrased). If MADV_POPULATE_*
> successfully populates a bunch of pages, then fails because of an
> error (e.g. EHWPOISON), it will return EHWPOISON, not ENOMEM, right?

Indeed, leftover from previous version. It's clearer in the man page I 
prepared, will fix it up.

> 
>> 7. MADV_POPULATE_READ and MADV_POPULATE_WRITE will return -EHWPOISON
>>     when encountering a HW poisoned page in the range.
>> 8. Similar to MAP_POPULATE, MADV_POPULATE_READ and MADV_POPULATE_WRITE
>>     cannot protect from the OOM (Out Of Memory) handler killing the
>>     process.
>>
>> While the use case for MADV_POPULATE_WRITE is fairly obvious (i.e.,
>> preallocate memory and prefault page tables for VMs), there are valid use
>> cases for MADV_POPULATE_READ:
>> 1. Efficiently populate page tables with zero pages (i.e., shared
>>     zeropage). This is necessary when using userfaultfd() WP (Write-Protect
>>     to properly catch all modifications within a mapping: for
>>     write-protection to be effective for a virtual address, there has to be
>>     a page already mapped -- even if it's the shared zeropage.
> 
> This sounds like a hack to work around issues that would be better
> addressed by improving userfaultfd?

There are plans to do that, indeed.

> 
>> 2. Pre-read a whole mapping from backend storage without marking it
>>     dirty, such that eviction won't have to write it back. If no backend
>>     memory has been allocated yet, allocate the backend memory. Helpful
>>     when preallocating/prefaulting a file stored on disk without having
>>     to writeback each and every page on eviction.
> 
> This sounds reasonable to me.

Yes, the case with holes / backend memory has to be clarified.

> 
>> Although sparse memory mappings are the primary use case, this will
>> also be useful for ordinary preallocations where MAP_POPULATE is not
>> desired especially in QEMU, where users can trigger preallocation of
>> guest RAM after the mapping was created.
>>
>> Looking at the history, MADV_POPULATE was already proposed in 2013 [1],
>> however, the main motivation back than was performance improvements
>> (which should also still be the case, but it is a secondary concern).
>>
>> V. Single-threaded performance comparison
>>
>> There is a performance benefit when using POPULATE_READ / POPULATE_WRITE
>> already when only using a single thread to do prefaulting/preallocation. As
>> we have less pagefaults for huge pages, the performance benefit is
>> negligible with small mappings.
> [...]
>> diff --git a/mm/gup.c b/mm/gup.c
> [...]
>> +long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
>> +                           unsigned long end, bool write, int *locked)
>> +{
>> +       struct mm_struct *mm = vma->vm_mm;
>> +       unsigned long nr_pages = (end - start) / PAGE_SIZE;
>> +       int gup_flags;
>> +
>> +       VM_BUG_ON(!PAGE_ALIGNED(start));
>> +       VM_BUG_ON(!PAGE_ALIGNED(end));
>> +       VM_BUG_ON_VMA(start < vma->vm_start, vma);
>> +       VM_BUG_ON_VMA(end > vma->vm_end, vma);
>> +       mmap_assert_locked(mm);
>> +
>> +       /*
>> +        * FOLL_HWPOISON: Return -EHWPOISON instead of -EFAULT when we hit
>> +        *                a poisoned page.
>> +        * FOLL_POPULATE: Always populate memory with VM_LOCKONFAULT.
>> +        * !FOLL_FORCE: Require proper access permissions.
>> +        */
>> +       gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK | FOLL_HWPOISON;
>> +       if (write)
>> +               gup_flags |= FOLL_WRITE;
>> +
>> +       /*
>> +        * See check_vma_flags(): Will return -EFAULT on incompatible mappings
>> +        * or with insufficient permissions.
>> +        */
>> +       return __get_user_pages(mm, start, nr_pages, gup_flags,
>> +                               NULL, NULL, locked);
> 
> You mentioned in the commit message that you don't want to actually
> dirty all the file pages and force writeback; but doesn't
> POPULATE_WRITE still do exactly that? In follow_page_pte(), if
> FOLL_TOUCH and FOLL_WRITE are set, we mark the page as dirty:

Well, I mention that POPULATE_READ explicitly doesn't do that. I 
primarily set it because populate_vma_page_range() also sets it.

Is it safe to *not* set it? IOW, fault something writable into a page 
table (where the CPU could dirty it without additional page faults) 
without marking it accessed? For me, this made logically sense. Thus I 
also understood why populate_vma_page_range() set it.

> 
> if (flags & FOLL_TOUCH) {
>          if ((flags & FOLL_WRITE) &&
>             !pte_dirty(pte) && !PageDirty(page))
>                  set_page_dirty(page);
>          /*
>           * pte_mkyoung() would be more correct here, but atomic care
>           * is needed to avoid losing the dirty bit: it is easier to use
>           * mark_page_accessed().
>           */
>          mark_page_accessed(page);
> }
> 
> 
>> +}
>> +
>>   /*
>>    * __mm_populate - populate and/or mlock pages within a range of address space.
>>    *
>> diff --git a/mm/internal.h b/mm/internal.h
>> index 3f22c4ceb7b5..ee398696380f 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -335,6 +335,9 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
>>   #ifdef CONFIG_MMU
>>   extern long populate_vma_page_range(struct vm_area_struct *vma,
>>                  unsigned long start, unsigned long end, int *locked);
>> +extern long faultin_vma_page_range(struct vm_area_struct *vma,
>> +                                  unsigned long start, unsigned long end,
>> +                                  bool write, int *locked);
>>   extern void munlock_vma_pages_range(struct vm_area_struct *vma,
>>                          unsigned long start, unsigned long end);
>>   static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 01fef79ac761..857460873f7a 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -53,6 +53,8 @@ static int madvise_need_mmap_write(int behavior)
>>          case MADV_COLD:
>>          case MADV_PAGEOUT:
>>          case MADV_FREE:
>> +       case MADV_POPULATE_READ:
>> +       case MADV_POPULATE_WRITE:
>>                  return 0;
>>          default:
>>                  /* be safe, default to 1. list exceptions explicitly */
>> @@ -822,6 +824,64 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>>                  return -EINVAL;
>>   }
>>
>> +static long madvise_populate(struct vm_area_struct *vma,
>> +                            struct vm_area_struct **prev,
>> +                            unsigned long start, unsigned long end,
>> +                            int behavior)
>> +{
>> +       const bool write = behavior == MADV_POPULATE_WRITE;
>> +       struct mm_struct *mm = vma->vm_mm;
>> +       unsigned long tmp_end;
>> +       int locked = 1;
>> +       long pages;
>> +
>> +       *prev = vma;
>> +
>> +       while (start < end) {
>> +               /*
>> +                * We might have temporarily dropped the lock. For example,
>> +                * our VMA might have been split.
>> +                */
>> +               if (!vma || start >= vma->vm_end) {
>> +                       vma = find_vma(mm, start);
>> +                       if (!vma || start < vma->vm_start)
>> +                               return -ENOMEM;
>> +               }
>> +
>> +               tmp_end = min_t(unsigned long, end, vma->vm_end);
>> +               /* Populate (prefault) page tables readable/writable. */
>> +               pages = faultin_vma_page_range(vma, start, tmp_end, write,
>> +                                              &locked);
>> +               if (!locked) {
>> +                       mmap_read_lock(mm);
>> +                       locked = 1;
>> +                       *prev = NULL;
>> +                       vma = NULL;
>> +               }
>> +               if (pages < 0) {
>> +                       switch (pages) {
>> +                       case -EINTR:
>> +                               return -EINTR;
>> +                       case -EFAULT: /* Incompatible mappings / permissions. */
>> +                               return -EINVAL;
>> +                       case -EHWPOISON:
>> +                               return -EHWPOISON;
>> +                       case -EBUSY:
> 
> What is -EBUSY doing here? __get_user_pages() fixes up -EBUSY from
> faultin_page() to 0, right?
> 
>> +                       case -EAGAIN:
> 
> Where can -EAGAIN come from?

On both points: the lack of documentation on return values made me add 
these. The faultin_page() path is indeed fine. If the other paths don't 
yield any such return values, we can drop both.


Thanks for the review!

-- 
Thanks,

David / dhildenb

