Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C4C570DAA
	for <lists+linux-arch@lfdr.de>; Tue, 12 Jul 2022 00:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiGKWzV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Jul 2022 18:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiGKWzT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jul 2022 18:55:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6060277A69;
        Mon, 11 Jul 2022 15:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE828B81601;
        Mon, 11 Jul 2022 22:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0F7C34115;
        Mon, 11 Jul 2022 22:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657580114;
        bh=14pnKIJT4xGcd7MxjhIRhm94fsD1jimb9rOIpABahqo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j3qpaHz6AIkJFBeD2OgRxoT8189q2v4Ect7vzDMo7mlAYKpjBl1wQdj9e2Q3FU8we
         01bt32X5/15z3SCQN8lLH1c4XaX1sdOeJyq1LkMjmZt4RC6cLZr/fMX5KI8znDehbA
         EpIRiPXw89kkJ+71ZugqXyOsjZaLQmg0NzB3DsQpnATtWCAwxLHEu2Ndyc1xNTnPyr
         yo4bGdzCuVFqqCN4XE45SgU7Ng33B8iW254Om2wUAp1PUejZZcTTYkjE2T5JEVkjbh
         gLhjoBu+ao52ASgUa2qXUDnWikLQMyg5VryICGW/S46SAjD20gdBZ/TMap8bWVlkSA
         GUfoY0G/YZxVw==
Message-ID: <c5a8eeeb-80fa-b542-e7a3-e0052177ca53@kernel.org>
Date:   Mon, 11 Jul 2022 17:55:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 07/15] nios2: drop definition of PTE_ORDER
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
 <20220705154708.181258-8-rppt@kernel.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220705154708.181258-8-rppt@kernel.org>
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
> This is the order of the page table allocation, not the order of a PTE.
> Since its always hardwired to 0, simply drop it.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/nios2/include/asm/pgtable.h | 3 +--
>   arch/nios2/mm/init.c             | 2 +-
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/pgtable.h b/arch/nios2/include/asm/pgtable.h
> index 262d0609268c..eaf8f28baa8b 100644
> --- a/arch/nios2/include/asm/pgtable.h
> +++ b/arch/nios2/include/asm/pgtable.h
> @@ -69,10 +69,9 @@ struct mm_struct;
>   #define PAGE_COPY MKP(0, 0, 1)
>   
>   #define PGD_ORDER	0
> -#define PTE_ORDER	0
>   
>   #define PTRS_PER_PGD	((PAGE_SIZE << PGD_ORDER) / sizeof(pgd_t))
> -#define PTRS_PER_PTE	((PAGE_SIZE << PTE_ORDER) / sizeof(pte_t))
> +#define PTRS_PER_PTE	(PAGE_SIZE / sizeof(pte_t))
>   
>   #define USER_PTRS_PER_PGD	\
>   	(CONFIG_NIOS2_KERNEL_MMU_REGION_BASE / PGDIR_SIZE)
> diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
> index 613fcaa5988a..2d6dbf7701f6 100644
> --- a/arch/nios2/mm/init.c
> +++ b/arch/nios2/mm/init.c
> @@ -80,7 +80,7 @@ void __init mmu_init(void)
>   
>   #define __page_aligned(order) __aligned(PAGE_SIZE << (order))
>   pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned(PGD_ORDER);
> -pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned(PTE_ORDER);
> +pte_t invalid_pte_table[PTRS_PER_PTE] __aligned(PAGE_SIZE);
>   static struct page *kuser_page[1];
>   
>   static int alloc_kuser_page(void)

Acked-by: Dinh Nguyen <dinguyen@kernel.org>
