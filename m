Return-Path: <linux-arch+bounces-3665-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595608A49B1
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 10:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138C1281C2C
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 08:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5A22D054;
	Mon, 15 Apr 2024 08:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hKFfLh3Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82052C868;
	Mon, 15 Apr 2024 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168236; cv=none; b=HWF4GD2Lxmj906WHA4TLryPBM5gIvdUvuiItwD71mM4VcDQ83wv1Bl5lR7NGw8+RqugD1739KjaEOVObfqiQ52bEWok6yUlCSlWhHpiUH0QsCv7nS0kLb050/lDHRXrnWSbEHJC1KgpFIaYCYNvcEarSZfkBsAc8Sa7VDeStzIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168236; c=relaxed/simple;
	bh=uAA0xNw3uXQEeAj18M82ry2VhWPmemP8F66GIQVJJSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rm+izJIVMHv2b3ER5HvDOyanVNOjJPEbRWmDw25wQYLRzjUVIhty5tPZDfEFNwdg7WAIW4XkyYwPmgQm1v2RQeRyaowT8067IkJ6Fz3Md4dWSuUpj4ds46VZ8tIywQoqCOsT1l6j+xmY+fSLxjcYxTOZx7GXLBZIzrcqfuxEjtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hKFfLh3Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SnC5QhRh3mlXbiY7BQLXM/Gh385CPpYbuU5jeG1ji44=; b=hKFfLh3ZzFSzJGPDsRiopYa0ZT
	efNxCJqPzVqpITxLJsqCQRDO/uvf69qkc9BXqmWr7IXteAQce+itGNJYH8NcZtrv9mowEIaYK6OnE
	zu1E4zjHKlTRzhIC1ZV1QOADiXZdrVLff1qYNP1JR24KuBKOy5EmbA81XuxsDuKJyy+iJ89PdOUI/
	efJhNT73J6k+ohWLAe+NOaJ0tLI7iHDK5KHmXtq9go12IpYLvh58Vu6qfltj09NU88Ez/5/ao6M2e
	ksvVbHfa9e2PLeJq7LlMBgltQx/i+r0JGyYLxMjQF0iD8WvUaOibeLqFhJKeJcs34Gs9iz6tlyZPZ
	lKITRWCQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwHJC-0000000FFhi-3aDy;
	Mon, 15 Apr 2024 08:03:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 12C5730040C; Mon, 15 Apr 2024 10:03:22 +0200 (CEST)
Date: Mon, 15 Apr 2024 10:03:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20240415080321.GG40213@noisy.programming.kicks-ass.net>
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

On Thu, Apr 11, 2024 at 07:00:42PM +0300, Mike Rapoport wrote:
> +static struct execmem_info execmem_info __ro_after_init = {
> +	.ranges = {
> +		[EXECMEM_DEFAULT] = {
> +			.start = MODULES_VADDR,
> +			.end = MODULES_END,
> +			.alignment = 1,
> +		},
> +	},
> +};
> +
> +struct execmem_info __init *execmem_arch_setup(void)
>  {
> +	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
> +
> +	return &execmem_info;
>  }

> +static struct execmem_info execmem_info __ro_after_init = {
> +	.ranges = {
> +		[EXECMEM_DEFAULT] = {
> +			.start = MODULES_VADDR,
> +			.end = MODULES_END,
> +			.pgprot = PAGE_KERNEL_EXEC,
> +			.alignment = 1,
> +		},
> +	},
> +};
> +
> +struct execmem_info __init *execmem_arch_setup(void)
>  {
> +	return &execmem_info;
>  }

> +static struct execmem_info execmem_info __ro_after_init = {
> +	.ranges = {
> +		[EXECMEM_DEFAULT] = {
> +			.pgprot = PAGE_KERNEL_RWX,
> +			.alignment = 1,
> +		},
> +	},
> +};
> +
> +struct execmem_info __init *execmem_arch_setup(void)
>  {
> +	execmem_info.ranges[EXECMEM_DEFAULT].start = VMALLOC_START;
> +	execmem_info.ranges[EXECMEM_DEFAULT].end = VMALLOC_END;
> +
> +	return &execmem_info;
>  }

> +static struct execmem_info execmem_info __ro_after_init = {
> +	.ranges = {
> +		[EXECMEM_DEFAULT] = {
> +			.pgprot = PAGE_KERNEL,
> +			.alignment = 1,
> +		},
> +	},
> +};
> +
> +struct execmem_info __init *execmem_arch_setup(void)
>  {
> +	execmem_info.ranges[EXECMEM_DEFAULT].start = MODULES_VADDR;
> +	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
> +
> +	return &execmem_info;
>  }

> +static struct execmem_info execmem_info __ro_after_init = {
> +	.ranges = {
> +		[EXECMEM_DEFAULT] = {
>  #ifdef CONFIG_SPARC64
> +			.start = MODULES_VADDR,
> +			.end = MODULES_END,
>  #else
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
> +	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
>  
> +	return &execmem_info;
>  }

I'm amazed by the weird and inconsistent breakup of initializations.

What exactly is wrong with something like:

static struct execmem_info execmem_info __ro_after_init;

struct execmem_info __init *execmem_arch_setup(void)
{
	execmem_info = (struct execmem_info){
		.ranges = {
			[EXECMEM_DEFAULT] = {
				.start	= MODULES_VADDR,
				.end	= MODULES_END,
				.pgprot	= PAGE_KERNEL,
				.alignment = 1,
			},
		},
	};
	return &execmem_info;
}


