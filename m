Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE0A242946
	for <lists+linux-arch@lfdr.de>; Wed, 12 Aug 2020 14:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgHLM04 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Aug 2020 08:26:56 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2597 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726722AbgHLM04 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Aug 2020 08:26:56 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id DB8FA142F805B19C9470;
        Wed, 12 Aug 2020 13:26:53 +0100 (IST)
Received: from localhost (10.52.122.74) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 12 Aug
 2020 13:26:53 +0100
Date:   Wed, 12 Aug 2020 13:25:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nicholas Piggin <npiggin@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Zefan Li" <lizefan@huawei.com>
Subject: Re: [PATCH v3 8/8] mm/vmalloc: Hugepage vmalloc mappings
Message-ID: <20200812132524.000067a6@Huawei.com>
In-Reply-To: <20200810022732.1150009-9-npiggin@gmail.com>
References: <20200810022732.1150009-1-npiggin@gmail.com>
        <20200810022732.1150009-9-npiggin@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.74]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 10 Aug 2020 12:27:32 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On platforms that define HAVE_ARCH_HUGE_VMAP and support PMD vmaps,
> vmalloc will attempt to allocate PMD-sized pages first, before falling
> back to small pages.
> 
> Allocations which use something other than PAGE_KERNEL protections are
> not permitted to use huge pages yet, not all callers expect this (e.g.,
> module allocations vs strict module rwx).
> 
> This reduces TLB misses by nearly 30x on a `git diff` workload on a
> 2-node POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%.
> 
> This can result in more internal fragmentation and memory overhead for a
> given allocation, an option nohugevmap is added to disable at boot.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Hi Nicholas,

Busy afternoon, but a possible point of interest in line in the meantime.


...

> @@ -2701,22 +2760,45 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  			pgprot_t prot, unsigned long vm_flags, int node,
>  			const void *caller)
>  {
> -	struct vm_struct *area;
> +	struct vm_struct *area = NULL;
>  	void *addr;
>  	unsigned long real_size = size;
> +	unsigned long real_align = align;
> +	unsigned int shift = PAGE_SHIFT;
>  
>  	size = PAGE_ALIGN(size);
>  	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
>  		goto fail;
>  
> -	area = __get_vm_area_node(real_size, align, VM_ALLOC | VM_UNINITIALIZED |
> +	if (vmap_allow_huge && (pgprot_val(prot) == pgprot_val(PAGE_KERNEL))) {
> +		unsigned long size_per_node;
> +
> +		/*
> +		 * Try huge pages. Only try for PAGE_KERNEL allocations,
> +		 * others like modules don't yet expect huge pages in
> +		 * their allocations due to apply_to_page_range not
> +		 * supporting them.
> +		 */
> +
> +		size_per_node = size;
> +		if (node == NUMA_NO_NODE)
> +			size_per_node /= num_online_nodes();
> +		if (size_per_node >= PMD_SIZE)
> +			shift = PMD_SHIFT;
> +	}
> +
> +again:
> +	align = max(real_align, 1UL << shift);
> +	size = ALIGN(real_size, align);

So my suspicion is that the issue on arm64 is related to this.
In the relevant call path, align is 32K whilst the size is 16K

Previously I don't think we force size to be a multiple of align.

I think this results in nr_pages being double what it was before.


> +
> +	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
>  				vm_flags, start, end, node, gfp_mask, caller);
>  	if (!area)
>  		goto fail;
>  
> -	addr = __vmalloc_area_node(area, gfp_mask, prot, node);
> +	addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
>  	if (!addr)
> -		return NULL;
> +		goto fail;
>  
>  	/*
>  	 * In this function, newly allocated vm_struct has VM_UNINITIALIZED
> @@ -2730,8 +2812,16 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	return addr;
>  
>  fail:
> -	warn_alloc(gfp_mask, NULL,
> +	if (shift > PAGE_SHIFT) {
> +		shift = PAGE_SHIFT;
> +		goto again;
> +	}
> +
> +	if (!area) {
> +		/* Warn for area allocation, page allocations already warn */
> +		warn_alloc(gfp_mask, NULL,
>  			  "vmalloc: allocation failure: %lu bytes", real_size);
> +	}
>  	return NULL;
>  }
>  


