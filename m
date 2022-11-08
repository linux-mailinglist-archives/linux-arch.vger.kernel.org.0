Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B71620F77
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 12:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233967AbiKHLtQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Nov 2022 06:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiKHLtO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Nov 2022 06:49:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB912FFF8;
        Tue,  8 Nov 2022 03:49:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D4A4B81A9A;
        Tue,  8 Nov 2022 11:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323B5C433C1;
        Tue,  8 Nov 2022 11:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667908149;
        bh=0696B0kSE64dgIUqPIU01jhuP+IbrVpbE6EZLipOlos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TWNAzCFvCJj7oTSUAc9q/N1ByzlxUQz1pgP/4zshfpKbWJ5C+6Sw42rifjVaUNyG9
         YZ8szw0A4ZzXi9zC9CVhRRgopLgLUfLdG1QpA/uHUw9EpbYyDblbNHAvLYRfZt0ORE
         YSa7+dpaILyLeoPJdRsxzHeEiKvQk/GkDO2pvF/s/RIqzWEpkCKwpQX8n7rM1p4Ob9
         nNvq/yOiiYl/tBLynGQDUodAsZzeSqNfsYgW1i5H1JvjDbDhHDAgxpzlOZA/LlL9MC
         pbgwboBiGD7uGVRsYyx3zVCJ7T1IitFDl6ZvSMqCbvdzmXso5wZag4mFeKk5KDtILY
         q8B7+E8ZWsBiQ==
Date:   Tue, 8 Nov 2022 13:48:54 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        peterz@infradead.org, hch@lst.de, rick.p.edgecombe@intel.com,
        aaron.lu@intel.com, mcgrof@kernel.org
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Message-ID: <Y2pCJpY+KALsGk60@kernel.org>
References: <20221107223921.3451913-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107223921.3451913-1-song@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

(added linux-arch list)

