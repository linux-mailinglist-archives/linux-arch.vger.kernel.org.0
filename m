Return-Path: <linux-arch+bounces-13109-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1ADB2016F
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 10:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0191696A4
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 08:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F262DA750;
	Mon, 11 Aug 2025 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2nv20t+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303B27A123;
	Mon, 11 Aug 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899872; cv=none; b=p3vFf711cxgb4kUeV94gpwko2xMwbezrlLMXwG56HEb2DuRlvDsWsOGHF5f7+q8xJCa9jya5QrCkhPxGXClo/F5yEqafpN8HrywzqHkZwBg3Qsi1oBaJSTO13EWedtlw5VJDl1iTOeLc34uEcazt5mlTVPMJWpKNOyP+vEeteMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899872; c=relaxed/simple;
	bh=P9xSC/pyU0TKP/viaDQllfkMkaKCa/vz5pDoZrB8kPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTlXpgieQ8i3FbH+aRibvHTpEiL7MuD1TNGkMY94/bYuYdHUvNerEBtXWmFg3eR1Z2dq4ZG4NlBJpngvefRhrqZHNBBPXP9++7Pv8nHbNRS5LwyYghtLQUHE7bXWBDJI6Rjdo6IVEZj1Dqiz1E5Hu7GnZKz3GnIcPwVkhhiEtYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2nv20t+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3FBC4CEED;
	Mon, 11 Aug 2025 08:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754899870;
	bh=P9xSC/pyU0TKP/viaDQllfkMkaKCa/vz5pDoZrB8kPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2nv20t+OZ1SVWjStca14ZouasTHG019rln89ZLHpJCT5fVGXCjBcGNlJzzhnNGnd
	 RP77+2hVojJn3LH+sHswmFc35a5N5G07w+BcQBrDSBs1QW5bUe/dQsj5qzclZXne4M
	 gtByfM5ep5DKuNJXxhk/cfKhYb59v1t7gIjaTB3QnEqLbH5ZPGZrzM9r00LQdq+/Os
	 KnSMBGKo5n2ITzDIWtPy6m9ZMghMsI0pJgZHNfLexUzN64C41ZStFX1xVLkPpf45oA
	 UTug/hqzeCWy1SsGLeLOAqvFBVtfUIHJuTfxqqugzkwcs9lr1AcmXQWykziyo1DHTp
	 Q8SAgfcijMLLA==
Date: Mon, 11 Aug 2025 11:10:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Dennis Zhou <dennis@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Hildenbrand <david@redhat.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexander Potapenko <glider@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Huth <thuth@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Alistair Popple <apopple@nvidia.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	linux-arch@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V4 mm-hotfixes 2/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <aJmlj3bG6qb60Me0@kernel.org>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-3-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811053420.10721-3-harry.yoo@oracle.com>

