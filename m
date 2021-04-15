Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E184360703
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 12:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbhDOKYW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 06:24:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:65295 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231766AbhDOKYW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 06:24:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FLb6P11KFz9vBmb;
        Thu, 15 Apr 2021 12:23:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UXyUUAwc-f7L; Thu, 15 Apr 2021 12:23:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FLb6P0B0nz9vBK7;
        Thu, 15 Apr 2021 12:23:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1299A8B7F6;
        Thu, 15 Apr 2021 12:23:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wlkDENXExdjy; Thu, 15 Apr 2021 12:23:58 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46D9D8B7F2;
        Thu, 15 Apr 2021 12:23:57 +0200 (CEST)
Subject: Re: [PATCH v13 14/14] powerpc/64s/radix: Enable huge vmalloc mappings
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <20210317062402.533919-1-npiggin@gmail.com>
 <20210317062402.533919-15-npiggin@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a5c57276-737d-930b-670c-58dc0c815501@csgroup.eu>
Date:   Thu, 15 Apr 2021 12:23:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210317062402.533919-15-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nick,

Le 17/03/2021 à 07:24, Nicholas Piggin a écrit :
> This reduces TLB misses by nearly 30x on a `git diff` workload on a
> 2-node POWER9 (59,800 -> 2,100) and reduces CPU cycles by 0.54%, due
> to vfs hashes being allocated with 2MB pages.
> 
> Cc: linuxppc-dev@lists.ozlabs.org
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   .../admin-guide/kernel-parameters.txt         |  2 ++
>   arch/powerpc/Kconfig                          |  1 +
>   arch/powerpc/kernel/module.c                  | 22 +++++++++++++++----
>   3 files changed, 21 insertions(+), 4 deletions(-)
> 
> --- a/arch/powerpc/kernel/module.c
> +++ b/arch/powerpc/kernel/module.c
> @@ -8,6 +8,7 @@
>   #include <linux/moduleloader.h>
>   #include <linux/err.h>
>   #include <linux/vmalloc.h>
> +#include <linux/mm.h>
>   #include <linux/bug.h>
>   #include <asm/module.h>
>   #include <linux/uaccess.h>
> @@ -87,13 +88,26 @@ int module_finalize(const Elf_Ehdr *hdr,
>   	return 0;
>   }
>   
> -#ifdef MODULES_VADDR
>   void *module_alloc(unsigned long size)
>   {
> +	unsigned long start = VMALLOC_START;
> +	unsigned long end = VMALLOC_END;
> +
> +#ifdef MODULES_VADDR
>   	BUILD_BUG_ON(TASK_SIZE > MODULES_VADDR);
> +	start = MODULES_VADDR;
> +	end = MODULES_END;
> +#endif
> +
> +	/*
> +	 * Don't do huge page allocations for modules yet until more testing
> +	 * is done. STRICT_MODULE_RWX may require extra work to support this
> +	 * too.
> +	 */
>   
> -	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END, GFP_KERNEL,
> -				    PAGE_KERNEL_EXEC, VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,


I think you should add the following in <asm/pgtable.h>

#ifndef MODULES_VADDR
#define MODULES_VADDR VMALLOC_START
#define MODULES_END VMALLOC_END
#endif

And leave module_alloc() as is (just removing the enclosing #ifdef MODULES_VADDR and adding the 
VM_NO_HUGE_VMAP  flag)

This would minimise the conflits with the changes I did in powerpc/next reported by Stephen R.

> +	return __vmalloc_node_range(size, 1, start, end, GFP_KERNEL,
> +				    PAGE_KERNEL_EXEC,
> +				    VM_NO_HUGE_VMAP | VM_FLUSH_RESET_PERMS,
> +				    NUMA_NO_NODE,
>   				    __builtin_return_address(0));
>   }
> -#endif
> 
