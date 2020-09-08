Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7934D2609CD
	for <lists+linux-arch@lfdr.de>; Tue,  8 Sep 2020 07:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgIHFGo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Sep 2020 01:06:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:39764 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgIHFGo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Sep 2020 01:06:44 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BltRK1g9Yz9tyWb;
        Tue,  8 Sep 2020 07:06:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NDyhNxhMFPxL; Tue,  8 Sep 2020 07:06:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BltRG5mjlz9tyWZ;
        Tue,  8 Sep 2020 07:06:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7661B8B78B;
        Tue,  8 Sep 2020 07:06:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HWiz5tBjyEqc; Tue,  8 Sep 2020 07:06:35 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3409E8B768;
        Tue,  8 Sep 2020 07:06:31 +0200 (CEST)
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <82fbe8f9-f199-5fc2-4168-eb43ad0b0346@csgroup.eu>
Date:   Tue, 8 Sep 2020 07:06:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 07/09/2020 à 20:00, Gerald Schaefer a écrit :
> From: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> code") introduced a subtle but severe bug on s390 with gup_fast, due to
> dynamic page table folding.
> 
> The question "What would it require for the generic code to work for s390"
> has already been discussed here
> https://lkml.kernel.org/r/20190418100218.0a4afd51@mschwideX1
> and ended with a promising approach here
> https://lkml.kernel.org/r/20190419153307.4f2911b5@mschwideX1
> which in the end unfortunately didn't quite work completely.
> 
> We tried to mimic static level folding by changing pgd_offset to always
> calculate top level page table offset, and do nothing in folded pXd_offset.
> What has been overlooked is that PxD_SIZE/MASK and thus pXd_addr_end do
> not reflect this dynamic behaviour, and still act like static 5-level
> page tables.
> 

[...]

> 
> Fix this by introducing new pXd_addr_end_folded helpers, which take an
> additional pXd entry value parameter, that can be used on s390
> to determine the correct page table level and return corresponding
> end / boundary. With that, the pointer iteration will always
> happen in gup_pgd_range for s390. No change for other architectures
> introduced.

Not sure pXd_addr_end_folded() is the best understandable name, 
allthough I don't have any alternative suggestion at the moment.
Maybe could be something like pXd_addr_end_fixup() as it will disappear 
in the next patch, or pXd_addr_end_gup() ?

Also, if it happens to be acceptable to get patch 2 in stable, I think 
you should switch patch 1 and patch 2 to avoid the step through 
pXd_addr_end_folded()


> 
> Fixes: 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast code")
> Cc: <stable@vger.kernel.org> # 5.2+
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>   arch/s390/include/asm/pgtable.h | 42 +++++++++++++++++++++++++++++++++
>   include/linux/pgtable.h         | 16 +++++++++++++
>   mm/gup.c                        |  8 +++----
>   3 files changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 7eb01a5459cd..027206e4959d 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -512,6 +512,48 @@ static inline bool mm_pmd_folded(struct mm_struct *mm)
>   }
>   #define mm_pmd_folded(mm) mm_pmd_folded(mm)
>   
> +/*
> + * With dynamic page table levels on s390, the static pXd_addr_end() functions
> + * will not return corresponding dynamic boundaries. This is no problem as long
> + * as only pXd pointers are passed down during page table walk, because
> + * pXd_offset() will simply return the given pointer for folded levels, and the
> + * pointer iteration over a range simply happens at the correct page table
> + * level.
> + * It is however a problem with gup_fast, or other places walking the page
> + * tables w/o locks using READ_ONCE(), and passing down the pXd values instead
> + * of pointers. In this case, the pointer given to pXd_offset() is a pointer to
> + * a stack variable, which cannot be used for pointer iteration at the correct
> + * level. Instead, the iteration then has to happen by going up to pgd level
> + * again. To allow this, provide pXd_addr_end_folded() functions with an
> + * additional pXd value parameter, which can be used on s390 to determine the
> + * folding level and return the corresponding boundary.
> + */
> +static inline unsigned long rste_addr_end_folded(unsigned long rste, unsigned long addr, unsigned long end)

