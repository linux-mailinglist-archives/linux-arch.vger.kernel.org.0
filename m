Return-Path: <linux-arch+bounces-5490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44134934888
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 09:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6822F1C21A6C
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 07:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D974E26;
	Thu, 18 Jul 2024 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUgbLYcY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630874058;
	Thu, 18 Jul 2024 07:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286358; cv=none; b=FvHe2v8sP6Y/Tl7c2rJt90rBErMZ+mXSfrMbxrfNTfGQV1fsFzXfXXXJaP3vFIYa6w2FZjRZd47DmWfkdFbeNXG0/ytz/WaoBtdNRzizB4V2cTHiFwyay8K9XZjzgXEGFKsIW1AmHfmtg+4puiGwE2MG8YQ3NwCg4ILx9jN9fTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286358; c=relaxed/simple;
	bh=whHsob4RS5v2GdrWHkkMKcRLrbELb7YOdJDyppVzr6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K23DeYFKovNpaD5mEMyu/CsQUGz3nTVXnlCQvS8EUZzVdlp278HW17owub9cJmIOtaMXi7A6evYrKaleGaz3EkTPXXC9DGVa4wq4EHJppAbw7nFhvfjwG3GXqZ1AFPUFnSxLKe1V3aFKGWDJbKyy/7FJON9I9HWzVQk28RJQ26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUgbLYcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD529C116B1;
	Thu, 18 Jul 2024 07:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721286357;
	bh=whHsob4RS5v2GdrWHkkMKcRLrbELb7YOdJDyppVzr6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUgbLYcYkFi+yM5DNGWYkc6mZnNnUffrZs2ftic6RoJlQJ7E8d8XWB5uF1VxaloMN
	 2pI7IBqElMjV0qmk4el5sVZlUVx1UwdD/P/sQY2CWDd738D2psQymoIvRySGsgmXuk
	 ZUck602iq5YkHci1Vyu9rFtlsvRJpdSEkMm+v+2VIQWc/AzrdgqrSUiCL4vEDXKVee
	 8A9PZCK5pqB7fQmK9zQfZYL2C8lRMzESmGfyxSOLFBGVMQZpNwRh+NK+wlWHkdZfdM
	 jaUarx/bIXxsaGX38yt2XwW4s4VTuawsNrk9K8J+JTbrZLoL9aVyqQB8FzZnTP9IQn
	 +gP4pgv5FiIEw==
Date: Thu, 18 Jul 2024 10:02:52 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
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
Subject: Re: [PATCH 05/17] arch, mm: pull out allocation of NODE_DATA to
 generic code
Message-ID: <Zpi-HAb7EBxrZBtK@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-6-rppt@kernel.org>
 <220da8ed-337a-4b1e-badf-2bff1d36e6c3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <220da8ed-337a-4b1e-badf-2bff1d36e6c3@redhat.com>

On Wed, Jul 17, 2024 at 04:42:48PM +0200, David Hildenbrand wrote:
> On 16.07.24 13:13, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Architectures that support NUMA duplicate the code that allocates
> > NODE_DATA on the node-local memory with slight variations in reporting
> > of the addresses where the memory was allocated.
> > 
> > Use x86 version as the basis for the generic alloc_node_data() function
> > and call this function in architecture specific numa initialization.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> 
> [...]
> 
> > diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> > index 9208eaadf690..909f6cec3a26 100644
> > --- a/arch/mips/loongson64/numa.c
> > +++ b/arch/mips/loongson64/numa.c
> > @@ -81,12 +81,8 @@ static void __init init_topology_matrix(void)
> >   static void __init node_mem_init(unsigned int node)
> >   {
> > -	struct pglist_data *nd;
> >   	unsigned long node_addrspace_offset;
> >   	unsigned long start_pfn, end_pfn;
> > -	unsigned long nd_pa;
> > -	int tnid;
> > -	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
> 
> One interesting change is that we now always round up to full pages on
> architectures where we previously rounded up to SMP_CACHE_BYTES.

On my workstation struct pglist_data take 174400, cachelines: 2725, members: 43 */
 
> I assume we don't really expect a significant growth in memory consumption
> that we care about, especially because most systems with many nodes also
> have  quite some memory around.

With Debian kernel configuration for 6.5 struct pglist data takes 174400
bytes so the increase here is below 1%.

For NUMA systems with a lot of nodes that shouldn't be a problem.

> > -/* Allocate NODE_DATA for a node on the local memory */
> > -static void __init alloc_node_data(int nid)
> > -{
> > -	const size_t nd_size = roundup(sizeof(pg_data_t), PAGE_SIZE);
> > -	u64 nd_pa;
> > -	void *nd;
> > -	int tnid;
> > -
> > -	/*
> > -	 * Allocate node data.  Try node-local memory and then any node.
> > -	 * Never allocate in DMA zone.
> > -	 */
> > -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> > -	if (!nd_pa) {
> > -		pr_err("Cannot find %zu bytes in any node (initial node: %d)\n",
> > -		       nd_size, nid);
> > -		return;
> > -	}
> > -	nd = __va(nd_pa);
> > -
> > -	/* report and initialize */
> > -	printk(KERN_INFO "NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
> > -	       nd_pa, nd_pa + nd_size - 1);
> > -	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
> > -	if (tnid != nid)
> > -		printk(KERN_INFO "    NODE_DATA(%d) on node %d\n", nid, tnid);
> > -
> > -	node_data[nid] = nd;
> > -	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> > -
> > -	node_set_online(nid);
> > -}
> > -
> >   /**
> >    * numa_cleanup_meminfo - Cleanup a numa_meminfo
> >    * @mi: numa_meminfo to clean up
> > @@ -571,6 +538,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
> >   			continue;
> >   		alloc_node_data(nid);
> > +		node_set_online(nid);
> >   	}
> 
> I can spot that we only remove a single node_set_online() call from x86.
> 
> What about all the other architectures? Will there be any change in behavior
> for them? Or do we simply set the nodes online later once more?

On x86 node_set_online() was a part of alloc_node_data() and I moved it
outside so it's called right after alloc_node_data(). On other
architectures the allocation didn't include that call, so there should be
no difference there.
 
> -- 
> Cheers,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.

