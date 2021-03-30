Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7D34E950
	for <lists+linux-arch@lfdr.de>; Tue, 30 Mar 2021 15:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhC3Nhq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Mar 2021 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbhC3Nhj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Mar 2021 09:37:39 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932EFC0613D9
        for <linux-arch@vger.kernel.org>; Tue, 30 Mar 2021 06:37:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i26so23770702lfl.1
        for <linux-arch@vger.kernel.org>; Tue, 30 Mar 2021 06:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yA1Cq5V8NrTg1cAYG6FJJd7lrtiA/N0nU3o0CVInh+U=;
        b=TxCkx8j3Nr4BwrOpzi4MXUh4zts8lelTxoPqXUfCOEFR1StnwpzUUCw2pAl+BU3bTe
         n2dj/eLG1MotIB7JaWHUSHEN+GcbSXHfYmilCaneM4qni4m3zHRE7BkhANB+66raUekA
         drs6yWVT0N5s8WNkPhOq3QmyW0Q09+Pj1wnTI7nHXSSvV1E1bPA9+wHesFugheoL2scN
         Nqq2vZ0b/bf4vHY8LewGxbPbyd/3lr5xwNw62bnovD3SwbXKalIdtTB3WrAbV/wNfJHT
         0yzc/X6wl9JCdTLILhtErgymh+FIMsizE/rGnH/RFeEy/NAKqWHni4mFaW+dDZqUrDq/
         /MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yA1Cq5V8NrTg1cAYG6FJJd7lrtiA/N0nU3o0CVInh+U=;
        b=tzpvs75XJ9zl4gA01QyhMrJDG4XDuIP3mSyp3hvyyB+ppvKNrlr7UmxYX//yrhXHJp
         s0fk0yg92IWNM0HfoK05/N4s89IiKtVqUVMHi2iuwLXDOYxQGqs6oC/v/sPttUjwUV5r
         jIzU7FA9Mw8cltpIt1UhLG2Vaclv8WBDeRanm9eRmVb8BQnDL8XFSggTi5brrxUymq3e
         6py2YAcR37mkVwAg0qSgatklItagbO4LxY3vpeqaKM+1Es15o2IPeu5bFoLIHhBXqNhS
         xc90OA02ppLhMIUBadH9dIlFtOleb5EmXXy8hSv/HCSS7g6fhNz+zY945uD1/yEJCpHC
         9pdA==
X-Gm-Message-State: AOAM533gTemPHVY0fhVkqkKzPxS3wvLcleqnoU5QmIasgwMAjMyryYOr
        52m5kIClkw1sZ+aQc060Ugho/2Ll134hRUEYbWJ89Q==
X-Google-Smtp-Source: ABdhPJwnmtaIPtEIR601t3q/imvyBMCVX/w236t9g26RzZm1rBspOkW4Ew+qL0jji2S4o6Ta0UfQOjEl76fN737h1K8=
X-Received: by 2002:a19:946:: with SMTP id 67mr21200257lfj.74.1617111456587;
 Tue, 30 Mar 2021 06:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210317110644.25343-1-david@redhat.com> <20210317110644.25343-3-david@redhat.com>
