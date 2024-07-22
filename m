Return-Path: <linux-arch+bounces-5547-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC3938AB4
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 10:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D84361C20ECB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E3E1607BB;
	Mon, 22 Jul 2024 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5Dp/726"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E7C17C6C;
	Mon, 22 Jul 2024 08:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635626; cv=none; b=iVapCy/Hga0hzfArjwSY5EM4jSdlcBTJgeH86jcYy4Z638iG+jCuv6WmV81ciezSyDhNOstunGCXpiQ4l/LS98bZ1U1m25RMsTkx2u77xwCxdEn2KOXeEBU3soj+17xHYw5W/iW0shk/KDYrNbvEsKno2HQcU9K2AIpMfKeaPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635626; c=relaxed/simple;
	bh=H9F6V5OYzjr4gKPKPFe3Wqpvyc1OTcMklndZSekeRHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xl3M1Igng35ChyGdweFJsIcutKpOhu2jytqGkhMdjB9gHZn7wKBb8kniXivgz/u0bRXaVn0RO5E42eSOWqQVpktkJQmEIykDsmLwDrakubOli4C5dFf1LXX54Mun9amn3++e9A86OBWKtkzDj3l6yP8sbXbb1YywPJMzI3ew6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5Dp/726; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D33C32782;
	Mon, 22 Jul 2024 08:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721635625;
	bh=H9F6V5OYzjr4gKPKPFe3Wqpvyc1OTcMklndZSekeRHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q5Dp/726iOiXcRsY4FjpIdOLw46JsxdnylRfDnLOAnzjGf18EfC22uDduEG/56577
	 mF9VR0M7MePJHH6qducKTMLl4+3wJJgy2MXlYIyme/Z0oGQmEBaV2fnZN8cTUTZZvp
	 e4AxGAr/yPA5Th2/BAQI9KKOEa1B0mXrWv1iZfa496Ragj+yYsX+mzlc5vma9rVTY9
	 zTTiTTmtETJN6g5cdK6hrsVEV55nEGUvysy6ROPM9ZclNIfLuk9SbEP9IB4BHpP+D6
	 6+f3Pr37n33T6UhUEbbN4W+dS5FVFyy9KfDtqZZwxaNb+ifX6zJtDsjsuk0MBnmqT3
	 FAlsWVe5OvzTA==
Date: Mon, 22 Jul 2024 11:03:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 12/17] mm: introduce numa_memblks
Message-ID: <Zp4SbYWA0LgvNvPD@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-13-rppt@kernel.org>
 <20240719191647.000072f6@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719191647.000072f6@Huawei.com>

