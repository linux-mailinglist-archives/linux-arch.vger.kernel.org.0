Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58F530F65E
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 16:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237178AbhBDPcq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 10:32:46 -0500
Received: from elvis.franken.de ([193.175.24.41]:52299 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237307AbhBDPXy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Feb 2021 10:23:54 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1l7gTM-0005ko-00; Thu, 04 Feb 2021 16:23:08 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C994EC0D54; Thu,  4 Feb 2021 16:22:39 +0100 (CET)
Date:   Thu, 4 Feb 2021 16:22:39 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Huang Pei <huangpei@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ambrosehua@gmail.com, Bibo Mao <maobibo@loongson.cn>,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Paul Burton <paulburton@kernel.org>,
        Li Xuefeng <lixuefeng@loongson.cn>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: [PATCH] MIPS: make userspace mapping young by default
Message-ID: <20210204152239.GA14292@alpha.franken.de>
References: <20210204013942.8398-1-huangpei@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204013942.8398-1-huangpei@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 04, 2021 at 09:39:42AM +0800, Huang Pei wrote:
> MIPS page fault path(except huge page) takes 3 exceptions (1 TLB Miss
> + 2 TLB Invalid), butthe second TLB Invalid exception is just
> triggered by __update_tlb from do_page_fault writing tlb without
> _PAGE_VALID set. With this patch, user space mapping prot is made
> young by default (with both _PAGE_VALID and _PAGE_YOUNG set),
> and it only take 1 TLB Miss + 1 TLB Invalid exception
> 
> Remove pte_sw_mkyoung without polluting MM code and make page fault
> delay of MIPS on par with other architecture
> 
> Signed-off-by: Huang Pei <huangpei@loongson.cn>
> ---
>  arch/mips/mm/cache.c    | 30 ++++++++++++++++--------------
>  include/linux/pgtable.h |  8 --------
>  mm/memory.c             |  3 ---
>  3 files changed, 16 insertions(+), 25 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Andrew, can you take this patch through your tree ?

Thomas.

> 
> diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
> index 23b16bfd97b2..e19cf424bb39 100644
> --- a/arch/mips/mm/cache.c
> +++ b/arch/mips/mm/cache.c
> @@ -156,29 +156,31 @@ unsigned long _page_cachable_default;
>  EXPORT_SYMBOL(_page_cachable_default);
>  
>  #define PM(p)	__pgprot(_page_cachable_default | (p))
> +#define PVA(p)	PM(_PAGE_VALID | _PAGE_ACCESSED | (p))
>  
>  static inline void setup_protection_map(void)
>  {
>  	protection_map[0]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -	protection_map[1]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
> -	protection_map[2]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -	protection_map[3]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
> -	protection_map[4]  = PM(_PAGE_PRESENT);
> -	protection_map[5]  = PM(_PAGE_PRESENT);
> -	protection_map[6]  = PM(_PAGE_PRESENT);
> -	protection_map[7]  = PM(_PAGE_PRESENT);
> +	protection_map[1]  = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
> +	protection_map[2]  = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> +	protection_map[3]  = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
> +	protection_map[4]  = PVA(_PAGE_PRESENT);
> +	protection_map[5]  = PVA(_PAGE_PRESENT);
> +	protection_map[6]  = PVA(_PAGE_PRESENT);
> +	protection_map[7]  = PVA(_PAGE_PRESENT);
>  
>  	protection_map[8]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_NO_READ);
> -	protection_map[9]  = PM(_PAGE_PRESENT | _PAGE_NO_EXEC);
> -	protection_map[10] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE |
> +	protection_map[9]  = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC);
> +	protection_map[10] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE |
>  				_PAGE_NO_READ);
> -	protection_map[11] = PM(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
> -	protection_map[12] = PM(_PAGE_PRESENT);
> -	protection_map[13] = PM(_PAGE_PRESENT);
> -	protection_map[14] = PM(_PAGE_PRESENT | _PAGE_WRITE);
> -	protection_map[15] = PM(_PAGE_PRESENT | _PAGE_WRITE);
> +	protection_map[11] = PVA(_PAGE_PRESENT | _PAGE_NO_EXEC | _PAGE_WRITE);
> +	protection_map[12] = PVA(_PAGE_PRESENT);
> +	protection_map[13] = PVA(_PAGE_PRESENT);
> +	protection_map[14] = PVA(_PAGE_PRESENT);
> +	protection_map[15] = PVA(_PAGE_PRESENT);
>  }
>  
> +#undef _PVA
>  #undef PM
>  
>  void cpu_cache_init(void)
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8fcdfa52eb4b..8c042627399a 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -432,14 +432,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>   * To be differentiate with macro pte_mkyoung, this macro is used on platforms
>   * where software maintains page access bit.
>   */
> -#ifndef pte_sw_mkyoung
> -static inline pte_t pte_sw_mkyoung(pte_t pte)
> -{
> -	return pte;
> -}
> -#define pte_sw_mkyoung	pte_sw_mkyoung
> -#endif
> -
>  #ifndef pte_savedwrite
>  #define pte_savedwrite pte_write
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index feff48e1465a..95718a623884 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2890,7 +2890,6 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  		}
>  		flush_cache_page(vma, vmf->address, pte_pfn(vmf->orig_pte));
>  		entry = mk_pte(new_page, vma->vm_page_prot);
> -		entry = pte_sw_mkyoung(entry);
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  
>  		/*
> @@ -3548,7 +3547,6 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	__SetPageUptodate(page);
>  
>  	entry = mk_pte(page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
>  	if (vma->vm_flags & VM_WRITE)
>  		entry = pte_mkwrite(pte_mkdirty(entry));
>  
> @@ -3824,7 +3822,6 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct page *page)
>  
>  	flush_icache_page(vma, page);
>  	entry = mk_pte(page, vma->vm_page_prot);
> -	entry = pte_sw_mkyoung(entry);
>  	if (write)
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  	/* copy-on-write page */
> -- 
> 2.17.1

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
