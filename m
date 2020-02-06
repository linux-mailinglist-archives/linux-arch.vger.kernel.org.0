Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42629153E72
	for <lists+linux-arch@lfdr.de>; Thu,  6 Feb 2020 07:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgBFGGM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Feb 2020 01:06:12 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:11421 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgBFGGM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Feb 2020 01:06:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48CnxF0SxrzB09b9;
        Thu,  6 Feb 2020 07:06:09 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=f4UQnclN; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id j05g7TitYtnk; Thu,  6 Feb 2020 07:06:08 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48CnxD6KPhzB09b8;
        Thu,  6 Feb 2020 07:06:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580969168; bh=C0dWiGjQX9kyjwbOBhkXPvb2XOD9IYbC4c03jrpHs1A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f4UQnclNil89sNzepQ/KrKVg4NcfszxJfzrlLkehSfaKFRPw2BPkZeM4Daaao4PY1
         udG6nlPaVH1TJKx72EWbFpUQIyfttZfM8/fTkLc+YYXOSMzrpAnseVxvpbJTdJtDTK
         MlxAQvTsJrDmzoSqG8nty6MaUGWBUyilk1Mkh+yA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A1D498B78A;
        Thu,  6 Feb 2020 07:06:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id zGNEq76t7uhU; Thu,  6 Feb 2020 07:06:09 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC8588B776;
        Thu,  6 Feb 2020 07:06:07 +0100 (CET)
