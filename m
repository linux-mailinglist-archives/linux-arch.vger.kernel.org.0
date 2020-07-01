Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5D721047E
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jul 2020 09:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGAHKm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jul 2020 03:10:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41056 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbgGAHKm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Jul 2020 03:10:42 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B0C0A65D660C38B54DB0;
        Wed,  1 Jul 2020 15:10:40 +0800 (CST)
Received: from [10.174.178.86] (10.174.178.86) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 1 Jul 2020
 15:10:36 +0800
Subject: Re: [PATCH v2 4/4] mm/vmalloc: Hugepage vmalloc mappings
To:     Nicholas Piggin <npiggin@gmail.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200413125303.423864-1-npiggin@gmail.com>
 <20200413125303.423864-5-npiggin@gmail.com>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <d148f86c-b27b-63fb-31d2-35b8f52ec540@huawei.com>
Date:   Wed, 1 Jul 2020 15:10:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200413125303.423864-5-npiggin@gmail.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.86]
X-CFilter-Loop: Reflected
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

>  static void *__vmalloc_node(unsigned long size, unsigned long align,
> -			    gfp_t gfp_mask, pgprot_t prot,
> -			    int node, const void *caller);
> +			gfp_t gfp_mask, pgprot_t prot, unsigned long vm_flags,
> +			int node, const void *caller);
>  static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> -				 pgprot_t prot, int node)
> +				 pgprot_t prot, unsigned int page_shift,
> +				 int node)
>  {
>  	struct page **pages;
> +	unsigned long addr = (unsigned long)area->addr;
> +	unsigned long size = get_vm_area_size(area);
> +	unsigned int page_order = page_shift - PAGE_SHIFT;
>  	unsigned int nr_pages, array_size, i;
>  	const gfp_t nested_gfp = (gfp_mask & GFP_RECLAIM_MASK) | __GFP_ZERO;
>  	const gfp_t alloc_mask = gfp_mask | __GFP_NOWARN;
>  	const gfp_t highmem_mask = (gfp_mask & (GFP_DMA | GFP_DMA32)) ?
> -					0 :
> -					__GFP_HIGHMEM;
> +					0 : __GFP_HIGHMEM;
>  
> -	nr_pages = get_vm_area_size(area) >> PAGE_SHIFT;
> +	nr_pages = size >> page_shift;

while try out this patchset, we encountered a BUG_ON in account_kernel_stack()
in kernel/fork.c.

BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);

which obviously should be updated accordingly.

>  	array_size = (nr_pages * sizeof(struct page *));
>  
>  	/* Please note that the recursion is strictly bounded. */
>  	if (array_size > PAGE_SIZE) {
>  		pages = __vmalloc_node(array_size, 1, nested_gfp|highmem_mask,
> -				PAGE_KERNEL, node, area->caller);
> +				PAGE_KERNEL, 0, node, area->caller);
>  	} else {
>  		pages = kmalloc_node(array_size, nested_gfp, node);
>  	}

