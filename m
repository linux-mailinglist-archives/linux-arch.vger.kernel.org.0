Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E489769641
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jul 2023 14:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjGaMZ4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jul 2023 08:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbjGaMZj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Jul 2023 08:25:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDD21724;
        Mon, 31 Jul 2023 05:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0K40KC1hdcWabwndSZwBHaRcP6z+xWm7XvI+3DJvaVw=; b=P7N0wvz5C4yYBzFsluWGdPjpvI
        Dvk1WnbcF5p2q9WoM/YHj4im2eVmo/a9KjUjLvdY6748yAk7MIlkRnYQTx8e6mbVhNkgktPqAsJbI
        9KQ5cWzxCS0yhuPReOfNgGEtsveNobYS9yIOIM57l0kVPOJPnIOnQXZub/mbUFWu++d7dKj7+1gIp
        zPS5BfnF11YPHQGBmj9ks705JgknptCWtWz9n7/ulq/ukkboit5OjhY5y49jRLVuzoLIbcyl+pW1k
        A6eO7VQkDh4hL2tGPfXA4OyM1wkDDHCbmb7YRlDsMVcUWn98p9EqQwCQNss1OlwB6SdPcI84CVLYP
        moZKMlsA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQRxO-001bd3-EK; Mon, 31 Jul 2023 12:25:02 +0000
Date:   Mon, 31 Jul 2023 13:25:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "xuyu@linux.alibaba.com" <xuyu@linux.alibaba.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
Message-ID: <ZMeoHoM8j/ric0Bh@casper.infradead.org>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74fe50d9-9be9-cc97-e550-3ca30aebfd13@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 31, 2023 at 12:35:00PM +0800, Rongwei Wang wrote:
> Hi Matthew
> 
> May I ask you another question about mshare under this RFC? I remember you
> said you will redesign the mshare to per-vma not per-mapping (apologize if
> remember wrongly) in last time MM alignment session. And I also refer to you
> to re-code this part in our internal version (based on this RFC). It seems
> that per VMA will can simplify the structure of pgtable sharing, even
> doesn't care the different permission of file mapping. these are advantages
> (maybe) that I can imagine. But IMHO, It seems not a strongly reason to
> switch per-mapping to per-vma.
> 
> And I can't imagine other considerations of upstream. Can you share the
> reason why redesigning in a per-vma way, due to integation with hugetlbfs
> pgtable sharing or anonymous page sharing?

It was David who wants to make page table sharing be per-VMA.  I think
he is advocating for the wrong approach.  In any case, I don't have time
to work on mshare and Khalid is on leave until September, so I don't
think anybody is actively working on mshare.

