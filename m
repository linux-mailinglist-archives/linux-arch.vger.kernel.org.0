Return-Path: <linux-arch+bounces-3654-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5787A8A40E1
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 09:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5AAA1F21417
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 07:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5C11CFBC;
	Sun, 14 Apr 2024 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSn3bFIT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213BE17565;
	Sun, 14 Apr 2024 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713079683; cv=none; b=ekIp91v3s3LBHAb2WunZcXrjH4xV3xGCu+c6oWltHqyO/V7ICXpHU7SFrr9NaxZu6OCYlp3u1+MZsxen3cNlwzBzpYU8k/j+Z5/7qoVjgTf8av2a1ickI3nlBiVyab0RNknvZV/Z1KU4m4IYjvdxuZHAMrCHC9NhD2YLRBTf7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713079683; c=relaxed/simple;
	bh=7UcAoz/SHZJ9dQ0bgxdPwC8jDXsqkfxw4nZlv0SLw5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbtxOfhZcaHsLD9jYrV2UIUzMCUE9EUXt1oaTpBMKzUZn1goQjZB8pC3+WRqLnjsOZnjz5GFc1H0/VPGjPGUY5yL3HHcR6uudTMBBTuF9XHxapMb6wL1ZZxvPcrwVX7L6g+IAnkXJRbzpuc2X1Q9qW95KlpFG4HTyJ5E5ImdaFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSn3bFIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759F8C072AA;
	Sun, 14 Apr 2024 07:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713079682;
	bh=7UcAoz/SHZJ9dQ0bgxdPwC8jDXsqkfxw4nZlv0SLw5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSn3bFITK7eYlJdTFbScch0ThBeU+CtfVZynIF2TKYAjwpfIWpT9mvprRtl/vRdi+
	 PWs0IudDlFW6Beno7xjDAiW1ip7pL/FGhEaTkCamfUxQ5eDkHTs4QkNm97zhVJccwv
	 UxX9+hkJgUV7GSohwVI620vdp0JYtwTWKKysZvcjBk9t6kUNPFg5Eeatgn84u8vivs
	 7On6vy8KLlD97z5wp8DI0bLXFhxIaSTkHjS//iWFuOPg7CQ+rJyeDYDISTJa6W6AFc
	 TXNbcHaOhhepqyuh8BUKoPaV89wZMsoGzWH9gtBjUYYSDb1AqF+wsfY3ZeQjYF2dQ5
	 tmillpYns8epg==
Date: Sun, 14 Apr 2024 10:26:47 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nadav Amit <nadav.amit@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v4 06/15] mm/execmem, arch: convert simple overrides of
 module_alloc to execmem
Message-ID: <ZhuFNyaZcfOrp7Cl@kernel.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-7-rppt@kernel.org>
 <20240411205346.GA66667@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411205346.GA66667@ravnborg.org>

On Thu, Apr 11, 2024 at 10:53:46PM +0200, Sam Ravnborg wrote:
> Hi Mike.
> 
> On Thu, Apr 11, 2024 at 07:00:42PM +0300, Mike Rapoport wrote:
> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > 
> > Several architectures override module_alloc() only to define address
> > range for code allocations different than VMALLOC address space.
> > 
> > Provide a generic implementation in execmem that uses the parameters for
> > address space ranges, required alignment and page protections provided
> > by architectures.
> > 
> > The architectures must fill execmem_info structure and implement
> > execmem_arch_setup() that returns a pointer to that structure. This way the
> > execmem initialization won't be called from every architecture, but rather
> > from a central place, namely a core_initcall() in execmem.
> > 
> > The execmem provides execmem_alloc() API that wraps __vmalloc_node_range()
> > with the parameters defined by the architectures.  If an architecture does
> > not implement execmem_arch_setup(), execmem_alloc() will fall back to
> > module_alloc().
> > 
> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> 
> This code snippet could be more readable ...
> > diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
> > index 66c45a2764bc..b70047f944cc 100644
> > --- a/arch/sparc/kernel/module.c
> > +++ b/arch/sparc/kernel/module.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/string.h>
> >  #include <linux/ctype.h>
> >  #include <linux/mm.h>
> > +#include <linux/execmem.h>
> >  
> >  #include <asm/processor.h>
> >  #include <asm/spitfire.h>
> > @@ -21,34 +22,26 @@
> >  
> >  #include "entry.h"
> >  
> > +static struct execmem_info execmem_info __ro_after_init = {
> > +	.ranges = {
> > +		[EXECMEM_DEFAULT] = {
> >  #ifdef CONFIG_SPARC64
> > -
> > -#include <linux/jump_label.h>
> > -
> > -static void *module_map(unsigned long size)
> > -{
> > -	if (PAGE_ALIGN(size) > MODULES_LEN)
> > -		return NULL;
> > -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> > -				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
> > -				__builtin_return_address(0));
> > -}
> > +			.start = MODULES_VADDR,
> > +			.end = MODULES_END,
> >  #else
> > -static void *module_map(unsigned long size)
> > +			.start = VMALLOC_START,
> > +			.end = VMALLOC_END,
> > +#endif
> > +			.alignment = 1,
> > +		},
> > +	},
> > +};
> > +
> > +struct execmem_info __init *execmem_arch_setup(void)
> >  {
> > -	return vmalloc(size);
> > -}
> > -#endif /* CONFIG_SPARC64 */
> > -
> > -void *module_alloc(unsigned long size)
> > -{
> > -	void *ret;
> > -
> > -	ret = module_map(size);
> > -	if (ret)
> > -		memset(ret, 0, size);
> > +	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
> >  
> > -	return ret;
> > +	return &execmem_info;
> >  }
> >  
> >  /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */
> 
> ... if the following was added:
> 
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> index 9e85d57ac3f2..62bcafe38b1f 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -432,6 +432,8 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,
> 
>  #define VMALLOC_START           _AC(0xfe600000,UL)
>  #define VMALLOC_END             _AC(0xffc00000,UL)
> +#define MODULES_VADDR           VMALLOC_START
> +#define MODULES_END             VMALLOC_END
> 
> 
> Then the #ifdef CONFIG_SPARC64 could be dropped and the code would be
> the same for 32 and 64 bits.
 
Yeah, the #ifdef there can be dropped even regardless of execmem.
I'll add a patch for that.

> Just a drive-by comment.
> 
> 	Sam
> 

-- 
Sincerely yours,
Mike.