What does 'rste' stands for ?

Isn't this line a bit long ?

> +{
> +	unsigned long type = (rste & _REGION_ENTRY_TYPE_MASK) >> 2;
> +	unsigned long size = 1UL << (_SEGMENT_SHIFT + type * 11);
> +	unsigned long boundary = (addr + size) & ~(size - 1);
> +
> +	/*
> +	 * FIXME The below check is for internal testing only, to be removed
> +	 */
> +	VM_BUG_ON(type < (_REGION_ENTRY_TYPE_R3 >> 2));
> +
> +	return (boundary - 1) < (end - 1) ? boundary : end;
> +}
> +
> +#define pgd_addr_end_folded pgd_addr_end_folded
> +static inline unsigned long pgd_addr_end_folded(pgd_t pgd, unsigned long addr, unsigned long end)
> +{
> +	return rste_addr_end_folded(pgd_val(pgd), addr, end);
> +}
> +
> +#define p4d_addr_end_folded p4d_addr_end_folded
> +static inline unsigned long p4d_addr_end_folded(p4d_t p4d, unsigned long addr, unsigned long end)
> +{
> +	return rste_addr_end_folded(p4d_val(p4d), addr, end);
> +}
> +
>   static inline int mm_has_pgste(struct mm_struct *mm)
>   {
>   #ifdef CONFIG_PGSTE
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index e8cbc2e795d5..981c4c2a31fe 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -681,6 +681,22 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>   })
>   #endif
>   
> +#ifndef pgd_addr_end_folded
> +#define pgd_addr_end_folded(pgd, addr, end)	pgd_addr_end(addr, end)
> +#endif
> +
> +#ifndef p4d_addr_end_folded
> +#define p4d_addr_end_folded(p4d, addr, end)	p4d_addr_end(addr, end)
> +#endif
> +
> +#ifndef pud_addr_end_folded
> +#define pud_addr_end_folded(pud, addr, end)	pud_addr_end(addr, end)
> +#endif
> +
> +#ifndef pmd_addr_end_folded
> +#define pmd_addr_end_folded(pmd, addr, end)	pmd_addr_end(addr, end)
> +#endif
> +
>   /*
>    * When walking page tables, we usually want to skip any p?d_none entries;
>    * and any p?d_bad entries - reporting the error before resetting to none.
> diff --git a/mm/gup.c b/mm/gup.c
> index bd883a112724..ba4aace5d0f4 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2521,7 +2521,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
>   	do {
>   		pmd_t pmd = READ_ONCE(*pmdp);
>   
> -		next = pmd_addr_end(addr, end);
> +		next = pmd_addr_end_folded(pmd, addr, end);
>   		if (!pmd_present(pmd))
>   			return 0;
>   
> @@ -2564,7 +2564,7 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>   	do {
>   		pud_t pud = READ_ONCE(*pudp);
>   
> -		next = pud_addr_end(addr, end);
> +		next = pud_addr_end_folded(pud, addr, end);
>   		if (unlikely(!pud_present(pud)))
>   			return 0;
>   		if (unlikely(pud_huge(pud))) {
> @@ -2592,7 +2592,7 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
>   	do {
>   		p4d_t p4d = READ_ONCE(*p4dp);
>   
> -		next = p4d_addr_end(addr, end);
> +		next = p4d_addr_end_folded(p4d, addr, end);
>   		if (p4d_none(p4d))
>   			return 0;
>   		BUILD_BUG_ON(p4d_huge(p4d));
> @@ -2617,7 +2617,7 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
>   	do {
>   		pgd_t pgd = READ_ONCE(*pgdp);
>   
> -		next = pgd_addr_end(addr, end);
> +		next = pgd_addr_end_folded(pgd, addr, end);
>   		if (pgd_none(pgd))
>   			return;
>   		if (unlikely(pgd_huge(pgd))) {
> 

Christophe
