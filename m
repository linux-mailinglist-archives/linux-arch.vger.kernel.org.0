Return-Path: <linux-arch+bounces-470-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B17D7FA3EE
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C342813CC
	for <lists+linux-arch@lfdr.de>; Mon, 27 Nov 2023 15:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D54E315BD;
	Mon, 27 Nov 2023 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38867AA;
	Mon, 27 Nov 2023 07:01:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CEEE2F4;
	Mon, 27 Nov 2023 07:02:01 -0800 (PST)
Received: from raptor (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 947493F6C4;
	Mon, 27 Nov 2023 07:01:08 -0800 (PST)
Date: Mon, 27 Nov 2023 15:01:05 +0000
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev,
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org,
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com, mhiramat@kernel.org,
	rppt@kernel.org, hughd@google.com, pcc@google.com,
	steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, eugenis@google.com, kcc@google.com,
	hyesoo.yu@samsung.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 12/27] arm64: mte: Add tag storage pages to the
 MIGRATE_CMA migratetype
Message-ID: <ZWSvMYMjFLFZ-abv@raptor>
References: <20231119165721.9849-1-alexandru.elisei@arm.com>
 <20231119165721.9849-13-alexandru.elisei@arm.com>
 <c49cd89d-41cf-495b-9b96-4434ab407967@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c49cd89d-41cf-495b-9b96-4434ab407967@redhat.com>

Hi David,

