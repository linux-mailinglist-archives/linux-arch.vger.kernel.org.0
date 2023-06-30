Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88900743AD5
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jun 2023 13:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjF3L3k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jun 2023 07:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjF3L3j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2023 07:29:39 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EFFC0;
        Fri, 30 Jun 2023 04:29:37 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VmIQKDt_1688124573;
Received: from 30.240.105.188(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0VmIQKDt_1688124573)
          by smtp.aliyun-inc.com;
          Fri, 30 Jun 2023 19:29:34 +0800
Message-ID: <e43c47c9-2bf7-b34d-0d30-83902543ae32@linux.alibaba.com>
Date:   Fri, 30 Jun 2023 19:29:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH RFC v2 0/4] Add support for sharing page tables across
 processes (Previously mshare)
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <cover.1682453344.git.khalid.aziz@oracle.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <cover.1682453344.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Khalid

I see this patch has send out in April, and wanna to ask about the 
status of this RFC now (IMHO, it seems that the code has some places to 
fix/do). This feature is useful to save much memory on pgtables, so we 
also want to use this optimization in our databases if upstream accept that.

BTW, in the past few weeks, I made some adjustments to simplify and meet 
with our databases base on your code, e.g. multi-vmas share same shadow 
mm, madvise, and memory compaction. if you are interested, I can provide 
a detailed codes.


Thanks,

-wrw

