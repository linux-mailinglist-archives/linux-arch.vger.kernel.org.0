Return-Path: <linux-arch+bounces-6102-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434794AF87
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 20:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4666B24296
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A994A13D52E;
	Wed,  7 Aug 2024 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs+rYBQU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C5762DF;
	Wed,  7 Aug 2024 18:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723054849; cv=none; b=UzexHyj+6+DG7Cw+bCAieqBXowPBKTUN3YqiCgcA+K7qS874GrFGccgp0Exc5VvwMbhStHR/zEPbPxwLVku0fRIaM6p8F7GfUix39ehMXHF6RpL7gT4+cCzOSkVUaUfzU96tT2Dfn3dmT8GQyccA3gWSVZDHXLb5yWqgZSATBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723054849; c=relaxed/simple;
	bh=iPtiZxg9mYFfVaMP/wI1h2AEAZxcZhi354BsRK7OzkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSiA9tLcvFL6wUaIhRVs5gEyH9nQ+1kiyb0Ae51o3bIv00t3YqhBcz4yr2IxdcgQUAtBnnTC0Nftc7OEqP6dexE6jsuWtJbtoQL3dlffGr5KYgSyFQfFhSfuNFdryzx2lNafJFvXxzv2cnrCwOisbgjU2UbskOMlUzi/ogevkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs+rYBQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF468C32781;
	Wed,  7 Aug 2024 18:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723054848;
	bh=iPtiZxg9mYFfVaMP/wI1h2AEAZxcZhi354BsRK7OzkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fs+rYBQUVp7T/qbPiJP5M3yDB/6MQZbtGhaQKvRjA1Mevvpi2N6URXoVm6Iu+rs/H
	 5E96EIlDL0oiovI1UalP4pGMxvee6uDYhAHWeNICYCTEurK07w5XNnYjIp7hBBtH+o
	 BuYSL8/k1GjAORViJw9J27QcUbojhI3Ae/34xWNzZpQoCHqR1I22VHBnMk5CVvZxw6
	 SS54CnDP9bArj1yivpeOI0pLAxkinjxlqbL5z/NWC2FfzasiBT9xJGfZMh2KPtgniu
	 UwqU0smfhLaXdoDIRZ0Xs8jOb5KYUUdKDjJmyRdFpd/cLCPX7dVpAIbbnapWdyqlxn
	 +oDN4u6kRqxgA==
Date: Wed, 7 Aug 2024 21:18:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
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
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 24/26] arch_numa: switch over to numa_memblks
Message-ID: <ZrO6cExVz1He_yPn@kernel.org>
References: <20240807064110.1003856-1-rppt@kernel.org>
 <20240807064110.1003856-25-rppt@kernel.org>
 <1befc540-8904-4c23-b0e6-e2c556fe22b9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1befc540-8904-4c23-b0e6-e2c556fe22b9@app.fastmail.com>

On Wed, Aug 07, 2024 at 08:58:37AM +0200, Arnd Bergmann wrote:
> On Wed, Aug 7, 2024, at 08:41, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > Until now arch_numa was directly translating firmware NUMA information
> > to memblock.
> 
> I get a link time warning from this:
> 
>     WARNING: modpost: vmlinux: section mismatch in reference: numa_set_cpumask+0x24 (section: .text.unlikely) -> early_cpu_to_node (section: .init.text)

I didn't see this neither in my build tests nor in kbuild reports :/
 
> > @@ -142,7 +144,7 @@ void __init early_map_cpu_to_node(unsigned int cpu, int nid)
> >  unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
> >  EXPORT_SYMBOL(__per_cpu_offset);
> > 
> > -int __init early_cpu_to_node(int cpu)
> > +int early_cpu_to_node(int cpu)
> >  {
> >  	return cpu_to_node_map[cpu];
> >  }
> 
> early_cpu_to_node() can no longer be __init here
> 
> > +#endif /* CONFIG_NUMA_EMU */
> > diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
> > index c32e0cf23c90..c2b046d1fd82 100644
> > --- a/include/asm-generic/numa.h
> > +++ b/include/asm-generic/numa.h
> > @@ -32,8 +32,6 @@ static inline const struct cpumask *cpumask_of_node(int node)
> > 
> >  void __init arch_numa_init(void);
> >  int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> > -void __init numa_set_distance(int from, int to, int distance);
> > -void __init numa_free_distance(void);
> >  void __init early_map_cpu_to_node(unsigned int cpu, int nid);
> >  int __init early_cpu_to_node(int cpu);
> >  void numa_store_cpu_info(unsigned int cpu);
> 
> but is still declared as __init in the header, so it is
> still put in that section and discarded after boot.

I believe this should fix it

diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index c2b046d1fd82..e063d6487f66 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -33,7 +33,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
 void __init arch_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
-int __init early_cpu_to_node(int cpu);
+int early_cpu_to_node(int cpu);
 void numa_store_cpu_info(unsigned int cpu);
 void numa_add_cpu(unsigned int cpu);
 void numa_remove_cpu(unsigned int cpu);
 
> I was confused by this at first, since the 'early' name
> seems to imply that you shouldn't call it once the system
> is up, but now you do.

I agree that this is confusing, but that's what x86 does and numa_emulation
uses.
 
>      Arnd
> 

-- 
Sincerely yours,
Mike.

