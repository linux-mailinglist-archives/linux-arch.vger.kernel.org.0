Return-Path: <linux-arch+bounces-5991-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD781948021
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 19:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A442870D0
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 17:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9730C15D5BE;
	Mon,  5 Aug 2024 17:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7q/lW63"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD9D2C684;
	Mon,  5 Aug 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722878260; cv=none; b=I5czU5lgfJeItm1sdUPEHk75g5NILwgvGeBs60LyJCZLdAADTti/MwXJ6+fWAAv3MT9gM3NfJ8i+p0ydzC4FNuQi45dZeoIFtSipbsXmFg5PVW75IW7QVywsUYJR5g7z7rhsoehrg6HrXaj7tM3gwEnipYWCz6OK5iYkhd3V2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722878260; c=relaxed/simple;
	bh=xUiHKiiFB+eGRf4/0vdH6U+v/YkOQHoLKaT521lWFxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6fonsPxPoEW1w3NbypP1JGml4NY44fBfEzA9w4WOi9HJwnHAx6jpjf1iA/8hXIiLeH7vDZv0y3LkVBAJqYIuCNFQQs9dxVfYEWfrpLJHCg0D1svymfbkT1DgVSsGqMwI8lSqP64kU4tcMbR3TZAe0+PNtJenJzLXSF3sEQT53A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7q/lW63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A951C32782;
	Mon,  5 Aug 2024 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722878259;
	bh=xUiHKiiFB+eGRf4/0vdH6U+v/YkOQHoLKaT521lWFxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7q/lW639aowtINXwVebTG+OLoxrXof+zBNSeR/8WY86B+624ZIuqcPJ12uz6WAq3
	 TOktvjQuFO3Psh/zSZk6bupzno8UjNgzGdjWYsGzuDHPa53tI5UwJrFUIiEWAMkla2
	 aZhopzXWwqHlnm+KETHsoZ8cxcOCV/ES/RMeaNClV0U/lI74zaSa7QLz8oGGmPM5b+
	 WVRXAQQqToAOAcGGygHFeY2KPxgU/pB39IDAe0i7d4FyqehFfReXcy3JQ8TWWNvwl/
	 YnEvZ6i15oUR+XxxozKV+u9zlrKVedpz+W1ReJtnBjYdPuNzzekfqSWqwV+cKpPHX5
	 XzWc8YkjVKQSQ==
Date: Mon, 5 Aug 2024 20:15:22 +0300
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
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 09/26] arch, mm: pull out allocation of NODE_DATA to
 generic code
Message-ID: <ZrEIqogZ4UJJY0c2@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
 <20240801060826.559858-10-rppt@kernel.org>
 <20240802105527.00005240@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802105527.00005240@Huawei.com>

On Fri, Aug 02, 2024 at 10:55:27AM +0100, Jonathan Cameron wrote:
> On Thu,  1 Aug 2024 09:08:09 +0300
> Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Architectures that support NUMA duplicate the code that allocates
> > NODE_DATA on the node-local memory with slight variations in reporting
> > of the addresses where the memory was allocated.
> > 
> > Use x86 version as the basis for the generic alloc_node_data() function
> > and call this function in architecture specific numa initialization.
> > 
> > Round up node data size to SMP_CACHE_BYTES rather than to PAGE_SIZE like
> > x86 used to do since the bootmem era when allocation granularity was
> > PAGE_SIZE anyway.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
> 
> One comment unrelated to this patch set as such, just made
> more obvious by it.
> 
> > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > index 0744a9a2944b..3c1da08304d0 100644
> > --- a/arch/powerpc/mm/numa.c
> > +++ b/arch/powerpc/mm/numa.c
> > @@ -1093,27 +1093,9 @@ void __init dump_numa_cpu_topology(void)
> >  static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
> >  {
> >  	u64 spanned_pages = end_pfn - start_pfn;
> 
> Trivial, but might as well squash this local variable into the
> single place it's used.
 

> > -	const size_t nd_size = roundup(sizeof(pg_data_t), SMP_CACHE_BYTES);

...

> > +
> > +	alloc_node_data(nid);
> > +
> >  	NODE_DATA(nid)->node_id = nid;
> >  	NODE_DATA(nid)->node_start_pfn = start_pfn;
> >  	NODE_DATA(nid)->node_spanned_pages = spanned_pages;

These are actually overridden later in free_area_init(), it would make
sense to audit all arch-specific node setup functions and clean them up a
bit.

-- 
Sincerely yours,
Mike.

