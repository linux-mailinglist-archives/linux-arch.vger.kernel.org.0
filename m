Return-Path: <linux-arch+bounces-10421-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2312DA47BB6
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 12:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1CE166179
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 11:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF5D22CBF4;
	Thu, 27 Feb 2025 11:13:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A10A225761;
	Thu, 27 Feb 2025 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654823; cv=none; b=AnDijjdMNsGDHSBR7eaegBrfJDLgQLmZ4yqFke+JgfMubzW1UYXGLf2tKUMnE2P63dPIvKw9Ze0NW2hnuIdV2gwh+QP07K5Jj8rZEtiR+VzdpFNuc3IE386qpTgvC5NxsvDBEuRKxRJcGAG9DqYlKzdsfeoYt6FtBH4LeFwZJdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654823; c=relaxed/simple;
	bh=SAqzx+hkCBMFjSaW75HdRmriaQmgXA3UpjpZK1/xZLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeHQ5FVkyKlUEOoG0+OgI2s6aF1YsAAza166Wjfgo3SVWD4hH+WT0gpYgV86UORlwiUJPZ3eB369gWCX7qjZEF5gfzoS9K+NPYuLcurXf3CbO9tC0ye5E+0UkIU4IFc8jLPu8jd7DOhnP6EneZIjRPz+yD5DR4oct2TRYAjVzgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B40CD2C23;
	Thu, 27 Feb 2025 03:13:56 -0800 (PST)
Received: from [10.57.85.134] (unknown [10.57.85.134])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FF103F6A8;
	Thu, 27 Feb 2025 03:13:31 -0800 (PST)
Message-ID: <16863478-2195-435e-a899-559df097bc59@arm.com>
Date: Thu, 27 Feb 2025 11:13:29 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] execmem: add support for cache of large ROX pages
Content-Language: en-GB
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Dev Jain <dev.jain@arm.com>
Cc: Andreas Larsson <andreas@gaisler.com>, Andy Lutomirski <luto@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christoph Hellwig <hch@infradead.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Dave Hansen <dave.hansen@linux.intel.com>, Dinh Nguyen
 <dinguyen@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>,
 Oleg Nesterov <oleg@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
 Stafford Horne <shorne@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>,
 Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org, x86@kernel.org
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241023162711.2579610-8-rppt@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241023162711.2579610-8-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mike,

Drive by review comments below...


On 23/10/2024 17:27, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Using large pages to map text areas reduces iTLB pressure and improves
> performance.
> 
> Extend execmem_alloc() with an ability to use huge pages with ROX
> permissions as a cache for smaller allocations.
> 
> To populate the cache, a writable large page is allocated from vmalloc with
> VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> ROX.
> 
> The direct map alias of that large page is exculded from the direct map.
> 
> Portions of that large page are handed out to execmem_alloc() callers
> without any changes to the permissions.
> 
> When the memory is freed with execmem_free() it is invalidated again so
> that it won't contain stale instructions.
> 
> An architecture has to implement execmem_fill_trapping_insns() callback
> and select ARCH_HAS_EXECMEM_ROX configuration option to be able to use
> the ROX cache.
> 
> The cache is enabled on per-range basis when an architecture sets
> EXECMEM_ROX_CACHE flag in definition of an execmem_range.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Tested-by: kdevops <kdevops@lists.linux.dev>
> ---

[...]

> +
> +static int execmem_cache_populate(struct execmem_range *range, size_t size)
> +{
> +	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> +	unsigned long start, end;
> +	struct vm_struct *vm;
> +	size_t alloc_size;
> +	int err = -ENOMEM;
> +	void *p;
> +
> +	alloc_size = round_up(size, PMD_SIZE);
> +	p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);

Shouldn't this be passing PAGE_KERNEL_ROX? Otherwise I don't see how the
allocated memory is ROX? I don't see any call below where you change the permission.

Given the range has the pgprot in it, you could just drop passing the pgprot
explicitly here and have execmem_vmalloc() use range->pgprot directly?

Thanks,
Ryan

> +	if (!p)
> +		return err;
> +
> +	vm = find_vm_area(p);
> +	if (!vm)
> +		goto err_free_mem;
> +
> +	/* fill memory with instructions that will trap */
> +	execmem_fill_trapping_insns(p, alloc_size, /* writable = */ true);
> +
> +	start = (unsigned long)p;
> +	end = start + alloc_size;
> +
> +	vunmap_range(start, end);
> +
> +	err = execmem_set_direct_map_valid(vm, false);
> +	if (err)
> +		goto err_free_mem;
> +
> +	err = vmap_pages_range_noflush(start, end, range->pgprot, vm->pages,
> +				       PMD_SHIFT);
> +	if (err)
> +		goto err_free_mem;
> +
> +	err = execmem_cache_add(p, alloc_size);
> +	if (err)
> +		goto err_free_mem;
> +
> +	return 0;
> +
> +err_free_mem:
> +	vfree(p);
> +	return err;
> +}

[...]


