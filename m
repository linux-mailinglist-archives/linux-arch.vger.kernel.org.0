Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2122C572C
	for <lists+linux-arch@lfdr.de>; Thu, 26 Nov 2020 15:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390854AbgKZOc7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Nov 2020 09:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390631AbgKZOc6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 26 Nov 2020 09:32:58 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EEC42065E;
        Thu, 26 Nov 2020 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606401178;
        bh=5dY8cbJVS6zfD7uZoLaby4Q2OOwNKKL2V1i9udJweeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBpBmf5VIbEXO88WpbzA6/iIU7KMKeADvAYkqkUzwv1+1V2haTEx2Ph0bDJb0KmlY
         s1ebOaFIn/gppwqJN43nLeT+6RcP0IDfD2unluy9hcIsWJUDt1xc18gs4uuGOWCHNg
         0HUeP5Xqav3l1507RgGTmw4lRaV28Zv5UHxU3gi8=
Date:   Thu, 26 Nov 2020 14:32:50 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kan.liang@linux.intel.com, mingo@kernel.org, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, willy@infradead.org,
        aneesh.kumar@linux.ibm.com, sparclinux@vger.kernel.org,
        davem@davemloft.net, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v2 4/6] arm64/mm: Implement pXX_leaf_size() support
Message-ID: <20201126143249.GA18344@willie-the-truck>
References: <20201126120114.071913521@infradead.org>
 <20201126121121.226210959@infradead.org>
 <20201126125747.GG2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126125747.GG2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 26, 2020 at 01:57:47PM +0100, Peter Zijlstra wrote:
> 
> Now with pmd_cont() defined...
> 
> ---
> Subject: arm64/mm: Implement pXX_leaf_size() support
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri Nov 13 11:46:06 CET 2020
> 
> ARM64 has non-pagetable aligned large page support with PTE_CONT, when
> this bit is set the page is part of a super-page. Match the hugetlb
> code and support these super pages for PTE and PMD levels.
> 
> This enables PERF_SAMPLE_{DATA,CODE}_PAGE_SIZE to report accurate
> pagetable leaf sizes.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/pgtable.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -407,6 +407,7 @@ static inline int pmd_trans_huge(pmd_t p
>  #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
>  #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
>  #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
> +#define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
>  #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
>  #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
>  #define pmd_mkwrite(pmd)	pte_pmd(pte_mkwrite(pmd_pte(pmd)))
> @@ -503,6 +504,9 @@ extern pgprot_t phys_mem_access_prot(str
>  				 PMD_TYPE_SECT)
>  #define pmd_leaf(pmd)		pmd_sect(pmd)
>  
> +#define pmd_leaf_size(pmd)	(pmd_cont(pmd) ? CONT_PMD_SIZE : PMD_SIZE)
> +#define pte_leaf_size(pte)	(pte_cont(pte) ? CONT_PTE_SIZE : PAGE_SIZE)
> +
>  #if defined(CONFIG_ARM64_64K_PAGES) || CONFIG_PGTABLE_LEVELS < 3
>  static inline bool pud_sect(pud_t pud) { return false; }
>  static inline bool pud_table(pud_t pud) { return true; }

Acked-by: Will Deacon <will@kernel.org>

I'm still highly dubious about the utility of this feature in perf, since
the TLB entry size is pretty much independent of the page-table
configuration, but that's a problem for all architectures I suspect.

Will
