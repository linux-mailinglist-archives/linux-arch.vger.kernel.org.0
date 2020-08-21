Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192CE24CD65
	for <lists+linux-arch@lfdr.de>; Fri, 21 Aug 2020 07:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgHUFtD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 01:49:03 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4595 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgHUFtD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Aug 2020 01:49:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BXrDW3DBnz9vD3p;
        Fri, 21 Aug 2020 07:48:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id VpnWpAjDVMm5; Fri, 21 Aug 2020 07:48:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BXrDW28hTz9vD3n;
        Fri, 21 Aug 2020 07:48:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 347958B87B;
        Fri, 21 Aug 2020 07:49:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OrIyz0STq1FM; Fri, 21 Aug 2020 07:49:00 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 479D18B75F;
        Fri, 21 Aug 2020 07:48:59 +0200 (CEST)
Subject: Re: [PATCH v5 6/8] mm: Move vmap_range from lib/ioremap.c to
 mm/vmalloc.c
To:     Nicholas Piggin <npiggin@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20200821044427.736424-1-npiggin@gmail.com>
 <20200821044427.736424-7-npiggin@gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <75f426b3-fcaf-c8fc-65b8-a6f501bae1da@csgroup.eu>
Date:   Fri, 21 Aug 2020 07:48:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821044427.736424-7-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 21/08/2020 à 06:44, Nicholas Piggin a écrit :
> This is a generic kernel virtual memory mapper, not specific to ioremap.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/linux/vmalloc.h |   2 +
>   mm/ioremap.c            | 192 ----------------------------------------
>   mm/vmalloc.c            | 191 +++++++++++++++++++++++++++++++++++++++
>   3 files changed, 193 insertions(+), 192 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 787d77ad7536..e3590e93bfff 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -181,6 +181,8 @@ extern struct vm_struct *remove_vm_area(const void *addr);
>   extern struct vm_struct *find_vm_area(const void *addr);
>   
>   #ifdef CONFIG_MMU
> +extern int vmap_range(unsigned long addr, unsigned long end, phys_addr_t phys_addr, pgprot_t prot,
> +			unsigned int max_page_shift);

extern keyword is useless on function prototypes and deprecated. Please 
don't add new function prototypes with that keyword.

>   extern int map_kernel_range_noflush(unsigned long start, unsigned long size,
>   				    pgprot_t prot, struct page **pages);
>   int map_kernel_range(unsigned long start, unsigned long size, pgprot_t prot,

Christophe
