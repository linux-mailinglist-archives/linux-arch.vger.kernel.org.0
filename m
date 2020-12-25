Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CDB2E2A5C
	for <lists+linux-arch@lfdr.de>; Fri, 25 Dec 2020 09:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgLYH7S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Dec 2020 02:59:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9650 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbgLYH7R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Dec 2020 02:59:17 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D2K6y53PWz15hnb;
        Fri, 25 Dec 2020 15:57:46 +0800 (CST)
Received: from [10.174.177.80] (10.174.177.80) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 25 Dec 2020 15:58:22 +0800
Subject: Re: [PATCH v9 11/12] mm/vmalloc: Hugepage vmalloc mappings
To:     Nicholas Piggin <npiggin@gmail.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, Zefan Li <lizefan@huawei.com>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
References: <20201205065725.1286370-1-npiggin@gmail.com>
 <20201205065725.1286370-12-npiggin@gmail.com>
From:   Ding Tianhong <dingtianhong@huawei.com>
Message-ID: <7db7564c-0600-33d9-68d9-61fa6fc1bc0d@huawei.com>
Date:   Fri, 25 Dec 2020 15:58:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201205065725.1286370-12-npiggin@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.80]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> +again:
> +	size = PAGE_ALIGN(size);
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
> @@ -2788,8 +2878,19 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  	return addr;
>  
>  fail:
> -	warn_alloc(gfp_mask, NULL,
> +	if (shift > PAGE_SHIFT) {
> +		free_vm_area(area);
> +		shift = PAGE_SHIFT;
> +		align = real_align;
> +		size = real_size;
> +		goto again;
> +	}
> +
Hi, Nicholas:

I met a problem like this:

[   67.103584] ------------[ cut here ]------------
[   67.103884] kernel BUG at vmalloc.c:2892!
[   67.104387] Internal error: Oops - BUG: 0 [#1] SMP
[   67.104942] Process insmod (pid: 1161, stack limit = 0x(____ptrval____))
[   67.105356] CPU: 2 PID: 1161 Comm: insmod Tainted: G           O      4.19.95+ #9
[   67.105702] Hardware name: linux,dummy-virt (DT)
[   67.106006] pstate: a0000005 (NzCv daif -PAN -UAO)
[   67.106285] pc : free_vm_area+0x78/0x80
[   67.106549] lr : free_vm_area+0x58/0x80

it looks like when __vmalloc_area_node failed, the area is already released, and the free_vm_area
will release the vm area again, so trigger the problem.

3405         ret = remove_vm_area(area->addr);
3406         BUG_ON(ret != area);
3407         kfree(area);


Ding
> +	if (!area) {
> +		/* Warn for area allocation, page allocations already warn */
> +		warn_alloc(gfp_mask, NULL,
>  			  "vmalloc: allocation failure: %lu bytes", real_size);
> +	}
>  	return NULL;
>  }
>  
> 