> Thanks for your time.
> 
> On 2023/4/27 00:49, Khalid Aziz wrote:
> > Memory pages shared between processes require a page table entry
> > (PTE) for each process. Each of these PTE consumes some of the
> > memory and as long as number of mappings being maintained is small
> > enough, this space consumed by page tables is not objectionable.
> > When very few memory pages are shared between processes, the number
> > of page table entries (PTEs) to maintain is mostly constrained by
> > the number of pages of memory on the system.  As the number of
> > shared pages and the number of times pages are shared goes up,
> > amount of memory consumed by page tables starts to become
> > significant. This issue does not apply to threads. Any number of
> > threads can share the same pages inside a process while sharing the
> > same PTEs. Extending this same model to sharing pages across
> > processes can eliminate this issue for sharing across processes as
> > well.
> > 
> > Some of the field deployments commonly see memory pages shared
> > across 1000s of processes. On x86_64, each page requires a PTE that
> > is only 8 bytes long which is very small compared to the 4K page
> > size. When 2000 processes map the same page in their address space,
> > each one of them requires 8 bytes for its PTE and together that adds
> > up to 8K of memory just to hold the PTEs for one 4K page. On a
> > database server with 300GB SGA, a system crash was seen with
> > out-of-memory condition when 1500+ clients tried to share this SGA
> > even though the system had 512GB of memory. On this server, in the
> > worst case scenario of all 1500 processes mapping every page from
> > SGA would have required 878GB+ for just the PTEs. If these PTEs
> > could be shared, amount of memory saved is very significant.
> > 
> > This patch series adds a new flag to mmap() call - MAP_SHARED_PT.
> > This flag can be specified along with MAP_SHARED by a process to
> > hint to kernel that it wishes to share page table entries for this
> > file mapping mmap region with other processes. Any other process
> > that mmaps the same file with MAP_SHARED_PT flag can then share the
> > same page table entries. Besides specifying MAP_SHARED_PT flag, the
> > processes must map the files at a PMD aligned address with a size
> > that is a multiple of PMD size and at the same virtual addresses.
> > This last requirement of same virtual addresses can possibly be
> > relaxed if that is the consensus.
> > 
> > When mmap() is called with MAP_SHARED_PT flag, a new host mm struct
> > is created to hold the shared page tables. Host mm struct is not
> > attached to a process. Start and size of host mm are set to the
> > start and size of the mmap region and a VMA covering this range is
> > also added to host mm struct. Existing page table entries from the
> > process that creates the mapping are copied over to the host mm
> > struct. All processes mapping this shared region are considered
> > guest processes. When a guest process mmap's the shared region, a vm
> > flag VM_SHARED_PT is added to the VMAs in guest process. Upon a page
> > fault, VMA is checked for the presence of VM_SHARED_PT flag. If the
> > flag is found, its corresponding PMD is updated with the PMD from
> > host mm struct so the PMD will point to the page tables in host mm
> > struct. vm_mm pointer of the VMA is also updated to point to host mm
> > struct for the duration of fault handling to ensure fault handling
> > happens in the context of host mm struct. When a new PTE is
> > created, it is created in the host mm struct page tables and the PMD
> > in guest mm points to the same PTEs.
> > 
> > This is a basic working implementation. It will need to go through
> > more testing and refinements. Some notes and questions:
> > 
> > - PMD size alignment and size requirement is currently hard coded
> >    in. Is there a need or desire to make this more flexible and work
> >    with other alignments/sizes? PMD size allows for adapting this
> >    infrastructure to form the basis for hugetlbfs page table sharing
> >    as well. More work will be needed to make that happen.
> > 
> > - Is there a reason to allow a userspace app to query this size and
> >    alignment requirement for MAP_SHARED_PT in some way?
> > 
> > - Shared PTEs means mprotect() call made by one process affects all
> >    processes sharing the same mapping and that behavior will need to
> >    be documented clearly. Effect of mprotect call being different for
> >    processes using shared page tables is the primary reason to
> >    require an explicit opt-in from userspace processes to share page
> >    tables. With a transparent sharing derived from MAP_SHARED alone,
> >    changed effect of mprotect can break significant number of
> >    userspace apps. One could work around that by unsharing whenever
> >    mprotect changes modes on shared mapping but that introduces
> >    complexity and the capability to execute a single mprotect to
> >    change modes across 1000's of processes sharing a mapped database
> >    is a feature explicitly asked for by database folks. This
> >    capability has significant performance advantage when compared to
> >    mechanism of sending messages to every process using shared
> >    mapping to call mprotect and change modes in each process, or
> >    using traps on permissions mismatch in each process.
> > 
> > - This implementation does not allow unmapping page table shared
> >    mappings partially. Should that be supported in future?
> > 
> > Some concerns in this RFC:
> > 
> > - When page tables for a process are freed upon process exit,
> >    pmd_free_tlb() gets called at one point to free all PMDs allocated
> >    by the process. For a shared page table, shared PMDs can not be
> >    released when a guest process exits. These shared PMDs are
> >    released when host mm struct is released upon end of last
> >    reference to page table shared region hosted by this mm. For now
> >    to stop PMDs being released, this RFC introduces following change
> >    in mm/memory.c which works but does not feel like the right
> >    approach. Any suggestions for a better long term approach will be
> >    very appreciated:
> > 
> > @@ -210,13 +221,19 @@ static inline void free_pmd_range(struct mmu_gather *tlb,
> > pud_t *pud,
> > 
> >          pmd = pmd_offset(pud, start);
> >          pud_clear(pud);
> > -       pmd_free_tlb(tlb, pmd, start);
> > -       mm_dec_nr_pmds(tlb->mm);
> > +       if (shared_pte) {
> > +               tlb_flush_pud_range(tlb, start, PAGE_SIZE);
> > +               tlb->freed_tables = 1;
> > +       } else {
> > +               pmd_free_tlb(tlb, pmd, start);
> > +               mm_dec_nr_pmds(tlb->mm);
> > +       }
> >   }
> > 
> >   static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
> > 
> > - This implementation requires an additional VM flag. Since all lower
> >    32 bits are currently in use, the new VM flag must come from upper
> >    32 bits which restricts this feature to 64-bit processors.
> > 
> > - This feature is implemented for file mappings only. Is there a
> >    need to support it for anonymous memory as well?
> > 
> > - Accounting for MAP_SHARED_PT mapped filepages in a process and
> >    pagetable bytes is not quite accurate yet in this RFC and will be
> >    fixed in the non-RFC version of patches.
> > 
> > I appreciate any feedback on these patches and ideas for
> > improvements before moving these patches out of RFC stage.
> > 
> > 
> > Changes from RFC v1:
> > - Broken the patches up into smaller patches
> > - Fixed a few bugs related to freeing PTEs and PMDs incorrectly
> > - Cleaned up the code a bit
> > 
> > 
> > Khalid Aziz (4):
> >    mm/ptshare: Add vm flag for shared PTE
> >    mm/ptshare: Add flag MAP_SHARED_PT to mmap()
> >    mm/ptshare: Create new mm struct for page table sharing
> >    mm/ptshare: Add page fault handling for page table shared regions
> > 
> >   include/linux/fs.h                     |   2 +
> >   include/linux/mm.h                     |   8 +
> >   include/trace/events/mmflags.h         |   3 +-
> >   include/uapi/asm-generic/mman-common.h |   1 +
> >   mm/Makefile                            |   2 +-
> >   mm/internal.h                          |  21 ++
> >   mm/memory.c                            | 105 ++++++++--
> >   mm/mmap.c                              |  88 +++++++++
> >   mm/ptshare.c                           | 263 +++++++++++++++++++++++++
> >   9 files changed, 476 insertions(+), 17 deletions(-)
> >   create mode 100644 mm/ptshare.c
> > 
