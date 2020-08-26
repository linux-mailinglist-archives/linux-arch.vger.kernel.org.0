Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929CC252D32
	for <lists+linux-arch@lfdr.de>; Wed, 26 Aug 2020 13:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgHZL7x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Aug 2020 07:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbgHZL7x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Aug 2020 07:59:53 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC4C061574;
        Wed, 26 Aug 2020 04:59:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bc4D61TSvz9sPB;
        Wed, 26 Aug 2020 21:59:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1598443190;
        bh=GOzj1DPicMFxSUlas1Q1vx8Ws0Up4IWmSCJigxWCf3c=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V70btNfX/PLjOnzqQvGO3b4JBQQrVQ+MYJhODoTs3ta63dpYfxgkjnEdefQDD9gKk
         XlRlc5uqLNiplsIQuUTrp0oGH4oIWJNP9GVUJQPoT4FU5Q5a+O7aC9o98aVRCDwk0A
         ODcN9kfK4IQHIeiyOdC0fDr1rCL0GJhchyRW7v77qgZvxXx+41peQWogcU11DF+5vn
         XlnUoGwLtvdnpo014boZOVav604iYLNp0ZEYApFGfH3vXOhe44m+s8UBlKyGvwsK/2
         EvwCBsggA12u7rX2osXIO5K7z6RTSUGtSqY3Lhvgfxd/QMaW+wIFPUC6W4Tf+LKzNm
         w1ahRc3PBceew==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v7 06/12] powerpc: inline huge vmap supported functions
In-Reply-To: <20200825145753.529284-7-npiggin@gmail.com>
References: <20200825145753.529284-1-npiggin@gmail.com> <20200825145753.529284-7-npiggin@gmail.com>
Date:   Wed, 26 Aug 2020 21:59:49 +1000
Message-ID: <87lfi1hb2i.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> This allows unsupported levels to be constant folded away, and so
> p4d_free_pud_page can be removed because it's no longer linked to.
>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>
> Ack or objection if this goes via the -mm tree? 

Fine by me if it builds.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/include/asm/vmalloc.h b/arch/powerpc/include/asm/vmalloc.h
> index 105abb73f075..3f0c153befb0 100644
> --- a/arch/powerpc/include/asm/vmalloc.h
> +++ b/arch/powerpc/include/asm/vmalloc.h
> @@ -1,12 +1,25 @@
>  #ifndef _ASM_POWERPC_VMALLOC_H
>  #define _ASM_POWERPC_VMALLOC_H
>  
> +#include <asm/mmu.h>
>  #include <asm/page.h>
>  
>  #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
> -bool arch_vmap_p4d_supported(pgprot_t prot);
> -bool arch_vmap_pud_supported(pgprot_t prot);
> -bool arch_vmap_pmd_supported(pgprot_t prot);
> +static inline bool arch_vmap_p4d_supported(pgprot_t prot)
> +{
> +	return false;
> +}
> +
> +static inline bool arch_vmap_pud_supported(pgprot_t prot)
> +{
> +	/* HPT does not cope with large pages in the vmalloc area */
> +	return radix_enabled();
> +}
> +
> +static inline bool arch_vmap_pmd_supported(pgprot_t prot)
> +{
> +	return radix_enabled();
> +}
>  #endif
>  
>  #endif /* _ASM_POWERPC_VMALLOC_H */
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index eca83a50bf2e..27f5837cf145 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1134,22 +1134,6 @@ void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
>  	set_pte_at(mm, addr, ptep, pte);
>  }
>  
> -bool arch_vmap_pud_supported(pgprot_t prot)
> -{
> -	/* HPT does not cope with large pages in the vmalloc area */
> -	return radix_enabled();
> -}
> -
> -bool arch_vmap_pmd_supported(pgprot_t prot)
> -{
> -	return radix_enabled();
> -}
> -
> -int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
> -{
> -	return 0;
> -}
> -
>  int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>  {
>  	pte_t *ptep = (pte_t *)pud;
> @@ -1233,8 +1217,3 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>  
>  	return 1;
>  }
> -
> -bool arch_vmap_p4d_supported(pgprot_t prot)
> -{
> -	return false;
> -}
> -- 
> 2.23.0
