Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473171183BE
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 10:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfLJJge (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 04:36:34 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45078 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJJge (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Dec 2019 04:36:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id d20so19029130ljc.12;
        Tue, 10 Dec 2019 01:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=gXjxkm88DEjZBFBOVgYS/nXq7WpsnAwIahBe1LGrB6M=;
        b=UBiVzNjP9aLMEiA7IC7YrACjXTaPDc9hQMibmR6mvQ2w5h2mcCTC9EkN995AN07C3h
         dbarlfB4UYV1kmfgjxkEetgiW/0lmCFZPD1RV2yf7SMmHbmt5kWl3v8fKQ2C/Tom/sZc
         1A5J74odxics4FORavwIVtIBailZYZvoG6ESd6ppFoWRQ/b6ORBJ5uCeCcEYX6Qdmc5x
         x/g7FCVHEhjHGf7+XfjwozXLtrf0kaajg/vIYnqw9H71l4SuFOrtDO/lztKSviCuXmNj
         2OR9+EoTAXh63GHszKYj1+zJxtYsT8ForpsjXGRBO4gxper4nFuzQ3A5G53npQ/hCq+g
         H1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gXjxkm88DEjZBFBOVgYS/nXq7WpsnAwIahBe1LGrB6M=;
        b=GxDVNASQ8o/xhHSDc0B/OyXRa96/XUbCEuac2Z69R2UjfVqhoVL9cF5QDcQhYRiLjZ
         arPfRIJUFwDonMQyOsqeSrrcxju8UlI11goC2PqjzfdyHCKwXuvTBMpTSlTMNmmgHjW1
         3vPhpl+aTVpnvZAa7J/X7gjRPZrevCNxIHpg1oVhj7uoci+F0dEPSuARH8qo6ArhpLCP
         7+/whB0sUGTbUPoLfBlMEuTPRGrXgX6cEsuG57kQTHoD9DXzTw29/g5TKSJCgtqoJ00n
         Ik1pRSyMSA30jjEwEOEcyHpNKamROmva4wqMZ0jU6h4MPZth0QFAsV2Fd46R7K7rt5EE
         8Law==
X-Gm-Message-State: APjAAAUmTJMdG2SoBzvjN1GvtaB7s/Vb6b6tRb+ZWE9txjQ57gfuEhjK
        s8LVTd+heZ0jx+hVCDrd1y8=
X-Google-Smtp-Source: APXvYqzgHWnb8WU25vCn8dceHQNUvqh7F9YCfgdEcTPnY24QYOgLeeWBuTndcT1N2jJAkfd3EaJ+zA==
X-Received: by 2002:a2e:9015:: with SMTP id h21mr3537646ljg.69.1575970592330;
        Tue, 10 Dec 2019 01:36:32 -0800 (PST)
Received: from [192.168.68.106] ([193.119.54.228])
        by smtp.gmail.com with ESMTPSA id m21sm1186222lfh.53.2019.12.10.01.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 01:36:31 -0800 (PST)
Subject: Re: [PATCH v2 2/4] kasan: use MAX_PTRS_PER_* for early shadow
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com
References: <20191210044714.27265-1-dja@axtens.net>
 <20191210044714.27265-3-dja@axtens.net>
From:   Balbir Singh <bsingharora@gmail.com>
Message-ID: <a31459ee-2019-2f7b-0dc1-235374579508@gmail.com>
Date:   Tue, 10 Dec 2019 20:36:24 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191210044714.27265-3-dja@axtens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 10/12/19 3:47 pm, Daniel Axtens wrote:
> This helps with powerpc support, and should have no effect on
> anything else.
> 
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Daniel Axtens <dja@axtens.net>

If you follow the recommendations by Christophe and I, you don't need this patch

Balbir Singh.

> ---
>  include/linux/kasan.h | 6 +++---
>  mm/kasan/init.c       | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index e18fe54969e9..d2f2a4ffcb12 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -15,9 +15,9 @@ struct task_struct;
>  #include <asm/pgtable.h>
>  
>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> -extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
> -extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
> -extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
> +extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE];
> +extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
> +extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
>  extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>  
>  int kasan_populate_early_shadow(const void *shadow_start,
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index ce45c491ebcd..8b54a96d3b3e 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -46,7 +46,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
>  }
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 3
> -pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
> +pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
>  static inline bool kasan_pud_table(p4d_t p4d)
>  {
>  	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
> @@ -58,7 +58,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
>  }
>  #endif
>  #if CONFIG_PGTABLE_LEVELS > 2
> -pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
> +pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
>  static inline bool kasan_pmd_table(pud_t pud)
>  {
>  	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
> @@ -69,7 +69,7 @@ static inline bool kasan_pmd_table(pud_t pud)
>  	return false;
>  }
>  #endif
> -pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
> +pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE] __page_aligned_bss;
>  
>  static inline bool kasan_pte_table(pmd_t pmd)
>  {
> 
