Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE37357DDFA
	for <lists+linux-arch@lfdr.de>; Fri, 22 Jul 2022 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiGVJ0A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Jul 2022 05:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiGVJZd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Jul 2022 05:25:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7C2C5D63;
        Fri, 22 Jul 2022 02:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8147EB827B7;
        Fri, 22 Jul 2022 09:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E7CC341C6;
        Fri, 22 Jul 2022 09:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658481372;
        bh=+MdnIBEBIPvCfL0UO13oheMzgvW0x0ZU/P8ra2XGuic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlAtZjYk4YLxZerW3Gw+L9EsV8S+0KUHFSFEfWQJAWGwX8LIUQXTtr+Hypq/IRSL6
         gCuaaAK7vUwsLQOeXljYmU4fUx9+fxxJOhVCrphK+ogWPcS8b7vO8cC8EilpAai/Ok
         puvpJEocCUFS1UzrfhqOEtd7NpuYb5aEjSL7ebZqcLMYxtOFtfgHSwBxRdxTf+SmM/
         XRFaI15q1RMXuIc5QMYMLglNyIuOjqIzIe7kmoK7189EVgKrhqNx9sBY4J2YKv6HNz
         Q4W7b2aIjj7uaUDPsBxLHYegdH5P7rgs1x5oHsS2KVBjKXZiIvM95K7f9QQiYGbC8v
         IMa1+X6PvjVWw==
Date:   Fri, 22 Jul 2022 10:16:05 +0100
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
Subject: Re: [PATCH V5 3/4] mm/sparse-vmemmap: Generalise
 vmemmap_populate_hugepages()
Message-ID: <20220722091604.GD18125@willie-the-truck>
References: <20220721130419.1904711-1-chenhuacai@loongson.cn>
 <20220721130419.1904711-4-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721130419.1904711-4-chenhuacai@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 21, 2022 at 09:04:18PM +0800, Huacai Chen wrote:
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 0abcb0a5f1b5..eafd084b8e19 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -694,6 +694,69 @@ int __meminit vmemmap_populate_basepages(unsigned long start, unsigned long end,
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
> +			} else if (altmap) {
> +				/*
> +				 * No fallback: In any case we care about, the
> +				 * altmap should be reasonably sized and aligned
> +				 * such that vmemmap_alloc_block_buf() will always
> +				 * succeed. If there is no more space in the altmap
> +				 * and we'd have to fallback to PTE (highly unlikely).

Can you tweak the last couple of sentences please, as they don't make sense
to me? To be specific, I'd suggest replacing:

  "If there is no more space in the altmap and we'd have to fallback to PTE
  (highly unlikely). That could indicate an altmap-size configuration
  issue."

with something like:

  "For consistency with the PTE case, return an error here as failure could
   indicate a configuration issue with the size of the altmap."

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
