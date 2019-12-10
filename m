Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97079118095
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 07:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfLJGkN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 01:40:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:26716 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbfLJGkN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 01:40:13 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47X9RG3vN1z9vBn0;
        Tue, 10 Dec 2019 07:40:10 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=Ae6vJj2Y; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XNdOmwdsKvbG; Tue, 10 Dec 2019 07:40:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47X9RG2WmWz9vBmy;
        Tue, 10 Dec 2019 07:40:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575960010; bh=OwdtjKhxdr7/aZ16cXB8T6/F98lgPqZDHw00Knn9Q18=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=Ae6vJj2Y8WYNKVmpXMI+6jQcBhSLTkIfBqzUbe8oAXbhnuyUCLQr8P0oWN3n64lOf
         DoarF53cv0oiDeazv87m2+BnSgkEHi3Kn0QzrxRXJTKvn7AJlaxUMflb3RNqy0Eb8O
         07z4e15XGuVOUThOEVeLEr8fe/UK7iOxAqY3tnXI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A7218B803;
        Tue, 10 Dec 2019 07:40:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ITyi-BVxuytF; Tue, 10 Dec 2019 07:40:11 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 135468B802;
        Tue, 10 Dec 2019 07:40:10 +0100 (CET)
Subject: Re: [PATCH v2 2/4] kasan: use MAX_PTRS_PER_* for early shadow
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-3-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <de333171-6697-aabc-70da-c9d593adfb08@c-s.fr>
Date:   Tue, 10 Dec 2019 07:40:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191210044714.27265-3-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



Le 10/12/2019 à 05:47, Daniel Axtens a écrit :
> This helps with powerpc support, and should have no effect on
> anything else.

As explained in previous patch, this patch is based on MAX_PTRS_PER_Pxx 
existing for every arch using KASAN, allthought all arches but powerpc 
will define it as PTRS_PER_Pxx.

I think instead of forcing all arches to define that value, just define 
a fallback in kasan.h (or somewhere else) would help keeping the changes 
to the minimum, see below.

> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>   include/linux/kasan.h | 6 +++---
>   mm/kasan/init.c       | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index e18fe54969e9..d2f2a4ffcb12 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -15,9 +15,9 @@ struct task_struct;
>   #include <asm/pgtable.h>

Add

#ifndef MAX_PTRS_PER_PTE
#define MAX_PTRS_PER_PTE PTRS_PER_PTE
#endif

#ifndef MAX_PTRS_PER_PMD
#define MAX_PTRS_PER_PMD PTRS_PER_PMD
#endif

#ifndef MAX_PTRS_PER_PUD
#define MAX_PTRS_PER_PUD PTRS_PER_PUD
#endif

#ifndef MAX_PTRS_PER_P4D
#define MAX_PTRS_PER_P4D PTRS_PER_P4D
#endif

With that you don't need patch 1.

>   
>   extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> -extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
> -extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
> -extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
> +extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE];
> +extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
> +extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
>   extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>   
>   int kasan_populate_early_shadow(const void *shadow_start,
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index ce45c491ebcd..8b54a96d3b3e 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -46,7 +46,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
>   }
>   #endif
>   #if CONFIG_PGTABLE_LEVELS > 3
> -pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
> +pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
>   static inline bool kasan_pud_table(p4d_t p4d)
>   {
>   	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
> @@ -58,7 +58,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
>   }
>   #endif
>   #if CONFIG_PGTABLE_LEVELS > 2
> -pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
>   static inline bool kasan_pmd_table(pud_t pud)
>   {
>   	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
> @@ -69,7 +69,7 @@ static inline bool kasan_pmd_table(pud_t pud)
>   	return false;
>   }
>   #endif
> -pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
> +pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE] __page_aligned_bss;
>   
>   static inline bool kasan_pte_table(pmd_t pmd)
>   {
> 

Christophe
