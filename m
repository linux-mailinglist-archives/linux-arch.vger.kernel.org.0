Return-Path: <linux-arch+bounces-5952-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 958DA946AEF
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 20:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A10C1F21CE6
	for <lists+linux-arch@lfdr.de>; Sat,  3 Aug 2024 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50F61CD29;
	Sat,  3 Aug 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="o5Y2Rmax"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D741BC40;
	Sat,  3 Aug 2024 18:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722711495; cv=none; b=nX1tcve8U7xJp2L6UF19XIufshC7F17rKLJ5MFZwKhBvHtloRMrHY533uePlGwLap6+Iq88Q3prZ0XZh7Ke3WuMAydOgj0ugFf7b8dilgIeEblPiaCm3O4aO350PUI4erCfOS5ymX079S2fU1VsPcx24qKQ81oR+GQgBkqxsqUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722711495; c=relaxed/simple;
	bh=Tpqmomamf68VJd3BX6Aa+aldBw76MPQW/c629qHRnbg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IbrSsGqOBStGIMJEps8mhKenKBf8B+hM7axxPIe76H166t8p4nL4QhbwZ42LjTqQlk0gUtF0LZatRQUt9L+FkSP1WB5smK97TLSZL41p+0UpSKXSri8jR/T2wYhe3tuluqqfZIKT+a95bhVG5V7Hst9Hf5Iv045WfuhfJdcqgSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=o5Y2Rmax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93706C116B1;
	Sat,  3 Aug 2024 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722711495;
	bh=Tpqmomamf68VJd3BX6Aa+aldBw76MPQW/c629qHRnbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o5Y2RmaxDgbz57iITn10F1azWivNnKphArt1mFz2o1k24QgUghcLPFcCl4Skc3J7n
	 2U6mfRYJicjGnJ/Lcha0tyWotwjt/73kHML1EvfQheasAaHT4z+JnEhKa6yfFin34R
	 FpUPzEcCObDFHQbrY87xJxqJmIAHp6RYNOzd/x7s=
Date: Sat, 3 Aug 2024 11:58:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Mike Rapoport <rppt@kernel.org>, <linux-kernel@vger.kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson
 <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, "Borislav Petkov"
 <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand
 <david@redhat.com>, "David S. Miller" <davem@davemloft.net>, Davidlohr
 Bueso <dave@stgolabs.net>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, Heiko Carstens <hca@linux.ibm.com>, Huacai
 Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, "John Paul Adrian Glaubitz"
 <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, Michael
 Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@dabbelt.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>,
 "Vasily Gorbik" <gor@linux.ibm.com>, Will Deacon <will@kernel.org>, Zi Yan
 <ziy@nvidia.com>, <devicetree@vger.kernel.org>,
 <linux-acpi@vger.kernel.org>, <linux-arch@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-cxl@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-mips@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-riscv@lists.infradead.org>,
 <linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <loongarch@lists.linux.dev>,
 <nvdimm@lists.linux.dev>, <sparclinux@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [PATCH v3 07/26] mm: drop CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
Message-Id: <20240803115813.809f808f1afbe9f9feaae129@linux-foundation.org>
In-Reply-To: <20240802104922.000051a0@Huawei.com>
References: <20240801060826.559858-1-rppt@kernel.org>
	<20240801060826.559858-8-rppt@kernel.org>
	<20240802104922.000051a0@Huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Aug 2024 10:49:22 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -1838,11 +1838,10 @@ void __init free_area_init(unsigned long *max_zone_pfn)
> >  
> >  		if (!node_online(nid)) {
> >  			/* Allocator not initialized yet */
> > -			pgdat = arch_alloc_nodedata(nid);
> > +			pgdat = memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);
> >  			if (!pgdat)
> >  				panic("Cannot allocate %zuB for node %d.\n",
> >  				       sizeof(*pgdat), nid);
> > -			arch_refresh_nodedata(nid, pgdat);
> 
> This allocates pgdat but never sets node_data[nid] to it
> and promptly leaks it on the line below. 
> 
> Just to sanity check this I spun up a qemu machine with no memory
> initially present on some nodes and it went boom as you'd expect.
> 
> I tested with addition of
> 			NODE_DATA(nid) = pgdat;
> and it all seems to work as expected.

Thanks, I added that.  It blew up on x86_64 allnoconfig because
node_data[] (and hence NODE_DATA()) isn't an lvalue when CONFIG_NUMA=n.

I'll put some #ifdef CONFIG_NUMAs in there for now but

a) NODE_DATA() is upper-case. Implies "constant".  Shouldn't be assigned to.

b) NODE_DATA() should be non-lvalue when CONFIG_NUMA=y also.  But no,
   we insist on implementing things in cpp instead of in C.

c) In fact assigning to anything which ends in "()" is nuts.  Please
   clean up my tempfix.

c) Mike, generally I'm wondering if there's a bunch of code here
   which isn't needed on CONFIG_NUMA=n.  Please check all of this for
   unneeded bloatiness.