On Fri, Jul 19, 2024 at 07:16:47PM +0100, Jonathan Cameron wrote:
> On Tue, 16 Jul 2024 14:13:41 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Move code dealing with numa_memblks from arch/x86 to mm/ and add Kconfig
> > options to let x86 select it in its Kconfig.
> > 
> > This code will be later reused by arch_numa.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Hi Mike,
> 
> My only real concern in here is there are a few places where
> the lifted code makes changes to memblocks that are x86 only today.
> I need to do some more digging to work out if those are safe
> in all cases.
> 
> Jonathan
> 
> 
> 
> > +/**
> > + * numa_cleanup_meminfo - Cleanup a numa_meminfo
> > + * @mi: numa_meminfo to clean up
> > + *
> > + * Sanitize @mi by merging and removing unnecessary memblks.  Also check for
> > + * conflicts and clear unused memblks.
> > + *
> > + * RETURNS:
> > + * 0 on success, -errno on failure.
> > + */
> > +int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
> > +{
> > +	const u64 low = 0;
> 
> Given always zero, why not just use that value inline?

Actually it seems to me that it should be memblock_start_of_DRAM().

The blocks outside system memory are moved to numa_reserved_meminfo, so
AFAIU on arm64/riscv such blocks can be below the RAM.
 
> > +	const u64 high = PFN_PHYS(max_pfn);
> > +	int i, j, k;
> > +
> > +	/* first, trim all entries */
> > +	for (i = 0; i < mi->nr_blks; i++) {
> > +		struct numa_memblk *bi = &mi->blk[i];
> > +
> > +		/* move / save reserved memory ranges */
> > +		if (!memblock_overlaps_region(&memblock.memory,
> > +					bi->start, bi->end - bi->start)) {
> > +			numa_move_tail_memblk(&numa_reserved_meminfo, i--, mi);
> > +			continue;
> > +		}
> > +
> > +		/* make sure all non-reserved blocks are inside the limits */
> > +		bi->start = max(bi->start, low);
> > +
> > +		/* preserve info for non-RAM areas above 'max_pfn': */
> > +		if (bi->end > high) {
> > +			numa_add_memblk_to(bi->nid, high, bi->end,
> > +					   &numa_reserved_meminfo);
> > +			bi->end = high;
> > +		}
> > +
> > +		/* and there's no empty block */
> > +		if (bi->start >= bi->end)
> > +			numa_remove_memblk_from(i--, mi);
> > +	}
> > +
> > +	/* merge neighboring / overlapping entries */
> > +	for (i = 0; i < mi->nr_blks; i++) {
> > +		struct numa_memblk *bi = &mi->blk[i];
> > +
> > +		for (j = i + 1; j < mi->nr_blks; j++) {
> > +			struct numa_memblk *bj = &mi->blk[j];
> > +			u64 start, end;
> > +
> > +			/*
> > +			 * See whether there are overlapping blocks.  Whine
> > +			 * about but allow overlaps of the same nid.  They
> > +			 * will be merged below.
> > +			 */
> > +			if (bi->end > bj->start && bi->start < bj->end) {
> > +				if (bi->nid != bj->nid) {
> > +					pr_err("node %d [mem %#010Lx-%#010Lx] overlaps with node %d [mem %#010Lx-%#010Lx]\n",
> > +					       bi->nid, bi->start, bi->end - 1,
> > +					       bj->nid, bj->start, bj->end - 1);
> > +					return -EINVAL;
> > +				}
> > +				pr_warn("Warning: node %d [mem %#010Lx-%#010Lx] overlaps with itself [mem %#010Lx-%#010Lx]\n",
> > +					bi->nid, bi->start, bi->end - 1,
> > +					bj->start, bj->end - 1);
> > +			}
> > +
> > +			/*
> > +			 * Join together blocks on the same node, holes
> > +			 * between which don't overlap with memory on other
> > +			 * nodes.
> > +			 */
> > +			if (bi->nid != bj->nid)
> > +				continue;
> > +			start = min(bi->start, bj->start);
> > +			end = max(bi->end, bj->end);
> > +			for (k = 0; k < mi->nr_blks; k++) {
> > +				struct numa_memblk *bk = &mi->blk[k];
> > +
> > +				if (bi->nid == bk->nid)
> > +					continue;
> > +				if (start < bk->end && end > bk->start)
> > +					break;
> > +			}
> > +			if (k < mi->nr_blks)
> > +				continue;
> > +			pr_info("NUMA: Node %d [mem %#010Lx-%#010Lx] + [mem %#010Lx-%#010Lx] -> [mem %#010Lx-%#010Lx]\n",
> > +			       bi->nid, bi->start, bi->end - 1, bj->start,
> > +			       bj->end - 1, start, end - 1);
> > +			bi->start = start;
> > +			bi->end = end;
> > +			numa_remove_memblk_from(j--, mi);
> > +		}
> > +	}
> > +
> > +	/* clear unused ones */
> > +	for (i = mi->nr_blks; i < ARRAY_SIZE(mi->blk); i++) {
> > +		mi->blk[i].start = mi->blk[i].end = 0;
> > +		mi->blk[i].nid = NUMA_NO_NODE;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> 
> > +/*
> > + * Mark all currently memblock-reserved physical memory (which covers the
> > + * kernel's own memory ranges) as hot-unswappable.
> > + */
> > +static void __init numa_clear_kernel_node_hotplug(void)
> 
> This will be a change for non x86 architectures.  'should' be fine
> but I'm not 100% sure.

This function sets nid to memblock.reserved which does not change anything
except the dump in debugfs and then uses the node info in memblock.reserve
to clear MEMBLOCK_HOTPLUG from the regions in memblock.memory that contain
the reserved memory because they cannot be hot(un)plugged anyway.
 
> > +{
> > +	nodemask_t reserved_nodemask = NODE_MASK_NONE;
> > +	struct memblock_region *mb_region;
> > +	int i;
> > +
> > +	/*
> > +	 * We have to do some preprocessing of memblock regions, to
> > +	 * make them suitable for reservation.
> > +	 *
> > +	 * At this time, all memory regions reserved by memblock are
> > +	 * used by the kernel, but those regions are not split up
> > +	 * along node boundaries yet, and don't necessarily have their
> > +	 * node ID set yet either.
> > +	 *
> > +	 * So iterate over all memory known to the x86 architecture,
> 
> Comment needs an update at least given not x86 specific any more.

Sure, will fix.
 
> > +	 * and use those ranges to set the nid in memblock.reserved.
> > +	 * This will split up the memblock regions along node
> > +	 * boundaries and will set the node IDs as well.
> > +	 */
> > +	for (i = 0; i < numa_meminfo.nr_blks; i++) {
> > +		struct numa_memblk *mb = numa_meminfo.blk + i;
> > +		int ret;
> > +
> > +		ret = memblock_set_node(mb->start, mb->end - mb->start,
> > +					&memblock.reserved, mb->nid);
> > +		WARN_ON_ONCE(ret);
> > +	}
> > +
> > +	/*
> > +	 * Now go over all reserved memblock regions, to construct a
> > +	 * node mask of all kernel reserved memory areas.
> > +	 *
> > +	 * [ Note, when booting with mem=nn[kMG] or in a kdump kernel,
> > +	 *   numa_meminfo might not include all memblock.reserved
> > +	 *   memory ranges, because quirks such as trim_snb_memory()
> > +	 *   reserve specific pages for Sandy Bridge graphics. ]
> > +	 */
> > +	for_each_reserved_mem_region(mb_region) {
> > +		int nid = memblock_get_region_node(mb_region);
> > +
> > +		if (nid != MAX_NUMNODES)
> > +			node_set(nid, reserved_nodemask);
> > +	}
> > +
> > +	/*
> > +	 * Finally, clear the MEMBLOCK_HOTPLUG flag for all memory
> > +	 * belonging to the reserved node mask.
> > +	 *
> > +	 * Note that this will include memory regions that reside
> > +	 * on nodes that contain kernel memory - entire nodes
> > +	 * become hot-unpluggable:
> > +	 */
> > +	for (i = 0; i < numa_meminfo.nr_blks; i++) {
> > +		struct numa_memblk *mb = numa_meminfo.blk + i;
> > +
> > +		if (!node_isset(mb->nid, reserved_nodemask))
> > +			continue;
> > +
> > +		memblock_clear_hotplug(mb->start, mb->end - mb->start);
> > +	}
> > +}
> 

-- 
Sincerely yours,
Mike.

