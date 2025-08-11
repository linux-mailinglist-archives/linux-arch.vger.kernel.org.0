Return-Path: <linux-arch+bounces-13107-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8FDB20156
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 10:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C85B171EA4
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 08:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8EF19E967;
	Mon, 11 Aug 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyessW4/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D7204863;
	Mon, 11 Aug 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754899567; cv=none; b=t3s36gUC4c1MBa7ehPI90ZF/3ykOr7H5FCy8BgFHPdcDPQt6+a0tk5c8/U0+bCOuadCzGPGNaN0LdWQiIm5FuPVD6/fbKii5Tdp3Qp7TSy1ddMLfXLLU2vNx3BuXq4Sh34VaRecEp8409pnuca/Gp4fIcwpIv0WwzYPO7Q4pqMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754899567; c=relaxed/simple;
	bh=yaMU/nHBhn8GkjD+KNfZv140D6dMpYnx9IMLLJNJ3Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgmF/ovqv0DJZg0KDGrCrZf+vsTwKa+nGAQoY/wcsSfiEY9RRgKyycX9cDz3e37GkuHxurrBbOX42m6OK3DMBttEJf2nHbnVxVmUF61kGeZysRGv3nsPsOXyiiMIOrh+kot8HghlX3KTW3ctyjz7e4+lw7hi7EkIOwxkkQ2EoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyessW4/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C29C4CEED;
	Mon, 11 Aug 2025 08:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754899566;
	bh=yaMU/nHBhn8GkjD+KNfZv140D6dMpYnx9IMLLJNJ3Og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyessW4/T3kSKzJjb0PEMUIXS+OI/MSkBPD9t3M4y8bEwRbREqt2QNPQ+kni4nDL6
	 pzFPvxpE3YkK8MbVjzMMoXWhSKpjhrQZWjSc5pobloPrBebHiwnpclNmoE/ps3dRHf
	 C/w0LubB5PizyfG2oDgOJtjbrGhhjHyK3CoXDWhHhpQhBeujHmu90X10x0d+Wu/YcX
	 BFG6tloNNS5RZuBYHIYfPCKjGsPBNmt5i7FYps5o7aHr7ZiF0e4UFdDedTFdByW6mA
	 Ssv8jadFBOV29pIl5X8xrAkjHAOeYQgfLhQ4wdjRZysgEU5Phahtug5e0BjSDLdnWT
	 LYNqxq6ljOTiw==
Date: Mon, 11 Aug 2025 11:05:51 +0300
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
Subject: Re: [PATCH V4 mm-hotfixes 1/3] mm: move page table sync declarations
 to linux/pgtable.h
Message-ID: <aJmkX3JBhH3F0PEC@kernel.org>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-2-harry.yoo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811053420.10721-2-harry.yoo@oracle.com>

On Mon, Aug 11, 2025 at 02:34:18PM +0900, Harry Yoo wrote:
> Move ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to
> linux/pgtable.h so that they can be used outside of vmalloc and ioremap.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/linux/pgtable.h | 16 ++++++++++++++++
>  include/linux/vmalloc.h | 16 ----------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 4c035637eeb7..ba699df6ef69 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1467,6 +1467,22 @@ static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned
>  }
>  #endif
>  
> +/*
> + * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> + * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()

If ARCH_PAGE_TABLE_SYNC_MASK can be used outside vmalloc(), the comment
needs an update, maybe

... and let the generic code that modifies kernel page tables

Other than that

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> + * needs to be called.
> + */
> +#ifndef ARCH_PAGE_TABLE_SYNC_MASK
> +#define ARCH_PAGE_TABLE_SYNC_MASK 0
> +#endif
> +
> +/*
> + * There is no default implementation for arch_sync_kernel_mappings(). It is
> + * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
> + * is 0.
> + */
> +void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
> +
>  #endif /* CONFIG_MMU */
>  
>  /*
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index fdc9aeb74a44..2759dac6be44 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -219,22 +219,6 @@ extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
>  int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
>  		     struct page **pages, unsigned int page_shift);
>  
> -/*
> - * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
> - * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
> - * needs to be called.
> - */
> -#ifndef ARCH_PAGE_TABLE_SYNC_MASK
> -#define ARCH_PAGE_TABLE_SYNC_MASK 0
> -#endif
> -
> -/*
> - * There is no default implementation for arch_sync_kernel_mappings(). It is
> - * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
> - * is 0.
> - */
> -void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
> -
>  /*
>   *	Lowlevel-APIs (not for driver use!)
>   */
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

