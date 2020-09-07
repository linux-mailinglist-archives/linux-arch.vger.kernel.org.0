Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 579D0260576
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 22:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgIGUQG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 16:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgIGUQF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Sep 2020 16:16:05 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEEA721556;
        Mon,  7 Sep 2020 20:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599509764;
        bh=RAEHj8xYfuFWI4Y+q/aFyLQ3Y81fPmwq73CuPlLtuLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=He38jwjTrF8JsybKdtpkafn6I41PVh9VCu45Rcex2vcAXxwQSXaRmFllsBPIYZ+VL
         vZjgVN2gASyM9VlZJ8s1FxZ73kaEMYdfXeCRo2+tYgHnkcL0pV9msWK3FqjY2+hfQ4
         WUxdkaZyDiiR1eOPP4BI2bi8sU1hW+gyy5K8utdc=
Date:   Mon, 7 Sep 2020 23:15:47 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH v2 3/3] mm: make generic pXd_addr_end() macros inline
 functions
Message-ID: <20200907201547.GD1976319@kernel.org>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

Some style comments below.

On Mon, Sep 07, 2020 at 08:00:58PM +0200, Gerald Schaefer wrote:
> From: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Since pXd_addr_end() macros take pXd page-table entry as a
> parameter it makes sense to check the entry type on compile.
> Even though most archs do not make use of page-table entries
> in pXd_addr_end() calls, checking the type in traversal code
> paths could help to avoid subtle bugs.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>  include/linux/pgtable.h | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 67ebc22cf83d..d9e7d16c2263 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -656,31 +656,35 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>   */
>  
>  #ifndef pgd_addr_end
> -#define pgd_addr_end(pgd, addr, end)					\
> -({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define pgd_addr_end pgd_addr_end
> +static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + PGDIR_SIZE) & PGDIR_MASK;

The code should be on a separate line from the curly brace.
Besides, since this is not a macro anymore, I think it would be nicer to
use 'boundary' without underscores.
This applies to the changes below as well.

> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>  #endif
>  
>  #ifndef p4d_addr_end
> -#define p4d_addr_end(p4d, addr, end)					\
> -({	unsigned long __boundary = ((addr) + P4D_SIZE) & P4D_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define p4d_addr_end p4d_addr_end
> +static inline unsigned long p4d_addr_end(p4d_t p4d, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + P4D_SIZE) & P4D_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>  #endif
>  
>  #ifndef pud_addr_end
> -#define pud_addr_end(pud, addr, end)					\
> -({	unsigned long __boundary = ((addr) + PUD_SIZE) & PUD_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define pud_addr_end pud_addr_end
> +static inline unsigned long pud_addr_end(pud_t pud, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + PUD_SIZE) & PUD_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>  #endif
>  
>  #ifndef pmd_addr_end
> -#define pmd_addr_end(pmd, addr, end)					\
> -({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
> -	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
> -})
> +#define pmd_addr_end pmd_addr_end
> +static inline unsigned long pmd_addr_end(pmd_t pmd, unsigned long addr, unsigned long end)
> +{	unsigned long __boundary = (addr + PMD_SIZE) & PMD_MASK;
> +	return (__boundary - 1 < end - 1) ? __boundary : end;
> +}
>  #endif
>  
>  /*
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.
