Return-Path: <linux-arch+bounces-1245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8512C823415
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7A11C212CC
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jan 2024 18:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E31C2B2;
	Wed,  3 Jan 2024 18:05:29 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6D81C2AE;
	Wed,  3 Jan 2024 18:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBDAC433C7;
	Wed,  3 Jan 2024 18:05:24 +0000 (UTC)
Date: Wed, 3 Jan 2024 18:05:21 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, Nadav Amit <namit@vmware.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Yu Zhao <yuzhao@google.com>,
	x86@kernel.org
Subject: Re: [PATCH 1/2] mm/tlb: fix fullmm semantics
Message-ID: <ZZWh4c3ZUtadFqD1@arm.com>
References: <20231228084642.1765-1-jszhang@kernel.org>
 <20231228084642.1765-2-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228084642.1765-2-jszhang@kernel.org>

On Thu, Dec 28, 2023 at 04:46:41PM +0800, Jisheng Zhang wrote:
> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
> index 846c563689a8..6164c5f3b78f 100644
> --- a/arch/arm64/include/asm/tlb.h
> +++ b/arch/arm64/include/asm/tlb.h
> @@ -62,7 +62,10 @@ static inline void tlb_flush(struct mmu_gather *tlb)
>  	 * invalidating the walk-cache, since the ASID allocator won't
>  	 * reallocate our ASID without invalidating the entire TLB.
>  	 */
> -	if (tlb->fullmm) {
> +	if (tlb->fullmm)
> +		return;
> +
> +	if (tlb->need_flush_all) {
>  		if (!last_level)
>  			flush_tlb_mm(tlb->mm);
>  		return;

I don't think that's correct. IIRC, commit f270ab88fdf2 ("arm64: tlb:
Adjust stride and type of TLBI according to mmu_gather") explicitly
added the !last_level check to invalidate the walk cache (correspondence
between the VA and the page table page rather than the full VA->PA
translation).

> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 129a3a759976..f2d46357bcbb 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -452,7 +452,7 @@ static inline void tlb_flush_mmu_tlbonly(struct mmu_gather *tlb)
>  	 * these bits.
>  	 */
>  	if (!(tlb->freed_tables || tlb->cleared_ptes || tlb->cleared_pmds ||
> -	      tlb->cleared_puds || tlb->cleared_p4ds))
> +	      tlb->cleared_puds || tlb->cleared_p4ds || tlb->need_flush_all))
>  		return;
>  
>  	tlb_flush(tlb);
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index 4f559f4ddd21..79298bac3481 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -384,7 +384,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb)
>  		 * On x86 non-fullmm doesn't yield significant difference
>  		 * against fullmm.
>  		 */
> -		tlb->fullmm = 1;
> +		tlb->need_flush_all = 1;
>  		__tlb_reset_range(tlb);
>  		tlb->freed_tables = 1;
>  	}

The optimisation here was added about a year later in commit
7a30df49f63a ("mm: mmu_gather: remove __tlb_reset_range() for force
flush"). Do we still need to keep freed_tables = 1 here? I'd say only
__tlb_reset_range().

-- 
Catalin

