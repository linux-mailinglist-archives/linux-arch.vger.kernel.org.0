Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE64B1A9B61
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 12:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896641AbgDOKs1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 06:48:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896436AbgDOKsC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Apr 2020 06:48:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD15620737;
        Wed, 15 Apr 2020 10:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586947681;
        bh=HnbCLVccnltKcSSZedL2CQZAK2TgY1Sbggx+zC543GY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vmDrvJumX7U4le53pGKjBrr2FhNVnQba1z1kLq52haEuy5GrM5awH1/ElXic1ZLC0
         Oh7NXNU+t5PKOYaPI1cLgdB+3NAFHrAq374CLyxZRTdB85poPdJp0cKh/DP/KUbuta
         z/klilXZlHdmW+czzWkq59ztl3oT1IXuEHLhkdow=
Date:   Wed, 15 Apr 2020 11:47:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200415104755.GD12621@willie-the-truck>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nick,

On Mon, Apr 13, 2020 at 10:53:03PM +1000, Nicholas Piggin wrote:
> For platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmap mappings,
> have vmalloc attempt to allocate PMD-sized pages first, before falling back
> to small pages. Allocations which use something other than PAGE_KERNEL
> protections are not permitted to use huge pages yet, not all callers expect
> this (e.g., module allocations vs strict module rwx).
> 
> This gives a 6x reduction in dTLB misses for a `git diff` (of linux), from
> 45600 to 6500 and a 2.2% reduction in cycles on a 2-node POWER9.

I wonder if it's worth extending vmap() to handle higher order pages in
a similar way? That might be helpful for tracing PMUs such as Arm SPE,
where the CPU streams tracing data out to a virtually addressed buffer
(see rb_alloc_aux_page()).

> This can result in more internal fragmentation and memory overhead for a
> given allocation. It can also cause greater NUMA unbalance on hashdist
> allocations.
> 
> There may be other callers that expect small pages under vmalloc but use
> PAGE_KERNEL, I'm not sure if it's feasible to catch them all. An
> alternative would be a new function or flag which enables large mappings,
> and use that in callers.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  include/linux/vmalloc.h |   2 +
>  mm/vmalloc.c            | 135 +++++++++++++++++++++++++++++-----------
>  2 files changed, 102 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 291313a7e663..853b82eac192 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -24,6 +24,7 @@ struct notifier_block;		/* in notifier.h */
>  #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
>  #define VM_NO_GUARD		0x00000040      /* don't add guard page */
>  #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
> +#define VM_HUGE_PAGES		0x00000100	/* may use huge pages */

Please can you add a check for this in the arm64 change_memory_common()
code? Other architectures might need something similar, but we need to
forbid changing memory attributes for portions of the huge page.

In general, I'm a bit wary of software table walkers tripping over this.
For example, I don't think apply_to_existing_page_range() can handle
huge mappings at all, but the one user (KASAN) only ever uses page mappings
so it's ok there.

> @@ -2325,9 +2356,11 @@ static struct vm_struct *__get_vm_area_node(unsigned long size,
>  	if (unlikely(!size))
>  		return NULL;
>  
> -	if (flags & VM_IOREMAP)
> -		align = 1ul << clamp_t(int, get_count_order_long(size),
> -				       PAGE_SHIFT, IOREMAP_MAX_ORDER);
> +	if (flags & VM_IOREMAP) {
> +		align = max(align,
> +			    1ul << clamp_t(int, get_count_order_long(size),
> +					   PAGE_SHIFT, IOREMAP_MAX_ORDER));
> +	}


I don't follow this part. Please could you explain why you're potentially
aligning above IOREMAP_MAX_ORDER? It doesn't seem to follow from the rest
of the patch.

Cheers,

Will