In-Reply-To: <20210317110644.25343-3-david@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 30 Mar 2021 15:37:07 +0200
Message-ID: <CAG48ez0BQ3Vd3nDLEvyiSU0XALgUQ=c-fAwcFVScUkgo_9qVuQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault/prealloc memory
To:     David Hildenbrand <david@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 17, 2021 at 12:07 PM David Hildenbrand <david@redhat.com> wrote:
> I. Background: Sparse Memory Mappings
>
> When we manage sparse memory mappings dynamically in user space - also
> sometimes involving MAP_NORESERVE - we want to dynamically populate/
> discard memory inside such a sparse memory region. Example users are
> hypervisors (especially implementing memory ballooning or similar
> technologies like virtio-mem) and memory allocators. In addition, we want
> to fail in a nice way (instead of generating SIGBUS) if populating does not
> succeed because we are out of backend memory (which can happen easily with
> file-based mappings, especially tmpfs and hugetlbfs).
>
> While MADV_DONTNEED, MADV_REMOVE and FALLOC_FL_PUNCH_HOLE allow for
> reliably discarding memory, there is no generic approach to populate
> page tables and preallocate memory.
>
> Although mmap() supports MAP_POPULATE, it is not applicable to the concept
> of sparse memory mappings, where we want to do populate/discard
> dynamically and avoid expensive/problematic remappings. In addition,
> we never actually report errors during the final populate phase - it is
> best-effort only.
>
> fallocate() can be used to preallocate file-based memory and fail in a safe
> way. However, it cannot really be used for any private mappings on
> anonymous files via memfd due to COW semantics. In addition, fallocate()
> does not actually populate page tables, so we still always get
> pagefaults on first access - which is sometimes undesired (i.e., real-time
> workloads) and requires real prefaulting of page tables, not just a
> preallocation of backend storage. There might be interesting use cases
> for sparse memory regions along with mlockall(MCL_ONFAULT) which
> fallocate() cannot satisfy as it does not prefault page tables.
>
> II. On preallcoation/prefaulting from user space
>
> Because we don't have a proper interface, what applications
> (like QEMU and databases) end up doing is touching (i.e., reading+writing
> one byte to not overwrite existing data) all individual pages.
>
> However, that approach
> 1) Can result in wear on storage backing, because we end up writing
>    and thereby dirtying each page --- i.e., disks or pmem.
> 2) Can result in mmap_sem contention when prefaulting via multiple
>    threads.
> 3) Requires expensive signal handling, especially to catch SIGBUS in case
>    of hugetlbfs/shmem/file-backed memory. For example, this is
>    problematic in hypervisors like QEMU where SIGBUS handlers might already
>    be used by other subsystems concurrently to e.g, handle hardware errors.
>    "Simply" doing preallocation concurrently from other thread is not that
>    easy.
>
> III. On MADV_WILLNEED
>
> Extending MADV_WILLNEED is not an option because
> 1. It would change the semantics: "Expect access in the near future." and
>    "might be a good idea to read some pages" vs. "Definitely populate/
>    preallocate all memory and definitely fail on errors.".
> 2. Existing users (like virtio-balloon in QEMU when deflating the balloon)
>    don't want populate/prealloc semantics. They treat this rather as a hint
>    to give a little performance boost without too much overhead - and don't
>    expect that a lot of memory might get consumed or a lot of time
>    might be spent.
>
> IV. MADV_POPULATE_READ and MADV_POPULATE_WRITE
>
> Let's introduce MADV_POPULATE_READ and MADV_POPULATE_WRITE with the
> following semantics:
> 1. MADV_POPULATE_READ can be used to preallocate backend memory and
>    prefault page tables just like manually reading each individual page.
>    This will not break any COW mappings -- e.g., it will populate the
>    shared zeropage when applicable.

Please clarify what is meant by "backend memory". As far as I can tell
from looking at the code, MADV_POPULATE_READ on file mappings will
allocate zeroed memory in the page cache, and map it as readonly pages
into userspace, but any attempt to actually write to that memory will
trigger the filesystem's ->page_mkwrite handler; and e.g. ext4 will
only try to allocate disk blocks at that point, which may fail. So as
far as I can tell, for files on filesystems like ext4, the current
implementation of MADV_POPULATE_READ does not replace fallocate(). Am
I missing something?

If the desired semantics are that disk blocks should be preallocated,
I think you may have to look up the ->vm_file and then internally call
vfs_fallocate() to address this, kinda like in madvise_remove()?

