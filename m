Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E0636D5B1
	for <lists+linux-arch@lfdr.de>; Wed, 28 Apr 2021 12:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239304AbhD1KVl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Apr 2021 06:21:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:1232 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239296AbhD1KVi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Apr 2021 06:21:38 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FVZQq457Cz9tT1;
        Wed, 28 Apr 2021 12:20:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lI0TKj8XhRxZ; Wed, 28 Apr 2021 12:20:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FVX2T0p7Cz9w8C;
        Wed, 28 Apr 2021 10:33:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ABB708B800;
        Wed, 28 Apr 2021 10:33:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ul-3gbgTjQKo; Wed, 28 Apr 2021 10:33:04 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 857FE8B799;
        Wed, 28 Apr 2021 10:33:03 +0200 (CEST)
Subject: Re: [PATCH v13 06/14] mm: HUGE_VMAP arch support cleanup
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        linuxppc-dev@lists.ozlabs.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20210317062402.533919-1-npiggin@gmail.com>
 <20210317062402.533919-7-npiggin@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <303a93df-6b32-1b3e-d293-b569e1a4b03e@csgroup.eu>
Date:   Wed, 28 Apr 2021 10:32:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210317062402.533919-7-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 17/03/2021 à 07:23, Nicholas Piggin a écrit :
> This changes the awkward approach where architectures provide init
> functions to determine which levels they can provide large mappings for,
> to one where the arch is queried for each call.
> 
> This removes code and indirection, and allows constant-folding of dead
> code for unsupported levels.
> 
> This also adds a prot argument to the arch query. This is unused
> currently but could help with some architectures (e.g., some powerpc
> processors can't map uncacheable memory with large pages).
> 
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Reviewed-by: Ding Tianhong <dingtianhong@huawei.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com> [arm64]
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   arch/arm64/include/asm/vmalloc.h         |  8 ++
>   arch/arm64/mm/mmu.c                      | 10 +--
>   arch/powerpc/include/asm/vmalloc.h       |  8 ++
>   arch/powerpc/mm/book3s64/radix_pgtable.c |  8 +-
>   arch/x86/include/asm/vmalloc.h           |  7 ++
>   arch/x86/mm/ioremap.c                    | 12 +--
>   include/linux/io.h                       |  9 ---
>   include/linux/vmalloc.h                  |  6 ++
>   init/main.c                              |  1 -
>   mm/debug_vm_pgtable.c                    |  4 +-
>   mm/ioremap.c                             | 94 ++++++++++--------------
>   11 files changed, 87 insertions(+), 80 deletions(-)
> 

> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 3f4d36f9745a..3264d0203785 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -16,49 +16,16 @@
>   #include "pgalloc-track.h"
>   
>   #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -static int __read_mostly ioremap_p4d_capable;
> -static int __read_mostly ioremap_pud_capable;
> -static int __read_mostly ioremap_pmd_capable;
> -static int __read_mostly ioremap_huge_disabled;
> +static bool __ro_after_init iomap_max_page_shift = PAGE_SHIFT;

Must be an int, not a bool.

>   
>   static int __init set_nohugeiomap(char *str)
>   {
> -	ioremap_huge_disabled = 1;
> +	iomap_max_page_shift = P4D_SHIFT;
>   	return 0;
>   }
>   early_param("nohugeiomap", set_nohugeiomap);
> -
> -void __init ioremap_huge_init(void)
> -{
> -	if (!ioremap_huge_disabled) {
> -		if (arch_ioremap_p4d_supported())
> -			ioremap_p4d_capable = 1;
> -		if (arch_ioremap_pud_supported())
> -			ioremap_pud_capable = 1;
> -		if (arch_ioremap_pmd_supported())
> -			ioremap_pmd_capable = 1;
> -	}
> -}
> -
> -static inline int ioremap_p4d_enabled(void)
> -{
> -	return ioremap_p4d_capable;
> -}
> -
> -static inline int ioremap_pud_enabled(void)
> -{
> -	return ioremap_pud_capable;
> -}
> -
> -static inline int ioremap_pmd_enabled(void)
> -{
> -	return ioremap_pmd_capable;
> -}
> -
> -#else	/* !CONFIG_HAVE_ARCH_HUGE_VMAP */
> -static inline int ioremap_p4d_enabled(void) { return 0; }
> -static inline int ioremap_pud_enabled(void) { return 0; }
> -static inline int ioremap_pmd_enabled(void) { return 0; }
> +#else /* CONFIG_HAVE_ARCH_HUGE_VMAP */
> +static const bool iomap_max_page_shift = PAGE_SHIFT;
>   #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
>   
>   static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,

Christophe
