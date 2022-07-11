Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD165570DAE
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 00:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiGKWzw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jul 2022 18:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiGKWzv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2022 18:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1F6252A4;
        Mon, 11 Jul 2022 15:55:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A07E611E0;
        Mon, 11 Jul 2022 22:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30295C3411C;
        Mon, 11 Jul 2022 22:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657580149;
        bh=306Zt8on93XWkgQdga4uepYhOUdbfhX4MuA93F+mjDg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CK6oxDOms/jOi0NV/YznDDefa7DzL+1hTYbuZsX1ubF2D7Dc5bCKUoODI2BCGJX89
         6NLGGeBf3orU1q8LBrJxMsNrQ0j6cVdbG3FhfCDMN0ZUKz6D4riXo6CB4iwPDRT739
         WOsA0EPpXuYXczd0Z+7ZxV5U8ulJl+qvCV/9mIm8Od50we4E7mN8kQ/5NHAjIteesc
         FN/ZwBzoV7cycc328T5X0MdbBOZh++pvIOcHOY+cxZ32ENLjyEp+N/wTvpM+lrH73/
         OAKQmoBmgIRy7tKoG4wIdPCUTRZq+cWBaLHhQcwgxOs/xFu2GAaqFudOGbWjPVirLB
         ATxDuYv4YevKQ==
Message-ID: <bced9f7f-992d-0965-949f-2682d31a6a2e@kernel.org>
Date:   Mon, 11 Jul 2022 17:55:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 08/15] nios2: drop definition of PGD_ORDER
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Wilcox <willy@infradead.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        WANG Xuerui <kernel@xen0n.name>, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        loongarch@lists.linux.dev
References: <20220705154708.181258-1-rppt@kernel.org>
 <20220705154708.181258-9-rppt@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220705154708.181258-9-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 7/5/22 10:47, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> This is the order of the page table allocation, not the order of a PGD.
> Since its always hardwired to 0, simply drop it.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/nios2/include/asm/pgtable.h | 4 +---
>   arch/nios2/mm/init.c             | 3 +--
>   arch/nios2/mm/pgtable.c          | 2 +-
>   3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
> index eaf8f28baa8b..74af16dafe86 100644
> --- a/arch/nios2/include/asm/pgtable.h
> +++ b/arch/nios2/include/asm/pgtable.h
> @@ -68,9 +68,7 @@ struct mm_struct;
>   
>   #define PAGE_COPY MKP(0, 0, 1)
>   
> -#define PGD_ORDER	0
> -
> -#define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
> +#define PTRS_PER_PGD	(PAGE_SIZE / sizeof(pgd_t))
>   #define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t))
>   
>   #define USER_PTRS_PER_PGD	\
> diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
> index 2d6dbf7701f6..eab65e8ea69c 100644
> --- a/arch/nios2/mm/init.c
> +++ b/arch/nios2/mm/init.c
> @@ -78,8 +78,7 @@ void __init mmu_init(void)
>   	flush_tlb_all();
>   }
>   
> -#define __page_aligned(order) __aligned(PAGE_SIZE << (order))
> -pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
> +pgd_t swapper_pg_dir[PTRS_PER_PGD] __aligned(PAGE_SIZE);
>   pte_t invalid_pte_table[PTRS_PER_PTE] __aligned(PAGE_SIZE);
>   static struct page *kuser_page[1];
>   
> diff --git a/arch/nios2/mm/pgtable.c b/arch/nios2/mm/pgtable.c
> index 9b587fd592dd..7c76e8a7447a 100644
> --- a/arch/nios2/mm/pgtable.c
> +++ b/arch/nios2/mm/pgtable.c
> @@ -54,7 +54,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>   {
>   	pgd_t *ret, *init;
>   
> -	ret = (pgd_t *) __get_free_pages(GFP_KERNEL, PGD_ORDER);
> +	ret = (pgd_t *) __get_free_page(GFP_KERNEL);
>   	if (ret) {
>   		init = pgd_offset(&init_mm, 0UL);
>   		pgd_init(ret);

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
