Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55BE916039E
	for <lists+linux-arch@lfdr.de>; Sun, 16 Feb 2020 11:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgBPKlN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Feb 2020 05:41:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28261 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgBPKlN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 16 Feb 2020 05:41:13 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48L3Yv0sRkz9tyM7;
        Sun, 16 Feb 2020 11:41:07 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=v+gbcEDk; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WyvC_D0c5SGS; Sun, 16 Feb 2020 11:41:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48L3Yt6byhz9tyM6;
        Sun, 16 Feb 2020 11:41:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581849666; bh=uYX8/YhQnPSB2yIUz2Iiabdy4hBMITqWSMKEeNzcsUE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=v+gbcEDki2kN7vHEJxzn4fWBIL7Q/3I+0FBhUByo9drALwmhlhMysLr6CcMG4Tb/X
         Z4bTovlfUg5KRdTCIWxMkP3mPM9tSoSf43EJfHHltAPtJWCtCrqKOA8Gx1u5xXKGgL
         NDEaCjEHzsYa4iDa+yCT8tNN28WzZnaXEMbkJvBY=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D90528B784;
        Sun, 16 Feb 2020 11:41:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id VGVzW0Ckh2uU; Sun, 16 Feb 2020 11:41:09 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B4E908B755;
        Sun, 16 Feb 2020 11:41:07 +0100 (CET)
Subject: Re: [PATCH v2 07/13] powerpc: add support for folded p4d page tables
To:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20200216081843.28670-1-rppt@kernel.org>
 <20200216081843.28670-8-rppt@kernel.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c79b363c-a111-389a-5752-51cf85fa8c44@c-s.fr>
Date:   Sun, 16 Feb 2020 11:41:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200216081843.28670-8-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 16/02/2020 à 09:18, Mike Rapoport a écrit :
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Implement primitives necessary for the 4th level folding, add walks of p4d
> level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.

I don't think it is worth adding all this additionnals walks of p4d, 
this patch could be limited to changes like:

-		pud = pud_offset(pgd, gpa);
+		pud = pud_offset(p4d_offset(pgd, gpa), gpa);

The additionnal walks should be added through another patch the day 
powerpc need them.

See below for more comments.

> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # 8xx and 83xx
> ---
>   arch/powerpc/include/asm/book3s/32/pgtable.h  |  1 -
>   arch/powerpc/include/asm/book3s/64/hash.h     |  4 +-
>   arch/powerpc/include/asm/book3s/64/pgalloc.h  |  4 +-
>   arch/powerpc/include/asm/book3s/64/pgtable.h  | 58 ++++++++++--------
>   arch/powerpc/include/asm/book3s/64/radix.h    |  6 +-
>   arch/powerpc/include/asm/nohash/32/pgtable.h  |  1 -
>   arch/powerpc/include/asm/nohash/64/pgalloc.h  |  2 +-
>   .../include/asm/nohash/64/pgtable-4k.h        | 32 +++++-----
>   arch/powerpc/include/asm/nohash/64/pgtable.h  |  6 +-
>   arch/powerpc/include/asm/pgtable.h            |  8 +++
>   arch/powerpc/kvm/book3s_64_mmu_radix.c        | 59 ++++++++++++++++---
>   arch/powerpc/lib/code-patching.c              |  7 ++-
>   arch/powerpc/mm/book3s32/mmu.c                |  2 +-
>   arch/powerpc/mm/book3s32/tlb.c                |  4 +-
>   arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 +-
>   arch/powerpc/mm/book3s64/radix_pgtable.c      | 19 ++++--
>   arch/powerpc/mm/book3s64/subpage_prot.c       |  6 +-
>   arch/powerpc/mm/hugetlbpage.c                 | 28 +++++----
>   arch/powerpc/mm/kasan/kasan_init_32.c         |  8 +--
>   arch/powerpc/mm/mem.c                         |  4 +-
>   arch/powerpc/mm/nohash/40x.c                  |  4 +-
>   arch/powerpc/mm/nohash/book3e_pgtable.c       | 15 +++--
>   arch/powerpc/mm/pgtable.c                     | 25 +++++++-
>   arch/powerpc/mm/pgtable_32.c                  | 28 +++++----
>   arch/powerpc/mm/pgtable_64.c                  | 10 ++--
>   arch/powerpc/mm/ptdump/hashpagetable.c        | 20 ++++++-
>   arch/powerpc/mm/ptdump/ptdump.c               | 22 ++++++-
>   arch/powerpc/xmon/xmon.c                      | 17 +++++-
>   28 files changed, 284 insertions(+), 120 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
> index 5b39c11e884a..39ec11371be0 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
> @@ -2,7 +2,6 @@
>   #ifndef _ASM_POWERPC_BOOK3S_32_PGTABLE_H
>   #define _ASM_POWERPC_BOOK3S_32_PGTABLE_H
>   
> -#define __ARCH_USE_5LEVEL_HACK
>   #include <asm-generic/pgtable-nopmd.h>
>   
>   #include <asm/book3s/32/hash.h>
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 2781ebf6add4..876d1528c2cf 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -134,9 +134,9 @@ static inline int get_region_id(unsigned long ea)
>   
>   #define	hash__pmd_bad(pmd)		(pmd_val(pmd) & H_PMD_BAD_BITS)
>   #define	hash__pud_bad(pud)		(pud_val(pud) & H_PUD_BAD_BITS)
> -static inline int hash__pgd_bad(pgd_t pgd)
> +static inline int hash__p4d_bad(p4d_t p4d)
>   {
> -	return (pgd_val(pgd) == 0);
> +	return (p4d_val(p4d) == 0);
>   }
>   #ifdef CONFIG_STRICT_KERNEL_RWX
>   extern void hash__mark_rodata_ro(void);
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index a41e91bd0580..69c5b051734f 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -85,9 +85,9 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>   	kmem_cache_free(PGT_CACHE(PGD_INDEX_SIZE), pgd);
>   }
>   
> -static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgd, pud_t *pud)
> +static inline void p4d_populate(struct mm_struct *mm, p4d_t *pgd, pud_t *pud)
>   {
> -	*pgd =  __pgd(__pgtable_ptr_val(pud) | PGD_VAL_BITS);
> +	*pgd =  __p4d(__pgtable_ptr_val(pud) | PGD_VAL_BITS);
>   }
>   
>   static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 201a69e6a355..ddddbafff0ab 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -2,7 +2,7 @@
>   #ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
>   #define _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
>   
> -#include <asm-generic/5level-fixup.h>
> +#include <asm-generic/pgtable-nop4d.h>
>   
>   #ifndef __ASSEMBLY__
>   #include <linux/mmdebug.h>
> @@ -251,7 +251,7 @@ extern unsigned long __pmd_frag_size_shift;
>   /* Bits to mask out from a PUD to get to the PMD page */
>   #define PUD_MASKED_BITS		0xc0000000000000ffUL
>   /* Bits to mask out from a PGD to get to the PUD page */
> -#define PGD_MASKED_BITS		0xc0000000000000ffUL
> +#define P4D_MASKED_BITS		0xc0000000000000ffUL
>   
>   /*
>    * Used as an indicator for rcu callback functions
> @@ -949,54 +949,60 @@ static inline bool pud_access_permitted(pud_t pud, bool write)
>   	return pte_access_permitted(pud_pte(pud), write);
>   }
>   
> -#define pgd_write(pgd)		pte_write(pgd_pte(pgd))
> +#define __p4d_raw(x)	((p4d_t) { __pgd_raw(x) })
> +static inline __be64 p4d_raw(p4d_t x)
> +{
> +	return pgd_raw(x.pgd);
> +}
> +

Shouldn't this be defined in asm/pgtable-be-types.h, just like other 
__pxx_raw() ?

> +#define p4d_write(p4d)		pte_write(p4d_pte(p4d))
>   
> -static inline void pgd_clear(pgd_t *pgdp)
> +static inline void p4d_clear(p4d_t *p4dp)
>   {
> -	*pgdp = __pgd(0);
> +	*p4dp = __p4d(0);
>   }
>   
> -static inline int pgd_none(pgd_t pgd)
> +static inline int p4d_none(p4d_t p4d)
>   {
> -	return !pgd_raw(pgd);
> +	return !p4d_raw(p4d);
>   }
>   
> -static inline int pgd_present(pgd_t pgd)
> +static inline int p4d_present(p4d_t p4d)
>   {
> -	return !!(pgd_raw(pgd) & cpu_to_be64(_PAGE_PRESENT));
> +	return !!(p4d_raw(p4d) & cpu_to_be64(_PAGE_PRESENT));
>   }
>   
> -static inline pte_t pgd_pte(pgd_t pgd)
> +static inline pte_t p4d_pte(p4d_t p4d)
>   {
> -	return __pte_raw(pgd_raw(pgd));
> +	return __pte_raw(p4d_raw(p4d));
>   }
>   
> -static inline pgd_t pte_pgd(pte_t pte)
> +static inline p4d_t pte_p4d(pte_t pte)
>   {
> -	return __pgd_raw(pte_raw(pte));
> +	return __p4d_raw(pte_raw(pte));
>   }
>   
> -static inline int pgd_bad(pgd_t pgd)
> +static inline int p4d_bad(p4d_t p4d)
>   {
>   	if (radix_enabled())
> -		return radix__pgd_bad(pgd);
> -	return hash__pgd_bad(pgd);
> +		return radix__p4d_bad(p4d);
> +	return hash__p4d_bad(p4d);
>   }
>   
> -#define pgd_access_permitted pgd_access_permitted
> -static inline bool pgd_access_permitted(pgd_t pgd, bool write)
> +#define p4d_access_permitted p4d_access_permitted
> +static inline bool p4d_access_permitted(p4d_t p4d, bool write)
>   {
> -	return pte_access_permitted(pgd_pte(pgd), write);
> +	return pte_access_permitted(p4d_pte(p4d), write);
>   }
>   
> -extern struct page *pgd_page(pgd_t pgd);
> +extern struct page *p4d_page(p4d_t p4d);
>   
>   /* Pointers in the page table tree are physical addresses */
>   #define __pgtable_ptr_val(ptr)	__pa(ptr)
>   
>   #define pmd_page_vaddr(pmd)	__va(pmd_val(pmd) & ~PMD_MASKED_BITS)
>   #define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
> -#define pgd_page_vaddr(pgd)	__va(pgd_val(pgd) & ~PGD_MASKED_BITS)
> +#define p4d_page_vaddr(p4d)	__va(p4d_val(p4d) & ~P4D_MASKED_BITS)
>   
>   #define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
>   #define pud_index(address) (((address) >> (PUD_SHIFT)) & (PTRS_PER_PUD - 1))
> @@ -1010,8 +1016,8 @@ extern struct page *pgd_page(pgd_t pgd);
>   
>   #define pgd_offset(mm, address)	 ((mm)->pgd + pgd_index(address))
>   
> -#define pud_offset(pgdp, addr)	\
> -	(((pud_t *) pgd_page_vaddr(*(pgdp))) + pud_index(addr))
> +#define pud_offset(p4dp, addr)	\
> +	(((pud_t *) p4d_page_vaddr(*(p4dp))) + pud_index(addr))
>   #define pmd_offset(pudp,addr) \
>   	(((pmd_t *) pud_page_vaddr(*(pudp))) + pmd_index(addr))
>   #define pte_offset_kernel(dir,addr) \
> @@ -1368,6 +1374,12 @@ static inline bool pud_is_leaf(pud_t pud)
>   	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PTE));
>   }
>   
> +#define p4d_is_leaf p4d_is_leaf
> +static inline bool p4d_is_leaf(p4d_t p4d)
> +{
> +	return !!(p4d_raw(p4d) & cpu_to_be64(_PAGE_PTE));
> +}
> +
>   #define pgd_is_leaf pgd_is_leaf
>   #define pgd_leaf pgd_is_leaf
>   static inline bool pgd_is_leaf(pgd_t pgd)

