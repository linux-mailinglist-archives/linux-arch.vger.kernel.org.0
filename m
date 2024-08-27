Return-Path: <linux-arch+bounces-6654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC169604F8
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 10:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40961B22882
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 08:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A881A1990C3;
	Tue, 27 Aug 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DusVZnZ7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58188158DD0;
	Tue, 27 Aug 2024 08:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724748945; cv=none; b=bLyEsNYT8WeLcukQ5W+0k58/kim9tIPhGIssieGFgBjDgndmcdCVx+ZBvjqA2+dosRdy8ryr1CoFfr3Qb3xKHtab7WuLBYb5dgto36HhoxjfgYTAhFkXjcRKuLGnU3wrLcS1RzSy1RVxoKfUC0LtlEak2epeUdHnzCC3T84a5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724748945; c=relaxed/simple;
	bh=WLyDwKrTLwxUKO9wLuHMkEx2eqbtMQG2RDk7GrJYDXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oW+yXMNYQLA8jsdJv8q+4imlY13EYHDB43Pi/YHEqiPG0tfwost9HmHi9gToLX3rOliQ49yvvdc1sLeVJnek25rOgrvDA3/hH5iYjH1dJ+jRDb4w9I2hLG/S6S47Z+71FPe/IJmHo0mt47b7lYNGEiVVzOXnRRgo84P4UjHV6aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DusVZnZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E362BC8B7A5;
	Tue, 27 Aug 2024 08:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724748944;
	bh=WLyDwKrTLwxUKO9wLuHMkEx2eqbtMQG2RDk7GrJYDXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DusVZnZ7wV2iULh/1avLL75JPrhMhQlBqoECiJtic0bUtwgwuIxQeD5hzgO3OPkyS
	 dpl+eK1bBgzJJ35WOwwwbfdgq1YQrY2eHAEWUAKnv8OixY+PRJYPtQH9Uh4KDOOHgD
	 2/VI5iJPwBhdC5LsFDFX73FW+2wIcx/umVi6Bv43EvELDrk40xPn4mIuDGkezsnKRA
	 xbs+ZNNQqQDTYUIePAvIqd1K0l/VrmBAarQw0NUQwiKK+jAlMR+ifUUyK+I6EB0ATl
	 0IqZzSdRMeIajz+pVDlkeyPLq3GoGX7ttE4pCEa3ZuqwGkXktl0F6ooJc0ev3A8Yxa
	 2+SfAAZCXhU+Q==
Date: Tue, 27 Aug 2024 11:52:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Bruno Faccini <bfaccini@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v4 24/26] arch_numa: switch over to numa_memblks
Message-ID: <Zs2T5wkSYO9MGcab@kernel.org>
References: <MW4PR12MB72616723E1A090E315681FF6A38B2@MW4PR12MB7261.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR12MB72616723E1A090E315681FF6A38B2@MW4PR12MB7261.namprd12.prod.outlook.com>

Hi,

On Mon, Aug 26, 2024 at 06:17:22PM +0000, Bruno Faccini wrote:
> > On 7 Aug 2024, at 2:41, Mike Rapoport wrote:
> > 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Until now arch_numa was directly translating firmware NUMA information
> > to memblock.
> > 
> > Using numa_memblks as an intermediate step has a few advantages:
> > * alignment with more battle tested x86 implementation
> > * availability of NUMA emulation
> > * maintaining node information for not yet populated memory
> > 
> > Adjust a few places in numa_memblks to compile with 32-bit phys_addr_t
> > and replace current functionality related to numa_add_memblk() and
> > __node_distance() in arch_numa with the implementation based on
> > numa_memblks and add functions required by numa_emulation.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> [arm64 + CXL via
> > QEMU]
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >   drivers/base/Kconfig       |   1 +
> >   drivers/base/arch_numa.c   | 201 +++++++++++--------------------------
> >   include/asm-generic/numa.h |   6 +-
> >   mm/numa_memblks.c          |  17 ++--
> >   4 files changed, 75 insertions(+), 150 deletions(-)
> >  
> > <snip>
> > 
> > +
> > +u64 __init numa_emu_dma_end(void)
> > +{
> > +             return PFN_PHYS(memblock_start_of_DRAM() + SZ_4G);
> > +}
> > +
> 
> PFN_PHYS() translation is unnecessary here, as
> memblock_start_of_DRAM() + SZ_4G is already a
> memory size.
> 
> This should fix it:
>  
> diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
> index 8d49893c0e94..e18701676426 100644
> --- a/drivers/base/arch_numa.c
> +++ b/drivers/base/arch_numa.c
> @@ -346,7 +346,7 @@ void __init numa_emu_update_cpu_to_node(int
> *emu_nid_to_phys,
> 
> u64 __init numa_emu_dma_end(void)
> {
> -              return PFN_PHYS(memblock_start_of_DRAM() + SZ_4G);
> +             return memblock_start_of_DRAM() + SZ_4G;
> }
> 
> void debug_cpumask_set_cpu(unsigned int cpu, int node, bool enable)

Right, I've missed that. Thanks for the fix!

Andrew, can you please apply this (with fixed formatting)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 8d49893c0e94..e18701676426 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -346,7 +346,7 @@ void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
 
 u64 __init numa_emu_dma_end(void)
 {
-	return PFN_PHYS(memblock_start_of_DRAM() + SZ_4G);
+	return memblock_start_of_DRAM() + SZ_4G;
 }
 
 void debug_cpumask_set_cpu(unsigned int cpu, int node, bool enable)

-- 
Sincerely yours,
Mike.

