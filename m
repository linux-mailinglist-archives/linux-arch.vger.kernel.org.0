Return-Path: <linux-arch+bounces-5541-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E329380AB
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jul 2024 12:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F351F21A2B
	for <lists+linux-arch@lfdr.de>; Sat, 20 Jul 2024 10:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4E81726;
	Sat, 20 Jul 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSOw1h0I"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7303D6D;
	Sat, 20 Jul 2024 10:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721471236; cv=none; b=KeEj6LBdcBUji8tOWwDGC+HnpcoLwETSPGyhLuPdqYqRP55ZaAfGYqtSw+eoIR38Ve69zYFI5gdBjORrU/dQYRLJSnc06sruVKMQUmmnPzeyzx9xfKmSIcxwEs1AEwp+WdFNEYleTIoRAlmwgTG8vrAK7N3C6nLbuebrcGuLG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721471236; c=relaxed/simple;
	bh=dVNVV+LbgZSpehO8np8DsTOCzJGiWq4UJOrsJg2zgCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7UJT3+YJHRBadBmJcGbxPtXBzDYKUZD0uSg9G+yQ4XUkqpsn9zZu5yFW/vnDdSefb+djQqsjadkrbfV5ZgFajA4TQQL+fouN3xDawy2Pd0kOPpRPgAfbr8noqq73LliFmJ+ZU2v31f0l4GrEFrivnGcL246VKshFSIr0YA1f18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSOw1h0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39A7C2BD10;
	Sat, 20 Jul 2024 10:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721471235;
	bh=dVNVV+LbgZSpehO8np8DsTOCzJGiWq4UJOrsJg2zgCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSOw1h0Ig/Sxo42NZVxgWqDg7PApDQPKQu7IqHtWulHzO5DZIoZUQKCkyr/Imoxko
	 Lntuo9YYc0lQcsGc+PRntWL+4q6xGqYrJQGqSwrQ2zZ1CtZ6MvlYyVAEJlaBtunrNO
	 F2DuSLx1QB9fjEK101QysRMhcJp+/gGJQsWj4+tgA87UM1Qqi7MiDFaIy33Yfgv/7x
	 VV0gk0bbejGKCDskyj6Yq3aWY4qrq3jL+EZ+nUCUWS3c3DH2vL/WRIeqbcd+hCBosA
	 QTOgUg+IY8NEEcUIVy6GfU3iS+hehOwAyUj7zAH7+pI+6MP+NYXBi6cf1MEyU9Ri4P
	 as0dGwXRHcDEg==
Date: Sat, 20 Jul 2024 13:24:06 +0300
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
Message-ID: <ZpuQRgmrp-4deiur@kernel.org>
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

I did some git archaeology and it seems that round up to full pages on x86
backdates to bootmem era when allocation granularity was PAGE_SIZE anyway.
I'm going to change that to SMP_CACHE_BYTES in v2.
 
> I assume we don't really expect a significant growth in memory consumption
> that we care about, especially because most systems with many nodes also
> have  quite some memory around.

-- 
Sincerely yours,
Mike.