[...]

> diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> index 8cc543ed114c..0a05fddd7881 100644
> --- a/arch/powerpc/include/asm/pgtable.h
> +++ b/arch/powerpc/include/asm/pgtable.h
> @@ -139,6 +139,14 @@ static inline bool pud_is_leaf(pud_t pud)
>   }
>   #endif
>   
> +#ifndef p4d_is_leaf
> +#define p4d_is_leaf p4d_is_leaf
> +static inline bool p4d_is_leaf(p4d_t p4d)
> +{
> +	return false;
> +}
> +#endif
> +
>   #ifndef pgd_is_leaf
>   #define pgd_is_leaf pgd_is_leaf
>   static inline bool pgd_is_leaf(pgd_t pgd)
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> index 803940d79b73..5aacfa0b27ef 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> @@ -494,17 +494,39 @@ static void kvmppc_unmap_free_pud(struct kvm *kvm, pud_t *pud,
>   	pud_free(kvm->mm, pud);
>   }
>   
> +static void kvmppc_unmap_free_p4d(struct kvm *kvm, p4d_t *p4d,
> +				  unsigned int lpid)
> +{
> +	unsigned long iu;
> +	p4d_t *p = p4d;
> +
> +	for (iu = 0; iu < PTRS_PER_P4D; ++iu, ++p) {
> +		if (!p4d_present(*p))
> +			continue;
> +		if (p4d_is_leaf(*p)) {
> +			p4d_clear(p);
> +		} else {
> +			pud_t *pud;
> +
> +			pud = pud_offset(p, 0);
> +			kvmppc_unmap_free_pud(kvm, pud, lpid);
> +			p4d_clear(p);
> +		}
> +	}
> +	p4d_free(kvm->mm, p4d);
> +}
> +
>   void kvmppc_free_pgtable_radix(struct kvm *kvm, pgd_t *pgd, unsigned int lpid)
>   {
>   	unsigned long ig;
>   
>   	for (ig = 0; ig < PTRS_PER_PGD; ++ig, ++pgd) {
> -		pud_t *pud;
> +		p4d_t *p4d;
>   
>   		if (!pgd_present(*pgd))
>   			continue;
> -		pud = pud_offset(pgd, 0);
> -		kvmppc_unmap_free_pud(kvm, pud, lpid);
> +		p4d = p4d_offset(pgd, 0);
> +		kvmppc_unmap_free_p4d(kvm, p4d, lpid);
>   		pgd_clear(pgd);
>   	}
>   }
> @@ -566,6 +588,7 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
>   		      unsigned long *rmapp, struct rmap_nested **n_rmap)
>   {
>   	pgd_t *pgd;
> +	p4d_t *p4d, *new_p4d = NULL;
>   	pud_t *pud, *new_pud = NULL;
>   	pmd_t *pmd, *new_pmd = NULL;
>   	pte_t *ptep, *new_ptep = NULL;
> @@ -573,9 +596,15 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
>   
>   	/* Traverse the guest's 2nd-level tree, allocate new levels needed */
>   	pgd = pgtable + pgd_index(gpa);
> -	pud = NULL;
> +	p4d = NULL;
>   	if (pgd_present(*pgd))
> -		pud = pud_offset(pgd, gpa);
> +		p4d = p4d_offset(pgd, gpa);
> +	else
> +		new_p4d = p4d_alloc_one(kvm->mm, gpa);
> +
> +	pud = NULL;
> +	if (p4d_present(*p4d))
> +		pud = pud_offset(p4d, gpa);

Is it worth adding all this new code ?

My understanding is that the series objective is to get rid of 
__ARCH_HAS_5LEVEL_HACK, to to add support for 5 levels to an 
architecture that not need it (at least for now).
If we want to add support for 5 levels, it can be done later in another 
patch.

Here I think your change could be limited to:

-		pud = pud_offset(pgd, gpa);
+		pud = pud_offset(p4d_offset(pgd, gpa), gpa);


>   	else
>   		new_pud = pud_alloc_one(kvm->mm, gpa);
>   
> @@ -597,12 +626,18 @@ int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
>   	/* Now traverse again under the lock and change the tree */
>   	ret = -ENOMEM;
>   	if (pgd_none(*pgd)) {
> +		if (!new_p4d)
> +			goto out_unlock;
> +		pgd_populate(kvm->mm, pgd, new_p4d);
> +		new_p4d = NULL;
> +	}
> +	if (p4d_none(*p4d)) {
>   		if (!new_pud)
>   			goto out_unlock;
> -		pgd_populate(kvm->mm, pgd, new_pud);
> +		p4d_populate(kvm->mm, p4d, new_pud);
>   		new_pud = NULL;
>   	}
> -	pud = pud_offset(pgd, gpa);
> +	pud = pud_offset(p4d, gpa);
>   	if (pud_is_leaf(*pud)) {
>   		unsigned long hgpa = gpa & PUD_MASK;
>   
> @@ -1220,6 +1255,7 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
>   	pgd_t *pgt;
>   	struct kvm_nested_guest *nested;
>   	pgd_t pgd, *pgdp;
> +	p4d_t p4d, *p4dp;
>   	pud_t pud, *pudp;
>   	pmd_t pmd, *pmdp;
>   	pte_t *ptep;
> @@ -1298,7 +1334,14 @@ static ssize_t debugfs_radix_read(struct file *file, char __user *buf,
>   			continue;
>   		}
>   
> -		pudp = pud_offset(&pgd, gpa);
> +		p4dp = p4d_offset(&pgd, gpa);
> +		p4d = READ_ONCE(*p4dp);
> +		if (!(p4d_val(p4d) & _PAGE_PRESENT)) {
> +			gpa = (gpa & P4D_MASK) + P4D_SIZE;
> +			continue;
> +		}
> +
> +		pudp = pud_offset(&p4d, gpa);

Same, here you are forcing a useless read with READ_ONCE().

Your change could be limited to

-		pudp = pud_offset(&pgd, gpa);
+		pudp = pud_offset(p4d_offset(&pgd, gpa), gpa);

This comment applies to many other places.


>   		pud = READ_ONCE(*pudp);
>   		if (!(pud_val(pud) & _PAGE_PRESENT)) {
>   			gpa = (gpa & PUD_MASK) + PUD_SIZE;
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 3345f039a876..7a59f6863cec 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -107,13 +107,18 @@ static inline int unmap_patch_area(unsigned long addr)
>   	pte_t *ptep;
>   	pmd_t *pmdp;
>   	pud_t *pudp;
> +	p4d_t *p4dp;
>   	pgd_t *pgdp;
>   
>   	pgdp = pgd_offset_k(addr);
>   	if (unlikely(!pgdp))
>   		return -EINVAL;
>   
> -	pudp = pud_offset(pgdp, addr);
> +	p4dp = p4d_offset(pgdp, addr);
> +	if (unlikely(!p4dp))
> +		return -EINVAL;
> +
> +	pudp = pud_offset(p4dp, addr);
>   	if (unlikely(!pudp))
>   		return -EINVAL;
>   
> diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
> index 0a1c65a2c565..b2fc3e71165c 100644
> --- a/arch/powerpc/mm/book3s32/mmu.c
> +++ b/arch/powerpc/mm/book3s32/mmu.c
> @@ -312,7 +312,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea)
>   
>   	if (!Hash)
>   		return;
> -	pmd = pmd_offset(pud_offset(pgd_offset(mm, ea), ea), ea);
> +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, ea), ea), ea), ea);

