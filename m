Return-Path: <linux-arch+bounces-9525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0475C9FD99B
	for <lists+linux-arch@lfdr.de>; Sat, 28 Dec 2024 10:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D95F1884DEE
	for <lists+linux-arch@lfdr.de>; Sat, 28 Dec 2024 09:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5578F77F10;
	Sat, 28 Dec 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGvbYYbX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8435958;
	Sat, 28 Dec 2024 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735378005; cv=none; b=UmLuDjrd7nK4T0/HxDYqvFZM4zitam8CQ4r/GQOYakiS/LEv8+oEnPCrJsvNXI/a5MCNDxQmvhMNuWrXHG6ZYi7r/bRpvThIqTiKVk2g8lp+Xo091bO/oD+VXLgIAejFrHYJ5V8/iWHEcF9wn6KbT7kIn/Rp/jin+4ZmTKKQN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735378005; c=relaxed/simple;
	bh=NdwGWxzQ61Bdlc2yCI55C25+yHdt7Yebulv/gpuFIvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6UyAheC+m9wWBB/BOtFHyfquK4fS0wQPOPIOtSnQLYEv9diWlMzNUWXNKVpSrPUwGzW3RbtX0xpYRv9dPuCdEF/ycijngmiRSUrshOGTt32sWlyhhZ/305LMLC1VTxx627bYm5FTXy68y9ApWdduvR2JK2+hHSDC4FaYqdfDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGvbYYbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB08C4CECD;
	Sat, 28 Dec 2024 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735378004;
	bh=NdwGWxzQ61Bdlc2yCI55C25+yHdt7Yebulv/gpuFIvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eGvbYYbXUkvEKK0od8pJgtkaFObAeB0+9Pm8rAB7Sa4zFKTc1py1H/zjuAAR99wb0
	 K2Gw4UfTuwgCfiJ43rGkjewBuPg2hWVlt8XFZiRX9g9/A1kgAj+TlRMWmCbsHDIDXM
	 k/LOdIIcUnaNI2hZ2bByD4wmHFb5M+WaPqL9kcpiFrmnQ7KVbzpyl7hRLwOugzqchJ
	 IqoKyVRRs3BYeTS4GX9BC3Agltc61xGFBJbqqpZ48YhMwv+4cuA7xkdOK8D/YoEOh4
	 82496kSUIGrDQcgNOe4nEvKMCkaq8IcToemFiXbVbl6NSFSNYLOi0XW+B5pq+H8WZH
	 ELopyF5Rw4YZA==
Date: Sat, 28 Dec 2024 11:26:22 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
	tglx@linutronix.de, david@redhat.com, jannh@google.com,
	hughd@google.com, yuzhao@google.com, willy@infradead.org,
	muchun.song@linux.dev, vbabka@kernel.org,
	lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
	rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	dave.hansen@linux.intel.com, ryan.roberts@arm.com,
	linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Message-ID: <Z2_EPmOTUHhcBegW@kernel.org>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
 <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>

On Mon, Dec 23, 2024 at 05:41:01PM +0800, Qi Zheng wrote:
> Here we are explicitly dealing with struct page, and the following logic
> semms strange:
> 
> tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));
> 
> tlb_remove_page_ptdesc
> --> tlb_remove_page(tlb, ptdesc_page(pt));
> 
> So remove tlb_remove_page_ptdesc() and make callers call tlb_remove_page()
> directly.

Please don't. The ptdesc wrappers are there as a part of reducing the size
of struct page project [1]. 

For now struct ptdesc overlaps struct page, but the goal is to have them
separate and always operate on struct ptdesc when working with page tables.

[1] https://kernelnewbies.org/MatthewWilcox/Memdescs
 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/csky/include/asm/pgalloc.h      | 2 +-
