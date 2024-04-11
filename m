Return-Path: <linux-arch+bounces-3610-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF968A2078
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 22:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6C8282E6E
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 20:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7C225D7;
	Thu, 11 Apr 2024 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="kv3VYS1n";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="2lz6/kgt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [46.30.211.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1317C95
	for <linux-arch@vger.kernel.org>; Thu, 11 Apr 2024 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712868841; cv=none; b=jz9wuJ53Cqw1qNjFI/sPAC2+ejcifkZw76uxS69oI+hMdqF7upb1ce5m0wY5bss+vf5GBt+ATsJxXIVQ3nR6Iq968Gug3+MOEhyDjuBrkb3qPtHPPheiHSYPUMJG59ib3sS/y3bv4lGSRFNvBmM/cf5Kn6dv2VoypjJfhNVe3pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712868841; c=relaxed/simple;
	bh=TF5y+t4h39/TPgiK6Hbd3LRpWjocizBPcHQbaJ6xqOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg6iEMLisbx4fz9aQ0usfxAXjmq+NU5adYtLzbmgwgTX+HYDcfOEG+FpwnQ43QgxXD5RNg1T+e3ntYvSGWNEciku9d5Ba9LIqXgSmTae59KGgDTOeVY4BT6h8x6ypWDFyJaO0eRla8OFBab4Tq/urSPK1E6pV/KADakiVMm5xS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=kv3VYS1n; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=2lz6/kgt; arc=none smtp.client-ip=46.30.211.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=8iZCIbXv/o+9vFGi/T/APUrhuAqs9LM6RRA1ferZ2wg=;
	b=kv3VYS1nb+1jhVe9oEyryqOQdogTQlFfldT5zGFYz9zCFOW49UnzyKwrJoDnpG5By8Wz6/89q37/J
	 74y1ANyGrc4+nAdiZLdwTQ7At1BMHShrpW21ksmQCnho4ndLVURK71dGIBPbwAmFDNXGQ3nhWfJORf
	 kv6U7sF+UeIM9uVpTWy6T9yWjx+pcsw/GMhx3KJhDEBn/z0Ta31X9WEj03K6p1on5B6YlTztmnenxM
	 6t/dz3ghpSDNSSOo+Nh+gwCqPRCFFIbfiAkM9VZsrPcOKFRvNMfm1iQmPZN5y4JbJlPGl97XHjBdfO
	 1z6v1BSheYGCsHilS105+mOpPAp8U2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=8iZCIbXv/o+9vFGi/T/APUrhuAqs9LM6RRA1ferZ2wg=;
	b=2lz6/kgt5Ws9Bwhsrc83nOkDSczAnngGL2Yh8km6qYY8h6ibpExr6aVD63x7Bbyn4q9jSyAbA/9ij
	 5z3+8uwDQ==
X-HalOne-ID: 9634f2b2-f845-11ee-b2f6-516168859393
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id 9634f2b2-f845-11ee-b2f6-516168859393;
	Thu, 11 Apr 2024 20:53:48 +0000 (UTC)
Date: Thu, 11 Apr 2024 22:53:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20240411205346.GA66667@ravnborg.org>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-7-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411160051.2093261-7-rppt@kernel.org>

Hi Mike.

On Thu, Apr 11, 2024 at 07:00:42PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Several architectures override module_alloc() only to define address
> range for code allocations different than VMALLOC address space.
> 
> Provide a generic implementation in execmem that uses the parameters for
> address space ranges, required alignment and page protections provided
> by architectures.
> 
> The architectures must fill execmem_info structure and implement
> execmem_arch_setup() that returns a pointer to that structure. This way the
> execmem initialization won't be called from every architecture, but rather
> from a central place, namely a core_initcall() in execmem.
> 
> The execmem provides execmem_alloc() API that wraps __vmalloc_node_range()
> with the parameters defined by the architectures.  If an architecture does
> not implement execmem_arch_setup(), execmem_alloc() will fall back to
> module_alloc().
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

This code snippet could be more readable ...
> diff --git a/arch/sparc/kernel/module.c b/arch/sparc/kernel/module.c
> index 66c45a2764bc..b70047f944cc 100644
> --- a/arch/sparc/kernel/module.c
> +++ b/arch/sparc/kernel/module.c
> @@ -14,6 +14,7 @@
>  #include <linux/string.h>
>  #include <linux/ctype.h>
>  #include <linux/mm.h>
> +#include <linux/execmem.h>
>  
>  #include <asm/processor.h>
>  #include <asm/spitfire.h>
> @@ -21,34 +22,26 @@
>  
>  #include "entry.h"
>  
> +static struct execmem_info execmem_info __ro_after_init = {
> +	.ranges = {
> +		[EXECMEM_DEFAULT] = {
>  #ifdef CONFIG_SPARC64
> -
> -#include <linux/jump_label.h>
> -
> -static void *module_map(unsigned long size)
> -{
> -	if (PAGE_ALIGN(size) > MODULES_LEN)
> -		return NULL;
> -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> -				GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,
> -				__builtin_return_address(0));
> -}
> +			.start = MODULES_VADDR,
> +			.end = MODULES_END,
>  #else
> -static void *module_map(unsigned long size)
> +			.start = VMALLOC_START,
> +			.end = VMALLOC_END,
> +#endif
> +			.alignment = 1,
> +		},
> +	},
> +};
> +
> +struct execmem_info __init *execmem_arch_setup(void)
>  {
> -	return vmalloc(size);
> -}
> -#endif /* CONFIG_SPARC64 */
> -
> -void *module_alloc(unsigned long size)
> -{
> -	void *ret;
> -
> -	ret = module_map(size);
> -	if (ret)
> -		memset(ret, 0, size);
> +	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
>  
> -	return ret;
> +	return &execmem_info;
>  }
>  
>  /* Make generic code ignore STT_REGISTER dummy undefined symbols.  */

... if the following was added:

diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index 9e85d57ac3f2..62bcafe38b1f 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -432,6 +432,8 @@ static inline int io_remap_pfn_range(struct vm_area_struct *vma,

 #define VMALLOC_START           _AC(0xfe600000,UL)
 #define VMALLOC_END             _AC(0xffc00000,UL)
+#define MODULES_VADDR           VMALLOC_START
+#define MODULES_END             VMALLOC_END


Then the #ifdef CONFIG_SPARC64 could be dropped and the code would be
the same for 32 and 64 bits.

Just a drive-by comment.

	Sam

