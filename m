Return-Path: <linux-arch+bounces-9568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB61A007DB
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 11:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DD263A3C02
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jan 2025 10:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690071BDA8F;
	Fri,  3 Jan 2025 10:31:35 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96051C1F2F;
	Fri,  3 Jan 2025 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735900295; cv=none; b=eFr0KPn+hEGyeMjU/bnso/6CdoVHAwxIEY2JFnrnO5Ab3OWJ8q8wcLJT2g7d2QsUrjP8p/lL2y+/tc61Jp2LZuhy95Gsu1dLLwqxvLlavBvyY7LjClN4wwCVrVuMZfzCokxmWXcs2iaMyNNp7V+ZcO/8h4afUUv5y8YXvBaL8ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735900295; c=relaxed/simple;
	bh=ISf2N1uOhGVvhDmYf90dbjdofd65v61h99oDmDLOQo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTYJOV6DlM8l5krHSECQyGmb4ubKkLblQcS5KS/ajzWYd9wxvg4xgDDLFXne/5+D9n/QLTuxOq6oG/dZMg3xDmldmFDYGjQWSr2TkEwcJiKISrqMfgJh90xq03dF9rD0512CEZl+sA6TedhqlTr/9qukO2mBk+IBGG/aDx2I9Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A9C3C0007;
	Fri,  3 Jan 2025 10:31:20 +0000 (UTC)
Message-ID: <2aed338a-97a4-40e3-8a95-99458756ca28@ghiti.fr>
Date: Fri, 3 Jan 2025 11:31:19 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] riscv: mm: Skip pgtable level check in
 {pud,p4d}_alloc_one
To: Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, loongarch@lists.linux.dev, x86@kernel.org
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-6-kevin.brodsky@arm.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20241219164425.2277022-6-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Kevin,

On 19/12/2024 17:44, Kevin Brodsky wrote:
> {pmd,pud,p4d}_alloc_one() is never called if the corresponding page
> table level is folded, as {pmd,pud,p4d}_alloc() already does the
> required check. We can therefore remove the runtime page table level
> checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
> the generic version, so we remove it altogether.
>
> This is consistent with the way arm64 and x86 handle this situation
> (runtime check in p4d_free() only).
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>   arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
>   1 file changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index f52264304f77..8ad0bbe838a2 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -12,7 +12,6 @@
>   #include <asm/tlb.h>
>   
>   #ifdef CONFIG_MMU
> -#define __HAVE_ARCH_PUD_ALLOC_ONE
>   #define __HAVE_ARCH_PUD_FREE
>   #include <asm-generic/pgalloc.h>
>   
> @@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
>   	}
>   }
>   
> -#define pud_alloc_one pud_alloc_one
> -static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
> -{
> -	if (pgtable_l4_enabled)
> -		return __pud_alloc_one(mm, addr);
> -
> -	return NULL;
> -}
> -
>   #define pud_free pud_free
>   static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>   {
> @@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>   #define p4d_alloc_one p4d_alloc_one
>   static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
>   {
> -	if (pgtable_l5_enabled) {
> -		gfp_t gfp = GFP_PGTABLE_USER;
> -
> -		if (mm == &init_mm)
> -			gfp = GFP_PGTABLE_KERNEL;
> -		return (p4d_t *)get_zeroed_page(gfp);
> -	}
> +	gfp_t gfp = GFP_PGTABLE_USER;
>   
> -	return NULL;
> +	if (mm == &init_mm)
> +		gfp = GFP_PGTABLE_KERNEL;
> +	return (p4d_t *)get_zeroed_page(gfp);
>   }
>   
>   static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


