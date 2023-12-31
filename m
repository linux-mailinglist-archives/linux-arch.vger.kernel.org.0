Return-Path: <linux-arch+bounces-1212-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCE88209E9
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 07:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AEB283128
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944EE33D3;
	Sun, 31 Dec 2023 06:24:28 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC87D33D1;
	Sun, 31 Dec 2023 06:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DD381C0002;
	Sun, 31 Dec 2023 06:24:22 +0000 (UTC)
Message-ID: <dc5e01b7-010b-4fc7-867b-b738a05becd9@ghiti.fr>
Date: Sun, 31 Dec 2023 07:24:22 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] riscv: tlb: convert __p*d_free_tlb() to inline
 functions
Content-Language: en-US
To: Jisheng Zhang <jszhang@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20231219175046.2496-1-jszhang@kernel.org>
 <20231219175046.2496-3-jszhang@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20231219175046.2496-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

On 19/12/2023 18:50, Jisheng Zhang wrote:
> This is to prepare for enabling MMU_GATHER_RCU_TABLE_FREE.
> No functionality changes.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   arch/riscv/include/asm/pgalloc.h | 54 +++++++++++++++++++-------------
>   1 file changed, 32 insertions(+), 22 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index a12fb83fa1f5..3c5e3bd15f46 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -95,13 +95,16 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>   		__pud_free(mm, pud);
>   }
>   
> -#define __pud_free_tlb(tlb, pud, addr)					\
> -do {									\
> -	if (pgtable_l4_enabled) {					\
> -		pagetable_pud_dtor(virt_to_ptdesc(pud));		\
> -		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
> -	}								\
> -} while (0)
> +static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
> +				  unsigned long addr)
> +{
> +	if (pgtable_l4_enabled) {
> +		struct ptdesc *ptdesc = virt_to_ptdesc(pud);
> +
> +		pagetable_pud_dtor(ptdesc);
> +		tlb_remove_page_ptdesc(tlb, ptdesc);
> +	}
> +}
>   
>   #define p4d_alloc_one p4d_alloc_one
>   static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
> @@ -130,11 +133,12 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>   		__p4d_free(mm, p4d);
>   }
>   
> -#define __p4d_free_tlb(tlb, p4d, addr)					\
> -do {									\
> -	if (pgtable_l5_enabled)						\
> -		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(p4d));	\
> -} while (0)
> +static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
> +				  unsigned long addr)
> +{
> +	if (pgtable_l5_enabled)
> +		tlb_remove_page_ptdesc(tlb, virt_to_ptdesc(p4d));
> +}
>   #endif /* __PAGETABLE_PMD_FOLDED */
>   
>   static inline void sync_kernel_mappings(pgd_t *pgd)
> @@ -159,19 +163,25 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>   
>   #ifndef __PAGETABLE_PMD_FOLDED
>   
> -#define __pmd_free_tlb(tlb, pmd, addr)				\
> -do {								\
> -	pagetable_pmd_dtor(virt_to_ptdesc(pmd));		\
> -	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
> -} while (0)
> +static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
> +				  unsigned long addr)
> +{
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
> +
> +	pagetable_pmd_dtor(ptdesc);
> +	tlb_remove_page_ptdesc(tlb, ptdesc);
> +}
>   
>   #endif /* __PAGETABLE_PMD_FOLDED */
>   
> -#define __pte_free_tlb(tlb, pte, buf)			\
> -do {							\
> -	pagetable_pte_dtor(page_ptdesc(pte));		\
> -	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
> -} while (0)
> +static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
> +				  unsigned long addr)
> +{
> +	struct ptdesc *ptdesc = page_ptdesc(pte);
> +
> +	pagetable_pte_dtor(ptdesc);
> +	tlb_remove_page_ptdesc(tlb, ptdesc);
> +}
>   #endif /* CONFIG_MMU */
>   
>   #endif /* _ASM_RISCV_PGALLOC_H */


You can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


