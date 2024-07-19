Return-Path: <linux-arch+bounces-5523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2D89379F7
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 17:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7680C2832B6
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2211459F6;
	Fri, 19 Jul 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlreXkvj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FD71459EA;
	Fri, 19 Jul 2024 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721403480; cv=none; b=NushCDfDpwr/UqawLpkzd5HLBhg48rf1iRMpamI9MIwPQg6zoo1WhnJM0YxhTSpPKGqo3Hu0zZSIf9/vIo0fSx+wPgsLVJS9vNJhSD+Sbc5uWnQBmrnomRdpjrmESUKbvqnVuYdHzYe1dZ/49ZoDXJXJMz6yxWquXAdxV2KQ6gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721403480; c=relaxed/simple;
	bh=tVgNxMmAQWvU1FxBOgdFor7NMUPhhxY2uJhGjcWiisk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oaqb61O4FiRH9IDNjHTi+k1+8KLFe4d/u6aFzUTigNk9vG2vYV73fluWnNq4NwWs6wo6Ms7WdfC5grAjyYgK1WBO7Jw9QAegX7C10Rd9YousA4RSTZLKOhw3FohmpeALkeD6D18LiGeOHr/7xTh/brPTxdh4XasjwuhJ9Ae+v64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlreXkvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13C5C32782;
	Fri, 19 Jul 2024 15:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721403479;
	bh=tVgNxMmAQWvU1FxBOgdFor7NMUPhhxY2uJhGjcWiisk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DlreXkvjsjdzHII3wrHEJX7xIvJtPh9sNl+PiEO4zziJHXT5L7qnqPt0W8Df87Z3f
	 68krH52A7kA5g1aa2XJv0roBndIEDg+cY8XsA+iWOIUm0CIjdZSUm1/AIR5wTZqSFF
	 ZPu7x311PvUpqpHwS7LKafCeg27rQek1LBnjCMCamVxdVjcv8NtScBCUdOQzaiCEoR
	 BqTsYabPbb92QT7cEQlh1F4nxwrHD6TrQWmcHk+zGXys8vhSWoRgXRyJExhg3qYStE
	 9kFSfb2sX7fKVVh0sACIwo3xjKCXDs62FfEmcrj+oNSNOGhNW1e1gj4yvau1AjZlG4
	 IOqx+qPRg9jcQ==
Date: Fri, 19 Jul 2024 18:34:54 +0300
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
Message-ID: <ZpqHniqaMxj-iDfw@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
 <20240716111346.3676969-6-rppt@kernel.org>
 <220da8ed-337a-4b1e-badf-2bff1d36e6c3@redhat.com>
 <Zpi-HAb7EBxrZBtK@kernel.org>
 <96850252-a49f-4d78-a94b-a9a25e3f2bd5@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96850252-a49f-4d78-a94b-a9a25e3f2bd5@redhat.com>

On Fri, Jul 19, 2024 at 05:07:35PM +0200, David Hildenbrand wrote:
> > > > -	 * Allocate node data.  Try node-local memory and then any node.
> > > > -	 * Never allocate in DMA zone.
> > > > -	 */
> > > > -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> > > > -	if (!nd_pa) {
> > > > -		pr_err("Cannot find %zu bytes in any node (initial node: %d)\n",
> > > > -		       nd_size, nid);
> > > > -		return;
> > > > -	}
> > > > -	nd = __va(nd_pa);
> > > > -
> > > > -	/* report and initialize */
> > > > -	printk(KERN_INFO "NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
> > > > -	       nd_pa, nd_pa + nd_size - 1);
> > > > -	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
> > > > -	if (tnid != nid)
> > > > -		printk(KERN_INFO "    NODE_DATA(%d) on node %d\n", nid, tnid);
> > > > -
> > > > -	node_data[nid] = nd;
> > > > -	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> > > > -
> > > > -	node_set_online(nid);
> > > > -}
> > > > -
> > > >    /**
> > > >     * numa_cleanup_meminfo - Cleanup a numa_meminfo
> > > >     * @mi: numa_meminfo to clean up
> > > > @@ -571,6 +538,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
> > > >    			continue;
> > > >    		alloc_node_data(nid);
> > > > +		node_set_online(nid);
> > > >    	}
> > > 
> > > I can spot that we only remove a single node_set_online() call from x86.
> > > 
> > > What about all the other architectures? Will there be any change in behavior
> > > for them? Or do we simply set the nodes online later once more?
> > 
> > On x86 node_set_online() was a part of alloc_node_data() and I moved it
> > outside so it's called right after alloc_node_data(). On other
> > architectures the allocation didn't include that call, so there should be
> > no difference there.
> 
> But won't their arch code try setting the nodes online at a later stage?
> 
> And I think, some architectures only set nodes online conditionally
> (see most other node_set_online() calls).
> 
> Sorry if I'm confused here, but with now unconditional node_set_online(), won't
> we change the behavior of other architectures?

The generic alloc_node_data() does not set the node online:

+/* Allocate NODE_DATA for a node on the local memory */
+void __init alloc_node_data(int nid)
+{
+	const size_t nd_size = roundup(sizeof(pg_data_t), PAGE_SIZE);
+	u64 nd_pa;
+	void *nd;
+	int tnid;
+
+	/* Allocate node data.  Try node-local memory and then any node. */
+	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
+	if (!nd_pa)
+		panic("Cannot allocate %zu bytes for node %d data\n",
+		      nd_size, nid);
+	nd = __va(nd_pa);
+
+	/* report and initialize */
+	pr_info("NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
+		nd_pa, nd_pa + nd_size - 1);
+	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
+	if (tnid != nid)
+		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
+
+	node_data[nid] = nd;
+	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
+}

I might have missed some architecture except x86 that calls
node_set_online() in its alloc_node_data(), but the intention was to leave
that call outside the alloc and explicitly add it after the call to
alloc_node_data() if needed like in x86.

> -- 
> Cheers,
> 
> David / dhildenb
> 
> 

-- 
Sincerely yours,
Mike.

