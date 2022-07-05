Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177A256662C
	for <lists+linux-arch@lfdr.de>; Tue,  5 Jul 2022 11:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiGEJaN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Jul 2022 05:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiGEJ3t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Jul 2022 05:29:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59D21B7;
        Tue,  5 Jul 2022 02:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91317B816A7;
        Tue,  5 Jul 2022 09:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD127C341C7;
        Tue,  5 Jul 2022 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657013385;
        bh=kGkmp8dPxzCCK114+0OM+AKFI00s3XSfhycOZJPJOlk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ulmzVpFf4aXRHwq+z6RYvnhTexooB8AMl3S7I2TeN59zwM5eunXVPWgFl9cM57OpW
         bq6hNbJ1xNpiDZ+Exf8NMU8/+15BNEH8FrQViQJJ2SVWdH9Ahk1ZhB7Rrudygq2+J3
         bR3rdhguoBudEGLYe5xClBPRn4MDtesG1dATflzPN8t6I4Swf5DAmW3Qxe4pvh79Sm
         TpdEgrft+3/r5kInwNblNRWn4DzPuHFvVvjZDJ7xs4FZZDYrrun1Sc3RqyAiS9bJSi
         1bujS052C+AeT6ccnqqZWlaIenIvvTFUk579henLIV1MojIa08mDP2VPX5QcBLYoRt
         LU5PxHa+sIh5A==
Date:   Tue, 5 Jul 2022 10:29:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>
Subject: Re: [PATCH V4 3/4] mm/sparse-vmemmap: Generalise
 vmemmap_populate_hugepages()
Message-ID: <20220705092937.GA552@willie-the-truck>
References: <20220704112526.2492342-1-chenhuacai@loongson.cn>
 <20220704112526.2492342-4-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704112526.2492342-4-chenhuacai@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 04, 2022 at 07:25:25PM +0800, Huacai Chen wrote:
> From: Feiyang Chen <chenfeiyang@loongson.cn>
> 
> Generalise vmemmap_populate_hugepages() so ARM64 & X86 & LoongArch can
> share its implementation.
> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/arm64/mm/mmu.c      | 53 ++++++-----------------
>  arch/loongarch/mm/init.c | 63 ++++++++-------------------
>  arch/x86/mm/init_64.c    | 92 ++++++++++++++--------------------------
>  include/linux/mm.h       |  6 +++
>  mm/sparse-vmemmap.c      | 54 +++++++++++++++++++++++
>  5 files changed, 124 insertions(+), 144 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 626ec32873c6..b080a65c719d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1158,49 +1158,24 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  	return vmemmap_populate_basepages(start, end, node, altmap);
>  }
>  #else	/* !ARM64_KERNEL_USES_PMD_MAPS */
> +void __meminit vmemmap_set_pmd(pmd_t *pmdp, void *p, int node,
> +			       unsigned long addr, unsigned long next)
> +{
> +	pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
> +}
> +
> +int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node, unsigned long addr,
> +				unsigned long next)
> +{
> +	vmemmap_verify((pte_t *)pmdp, node, addr, next);
> +	return 1;
> +}
> +
>  int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  		struct vmem_altmap *altmap)
>  {
> -	unsigned long addr = start;
> -	unsigned long next;
> -	pgd_t *pgdp;
> -	p4d_t *p4dp;
> -	pud_t *pudp;
> -	pmd_t *pmdp;
> -
>  	WARN_ON((start < VMEMMAP_START) || (end > VMEMMAP_END));
> -	do {
> -		next = pmd_addr_end(addr, end);
> -
> -		pgdp = vmemmap_pgd_populate(addr, node);
> -		if (!pgdp)
> -			return -ENOMEM;
> -
> -		p4dp = vmemmap_p4d_populate(pgdp, addr, node);
> -		if (!p4dp)
> -			return -ENOMEM;
> -
> -		pudp = vmemmap_pud_populate(p4dp, addr, node);
> -		if (!pudp)
> -			return -ENOMEM;
> -
> -		pmdp = pmd_offset(pudp, addr);
> -		if (pmd_none(READ_ONCE(*pmdp))) {
> -			void *p = NULL;
> -
> -			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> -			if (!p) {
> -				if (vmemmap_populate_basepages(addr, next, node, altmap))
> -					return -ENOMEM;
> -				continue;
> -			}
> -
> -			pmd_set_huge(pmdp, __pa(p), __pgprot(PROT_SECT_NORMAL));
> -		} else
> -			vmemmap_verify((pte_t *)pmdp, node, addr, next);
> -	} while (addr = next, addr != end);
> -
> -	return 0;
> +	return vmemmap_populate_hugepages(start, end, node, altmap);
>  }
>  #endif	/* !ARM64_KERNEL_USES_PMD_MAPS */


I think the arm64 change is mostly ok (thanks!), but I have a question about
the core code you're introducing:

> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 33e2a1ceee72..6f2e40bb695d 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -686,6 +686,60 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
>  	return vmemmap_populate_range(start, end, node, altmap, NULL);
>  }
>  
> +void __weak __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> +				      unsigned long addr, unsigned long next)
> +{
> +}
> +
> +int __weak __meminit vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
> +				       unsigned long next)
> +{
> +	return 0;
> +}
> +
> +int __meminit vmemmap_populate_hugepages(unsigned long start, unsigned long end,
> +					 int node, struct vmem_altmap *altmap)
> +{
> +	unsigned long addr;
> +	unsigned long next;
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	for (addr = start; addr < end; addr = next) {
> +		next = pmd_addr_end(addr, end);
> +
> +		pgd = vmemmap_pgd_populate(addr, node);
> +		if (!pgd)
> +			return -ENOMEM;
> +
> +		p4d = vmemmap_p4d_populate(pgd, addr, node);
> +		if (!p4d)
> +			return -ENOMEM;
> +
> +		pud = vmemmap_pud_populate(p4d, addr, node);
> +		if (!pud)
> +			return -ENOMEM;
> +
> +		pmd = pmd_offset(pud, addr);
> +		if (pmd_none(READ_ONCE(*pmd))) {
> +			void *p;
> +
> +			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
> +			if (p) {
> +				vmemmap_set_pmd(pmd, p, node, addr, next);
> +				continue;
> +			} else if (altmap)
> +				return -ENOMEM; /* no fallback */

Why do you return -ENOMEM if 'altmap' here? That seems to be different to
what we currently have on arm64 and it's not clear to me why we're happy
with an altmap for the pmd case, but not for the pte case.

Will
