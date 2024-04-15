Return-Path: <linux-arch+bounces-3669-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 597B98A4BAB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 11:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC1DFB24699
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB4D4AEEC;
	Mon, 15 Apr 2024 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WL3mGK96"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54164F5F8;
	Mon, 15 Apr 2024 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173842; cv=none; b=pbQqkCTcje0HWDFhbzBqrEPHQx2b6HeINO5CanXLwM1bWOq8S/AnvHg5BTywTq4oVZIuv+g0aAFyPgGm1ErLhRzdEm94U+Ul/rOa5tgZ6AN6nuIdm1RQ4edWwkTcKC3acHEGvQH6tctxRJuQeFS9aX2K8LCuDJ1qnv/+zJYjQHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173842; c=relaxed/simple;
	bh=iWSAcKBzCT/GfR3CUsNAvXWE2GqvA4i8aFyoJ/HJFOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2lNb9r/DxUP93+ofQORD7YKXJKeRsJoE/3dIqBgHS5rsnw59UpuUAiIXByBpnqgJJMx/UNjjt62ks4laRvVeCLv82IiHSQ4JB5dYZ8nLxD0+Up5pAjZ/soNov6lJiecpVMDpS8YICWGIy2cEgqWycZTJy7RywZeMzDIt2RR+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WL3mGK96; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gJURSN8ZhZs54MX6UPe8WS991KHmcU3CMSr/wsPBYas=; b=WL3mGK96b4dqocWg2WT6S+o3Lh
	6R4hcBA6RfcHuQQK7isTyMyXCwDos8Q1HdHKBvnc80dazhTsMKZZh+HOA+2p3MytoMgm0z79fe1lO
	6VNzmYAbfQ0K4rY/gTJDrpu5Cj+twK8P8H6r2xTaYF5wANkZ19gJAqZM8x7uwfcFkyoEWlipCNTWk
	6fylSl1gmglon4eNg+zb/yC04zTO/2Lfq8d+LNZPMMi03er3jB/2uzdVHk4Db9ls69FN+sjSeErGv
	ir1OIAWRPD8gvlVd9eQwbdsiTncbhidLvva928W/3FSV8BR+sXBV2NxpcV2Vc46i56RkcJA4zwnpr
	gpLaCNRw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwIlk-0000000FOjV-0IDN;
	Mon, 15 Apr 2024 09:36:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1DC030040C; Mon, 15 Apr 2024 11:36:55 +0200 (CEST)
Date: Mon, 15 Apr 2024 11:36:55 +0200
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
Subject: Re: [PATCH v4 07/15] mm/execmem, arch: convert remaining overrides
 of module_alloc to execmem
Message-ID: <20240415093655.GH40213@noisy.programming.kicks-ass.net>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-8-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411160051.2093261-8-rppt@kernel.org>

On Thu, Apr 11, 2024 at 07:00:43PM +0300, Mike Rapoport wrote:

> +static struct execmem_info execmem_info __ro_after_init = {
> +	.ranges = {
> +		[EXECMEM_DEFAULT] = {
> +			.flags = EXECMEM_KASAN_SHADOW,
> +			.alignment = MODULE_ALIGN,
> +		},
> +	},
> +};
>  
> +struct execmem_info __init *execmem_arch_setup(void)
>  {
> +	unsigned long start, offset = 0;
>  
> +	if (kaslr_enabled())
> +		offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
>  
> +	start = MODULES_VADDR + offset;
> +	execmem_info.ranges[EXECMEM_DEFAULT].start = start;
> +	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
> +	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
>  
> +	return &execmem_info;
>  }

struct execmem_info __init *execmem_arch_setup(void)
{
	unsigned long offset = 0;

	if (kaslr_enabled())
		offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;

	execmem_info = (struct execmem_info){
		.ranges = {
			[EXECMEM_DEFAULT] = {
				.start     = MODULES_VADDR + offset,
				.end       = MODULES_END,
				.pgprot    = PAGE_KERNEL,
				.flags     = EXECMEM_KASAN_SHADOW,
				.alignment = 1,
			},
		},
	};

	return &execmem_info;
}

