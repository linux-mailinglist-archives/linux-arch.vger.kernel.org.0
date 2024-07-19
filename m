Return-Path: <linux-arch+bounces-5526-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C627D937A2E
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 17:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86A9A282C3B
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jul 2024 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480BD145B0C;
	Fri, 19 Jul 2024 15:51:52 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83141B86D5;
	Fri, 19 Jul 2024 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721404312; cv=none; b=NlkCBFxFr+WW6RMCXTdwnq/O4AxgjJHp5B2n4jGGLHQxxg/ptC+d1nI4LbYSKrwefaOWA2rgjuhtowlufWT6z1dIvop1U4AMh6j5oV1D5eALpJ8tWMaFg/NZd0eqNa/22oUHIUyKa7kmPS8kcAdFxLkvqI1fZtNIiLyZvahCsYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721404312; c=relaxed/simple;
	bh=AlQm9yZ2sFI01jHgI7WArkoI84hOnV0JYdzW/8DBq5k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L21f8rchkOuk+7SDWprPMSywKoyI+itAYQYjkZwLSmFozI7XUzJ6K7vnMFuq7H6Q0oSi07KjrfrL1Z6vx84tYadluAoD/eXf8vLis80DPF+Q4D7VvG6VmMQMu/fyf5JSP8PAxX4wWGVilikR52SmWSdud3/HFNDf6gevr7GWgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WQYyl1P08z6J67T;
	Fri, 19 Jul 2024 23:49:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BC470140517;
	Fri, 19 Jul 2024 23:51:45 +0800 (CST)
Received: from localhost (10.48.157.16) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 19 Jul
 2024 16:51:44 +0100
Date: Fri, 19 Jul 2024 16:51:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Hildenbrand <david@redhat.com>
CC: Mike Rapoport <rppt@kernel.org>, <linux-kernel@vger.kernel.org>,
	"Alexander Gordeev" <agordeev@linux.ibm.com>, Andreas Larsson
	<andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd
 Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens
	<hca@linux.ibm.com>, "Huacai Chen" <chenhuacai@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Ellerman
	<mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, "Vasily Gorbik" <gor@linux.ibm.com>, Will Deacon
	<will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<loongarch@lists.linux.dev>, <linux-mips@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<sparclinux@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-mm@kvack.org>, <x86@kernel.org>
Subject: Re: [PATCH 05/17] arch, mm: pull out allocation of NODE_DATA to
 generic code
Message-ID: <20240719165143.0000002e@Huawei.com>
In-Reply-To: <96850252-a49f-4d78-a94b-a9a25e3f2bd5@redhat.com>
References: <20240716111346.3676969-1-rppt@kernel.org>
	<20240716111346.3676969-6-rppt@kernel.org>
	<220da8ed-337a-4b1e-badf-2bff1d36e6c3@redhat.com>
	<Zpi-HAb7EBxrZBtK@kernel.org>
	<96850252-a49f-4d78-a94b-a9a25e3f2bd5@redhat.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 19 Jul 2024 17:07:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> >>> -	 * Allocate node data.  Try node-local memory and then any node.
> >>> -	 * Never allocate in DMA zone.
> >>> -	 */
> >>> -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> >>> -	if (!nd_pa) {
> >>> -		pr_err("Cannot find %zu bytes in any node (initial node: %d)\n",
> >>> -		       nd_size, nid);
> >>> -		return;
> >>> -	}
> >>> -	nd = __va(nd_pa);
> >>> -
> >>> -	/* report and initialize */
> >>> -	printk(KERN_INFO "NODE_DATA(%d) allocated [mem %#010Lx-%#010Lx]\n", nid,
> >>> -	       nd_pa, nd_pa + nd_size - 1);
> >>> -	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
> >>> -	if (tnid != nid)
> >>> -		printk(KERN_INFO "    NODE_DATA(%d) on node %d\n", nid, tnid);
> >>> -
> >>> -	node_data[nid] = nd;
> >>> -	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> >>> -
> >>> -	node_set_online(nid);
> >>> -}
> >>> -
> >>>    /**
> >>>     * numa_cleanup_meminfo - Cleanup a numa_meminfo
> >>>     * @mi: numa_meminfo to clean up
> >>> @@ -571,6 +538,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
> >>>    			continue;
> >>>    		alloc_node_data(nid);
> >>> +		node_set_online(nid);
> >>>    	}  
> >>
> >> I can spot that we only remove a single node_set_online() call from x86.
> >>
> >> What about all the other architectures? Will there be any change in behavior
> >> for them? Or do we simply set the nodes online later once more?  
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
This is moving x86 code to x86 code, not a generic location
so how would that affect anyone else? Their onlining should be same as
before.

The node onlining difference are a pain (I recall that fun from adding
generic initiators) as different ordering on x86 and arm64 at least.

Jonathan

> 