On Fri, Nov 24, 2023 at 08:40:55PM +0100, David Hildenbrand wrote:
> On 19.11.23 17:57, Alexandru Elisei wrote:
> > Add the MTE tag storage pages to the MIGRATE_CMA migratetype, which allows
> > the page allocator to manage them like regular pages.
> > 
> > Ths migratype lends the pages some very desirable properties:
> > 
> > * They cannot be longterm pinned, meaning they will always be migratable.
> > 
> > * The pages can be allocated explicitely by using their PFN (with
> >    alloc_contig_range()) when they are needed to store tags.
> > 
> > Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> > ---
> >   arch/arm64/Kconfig                  |  1 +
> >   arch/arm64/kernel/mte_tag_storage.c | 68 +++++++++++++++++++++++++++++
> >   include/linux/mmzone.h              |  5 +++
> >   mm/internal.h                       |  3 --
> >   4 files changed, 74 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index fe8276fdc7a8..047487046e8f 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -2065,6 +2065,7 @@ config ARM64_MTE
> >   if ARM64_MTE
> >   config ARM64_MTE_TAG_STORAGE
> >   	bool "Dynamic MTE tag storage management"
> > +	select CONFIG_CMA
> >   	help
> >   	  Adds support for dynamic management of the memory used by the hardware
> >   	  for storing MTE tags. This memory, unlike normal memory, cannot be
> > diff --git a/arch/arm64/kernel/mte_tag_storage.c b/arch/arm64/kernel/mte_tag_storage.c
> > index fa6267ef8392..427f4f1909f3 100644
> > --- a/arch/arm64/kernel/mte_tag_storage.c
> > +++ b/arch/arm64/kernel/mte_tag_storage.c
> > @@ -5,10 +5,12 @@
> >    * Copyright (C) 2023 ARM Ltd.
> >    */
> > +#include <linux/cma.h>
> >   #include <linux/memblock.h>
> >   #include <linux/mm.h>
> >   #include <linux/of_device.h>
> >   #include <linux/of_fdt.h>
> > +#include <linux/pageblock-flags.h>
> >   #include <linux/range.h>
> >   #include <linux/string.h>
> >   #include <linux/xarray.h>
> > @@ -189,6 +191,14 @@ static int __init fdt_init_tag_storage(unsigned long node, const char *uname,
> >   		return ret;
> >   	}
> > +	/* Pages are managed in pageblock_nr_pages chunks */
> > +	if (!IS_ALIGNED(tag_range->start | range_len(tag_range), pageblock_nr_pages)) {
> > +		pr_err("Tag storage region 0x%llx-0x%llx not aligned to pageblock size 0x%llx",
> > +		       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end),
> > +		       PFN_PHYS(pageblock_nr_pages));
> > +		return -EINVAL;
> > +	}
> > +
> >   	ret = tag_storage_get_memory_node(node, &mem_node);
> >   	if (ret)
> >   		return ret;
> > @@ -254,3 +264,61 @@ void __init mte_tag_storage_init(void)
> >   		pr_info("MTE tag storage region management disabled");
> >   	}
> >   }
> > +
> > +static int __init mte_tag_storage_activate_regions(void)
> > +{
> > +	phys_addr_t dram_start, dram_end;
> > +	struct range *tag_range;
> > +	unsigned long pfn;
> > +	int i, ret;
> > +
> > +	if (num_tag_regions == 0)
> > +		return 0;
> > +
> > +	dram_start = memblock_start_of_DRAM();
> > +	dram_end = memblock_end_of_DRAM();
> > +
> > +	for (i = 0; i < num_tag_regions; i++) {
> > +		tag_range = &tag_regions[i].tag_range;
> > +		/*
> > +		 * Tag storage region was clipped by arm64_bootmem_init()
> > +		 * enforcing addressing limits.
> > +		 */
> > +		if (PFN_PHYS(tag_range->start) < dram_start ||
> > +				PFN_PHYS(tag_range->end) >= dram_end) {
> > +			pr_err("Tag storage region 0x%llx-0x%llx outside addressable memory",
> > +			       PFN_PHYS(tag_range->start), PFN_PHYS(tag_range->end));
> > +			ret = -EINVAL;
> > +			goto out_disabled;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * MTE disabled, tag storage pages can be used like any other pages. The
> > +	 * only restriction is that the pages cannot be used by kexec because
> > +	 * the memory remains marked as reserved in the memblock allocator.
> > +	 */
> > +	if (!system_supports_mte()) {
> > +		for (i = 0; i< num_tag_regions; i++) {
> > +			tag_range = &tag_regions[i].tag_range;
> > +			for (pfn = tag_range->start; pfn <= tag_range->end; pfn++)
> > +				free_reserved_page(pfn_to_page(pfn));
> > +		}
> > +		ret = 0;
> > +		goto out_disabled;
> > +	}
> > +
> > +	for (i = 0; i < num_tag_regions; i++) {
> > +		tag_range = &tag_regions[i].tag_range;
> > +		for (pfn = tag_range->start; pfn <= tag_range->end; pfn += pageblock_nr_pages)
> > +			init_cma_reserved_pageblock(pfn_to_page(pfn));
> > +		totalcma_pages += range_len(tag_range);
> > +	}
> 
> You shouldn't be doing that manually in arm code. Likely you want some cma.c
> helper for something like that.

If you referring to the last loop (the one that does
ini_cma_reserved_pageblock()), indeed, there's already a function which
does that, cma_init_reserved_areas() -> cma_activate_area().

> 
> But, can you elaborate on why you took this hacky (sorry) approach as
> documented in the cover letter:

No worries, it is indeed a bit hacky :)

> 
> "The arm64 code manages this memory directly instead of using
> cma_declare_contiguous/cma_alloc for performance reasons."
> 
> What is the exact problem?

I am referring to the performance degredation that is fixed in patch #26,
"arm64: mte: Fast track reserving tag storage when the block is free" [1].
The issue is that alloc_contig_range() -> __alloc_contig_migrate_range()
calls lru_cache_disable(), which IPIs all the CPUs in the system, and that
leads to a 10-20% performance degradation on Chrome. It has been observed
that most of the time the tag storage pages are free, and the
lru_cache_disable() calls are unnecessary.

The performance degradation is almost entirely eliminated by having the code
take the tag storage page directly from the free list if it's free, instead
of calling alloc_contig_range().

Do you believe it would be better to use the cma code, and modify it to use
this fast path to take the page drectly from the buddy allocator?

I can definitely try to integrate the code with cma_alloc(), but I think
keeping the fast path for reserving tag storage is extremely desirable,
since it makes such a huge difference to performance.

[1] https://lore.kernel.org/linux-trace-kernel/20231119165721.9849-27-alexandru.elisei@arm.com/

Thanks,
Alex

> 
> -- 
> Cheers,
> 
> David / dhildenb
> 
> 