On Mon, Nov 07, 2022 at 02:39:16PM -0800, Song Liu wrote:
> This patchset tries to address the following issues:
> 
> 1. Direct map fragmentation
> 
> On x86, STRICT_*_RWX requires the direct map of any RO+X memory to be also
> RO+X. These set_memory_* calls cause 1GB page table entries to be split
> into 2MB and 4kB ones. This fragmentation in direct map results in bigger
> and slower page table, and pressure for both instruction and data TLB.
> 
> Our previous work in bpf_prog_pack tries to address this issue from BPF
> program side. Based on the experiments by Aaron Lu [4], bpf_prog_pack has
> greatly reduced direct map fragmentation from BPF programs.
> 
> 2. iTLB pressure from BPF program
> 
> Dynamic kernel text such as modules and BPF programs (even with current
> bpf_prog_pack) use 4kB pages on x86, when the total size of modules and
> BPF program is big, we can see visible performance drop caused by high
> iTLB miss rate.
> 
> 3. TLB shootdown for short-living BPF programs
> 
> Before bpf_prog_pack loading and unloading BPF programs requires global
> TLB shootdown. This patchset (and bpf_prog_pack) replaces it with a local
> TLB flush.
> 
> 4. Reduce memory usage by BPF programs (in some cases)
> 
> Most BPF programs and various trampolines are small, and they often
> occupies a whole page. From a random server in our fleet, 50% of the
> loaded BPF programs are less than 500 byte in size, and 75% of them are
> less than 2kB in size. Allowing these BPF programs to share 2MB pages
> would yield some memory saving for systems with many BPF programs. For
> systems with only small number of BPF programs, this patch may waste a
> little memory by allocating one 2MB page, but using only part of it.
> 
> 
> Based on our experiments [5], we measured 0.5% performance improvement
> from bpf_prog_pack. This patchset further boosts the improvement to 0.7%.
> The difference is because bpf_prog_pack uses 512x 4kB pages instead of
> 1x 2MB page, bpf_prog_pack as-is doesn't resolve #2 above.
> 
> This patchset replaces bpf_prog_pack with a better API and makes it
> available for other dynamic kernel text, such as modules, ftrace, kprobe.
> 
> 
> This set enables bpf programs and bpf dispatchers to share huge pages with
> new API:
>   execmem_alloc()
>   execmem_alloc()
>   execmem_fill()
> 
> The idea is similar to Peter's suggestion in [1].
> 
> execmem_alloc() manages a set of PMD_SIZE RO+X memory, and allocates these
> memory to its users. execmem_alloc() is used to free memory allocated by
> execmem_alloc(). execmem_fill() is used to update memory allocated by
> execmem_alloc().
> 
> Memory allocated by execmem_alloc() is RO+X, so this doesnot violate W^X.
> The caller has to update the content with text_poke like mechanism.
> Specifically, execmem_fill() is provided to update memory allocated by
> execmem_alloc(). execmem_fill() also makes sure the update stays in the
> boundary of one chunk allocated by execmem_alloc(). Please refer to patch
> 1/5 for more details of
> 
> Patch 3/5 uses these new APIs in bpf program and bpf dispatcher.
> 
> Patch 4/5 and 5/5 allows static kernel text (_stext to _etext) to share
> PMD_SIZE pages with dynamic kernel text on x86_64. This is achieved by
> allocating PMD_SIZE pages to roundup(_etext, PMD_SIZE), and then use
> _etext to roundup(_etext, PMD_SIZE) for dynamic kernel text.
> 
> [1] https://lore.kernel.org/bpf/Ys6cWUMHO8XwyYgr@hirez.programming.kicks-ass.net/
> [2] RFC v1: https://lore.kernel.org/linux-mm/20220818224218.2399791-3-song@kernel.org/T/
> [3] v1: https://lore.kernel.org/bpf/20221031222541.1773452-1-song@kernel.org/
> [4] https://lore.kernel.org/bpf/Y2ioTodn+mBXdIqp@ziqianlu-desk2/
> [5] https://lore.kernel.org/bpf/20220707223546.4124919-1-song@kernel.org/
> 
> Changes PATCH v1 => v2:
> 1. Rename the APIs as execmem_* (Christoph Hellwig)
> 2. Add more information about the motivation of this work (and follow up
>    works in for kernel modules, various trampolines, etc).
>    (Luis Chamberlain, Rick Edgecombe, Mike Rapoport, Aaron Lu)
> 3. Include expermential results from previous bpf_prog_pack and the
>    community. (Aaron Lu, Luis Chamberlain, Rick Edgecombe)
> 
> Changes RFC v2 => PATCH v1:
> 1. Add vcopy_exec(), which updates memory allocated by vmalloc_exec(). It
>    also ensures vcopy_exec() is only used to update memory from one single
>    vmalloc_exec() call. (Christoph Hellwig)
> 2. Add arch_vcopy_exec() and arch_invalidate_exec() as wrapper for the
>    text_poke() like logic.
> 3. Drop changes for kernel modules and focus on BPF side changes.
> 
> Changes RFC v1 => RFC v2:
> 1. Major rewrite of the logic of vmalloc_exec and vfree_exec. They now
>    work fine with BPF programs (patch 1, 2, 4). But module side (patch 3)
>    still need some work.
> 
> Song Liu (5):
>   vmalloc: introduce execmem_alloc, execmem_free, and execmem_fill
>   x86/alternative: support execmem_alloc() and execmem_free()
>   bpf: use execmem_alloc for bpf program and bpf dispatcher
>   vmalloc: introduce register_text_tail_vm()
>   x86: use register_text_tail_vm
> 
>  arch/x86/include/asm/pgtable_64_types.h |   1 +
>  arch/x86/kernel/alternative.c           |  12 +
>  arch/x86/mm/init_64.c                   |   4 +-
>  arch/x86/net/bpf_jit_comp.c             |  23 +-
>  include/linux/bpf.h                     |   3 -
>  include/linux/filter.h                  |   5 -
>  include/linux/vmalloc.h                 |   9 +
>  kernel/bpf/core.c                       | 180 +-----------
>  kernel/bpf/dispatcher.c                 |  11 +-
>  mm/nommu.c                              |  12 +
>  mm/vmalloc.c                            | 354 ++++++++++++++++++++++++
>  11 files changed, 412 insertions(+), 202 deletions(-)
> 
> --
> 2.30.2

-- 
Sincerely yours,
Mike.
