Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12391A222F
	for <lists+linux-arch@lfdr.de>; Wed,  8 Apr 2020 14:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgDHMim (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Apr 2020 08:38:42 -0400
Received: from foss.arm.com ([217.140.110.172]:38334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgDHMim (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Apr 2020 08:38:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87C1331B;
        Wed,  8 Apr 2020 05:38:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ADA83F73D;
        Wed,  8 Apr 2020 05:38:37 -0700 (PDT)
Date:   Wed, 8 Apr 2020 13:38:36 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 18/28] mm: enforce that vmap can't map pages executable
Message-ID: <20200408123835.GB36478@lakrids.cambridge.arm.com>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-19-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115926.1467567-19-hch@lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 08, 2020 at 01:59:16PM +0200, Christoph Hellwig wrote:
> To help enforcing the W^X protection don't allow remapping existing
> pages as executable.
> 
> Based on patch from Peter Zijlstra <peterz@infradead.org>.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/x86/include/asm/pgtable_types.h | 6 ++++++
>  include/asm-generic/pgtable.h        | 4 ++++
>  mm/vmalloc.c                         | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 947867f112ea..2e7c442cc618 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -282,6 +282,12 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
>  
>  typedef struct { pgdval_t pgd; } pgd_t;
>  
> +static inline pgprot_t pgprot_nx(pgprot_t prot)
> +{
> +	return __pgprot(pgprot_val(prot) | _PAGE_NX);
> +}
> +#define pgprot_nx pgprot_nx
> +
>  #ifdef CONFIG_X86_PAE

I reckon for arm64 we can do similar in our <asm/pgtable.h>:

#define pgprot_nx(pgprot_t prot) \
	__pgprot_modify(prot, 0, PTE_PXN)

... matching the style of our existing pgprot_*() modifier helpers.

Mark.

>  
>  /*
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 329b8c8ca703..8c5f9c29698b 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -491,6 +491,10 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>  #define flush_tlb_fix_spurious_fault(vma, address) flush_tlb_page(vma, address)
>  #endif
>  
> +#ifndef pgprot_nx
> +#define pgprot_nx(prot)	(prot)
> +#endif
> +
>  #ifndef pgprot_noncached
>  #define pgprot_noncached(prot)	(prot)
>  #endif
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7356b3f07bd8..334c75251ddb 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2390,7 +2390,7 @@ void *vmap(struct page **pages, unsigned int count,
>  	if (!area)
>  		return NULL;
>  
> -	if (map_kernel_range((unsigned long)area->addr, size, prot,
> +	if (map_kernel_range((unsigned long)area->addr, size, pgprot_nx(prot),
>  			pages) < 0) {
>  		vunmap(area->addr);
>  		return NULL;
> -- 
> 2.25.1
> 
