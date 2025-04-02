Return-Path: <linux-arch+bounces-11220-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB5A78E13
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 14:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A0227A1BCC
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27589238D2E;
	Wed,  2 Apr 2025 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4C4HdGt+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t1CXcxl7"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7B1D7E57;
	Wed,  2 Apr 2025 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743596350; cv=none; b=McQRz++SFqABj8HbtqGy+6LtIhTTDlwbN8q/QUDbGCMn+qnzpy8rsH8Eulxspq2YUmtVWw2yfEmzvcST8OcwnT6/IU8Ks71DOecaNRIyFyZ+2YXoLio0Wx3wSEAdF5cYdxfe63YEj2iQoDgP29wDGXCP8Nhg7ATU6j5iYmpXBqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743596350; c=relaxed/simple;
	bh=+YugTiA5uSlijtvOniAz233xfd9rjfYPP9SWxiLilz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFVvvevE10ce9SxMctrL+V8/S2jSu2aJLtSzROjTk5C3bJrFKJExAfsRYL1qaY3YLVkQpkR6uGY96+CP0Nq+0MHyxruXWrVHFL1LJniiE41386e0iU86v4xjcILL/XotqC3vZ6sj4NFBZM6g5XIxvOAtF8dn0Kz9y0KdOjnPGFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4C4HdGt+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t1CXcxl7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 2 Apr 2025 14:19:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743596346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPwuNcBCkbZ5awEPfs4/za9zsV6NBdgUfdxmq9Ar2zg=;
	b=4C4HdGt+Eda2qns01kTkRT+qPk6Wn4tZQ5k8O1Gx7H6kUOU1PXVZWAQFtMS0r4AiH92Qy2
	T19YMwiz9JFLLSHv54Dn9RITOldT/MtOzK49CNMWAuxNeEC+2Y6jm0UKbVEosmPzAfc5jj
	9ZmhrVVrsxgekRU0tgRzk1+hD6Ij87xwwZ7agsbOUR5Gj8FET9ayzNQGwloZQFkrw1war7
	RXDjG/MLKkGblGXOcKEt15IW1odXI5QbD6QWTMGTgmopNAe9NZ59ehpG3ncR54fm//ECjU
	qSSL0ofXcq5UCmBbiP/BNaPIX9ZMUzNeOBxIdcNETXuRaJGbkcuNUw631Z8kYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743596346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QPwuNcBCkbZ5awEPfs4/za9zsV6NBdgUfdxmq9Ar2zg=;
	b=t1CXcxl7E7i5zDKv6ErJjLdNnAghpNhssI165DwRwHvZe5uvKbvjZ19neMAQXjnMrzKBSO
	g9EkcgUMbGsLe6BA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Mike Rapoport <rppt@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Subject: Re: [PATCH v2 10/13] arch, mm: set high_memory in free_area_init()
Message-ID: <20250402140521-bf9b3743-094e-4097-a189-10cdf1db9255@linutronix.de>
References: <20250313135003.836600-1-rppt@kernel.org>
 <20250313135003.836600-11-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313135003.836600-11-rppt@kernel.org>

(drop all the non-x86 and non-mm recipients)

Hi,

On Thu, Mar 13, 2025 at 03:50:00PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> high_memory defines upper bound on the directly mapped memory.
> This bound is defined by the beginning of ZONE_HIGHMEM when a system has
> high memory and by the end of memory otherwise.
> 
> All this is known to generic memory management initialization code that
> can set high_memory while initializing core mm structures.
> 
> Add a generic calculation of high_memory to free_area_init() and remove
> per-architecture calculation except for the architectures that set and
> use high_memory earlier than that.

This change (in mainline as commit e120d1bc12da ("arch, mm: set high_memory in free_area_init()")
breaks booting i386 on QEMU for me (and others [0]).
The boot just hangs without output.

It's easily reproducible with kunit:
./tools/testing/kunit/kunit.py run --arch i386

See below for the specific problematic hunk.

[0] https://lore.kernel.org/lkml/CA+G9fYtdXHVuirs3v6at3UoKNH5keuq0tpcvpz0tJFT4toLG4g@mail.gmail.com/

> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>	# x86
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/alpha/mm/init.c         |  1 -
>  arch/arc/mm/init.c           |  2 --
>  arch/arm64/mm/init.c         |  2 --
>  arch/csky/mm/init.c          |  1 -
>  arch/hexagon/mm/init.c       |  6 ------
>  arch/loongarch/kernel/numa.c |  1 -
>  arch/loongarch/mm/init.c     |  2 --
>  arch/microblaze/mm/init.c    |  2 --
>  arch/mips/mm/init.c          |  2 --
>  arch/nios2/mm/init.c         |  6 ------
>  arch/openrisc/mm/init.c      |  2 --
>  arch/parisc/mm/init.c        |  1 -
>  arch/riscv/mm/init.c         |  1 -
>  arch/s390/mm/init.c          |  2 --
>  arch/sh/mm/init.c            |  7 -------
>  arch/sparc/mm/init_32.c      |  1 -
>  arch/sparc/mm/init_64.c      |  2 --
>  arch/um/kernel/um_arch.c     |  1 -
>  arch/x86/kernel/setup.c      |  2 --
>  arch/x86/mm/init_32.c        |  3 ---
>  arch/x86/mm/numa_32.c        |  3 ---
>  arch/xtensa/mm/init.c        |  2 --
>  mm/memory.c                  |  8 --------
>  mm/mm_init.c                 | 30 ++++++++++++++++++++++++++++++
>  mm/nommu.c                   |  2 --
>  25 files changed, 30 insertions(+), 62 deletions(-)

<snip>

> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index 6d2f8cb9451e..801b659ead0c 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -643,9 +643,6 @@ void __init initmem_init(void)
>  		highstart_pfn = max_low_pfn;
>  	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
>  		pages_to_mb(highend_pfn - highstart_pfn));
> -	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
> -#else
> -	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
>  #endif

Reverting this hunk fixes the issue for me.

>  
>  	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);