> 2. If MADV_POPULATE_READ succeeds, all page tables have been populated
>    (prefaulted) readable once.
> 3. MADV_POPULATE_WRITE can be used to preallocate backend memory and
>    prefault page tables just like manually writing (or
>    reading+writing) each individual page. This will break any COW
>    mappings -- e.g., the shared zeropage is never populated.
> 4. If MADV_POPULATE_WRITE succeeds, all page tables have been populated
>    (prefaulted) writable once.
> 5. MADV_POPULATE_READ and MADV_POPULATE_WRITE cannot be applied to special
>    mappings marked with VM_PFNMAP and VM_IO. Also, proper access
>    permissions (e.g., PROT_READ, PROT_WRITE) are required. If any such
>    mapping is encountered, madvise() fails with -EINVAL.
> 6. If MADV_POPULATE_READ or MADV_POPULATE_WRITE fails, some page tables
>    might have been populated. In that case, madvise() fails with
>    -ENOMEM.

AFAICS that's not true (or misphrased). If MADV_POPULATE_*
successfully populates a bunch of pages, then fails because of an
error (e.g. EHWPOISON), it will return EHWPOISON, not ENOMEM, right?

> 7. MADV_POPULATE_READ and MADV_POPULATE_WRITE will return -EHWPOISON
>    when encountering a HW poisoned page in the range.
> 8. Similar to MAP_POPULATE, MADV_POPULATE_READ and MADV_POPULATE_WRITE
>    cannot protect from the OOM (Out Of Memory) handler killing the
>    process.
>
> While the use case for MADV_POPULATE_WRITE is fairly obvious (i.e.,
> preallocate memory and prefault page tables for VMs), there are valid use
> cases for MADV_POPULATE_READ:
> 1. Efficiently populate page tables with zero pages (i.e., shared
>    zeropage). This is necessary when using userfaultfd() WP (Write-Protect
>    to properly catch all modifications within a mapping: for
>    write-protection to be effective for a virtual address, there has to be
>    a page already mapped -- even if it's the shared zeropage.

This sounds like a hack to work around issues that would be better
addressed by improving userfaultfd?

> 2. Pre-read a whole mapping from backend storage without marking it
>    dirty, such that eviction won't have to write it back. If no backend
>    memory has been allocated yet, allocate the backend memory. Helpful
>    when preallocating/prefaulting a file stored on disk without having
>    to writeback each and every page on eviction.

This sounds reasonable to me.

> Although sparse memory mappings are the primary use case, this will
> also be useful for ordinary preallocations where MAP_POPULATE is not
> desired especially in QEMU, where users can trigger preallocation of
> guest RAM after the mapping was created.
>
> Looking at the history, MADV_POPULATE was already proposed in 2013 [1],
> however, the main motivation back than was performance improvements
> (which should also still be the case, but it is a secondary concern).
>
> V. Single-threaded performance comparison
>
> There is a performance benefit when using POPULATE_READ / POPULATE_WRITE
> already when only using a single thread to do prefaulting/preallocation. As
> we have less pagefaults for huge pages, the performance benefit is
> negligible with small mappings.
[...]
> diff --git a/mm/gup.c b/mm/gup.c
[...]
> +long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
> +                           unsigned long end, bool write, int *locked)
> +{
> +       struct mm_struct *mm = vma->vm_mm;
> +       unsigned long nr_pages = (end - start) / PAGE_SIZE;
> +       int gup_flags;
> +
> +       VM_BUG_ON(!PAGE_ALIGNED(start));
> +       VM_BUG_ON(!PAGE_ALIGNED(end));
> +       VM_BUG_ON_VMA(start < vma->vm_start, vma);
> +       VM_BUG_ON_VMA(end > vma->vm_end, vma);
> +       mmap_assert_locked(mm);
> +
> +       /*
> +        * FOLL_HWPOISON: Return -EHWPOISON instead of -EFAULT when we hit
> +        *                a poisoned page.
> +        * FOLL_POPULATE: Always populate memory with VM_LOCKONFAULT.
> +        * !FOLL_FORCE: Require proper access permissions.
> +        */
> +       gup_flags = FOLL_TOUCH | FOLL_POPULATE | FOLL_MLOCK | FOLL_HWPOISON;
> +       if (write)
> +               gup_flags |= FOLL_WRITE;
> +
> +       /*
> +        * See check_vma_flags(): Will return -EFAULT on incompatible mappings
> +        * or with insufficient permissions.
> +        */
> +       return __get_user_pages(mm, start, nr_pages, gup_flags,
> +                               NULL, NULL, locked);

You mentioned in the commit message that you don't want to actually
dirty all the file pages and force writeback; but doesn't
POPULATE_WRITE still do exactly that? In follow_page_pte(), if
FOLL_TOUCH and FOLL_WRITE are set, we mark the page as dirty:

if (flags & FOLL_TOUCH) {
        if ((flags & FOLL_WRITE) &&
           !pte_dirty(pte) && !PageDirty(page))
                set_page_dirty(page);
        /*
         * pte_mkyoung() would be more correct here, but atomic care
         * is needed to avoid losing the dirty bit: it is easier to use
         * mark_page_accessed().
         */
        mark_page_accessed(page);
}


> +}
> +
>  /*
>   * __mm_populate - populate and/or mlock pages within a range of address space.
>   *
> diff --git a/mm/internal.h b/mm/internal.h
> index 3f22c4ceb7b5..ee398696380f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -335,6 +335,9 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
>  #ifdef CONFIG_MMU
>  extern long populate_vma_page_range(struct vm_area_struct *vma,
>                 unsigned long start, unsigned long end, int *locked);
> +extern long faultin_vma_page_range(struct vm_area_struct *vma,
> +                                  unsigned long start, unsigned long end,
> +                                  bool write, int *locked);
>  extern void munlock_vma_pages_range(struct vm_area_struct *vma,
>                         unsigned long start, unsigned long end);
>  static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 01fef79ac761..857460873f7a 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -53,6 +53,8 @@ static int madvise_need_mmap_write(int behavior)
>         case MADV_COLD:
>         case MADV_PAGEOUT:
>         case MADV_FREE:
> +       case MADV_POPULATE_READ:
> +       case MADV_POPULATE_WRITE:
>                 return 0;
>         default:
>                 /* be safe, default to 1. list exceptions explicitly */
> @@ -822,6 +824,64 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
>                 return -EINVAL;
>  }
>
> +static long madvise_populate(struct vm_area_struct *vma,
> +                            struct vm_area_struct **prev,
> +                            unsigned long start, unsigned long end,
> +                            int behavior)
> +{
> +       const bool write = behavior == MADV_POPULATE_WRITE;
> +       struct mm_struct *mm = vma->vm_mm;
> +       unsigned long tmp_end;
> +       int locked = 1;
> +       long pages;
> +
> +       *prev = vma;
> +
> +       while (start < end) {
> +               /*
> +                * We might have temporarily dropped the lock. For example,
> +                * our VMA might have been split.
> +                */
> +               if (!vma || start >= vma->vm_end) {
> +                       vma = find_vma(mm, start);
> +                       if (!vma || start < vma->vm_start)
> +                               return -ENOMEM;
> +               }
> +
> +               tmp_end = min_t(unsigned long, end, vma->vm_end);
> +               /* Populate (prefault) page tables readable/writable. */
> +               pages = faultin_vma_page_range(vma, start, tmp_end, write,
> +                                              &locked);
> +               if (!locked) {
> +                       mmap_read_lock(mm);
> +                       locked = 1;
> +                       *prev = NULL;
> +                       vma = NULL;
> +               }
> +               if (pages < 0) {
> +                       switch (pages) {
> +                       case -EINTR:
> +                               return -EINTR;
> +                       case -EFAULT: /* Incompatible mappings / permissions. */
> +                               return -EINVAL;
> +                       case -EHWPOISON:
> +                               return -EHWPOISON;
> +                       case -EBUSY:

What is -EBUSY doing here? __get_user_pages() fixes up -EBUSY from
faultin_page() to 0, right?

> +                       case -EAGAIN:

Where can -EAGAIN come from?

> +                               continue;
> +                       default:
> +                               pr_warn_once("%s: unhandled return value: %ld\n",
> +                                            __func__, pages);
> +                               fallthrough;
> +                       case -ENOMEM:
> +                               return -ENOMEM;
> +                       }
> +               }
> +               start += pages * PAGE_SIZE;
> +       }
> +       return 0;
> +}