>  arch/hexagon/include/asm/pgalloc.h   | 2 +-
>  arch/loongarch/include/asm/pgalloc.h | 2 +-
>  arch/m68k/include/asm/sun3_pgalloc.h | 2 +-
>  arch/mips/include/asm/pgalloc.h      | 2 +-
>  arch/nios2/include/asm/pgalloc.h     | 2 +-
>  arch/openrisc/include/asm/pgalloc.h  | 2 +-
>  arch/riscv/include/asm/pgalloc.h     | 2 +-
>  arch/sh/include/asm/pgalloc.h        | 2 +-
>  arch/um/include/asm/pgalloc.h        | 8 ++++----
>  include/asm-generic/tlb.h            | 6 ------
>  11 files changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
> index f1ce5b7b28f22..936a43a49e704 100644
> --- a/arch/csky/include/asm/pgalloc.h
> +++ b/arch/csky/include/asm/pgalloc.h
> @@ -64,7 +64,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  #define __pte_free_tlb(tlb, pte, address)		\
>  do {							\
>  	pagetable_dtor(page_ptdesc(pte));		\
> -	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
> +	tlb_remove_page(tlb, (pte));			\
>  } while (0)
>  
>  extern void pagetable_init(void);
> diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
> index 40e42a0e71673..8b1550498f1bf 100644
> --- a/arch/hexagon/include/asm/pgalloc.h
> +++ b/arch/hexagon/include/asm/pgalloc.h
> @@ -90,7 +90,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
>  #define __pte_free_tlb(tlb, pte, addr)				\
>  do {								\
>  	pagetable_dtor((page_ptdesc(pte)));			\
> -	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +	tlb_remove_page((tlb), (pte));				\
>  } while (0)
>  
>  #endif
> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
> index 7211dff8c969e..5a4f22aeb6189 100644
> --- a/arch/loongarch/include/asm/pgalloc.h
> +++ b/arch/loongarch/include/asm/pgalloc.h
> @@ -58,7 +58,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  #define __pte_free_tlb(tlb, pte, address)			\
>  do {								\
>  	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
> +	tlb_remove_page((tlb), (pte));				\
>  } while (0)
>  
>  #ifndef __PAGETABLE_PMD_FOLDED
> diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
> index 2b626cb3ad0ae..63d9f95f5e3dd 100644
> --- a/arch/m68k/include/asm/sun3_pgalloc.h
> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
> @@ -20,7 +20,7 @@ extern const char bad_pmd_string[];
>  #define __pte_free_tlb(tlb, pte, addr)				\
>  do {								\
>  	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
> +	tlb_remove_page((tlb), (pte));				\
>  } while (0)
>  
>  static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
> diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
> index 36d9805033c4b..bbee21345154b 100644
> --- a/arch/mips/include/asm/pgalloc.h
> +++ b/arch/mips/include/asm/pgalloc.h
> @@ -57,7 +57,7 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  #define __pte_free_tlb(tlb, pte, address)			\
>  do {								\
>  	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
> +	tlb_remove_page((tlb), (pte));				\
>  } while (0)
>  
>  #ifndef __PAGETABLE_PMD_FOLDED
> diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
> index 12a536b7bfbd4..641cec8fb2a22 100644
> --- a/arch/nios2/include/asm/pgalloc.h
> +++ b/arch/nios2/include/asm/pgalloc.h
> @@ -31,7 +31,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
>  #define __pte_free_tlb(tlb, pte, addr)					\
>  	do {								\
>  		pagetable_dtor(page_ptdesc(pte));			\
> -		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +		tlb_remove_page((tlb), (pte));				\
>  	} while (0)
>  
>  #endif /* _ASM_NIOS2_PGALLOC_H */
> diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
> index 596e2355824e3..e9b9bc53ece0b 100644
> --- a/arch/openrisc/include/asm/pgalloc.h
> +++ b/arch/openrisc/include/asm/pgalloc.h
> @@ -69,7 +69,7 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
>  #define __pte_free_tlb(tlb, pte, addr)				\
>  do {								\
>  	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +	tlb_remove_page((tlb), (pte));				\
>  } while (0)
>  
>  #endif
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index c8907b8317115..ab4f9b2cf9e11 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -29,7 +29,7 @@ static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
>  		tlb_remove_ptdesc(tlb, pt);
>  	} else {
>  		pagetable_dtor(pt);
> -		tlb_remove_page_ptdesc(tlb, pt);
> +		tlb_remove_page(tlb, ptdesc_page((struct ptdesc *)pt));
>  	}
>  }
>  
> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
> index 96d938fdf2244..43812b2363efd 100644
> --- a/arch/sh/include/asm/pgalloc.h
> +++ b/arch/sh/include/asm/pgalloc.h
> @@ -35,7 +35,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>  #define __pte_free_tlb(tlb, pte, addr)				\
>  do {								\
>  	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +	tlb_remove_page((tlb), (pte));				\
>  } while (0)
>  
>  #endif /* __ASM_SH_PGALLOC_H */
> diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
> index f0af23c3aeb2b..98190c318a8e9 100644
> --- a/arch/um/include/asm/pgalloc.h
> +++ b/arch/um/include/asm/pgalloc.h
> @@ -28,7 +28,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *);
>  #define __pte_free_tlb(tlb, pte, address)			\
>  do {								\
>  	pagetable_dtor(page_ptdesc(pte));			\
> -	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
> +	tlb_remove_page((tlb), (pte));				\
>  } while (0)
>  
>  #if CONFIG_PGTABLE_LEVELS > 2
> @@ -36,15 +36,15 @@ do {								\
>  #define __pmd_free_tlb(tlb, pmd, address)			\
>  do {								\
>  	pagetable_dtor(virt_to_ptdesc(pmd));			\
> -	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
> +	tlb_remove_page((tlb), virt_to_page(pmd));		\
>  } while (0)
>  
>  #if CONFIG_PGTABLE_LEVELS > 3
>  
>  #define __pud_free_tlb(tlb, pud, address)			\
>  do {								\
> -	pagetable_dtor(virt_to_ptdesc(pud));		\
> -	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
> +	pagetable_dtor(virt_to_ptdesc(pud));			\
> +	tlb_remove_page((tlb), virt_to_page(pud));		\
>  } while (0)
>  
>  #endif
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 69de47c7ef3c5..8d6cfe5058543 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -504,12 +504,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
>  	tlb_remove_table(tlb, pt);
>  }
>  
> -/* Like tlb_remove_ptdesc, but for page-like page directories. */
> -static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
> -{
> -	tlb_remove_page(tlb, ptdesc_page(pt));
> -}
> -
>  static inline void tlb_change_page_size(struct mmu_gather *tlb,
>  						     unsigned int page_size)
>  {
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