If we continue like this, in ten years this like is going to be many 
kilometers long.

I think the above would be worth a generic helper.

>   	if (!pmd_none(*pmd))
>   		add_hash_page(mm->context.id, ea, pmd_val(*pmd));
>   }
> diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
> index 2fcd321040ff..175bc33b41b7 100644
> --- a/arch/powerpc/mm/book3s32/tlb.c
> +++ b/arch/powerpc/mm/book3s32/tlb.c
> @@ -87,7 +87,7 @@ static void flush_range(struct mm_struct *mm, unsigned long start,
>   	if (start >= end)
>   		return;
>   	end = (end - 1) | ~PAGE_MASK;
> -	pmd = pmd_offset(pud_offset(pgd_offset(mm, start), start), start);
> +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, start), start), start), start);
>   	for (;;) {
>   		pmd_end = ((start + PGDIR_SIZE) & PGDIR_MASK) - 1;
>   		if (pmd_end > end)
> @@ -145,7 +145,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
>   		return;
>   	}
>   	mm = (vmaddr < TASK_SIZE)? vma->vm_mm: &init_mm;
> -	pmd = pmd_offset(pud_offset(pgd_offset(mm, vmaddr), vmaddr), vmaddr);
> +	pmd = pmd_offset(pud_offset(p4d_offset(pgd_offset(mm, vmaddr), vmaddr), vmaddr), vmaddr);
>   	if (!pmd_none(*pmd))
>   		flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
>   }
> diff --git a/arch/powerpc/mm/book3s64/hash_pgtable.c b/arch/powerpc/mm/book3s64/hash_pgtable.c
> index 64733b9cb20a..9cd15937e88a 100644
> --- a/arch/powerpc/mm/book3s64/hash_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/hash_pgtable.c
> @@ -148,6 +148,7 @@ void hash__vmemmap_remove_mapping(unsigned long start,
>   int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
>   {
>   	pgd_t *pgdp;
> +	p4d_t *p4dp;
>   	pud_t *pudp;
>   	pmd_t *pmdp;
>   	pte_t *ptep;
> @@ -155,7 +156,8 @@ int hash__map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
>   	BUILD_BUG_ON(TASK_SIZE_USER64 > H_PGTABLE_RANGE);
>   	if (slab_is_available()) {
>   		pgdp = pgd_offset_k(ea);
> -		pudp = pud_alloc(&init_mm, pgdp, ea);
> +		p4dp = p4d_offset(pgdp, ea);
> +		pudp = pud_alloc(&init_mm, p4dp, ea);

Could be a single line, without a new var.

-		pudp = pud_alloc(&init_mm, pgdp, ea);
+		pudp = pud_alloc(&init_mm, p4d_offset(pgdp, ea), ea);


Same kind of comments as already done apply to the rest.

Christophe
