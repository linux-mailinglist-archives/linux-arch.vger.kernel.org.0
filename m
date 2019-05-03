Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0B512FB5
	for <lists+linux-arch@lfdr.de>; Fri,  3 May 2019 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfECOB0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 May 2019 10:01:26 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:48110 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfECOB0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 10:01:26 -0400
X-Greylist: delayed 1909 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 May 2019 10:01:24 EDT
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hMYFM-00074d-Bk; Fri, 03 May 2019 13:29:04 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hMYFF-0001a5-CV; Fri, 03 May 2019 14:29:03 +0100
Subject: Re: [PATCH 14/15] um: switch to generic version of pte allocation
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>, linux-mips@vger.kernel.org,
        Guo Ren <guoren@kernel.org>, linux-hexagon@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matt Turner <mattst88@gmail.com>,
        Sam Creasey <sammy@sammy.net>, Arnd Bergmann <arnd@arndb.de>,
        linux-um@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        linux-m68k@lists.linux-m68k.org, Greentime Hu <green.hu@gmail.com>,
        nios2-dev@lists.rocketboards.org, Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-alpha@vger.kernel.org, Ley Foon Tan <lftan@altera.com>,
        linuxppc-dev@lists.ozlabs.org
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
 <1556810922-20248-15-git-send-email-rppt@linux.ibm.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <3fddc076-1843-ee84-febb-44c8d317489f@cambridgegreys.com>
Date:   Fri, 3 May 2019 14:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556810922-20248-15-git-send-email-rppt@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 02/05/2019 16:28, Mike Rapoport wrote:
> um allocates PTE pages with __get_free_page() and uses
> GFP_KERNEL | __GFP_ZERO for the allocations.
> 
> Switch it to the generic version that does exactly the same thing for the
> kernel page tables and adds __GFP_ACCOUNT for the user PTEs.
> 
> The pte_free() and pte_free_kernel() versions are identical to the generic
> ones and can be simply dropped.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/um/include/asm/pgalloc.h | 16 ++--------------
>   arch/um/kernel/mem.c          | 22 ----------------------
>   2 files changed, 2 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
> index 99eb568..d7b282e 100644
> --- a/arch/um/include/asm/pgalloc.h
> +++ b/arch/um/include/asm/pgalloc.h
> @@ -10,6 +10,8 @@
>   
>   #include <linux/mm.h>
>   
> +#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
> +
>   #define pmd_populate_kernel(mm, pmd, pte) \
>   	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) __pa(pte)))
>   
> @@ -25,20 +27,6 @@
>   extern pgd_t *pgd_alloc(struct mm_struct *);
>   extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
>   
> -extern pte_t *pte_alloc_one_kernel(struct mm_struct *);
> -extern pgtable_t pte_alloc_one(struct mm_struct *);
> -
> -static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> -{
> -	free_page((unsigned long) pte);
> -}
> -
> -static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
> -{
> -	pgtable_page_dtor(pte);
> -	__free_page(pte);
> -}
> -
>   #define __pte_free_tlb(tlb,pte, address)		\
>   do {							\
>   	pgtable_page_dtor(pte);				\
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 99aa11b..2280374 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -215,28 +215,6 @@ void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   	free_page((unsigned long) pgd);
>   }
>   
> -pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
> -{
> -	pte_t *pte;
> -
> -	pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
> -	return pte;
> -}
> -
> -pgtable_t pte_alloc_one(struct mm_struct *mm)
> -{
> -	struct page *pte;
> -
> -	pte = alloc_page(GFP_KERNEL|__GFP_ZERO);
> -	if (!pte)
> -		return NULL;
> -	if (!pgtable_page_ctor(pte)) {
> -		__free_page(pte);
> -		return NULL;
> -	}
> -	return pte;
> -}
> -
>   #ifdef CONFIG_3_LEVEL_PGTABLES
>   pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>   {
> 


Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
