Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2597F5650BC
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jul 2022 11:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbiGDJ1P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jul 2022 05:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiGDJ1I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2022 05:27:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAF5B874;
        Mon,  4 Jul 2022 02:27:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09DC6613F9;
        Mon,  4 Jul 2022 09:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AECC3411E;
        Mon,  4 Jul 2022 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656926826;
        bh=hH3spFHQdwa+gBgAQj1zYN9yiX7A+GyWbQNkSUNtmqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPgH5MviYy9ljQGlgk2YGIiFgQ8NkEu/yXE76JqtS8NDw6dJRXw0NALaVYioW0QRv
         sO7GRsJSFEvCL37fwZTrUV1KRtLzjUd1qcAjSbNHezIvUyPFhpNOdR7R65xhA1Bzna
         xdh4ctJKv6zSFXk1dw18xyL9kStkntDYzzEnIPp/Gw4DO5bMUPhipv3D099StIfaYg
         op2O9GNXgwghxWt0W6k1nPUVzGeYaifFqQdn7NcCRy5D7iijvfoOasn133QL4+KyD7
         qdeWKZuMu8Hl5DMVRekLenYO0rMF8Cmq8lY0fT/jDIcYYM8DJiIfO1RJD7jq2fzpI6
         aGn3RxHukrnKg==
Date:   Mon, 4 Jul 2022 10:26:58 +0100
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
Subject: Re: [PATCH V3 3/4] mm/sparse-vmemmap: Generalise
 vmemmap_populate_hugepages()
Message-ID: <20220704092658.GA31220@willie-the-truck>
References: <20220702080021.1167190-1-chenhuacai@loongson.cn>
 <20220702080021.1167190-4-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702080021.1167190-4-chenhuacai@loongson.cn>
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

On Sat, Jul 02, 2022 at 04:00:20PM +0800, Huacai Chen wrote:
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
> +void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> +			       unsigned long addr, unsigned long next)
> +{
> +	pmd_set_huge(pmd, __pa(p), __pgprot(PROT_SECT_NORMAL));
> +}
> +
> +int __meminit vmemmap_check_pmd(pmd_t *pmd, int node, unsigned long addr,
> +				unsigned long next)
> +{
> +	vmemmap_verify((pte_t *)pmd, node, addr, next);
> +	return 1;
> +}

nit, but please can you use 'pmdp' instead of 'pmd' for the pointers? We're
pretty consistent elsewhere for arch/arm64 and it makes the READ_ONCE()
usage easier to follow once functions end up loading the entry.

Thanks,

Will