On 2023/4/27 00:49, Khalid Aziz wrote:
> Memory pages shared between processes require a page table entry
> (PTE) for each process. Each of these PTE consumes some of the
> memory and as long as number of mappings being maintained is small
> enough, this space consumed by page tables is not objectionable.
> When very few memory pages are shared between processes, the number
> of page table entries (PTEs) to maintain is mostly constrained by
> the number of pages of memory on the system.  As the number of
> shared pages and the number of times pages are shared goes up,
> amount of memory consumed by page tables starts to become
> significant. This issue does not apply to threads. Any number of
> threads can share the same pages inside a process while sharing the
> same PTEs. Extending this same model to sharing pages across
> processes can eliminate this issue for sharing across processes as
> well.
>
> Some of the field deployments commonly see memory pages shared
> across 1000s of processes. On x86_64, each page requires a PTE that
> is only 8 bytes long which is very small compared to the 4K page
> size. When 2000 processes map the same page in their address space,
> each one of them requires 8 bytes for its PTE and together that adds
> up to 8K of memory just to hold the PTEs for one 4K page. On a
> database server with 300GB SGA, a system crash was seen with
> out-of-memory condition when 1500+ clients tried to share this SGA
> even though the system had 512GB of memory. On this server, in the
> worst case scenario of all 1500 processes mapping every page from
> SGA would have required 878GB+ for just the PTEs. If these PTEs
> could be shared, amount of memory saved is very significant.
>
> This patch series adds a new flag to mmap() call - MAP_SHARED_PT.
> This flag can be specified along with MAP_SHARED by a process to
> hint to kernel that it wishes to share page table entries for this
> file mapping mmap region with other processes. Any other process
> that mmaps the same file with MAP_SHARED_PT flag can then share the
> same page table entries. Besides specifying MAP_SHARED_PT flag, the
> processes must map the files at a PMD aligned address with a size
> that is a multiple of PMD size and at the same virtual addresses.
> This last requirement of same virtual addresses can possibly be
> relaxed if that is the consensus.
>
> When mmap() is called with MAP_SHARED_PT flag, a new host mm struct
> is created to hold the shared page tables. Host mm struct is not
> attached to a process. Start and size of host mm are set to the
> start and size of the mmap region and a VMA covering this range is
> also added to host mm struct. Existing page table entries from the
> process that creates the mapping are copied over to the host mm
> struct. All processes mapping this shared region are considered
> guest processes. When a guest process mmap's the shared region, a vm
> flag VM_SHARED_PT is added to the VMAs in guest process. Upon a page
> fault, VMA is checked for the presence of VM_SHARED_PT flag. If the
> flag is found, its corresponding PMD is updated with the PMD from
> host mm struct so the PMD will point to the page tables in host mm
> struct. vm_mm pointer of the VMA is also updated to point to host mm
> struct for the duration of fault handling to ensure fault handling
> happens in the context of host mm struct. When a new PTE is
> created, it is created in the host mm struct page tables and the PMD
> in guest mm points to the same PTEs.
>
> This is a basic working implementation. It will need to go through
> more testing and refinements. Some notes and questions:
>
> - PMD size alignment and size requirement is currently hard coded
>    in. Is there a need or desire to make this more flexible and work
>    with other alignments/sizes? PMD size allows for adapting this
>    infrastructure to form the basis for hugetlbfs page table sharing
>    as well. More work will be needed to make that happen.
>
> - Is there a reason to allow a userspace app to query this size and
>    alignment requirement for MAP_SHARED_PT in some way?
>
> - Shared PTEs means mprotect() call made by one process affects all
>    processes sharing the same mapping and that behavior will need to
>    be documented clearly. Effect of mprotect call being different for
>    processes using shared page tables is the primary reason to
>    require an explicit opt-in from userspace processes to share page
>    tables. With a transparent sharing derived from MAP_SHARED alone,
>    changed effect of mprotect can break significant number of
>    userspace apps. One could work around that by unsharing whenever
>    mprotect changes modes on shared mapping but that introduces
>    complexity and the capability to execute a single mprotect to
>    change modes across 1000's of processes sharing a mapped database
>    is a feature explicitly asked for by database folks. This
>    capability has significant performance advantage when compared to
>    mechanism of sending messages to every process using shared
>    mapping to call mprotect and change modes in each process, or
>    using traps on permissions mismatch in each process.
>
> - This implementation does not allow unmapping page table shared
>    mappings partially. Should that be supported in future?
>
> Some concerns in this RFC:
>
> - When page tables for a process are freed upon process exit,
>    pmd_free_tlb() gets called at one point to free all PMDs allocated
>    by the process. For a shared page table, shared PMDs can not be
>    released when a guest process exits. These shared PMDs are
>    released when host mm struct is released upon end of last
>    reference to page table shared region hosted by this mm. For now
>    to stop PMDs being released, this RFC introduces following change
>    in mm/memory.c which works but does not feel like the right
>    approach. Any suggestions for a better long term approach will be
>    very appreciated:
>
> @@ -210,13 +221,19 @@ static inline void free_pmd_range(struct mmu_gather *tlb,
> pud_t *pud,
>
>          pmd = pmd_offset(pud, start);
>          pud_clear(pud);
> -       pmd_free_tlb(tlb, pmd, start);
> -       mm_dec_nr_pmds(tlb->mm);
> +       if (shared_pte) {
> +               tlb_flush_pud_range(tlb, start, PAGE_SIZE);
> +               tlb->freed_tables = 1;
> +       } else {
> +               pmd_free_tlb(tlb, pmd, start);
> +               mm_dec_nr_pmds(tlb->mm);
> +       }
>   }
>
>   static inline void free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
>
> - This implementation requires an additional VM flag. Since all lower
>    32 bits are currently in use, the new VM flag must come from upper
>    32 bits which restricts this feature to 64-bit processors.
>
> - This feature is implemented for file mappings only. Is there a
>    need to support it for anonymous memory as well?
>
> - Accounting for MAP_SHARED_PT mapped filepages in a process and
>    pagetable bytes is not quite accurate yet in this RFC and will be
>    fixed in the non-RFC version of patches.
>
> I appreciate any feedback on these patches and ideas for
> improvements before moving these patches out of RFC stage.
>
>
> Changes from RFC v1:
> - Broken the patches up into smaller patches
> - Fixed a few bugs related to freeing PTEs and PMDs incorrectly
> - Cleaned up the code a bit
>
>
> Khalid Aziz (4):
>    mm/ptshare: Add vm flag for shared PTE
>    mm/ptshare: Add flag MAP_SHARED_PT to mmap()
>    mm/ptshare: Create new mm struct for page table sharing
>    mm/ptshare: Add page fault handling for page table shared regions
>
>   include/linux/fs.h                     |   2 +
>   include/linux/mm.h                     |   8 +
>   include/trace/events/mmflags.h         |   3 +-
>   include/uapi/asm-generic/mman-common.h |   1 +
>   mm/Makefile                            |   2 +-
>   mm/internal.h                          |  21 ++
>   mm/memory.c                            | 105 ++++++++--
>   mm/mmap.c                              |  88 +++++++++
>   mm/ptshare.c                           | 263 +++++++++++++++++++++++++
>   9 files changed, 476 insertions(+), 17 deletions(-)
>   create mode 100644 mm/ptshare.c
>