Subject: Re: [PATCH v6 06/11] powerpc/mm/book3s64/hash: Use functions to track
 lockless pgtbl walks
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Reza Arbab <arbab@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-7-leonardo@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1b65f1a8-42a8-6ffc-3a06-08fbb34edab5@c-s.fr>
Date:   Thu, 6 Feb 2020 07:06:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200206030900.147032-7-leonardo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 06/02/2020 à 04:08, Leonardo Bras a écrit :
> Applies the new tracking functions to all hash-related functions that do
> lockless pagetable walks.
> 
> hash_page_mm: Adds comment that explain that there is no need to
> local_int_disable/save given that it is only called from DataAccess
> interrupt, so interrupts are already disabled.
> 
> local_irq_{save,restore} is already inside {begin,end}_lockless_pgtbl_walk,
> so there is no need to repeat it here.
> 
> Variable that saves the	irq mask was renamed from flags to irq_mask so it
> doesn't lose meaning now it's not directly passed to local_irq_* functions.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>   arch/powerpc/mm/book3s64/hash_tlb.c   |  6 +++---
>   arch/powerpc/mm/book3s64/hash_utils.c | 27 +++++++++++++++++----------
>   2 files changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/hash_tlb.c b/arch/powerpc/mm/book3s64/hash_tlb.c
> index 4a70d8dd39cd..86547c4151f6 100644
> --- a/arch/powerpc/mm/book3s64/hash_tlb.c
> +++ b/arch/powerpc/mm/book3s64/hash_tlb.c
> @@ -194,7 +194,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
>   {
>   	bool is_thp;
>   	int hugepage_shift;
> -	unsigned long flags;
> +	unsigned long irq_mask;
>   
>   	start = _ALIGN_DOWN(start, PAGE_SIZE);
>   	end = _ALIGN_UP(end, PAGE_SIZE);
> @@ -209,7 +209,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
>   	 * to being hashed). This is not the most performance oriented
>   	 * way to do things but is fine for our needs here.
>   	 */
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   	arch_enter_lazy_mmu_mode();
>   	for (; start < end; start += PAGE_SIZE) {
>   		pte_t *ptep = find_current_mm_pte(mm->pgd, start, &is_thp,
> @@ -229,7 +229,7 @@ void __flush_hash_table_range(struct mm_struct *mm, unsigned long start,
>   			hpte_need_flush(mm, start, ptep, pte, hugepage_shift);
>   	}
>   	arch_leave_lazy_mmu_mode();
> -	local_irq_restore(flags);
> +	end_lockless_pgtbl_walk(irq_mask);
>   }
>   
>   void flush_tlb_pmd_range(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index 523d4d39d11e..e6d4ab42173b 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -1341,12 +1341,16 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>   		ea &= ~((1ul << mmu_psize_defs[psize].shift) - 1);
>   #endif /* CONFIG_PPC_64K_PAGES */
>   
> -	/* Get PTE and page size from page tables */
> +	/* Get PTE and page size from page tables :
> +	 * Called in from DataAccess interrupt (data_access_common: 0x300),
> +	 * interrupts are disabled here.
> +	 */

Comments formatting is not in line with Linux kernel rules. Should be no 
text on the first /* line.

> +	__begin_lockless_pgtbl_walk(false);

I think it would be better to not use __begin_lockless_pgtbl_walk() 
directly but keep it in a single place, and define something like 
begin_lockless_pgtbl_walk_noirq() similar to begin_lockless_pgtbl_walk()

>   	ptep = find_linux_pte(pgdir, ea, &is_thp, &hugeshift);
>   	if (ptep == NULL || !pte_present(*ptep)) {
>   		DBG_LOW(" no PTE !\n");
>   		rc = 1;
> -		goto bail;
> +		goto bail_pgtbl_walk;

What's the point in changing the name of this label ? There is only one 
label, why polute the function with so huge name ?

For me, everyone understand what 'bail' means. Unneccessary changes 
should be avoided. If you really really want to do it, it should be 
another patch.

See kernel codying style, chapter 'naming':
"LOCAL variable names should be short". This also applies to labels.

"C is a Spartan language, and so should your naming be. Unlike Modula-2 
and Pascal programmers, C programmers do not use cute names like 
ThisVariableIsATemporaryCounter. A C programmer would call that variable 
tmp, which is much easier to write, and not the least more difficult to 
understand."

>   	}
>   
>   	/* Add _PAGE_PRESENT to the required access perm */
> @@ -1359,7 +1363,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>   	if (!check_pte_access(access, pte_val(*ptep))) {
>   		DBG_LOW(" no access !\n");
>   		rc = 1;
> -		goto bail;
> +		goto bail_pgtbl_walk;
>   	}
>   
>   	if (hugeshift) {
> @@ -1383,7 +1387,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>   		if (current->mm == mm)
>   			check_paca_psize(ea, mm, psize, user_region);
>   
> -		goto bail;
> +		goto bail_pgtbl_walk;
>   	}
>   
>   #ifndef CONFIG_PPC_64K_PAGES
> @@ -1457,6 +1461,8 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
>   #endif
>   	DBG_LOW(" -> rc=%d\n", rc);
>   
> +bail_pgtbl_walk:
> +	__end_lockless_pgtbl_walk(0, false);
>   bail:
>   	exception_exit(prev_state);
>   	return rc;
> @@ -1545,7 +1551,7 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
>   	unsigned long vsid;
>   	pgd_t *pgdir;
>   	pte_t *ptep;
> -	unsigned long flags;
> +	unsigned long irq_mask;
>   	int rc, ssize, update_flags = 0;
>   	unsigned long access = _PAGE_PRESENT | _PAGE_READ | (is_exec ? _PAGE_EXEC : 0);
>   
> @@ -1567,11 +1573,12 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
>   	vsid = get_user_vsid(&mm->context, ea, ssize);
>   	if (!vsid)
>   		return;
> +

Is this new line related to the patch ?

>   	/*
>   	 * Hash doesn't like irqs. Walking linux page table with irq disabled
>   	 * saves us from holding multiple locks.
>   	 */
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   
>   	/*
>   	 * THP pages use update_mmu_cache_pmd. We don't do
> @@ -1616,7 +1623,7 @@ static void hash_preload(struct mm_struct *mm, unsigned long ea,
>   				   mm_ctx_user_psize(&mm->context),
>   				   pte_val(*ptep));
>   out_exit:
> -	local_irq_restore(flags);
> +	end_lockless_pgtbl_walk(irq_mask);
>   }
>   
>   /*
> @@ -1679,16 +1686,16 @@ u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
>   {
>   	pte_t *ptep;
>   	u16 pkey = 0;
> -	unsigned long flags;
> +	unsigned long irq_mask;
>   
>   	if (!mm || !mm->pgd)
>   		return 0;
>   
> -	local_irq_save(flags);
> +	irq_mask = begin_lockless_pgtbl_walk();
>   	ptep = find_linux_pte(mm->pgd, address, NULL, NULL);
>   	if (ptep)
>   		pkey = pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
> -	local_irq_restore(flags);
> +	end_lockless_pgtbl_walk(irq_mask);
>   
>   	return pkey;
>   }
> 

Christophe
