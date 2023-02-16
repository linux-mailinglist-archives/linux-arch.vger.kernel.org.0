Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2405A698991
	for <lists+linux-arch@lfdr.de>; Thu, 16 Feb 2023 01:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBPA7y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 19:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBPA7v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 19:59:51 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ED422000
        for <linux-arch@vger.kernel.org>; Wed, 15 Feb 2023 16:59:50 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id mg23so388881pjb.0
        for <linux-arch@vger.kernel.org>; Wed, 15 Feb 2023 16:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpHQhzeyzL5wD6cZybCHw0C081RE1xl3jXGOGKhpSHc=;
        b=BQTA+Db/5dUfeEZto6bJS/MbnGO3ZD5hXIRPrej7JH5TEgw7bl03VPxjQEv0GiZ6FO
         DHHRPc7s2ay4VWWigo8PljTia413U8vrJrVfuRBnttCQzcKPG3UH7PLxxrsiGjApRQIQ
         22y0byBAuVO08L8BAfmMPewvYtQTEF8AqOJjmaspZF799pi/rQ1JjmKMjdNjJWpV5t1D
         AameQMn+kU8kJdBAFO114OFMf1+HukRDrhcGnw4mbMOREhcM0l6uYcKm/M9zau/wjUFL
         LW7EBP4u0wPXTAOsmqjIMFBbN40bpkwVQnj01jdTGxfx9SUPfzK1VAK+Apmf23B9RlvQ
         PAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpHQhzeyzL5wD6cZybCHw0C081RE1xl3jXGOGKhpSHc=;
        b=aCaRY6lf9HVXHZzUlpALmJXxs9VX1pbdaA6LYWmvwXyZmGn7x007O7AqtPMllqAgpB
         R/VNXbXMNRJiXD5TQeYaXy8Lh7g/WytEjKWyS9ni6gjFlKCMYo6r3gpQJOTvUDeguz3k
         Sw4gpyQFENOpwTkfpnjVsvlMdbMZj2dlS2BxQp8l3U+chP9oHNyMpNCwEanOVJ4mY/NI
         7GW0ElzdoT4PM2ZRG06b6Dz73iFg/17Vp1X/9pZf8WqZ1Q1t4bxgwB/aXE2nJhvPYOEj
         /DMVLL1y175GlQ08n2JajQq0WDz0vqOXZf1x7R35pbElGw+XZC/7WDpKWq9U6eLPOx6y
         kkpA==
X-Gm-Message-State: AO0yUKWvgwVPU/DRjzGDYVfGKsrFlraNoq2ZqbNDGBHvpBYzZvpvMHTu
        ZPZNjW6SjFIz0rYDg5bWQAONIUP25bA=
X-Google-Smtp-Source: AK7set9luO9T3j6foSqzsOaMOecYdtmK+BrOQ5wXWoT7IBdAJRugwBFrd2VAWQLwjg6ebn3RF6BNDg==
X-Received: by 2002:a17:90b:380e:b0:22b:f622:56ae with SMTP id mq14-20020a17090b380e00b0022bf62256aemr4926750pjb.23.1676509190042;
        Wed, 15 Feb 2023 16:59:50 -0800 (PST)
Received: from ?IPV6:2001:df0:0:200c:cd94:f395:2261:621f? ([2001:df0:0:200c:cd94:f395:2261:621f])
        by smtp.gmail.com with ESMTPSA id m6-20020a17090a858600b00233e8a83853sm207269pjn.34.2023.02.15.16.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 16:59:49 -0800 (PST)
Message-ID: <84c923f7-c60b-068d-bb06-48aea1412f53@gmail.com>
Date:   Thu, 16 Feb 2023 13:59:44 +1300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 15/17] m68k: Implement the new page table range API
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-arch@vger.kernel.org
References: <20230215000446.1655635-1-willy@infradead.org>
 <20230215200920.1849567-1-willy@infradead.org>
 <20230215200920.1849567-2-willy@infradead.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <20230215200920.1849567-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Matthew,

On 16/02/23 09:09, Matthew Wilcox (Oracle) wrote:
> Add set_ptes(), update_mmu_cache_range(), flush_icache_pages() and
> flush_dcache_folio().  I'm not entirely certain that the 040/060 case
> in __flush_pages_to_ram() is correct.

I'm pretty sure you need to iterate to hit each of the pages - the code 
as is will only push cache entries for the first page.

Quoting the 040 UM:

"Both instructions [cinv, cpush] allow operation on a single cache line, 
all cache lines in a specific page, or an entire cache, and can select 
one or both caches for the operation. For line and page operations, a 
physical address in an address register specifies the memory address."

