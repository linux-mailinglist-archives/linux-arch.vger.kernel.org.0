Return-Path: <linux-arch+bounces-5918-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B99945B8C
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 11:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5966C1C2088B
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811311DB44D;
	Fri,  2 Aug 2024 09:55:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109051C2BD;
	Fri,  2 Aug 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592535; cv=none; b=nMzyYhygBK/IeaV+xdQfjXHeNevpzN5q2n8FrW0ryEyRgGOXXFHHrZlzTTGo5RUmBSWnbxYOOvljTKtzO9hAtFtqbLIlJ2Ndhy2wuWcAYusqxQx93ZbMIibGp8uHrzHZbs8QXxR74dPzhxDcGfbFOzREjYn69f/nyuO51/SH92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592535; c=relaxed/simple;
	bh=WGch83+auWMTzDfx3QBlwfimVN5n/QF3g/w9CXRWSKc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PfRTUpc6CJf0EflZ+AyfJgIhTQvnNvXeD7Dl4OuruiS7Nw9veRcJLj4BN3i5S9/qlbkuH11C9qBJHThZoPlZeDfmA4LUiid5WgoBkOEoNsvMsVnQDjynmcVzsb/8LBPyiZQbkoIQ7iCB6f3G2WvFEHYQqViBe1ME+ehpUfke7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wb1NN08c9z6K99q;
	Fri,  2 Aug 2024 17:52:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 51A73140A86;
	Fri,  2 Aug 2024 17:55:29 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 2 Aug
 2024 10:55:28 +0100
Date: Fri, 2 Aug 2024 10:55:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mike Rapoport <rppt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "Borislav
 Petkov" <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand
	<david@redhat.com>, "David S. Miller" <davem@davemloft.net>, Davidlohr Bueso
	<dave@stgolabs.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Heiko
 Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "John Paul
 Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>, Jonathan Corbet
	<corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt
	<palmer@dabbelt.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring
	<robh@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
	<tglx@linutronix.de>, "Vasily Gorbik" <gor@linux.ibm.com>, Will Deacon
	<will@kernel.org>, Zi Yan <ziy@nvidia.com>, <devicetree@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-cxl@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-mips@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <loongarch@lists.linux.dev>,
	<nvdimm@lists.linux.dev>, <sparclinux@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v3 09/26] arch, mm: pull out allocation of NODE_DATA to
 generic code
Message-ID: <20240802105527.00005240@Huawei.com>
In-Reply-To: <20240801060826.559858-10-rppt@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
	<20240801060826.559858-10-rppt@kernel.org>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  1 Aug 2024 09:08:09 +0300
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Architectures that support NUMA duplicate the code that allocates
> NODE_DATA on the node-local memory with slight variations in reporting
> of the addresses where the memory was allocated.
> 
> Use x86 version as the basis for the generic alloc_node_data() function
> and call this function in architecture specific numa initialization.
> 
> Round up node data size to SMP_CACHE_BYTES rather than to PAGE_SIZE like
> x86 used to do since the bootmem era when allocation granularity was
> PAGE_SIZE anyway.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64

One comment unrelated to this patch set as such, just made
more obvious by it.

> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 0744a9a2944b..3c1da08304d0 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1093,27 +1093,9 @@ void __init dump_numa_cpu_topology(void)
>  static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>  {
>  	u64 spanned_pages = end_pfn - start_pfn;

Trivial, but might as well squash this local variable into the
single place it's used.

> -	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);
> -	u64 nd_pa;
> -	void *nd;
> -	int tnid;
> -
> -	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> -	if (!nd_pa)
> -		panic("Cannot allocate %zu bytes for node %d data\n",
> -		      nd_size, nid);
> -
> -	nd = __va(nd_pa);
> -
> -	/* report and initialize */
> -	pr_info("  NODE_DATA [mem %#010Lx-%#010Lx]\n",
> -		nd_pa, nd_pa + nd_size - 1);
> -	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
> -	if (tnid != nid)
> -		pr_info("    NODE_DATA(%d) on node %d\n", nid, tnid);
> -
> -	node_data[nid] = nd;
> -	memset(NODE_DATA(nid), 0, sizeof(pg_data_t));
> +
> +	alloc_node_data(nid);
> +
>  	NODE_DATA(nid)->node_id = nid;
>  	NODE_DATA(nid)->node_start_pfn = start_pfn;
>  	NODE_DATA(nid)->node_spanned_pages = spanned_pages;