On Mon, Aug 11, 2025 at 02:34:19PM +0900, Harry Yoo wrote:
> Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> populating PGD and P4D entries for the kernel address space.
> These helpers ensure proper synchronization of page tables when
> updating the kernel portion of top-level page tables.
> 
> Until now, the kernel has relied on each architecture to handle
> synchronization of top-level page tables in an ad-hoc manner.
> For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> direct mapping and vmemmap mapping changes").
> 
> However, this approach has proven fragile for following reasons:
> 
>   1) It is easy to forget to perform the necessary page table
>      synchronization when introducing new changes.
>      For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
>      savings for compound devmaps") overlooked the need to synchronize
>      page tables for the vmemmap area.
> 
>   2) It is also easy to overlook that the vmemmap and direct mapping areas
>      must not be accessed before explicit page table synchronization.
>      For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
>      sub-pmd ranges")) caused crashes by accessing the vmemmap area
>      before calling sync_global_pgds().
> 
> To address this, as suggested by Dave Hansen, introduce _kernel() variants
> of the page table population helpers, which invoke architecture-specific
> hooks to properly synchronize page tables. These are introduced in a new
> header file, include/linux/pgalloc.h, so they can be called from common code.
> 
> They reuse existing infrastructure for vmalloc and ioremap.
> Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> and the actual synchronization is performed by arch_sync_kernel_mappings().
> 
> This change currently targets only x86_64, so only PGD and P4D level
> helpers are introduced. In theory, PUD and PMD level helpers can be added
> later if needed by other architectures.
> 
> Currently this is a no-op, since no architecture sets
> PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/pgalloc.h | 24 ++++++++++++++++++++++++
>  include/linux/pgtable.h |  4 ++--
>  mm/kasan/init.c         | 12 ++++++------
>  mm/percpu.c             |  6 +++---
>  mm/sparse-vmemmap.c     |  6 +++---
>  5 files changed, 38 insertions(+), 14 deletions(-)
>  create mode 100644 include/linux/pgalloc.h
> 
> diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
> new file mode 100644
> index 000000000000..290ab864320f
> --- /dev/null
> +++ b/include/linux/pgalloc.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_PGALLOC_H
> +#define _LINUX_PGALLOC_H
> +
> +#include <linux/pgtable.h>
> +#include <asm/pgalloc.h>
> +
> +static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
> +				       p4d_t *p4d)
> +{
> +	pgd_populate(&init_mm, pgd, p4d);
> +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
> +		arch_sync_kernel_mappings(addr, addr);
> +}
> +
> +static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d,
> +				       pud_t *pud)
> +{
> +	p4d_populate(&init_mm, p4d, pud);
> +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
> +		arch_sync_kernel_mappings(addr, addr);
> +}
> +
> +#endif /* _LINUX_PGALLOC_H */
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index ba699df6ef69..0cf5c6c3e483 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1469,8 +1469,8 @@ static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned
>  
>  /*
>   * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> - * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> - * needs to be called.
> + * and let generic vmalloc, ioremap and page table update code know when
> + * arch_sync_kernel_mappings() needs to be called.
>   */
>  #ifndef ARCH_PAGE_TABLE_SYNC_MASK
>  #define ARCH_PAGE_TABLE_SYNC_MASK 0
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index ced6b29fcf76..8fce3370c84e 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -13,9 +13,9 @@
>  #include <linux/mm.h>
>  #include <linux/pfn.h>
>  #include <linux/slab.h>
> +#include <linux/pgalloc.h>
>  
>  #include <asm/page.h>
> -#include <asm/pgalloc.h>
>  
>  #include "kasan.h"
>  
> @@ -191,7 +191,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
>  			pud_t *pud;
>  			pmd_t *pmd;
>  
> -			p4d_populate(&init_mm, p4d,
> +			p4d_populate_kernel(addr, p4d,
>  					lm_alias(kasan_early_shadow_pud));
>  			pud = pud_offset(p4d, addr);
>  			pud_populate(&init_mm, pud,
> @@ -212,7 +212,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
>  			} else {
>  				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
>  				pud_init(p);
> -				p4d_populate(&init_mm, p4d, p);
> +				p4d_populate_kernel(addr, p4d, p);
>  			}
>  		}
>  		zero_pud_populate(p4d, addr, next);
> @@ -251,10 +251,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>  			 * puds,pmds, so pgd_populate(), pud_populate()
>  			 * is noops.
>  			 */
> -			pgd_populate(&init_mm, pgd,
> +			pgd_populate_kernel(addr, pgd,
>  					lm_alias(kasan_early_shadow_p4d));
>  			p4d = p4d_offset(pgd, addr);
> -			p4d_populate(&init_mm, p4d,
> +			p4d_populate_kernel(addr, p4d,
>  					lm_alias(kasan_early_shadow_pud));
>  			pud = pud_offset(p4d, addr);
>  			pud_populate(&init_mm, pud,
> @@ -273,7 +273,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
>  				if (!p)
>  					return -ENOMEM;
>  			} else {
> -				pgd_populate(&init_mm, pgd,
> +				pgd_populate_kernel(addr, pgd,
>  					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
>  			}
>  		}
> diff --git a/mm/percpu.c b/mm/percpu.c
> index d9cbaee92b60..a56f35dcc417 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -3108,7 +3108,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
>  #endif /* BUILD_EMBED_FIRST_CHUNK */
>  
>  #ifdef BUILD_PAGE_FIRST_CHUNK
> -#include <asm/pgalloc.h>
> +#include <linux/pgalloc.h>
>  
>  #ifndef P4D_TABLE_SIZE
>  #define P4D_TABLE_SIZE PAGE_SIZE
> @@ -3134,13 +3134,13 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
>  
>  	if (pgd_none(*pgd)) {
>  		p4d = memblock_alloc_or_panic(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
> -		pgd_populate(&init_mm, pgd, p4d);
> +		pgd_populate_kernel(addr, pgd, p4d);
>  	}
>  
>  	p4d = p4d_offset(pgd, addr);
>  	if (p4d_none(*p4d)) {
>  		pud = memblock_alloc_or_panic(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
> -		p4d_populate(&init_mm, p4d, pud);
> +		p4d_populate_kernel(addr, p4d, pud);
>  	}
>  
>  	pud = pud_offset(p4d, addr);
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 41aa0493eb03..dbd8daccade2 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -27,9 +27,9 @@
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched.h>
> +#include <linux/pgalloc.h>
>  
>  #include <asm/dma.h>
> -#include <asm/pgalloc.h>
>  #include <asm/tlbflush.h>
>  
>  #include "hugetlb_vmemmap.h"
> @@ -229,7 +229,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
>  		if (!p)
>  			return NULL;
>  		pud_init(p);
> -		p4d_populate(&init_mm, p4d, p);
> +		p4d_populate_kernel(addr, p4d, p);
>  	}
>  	return p4d;
>  }
> @@ -241,7 +241,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
>  		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
>  		if (!p)
>  			return NULL;
> -		pgd_populate(&init_mm, pgd, p);
> +		pgd_populate_kernel(addr, pgd, p);
>  	}
>  	return pgd;
>  }
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