Cheers,

     Michael


> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   arch/m68k/include/asm/cacheflush_mm.h | 12 ++++++++----
>   arch/m68k/include/asm/pgtable_mm.h    | 21 ++++++++++++++++++---
>   arch/m68k/mm/motorola.c               |  2 +-
>   3 files changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/arch/m68k/include/asm/cacheflush_mm.h b/arch/m68k/include/asm/cacheflush_mm.h
> index 1ac55e7b47f0..2244c35178d0 100644
> --- a/arch/m68k/include/asm/cacheflush_mm.h
> +++ b/arch/m68k/include/asm/cacheflush_mm.h
> @@ -220,13 +220,13 @@ static inline void flush_cache_page(struct vm_area_struct *vma, unsigned long vm
>   
>   /* Push the page at kernel virtual address and clear the icache */
>   /* RZ: use cpush %bc instead of cpush %dc, cinv %ic */
> -static inline void __flush_page_to_ram(void *vaddr)
> +static inline void __flush_pages_to_ram(void *vaddr, unsigned int nr)
>   {
>   	if (CPU_IS_COLDFIRE) {
>   		unsigned long addr, start, end;
>   		addr = ((unsigned long) vaddr) & ~(PAGE_SIZE - 1);
>   		start = addr & ICACHE_SET_MASK;
> -		end = (addr + PAGE_SIZE - 1) & ICACHE_SET_MASK;
> +		end = (addr + nr * PAGE_SIZE - 1) & ICACHE_SET_MASK;
>   		if (start > end) {
>   			flush_cf_bcache(0, end);
>   			end = ICACHE_MAX_ADDR;
> @@ -249,10 +249,14 @@ static inline void __flush_page_to_ram(void *vaddr)
>   }
>   
>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
> -#define flush_dcache_page(page)		__flush_page_to_ram(page_address(page))
> +#define flush_dcache_page(page)	__flush_pages_to_ram(page_address(page), 1)
> +#define flush_dcache_folio(folio)		\
> +	__flush_pages_to_ram(folio_address(folio), folio_nr_pages(folio))
>   #define flush_dcache_mmap_lock(mapping)		do { } while (0)
>   #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
> -#define flush_icache_page(vma, page)	__flush_page_to_ram(page_address(page))
> +#define flush_icache_pages(vma, page, nr)	\
> +	__flush_pages_to_ram(page_address(page), nr)
> +#define flush_icache_page(vma, page) flush_icache_pages(vma, page, 1)
>   
>   extern void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
>   				    unsigned long addr, int len);
> diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
> index b93c41fe2067..400206c17c97 100644
> --- a/arch/m68k/include/asm/pgtable_mm.h
> +++ b/arch/m68k/include/asm/pgtable_mm.h
> @@ -31,8 +31,20 @@
>   	do{							\
>   		*(pteptr) = (pteval);				\
>   	} while(0)
> -#define set_pte_at(mm,addr,ptep,pteval) set_pte(ptep,pteval)
>   
> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
> +		pte_t *ptep, pte_t pte, unsigned int nr)
> +{
> +	for (;;) {
> +		set_pte(ptep, pte);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		pte_val(pte) += PAGE_SIZE;
> +	}
> +}
> +
> +#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
>   
>   /* PMD_SHIFT determines the size of the area a second-level page table can map */
>   #if CONFIG_PGTABLE_LEVELS == 3
> @@ -138,11 +150,14 @@ extern void kernel_set_cachemode(void *addr, unsigned long size, int cmode);
>    * tables contain all the necessary information.  The Sun3 does, but
>    * they are updated on demand.
>    */
> -static inline void update_mmu_cache(struct vm_area_struct *vma,
> -				    unsigned long address, pte_t *ptep)
> +static inline void update_mmu_cache_range(struct vm_area_struct *vma,
> +		unsigned long address, pte_t *ptep, unsigned int nr)
>   {
>   }
>   
> +#define update_mmu_cache(vma, addr, ptep) \
> +	update_mmu_cache_range(vma, addr, ptep, 1)
> +
>   #endif /* !__ASSEMBLY__ */
>   
>   /* MMU-specific headers */
> diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
> index 2a375637e007..7784d0fcdf6e 100644
> --- a/arch/m68k/mm/motorola.c
> +++ b/arch/m68k/mm/motorola.c
> @@ -81,7 +81,7 @@ static inline void cache_page(void *vaddr)
>   
>   void mmu_page_ctor(void *page)
>   {
> -	__flush_page_to_ram(page);
> +	__flush_pages_to_ram(page, 1);
>   	flush_tlb_kernel_page(page);
>   	nocache_page(page);
>   }
