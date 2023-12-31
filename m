Return-Path: <linux-arch+bounces-1211-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0567D8209E6
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 07:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DCC1F21E9E
	for <lists+linux-arch@lfdr.de>; Sun, 31 Dec 2023 06:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D601844;
	Sun, 31 Dec 2023 06:21:54 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE66C185D;
	Sun, 31 Dec 2023 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0AFF71C0002;
	Sun, 31 Dec 2023 06:21:38 +0000 (UTC)
Message-ID: <08f55d3e-d68e-406a-9bc9-d62f3c86e949@ghiti.fr>
Date: Sun, 31 Dec 2023 07:21:38 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH 1/4] riscv: tlb: fix __p*d_free_tlb()
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
 <20231219175046.2496-2-jszhang@kernel.org>
Content-Language: en-US
In-Reply-To: <20231219175046.2496-2-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Jisheng,

On 19/12/2023 18:50, Jisheng Zhang wrote:
> If non-leaf PTEs I.E pmd, pud or p4d is modified, a sfence.vma is
> a must for safe, imagine if an implementation caches the non-leaf
> translation in TLB, although I didn't meet this HW so far, but it's
> possible in theory.
>
> Signed-off-by: Jisheng Zhang<jszhang@kernel.org>
> ---
>   arch/riscv/include/asm/pgalloc.h | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index d169a4f41a2e..a12fb83fa1f5 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -95,7 +95,13 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>   		__pud_free(mm, pud);
>   }
>   
> -#define __pud_free_tlb(tlb, pud, addr)  pud_free((tlb)->mm, pud)
> +#define __pud_free_tlb(tlb, pud, addr)					\
> +do {									\
> +	if (pgtable_l4_enabled) {					\
> +		pagetable_pud_dtor(virt_to_ptdesc(pud));		\
> +		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\


The specification indeed states that an sfence.vma must be emitted after 
a page directory modification. Your change is not enough though since 
eventually tlb_flush() is called and in this function we should add:

if (tlb->freed_tables)
     tlb_flush_mm();

otherwise we are not guaranteed that a "global" sfence.vma is called.

Would you be able to benchmark this change and see the performance impact?

Thanks,

Alex


> +	}								\
> +} while (0)
>   
>   #define p4d_alloc_one p4d_alloc_one
>   static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
> @@ -124,7 +130,11 @@ static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>   		__p4d_free(mm, p4d);
>   }
>   
> -#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
> +#define __p4d_free_tlb(tlb, p4d, addr)					\
> +do {									\
> +	if (pgtable_l5_enabled)						\
> +		tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(p4d));	\
> +} while (0)
>   #endif /* __PAGETABLE_PMD_FOLDED */
>   
>   static inline void sync_kernel_mappings(pgd_t *pgd)
> @@ -149,7 +159,11 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>   
>   #ifndef __PAGETABLE_PMD_FOLDED
>   
> -#define __pmd_free_tlb(tlb, pmd, addr)  pmd_free((tlb)->mm, pmd)
> +#define __pmd_free_tlb(tlb, pmd, addr)				\
> +do {								\
> +	pagetable_pmd_dtor(virt_to_ptdesc(pmd));		\
> +	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
> +} while (0)
>   
>   #endif /* __PAGETABLE_PMD_FOLDED */
>   

