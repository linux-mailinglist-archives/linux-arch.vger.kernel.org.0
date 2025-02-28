Return-Path: <linux-arch+bounces-10465-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 479C9A49B12
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 14:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023F2188E92D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Feb 2025 13:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D28C26D5A4;
	Fri, 28 Feb 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnH7vM73"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D412421CC78;
	Fri, 28 Feb 2025 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750969; cv=none; b=i3ZA7u5qGFXFqImrXcwZhgkRdygoahWewRCp3kmvRLRa0a/AfyrzBuXb0dYoWE1OoDe2z7jcglcGDs5BLtZnDlVxMJIyHya3eVQQKc4rugXPjCf6GhWorEIsUwqQxxHDJFBbcizIR3L+8DYTFM6iBbfFUSng/N00/faENalvPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750969; c=relaxed/simple;
	bh=1IRowyiOxlD3aJXg1mzDgOLSKDvuTpO5rwTj3G6RUt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDUf7dgdsLvApRgi4adzflRd2ttTE6DtiDWHFNcAd0Ga7cM60nVOcQ6MDf0PTBNPgScIpK3dQXHHX1iwjbD405+PCgQEj7ajwRgDAV7iaSnRrAD9FF+659PXNIzCt+zL8aW7KG/9vIB9JS16QJHRw7Kd4CfAXTKe5KEXtLtzJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnH7vM73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EA8C4CEE2;
	Fri, 28 Feb 2025 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740750968;
	bh=1IRowyiOxlD3aJXg1mzDgOLSKDvuTpO5rwTj3G6RUt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnH7vM73Zjpr8yZOH5QgfgQiSw0pmBWJwyV6oH4lnUx6KcNNLgBYYJulfb/SOKw4i
	 Zkm3msW661FidfCoi/ar4s+MKouda8UuOKQJVozVEXvAvSibmI7k9WxUPFNYkImrpm
	 nMJqrfmWsggXRbny/dSvcLd6O/w5mYI7U35gabE5OMAnP119A+B9Z9gcS1udwYaPDT
	 haSivt5w98I2lC6hpiCjEl3HQRzpovHqj3M+6AQ/d9NOf1QW57gfgkHOWFS4Y8Iwt4
	 dVExS2M99VzccMzDPnxcN2Fshmin/V/WHUi6c8awMapcLOMc4QlOWwdQMyM3HZ2OR4
	 n0uklzJCb+JTQ==
Date: Fri, 28 Feb 2025 15:55:38 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>, Dev Jain <dev.jain@arm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
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
Subject: Re: [PATCH v7 7/8] execmem: add support for cache of large ROX pages
Message-ID: <Z8HAWu4zQFeg19KR@kernel.org>
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241023162711.2579610-8-rppt@kernel.org>
 <16863478-2195-435e-a899-559df097bc59@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16863478-2195-435e-a899-559df097bc59@arm.com>

Hi Ryan,

On Thu, Feb 27, 2025 at 11:13:29AM +0000, Ryan Roberts wrote:
> Hi Mike,
> 
> Drive by review comments below...
> 
> 
> On 23/10/2024 17:27, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Using large pages to map text areas reduces iTLB pressure and improves
> > performance.
> > 
> > Extend execmem_alloc() with an ability to use huge pages with ROX
> > permissions as a cache for smaller allocations.
> > 
> > To populate the cache, a writable large page is allocated from vmalloc with
> > VM_ALLOW_HUGE_VMAP, filled with invalid instructions and then remapped as
> > ROX.
> > 
> > The direct map alias of that large page is exculded from the direct map.
> > 
> > Portions of that large page are handed out to execmem_alloc() callers
> > without any changes to the permissions.
> > 
> > When the memory is freed with execmem_free() it is invalidated again so
> > that it won't contain stale instructions.
> > 
> > An architecture has to implement execmem_fill_trapping_insns() callback
> > and select ARCH_HAS_EXECMEM_ROX configuration option to be able to use
> > the ROX cache.
> > 
> > The cache is enabled on per-range basis when an architecture sets
> > EXECMEM_ROX_CACHE flag in definition of an execmem_range.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> > Tested-by: kdevops <kdevops@lists.linux.dev>
> > ---
> 
> [...]
> 
> > +
> > +static int execmem_cache_populate(struct execmem_range *range, size_t size)
> > +{
> > +	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
> > +	unsigned long start, end;
> > +	struct vm_struct *vm;
> > +	size_t alloc_size;
> > +	int err = -ENOMEM;
> > +	void *p;
> > +
> > +	alloc_size = round_up(size, PMD_SIZE);
> > +	p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
> 
> Shouldn't this be passing PAGE_KERNEL_ROX? Otherwise I don't see how the
> allocated memory is ROX? I don't see any call below where you change the permission.

The memory is allocated RW, filled with invalid instructions, unammped in
vmalloc space, removed from the direct map and then mapped as ROX in
vmalloc address space.
 
> Given the range has the pgprot in it, you could just drop passing the pgprot
> explicitly here and have execmem_vmalloc() use range->pgprot directly?

Here range->prprot and the prot passed to vmalloc are different.
 
> Thanks,
> Ryan
> 
> > +	if (!p)
> > +		return err;
> > +
> > +	vm = find_vm_area(p);
> > +	if (!vm)
> > +		goto err_free_mem;
> > +
> > +	/* fill memory with instructions that will trap */
> > +	execmem_fill_trapping_insns(p, alloc_size, /* writable = */ true);
> > +
> > +	start = (unsigned long)p;
> > +	end = start + alloc_size;
> > +
> > +	vunmap_range(start, end);
> > +
> > +	err = execmem_set_direct_map_valid(vm, false);
> > +	if (err)
> > +		goto err_free_mem;
> > +
> > +	err = vmap_pages_range_noflush(start, end, range->pgprot, vm->pages,
> > +				       PMD_SHIFT);
> > +	if (err)
> > +		goto err_free_mem;
> > +
> > +	err = execmem_cache_add(p, alloc_size);
> > +	if (err)
> > +		goto err_free_mem;
> > +
> > +	return 0;
> > +
> > +err_free_mem:
> > +	vfree(p);
> > +	return err;
> > +}
> 
> [...]
> 

-- 
Sincerely yours,
Mike.

