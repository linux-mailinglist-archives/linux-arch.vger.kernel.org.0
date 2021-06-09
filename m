Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8A3A11C2
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 12:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238431AbhFIK5H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 06:57:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238444AbhFIK5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 06:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623236110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=benEkoYiyJABYdMW95hQGiXtSU/C1XePwCmkHhtvx1g=;
        b=PaNnjs6ibUg2dwjRwpZK3wVXVNgdJHJo6Ls5EGV6lHp3DQ9yO5eOStmU5wCgwGweoio8QG
        CJQaEbBRek6Ew6+zPEVH9PpFrqaz9dmXafmSuP8+e3qLB4csy0S8Bj48mBLaQnj5JjIfVE
        T6lD5VDbMtCrSW04O05+VWQYQ48tDIQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-7He01pHmPuGsEcRTNoLltg-1; Wed, 09 Jun 2021 06:55:09 -0400
X-MC-Unique: 7He01pHmPuGsEcRTNoLltg-1
Received: by mail-wr1-f71.google.com with SMTP id x9-20020adfffc90000b02901178add5f60so10627313wrs.5
        for <linux-arch@vger.kernel.org>; Wed, 09 Jun 2021 03:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=benEkoYiyJABYdMW95hQGiXtSU/C1XePwCmkHhtvx1g=;
        b=JqqswYehGmxDsuSoWqwC4T4F+2UgOnM4DEEJ4teMdXrMan6IViq8hENHba+cSaKwul
         akpsBlmFC0Jt2o2TrA2rVu5eZdsYXK1r8UWEJ3Pl7XZL5yPjThx4T3c9emm7orgYXTvs
         ElA/9hvttb8706zTkVLwzcFfh17dSlBU9QmaR4v4+k+TCZHy6puI25YGkttEExyOwj7G
         N+N4T6Ee1edZlKy1T/N59VEuCG8+6TgF6QZnon0kmvvMfLl+PQ2drNgCRRMMl6KJO/18
         tXr1IqVVVuNG9jg2Fduoq4AEY9/GREuFhOnyFEiWIYqdsef6HMiO8yCUe82g2yxM2Zk7
         9KCQ==
X-Gm-Message-State: AOAM532vnN3vaRIc4h8CGrPnVGeY1DVo/p1XyZnOPB8fK6TzO4utbOgk
        eg2f3thj06y2gBtEB/OVGS7S1N2hbn82iIOf9mkK1JPFqcnoUwUsnFGp4PG4Kct+JqUAjNmg13R
        cu+DnonfbnnXByBP7uzBr1Q==
X-Received: by 2002:adf:a195:: with SMTP id u21mr27273832wru.367.1623236108241;
        Wed, 09 Jun 2021 03:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjnCkAcBENrkqMTB70+rs2Nob4xVwaz0WEFyYcAGQK8OJcQbAHNdq4EvIJiX07BLGSW1YWbw==
X-Received: by 2002:adf:a195:: with SMTP id u21mr27273781wru.367.1623236107908;
        Wed, 09 Jun 2021 03:55:07 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id j1sm20561498wmi.44.2021.06.09.03.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 03:55:07 -0700 (PDT)
Subject: Re: [PATCH 5/9] mm: remove CONFIG_DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
References: <20210602105348.13387-1-rppt@kernel.org>
 <20210602105348.13387-6-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <c6c79dd2-6b93-c887-84a7-f9ee782bfd36@redhat.com>
Date:   Wed, 9 Jun 2021 12:55:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210602105348.13387-6-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02.06.21 12:53, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There are no architectures that support DISCONTIGMEM left.
> 
> Remove the configuration option and the dead code it was guarding in the
> generic memory management code.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   include/asm-generic/memory_model.h | 37 ++++--------------------------
>   include/linux/mmzone.h             |  4 ++--
>   mm/Kconfig                         | 25 +++-----------------
>   mm/memory.c                        |  3 +--
>   mm/page_alloc.c                    | 13 -----------
>   5 files changed, 10 insertions(+), 72 deletions(-)
> 
> diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
> index 7637fb46ba4f..a2c8ed60233a 100644
> --- a/include/asm-generic/memory_model.h
> +++ b/include/asm-generic/memory_model.h
> @@ -6,47 +6,18 @@
>   
>   #ifndef __ASSEMBLY__
>   
> +/*
> + * supports 3 memory models.
> + */
>   #if defined(CONFIG_FLATMEM)
>   
>   #ifndef ARCH_PFN_OFFSET
>   #define ARCH_PFN_OFFSET		(0UL)
>   #endif
>   
> -#elif defined(CONFIG_DISCONTIGMEM)
> -
> -#ifndef arch_pfn_to_nid
> -#define arch_pfn_to_nid(pfn)	pfn_to_nid(pfn)
> -#endif
> -
> -#ifndef arch_local_page_offset
> -#define arch_local_page_offset(pfn, nid)	\
> -	((pfn) - NODE_DATA(nid)->node_start_pfn)
> -#endif
> -
> -#endif /* CONFIG_DISCONTIGMEM */
> -
> -/*
> - * supports 3 memory models.
> - */
> -#if defined(CONFIG_FLATMEM)
> -
>   #define __pfn_to_page(pfn)	(mem_map + ((pfn) - ARCH_PFN_OFFSET))
>   #define __page_to_pfn(page)	((unsigned long)((page) - mem_map) + \
>   				 ARCH_PFN_OFFSET)
> -#elif defined(CONFIG_DISCONTIGMEM)
> -
> -#define __pfn_to_page(pfn)			\
> -({	unsigned long __pfn = (pfn);		\
> -	unsigned long __nid = arch_pfn_to_nid(__pfn);  \
> -	NODE_DATA(__nid)->node_mem_map + arch_local_page_offset(__pfn, __nid);\
> -})
> -
> -#define __page_to_pfn(pg)						\
> -({	const struct page *__pg = (pg);					\
> -	struct pglist_data *__pgdat = NODE_DATA(page_to_nid(__pg));	\
> -	(unsigned long)(__pg - __pgdat->node_mem_map) +			\
> -	 __pgdat->node_start_pfn;					\
> -})
>   
>   #elif defined(CONFIG_SPARSEMEM_VMEMMAP)
>   
> @@ -70,7 +41,7 @@
>   	struct mem_section *__sec = __pfn_to_section(__pfn);	\
>   	__section_mem_map_addr(__sec) + __pfn;		\
>   })
> -#endif /* CONFIG_FLATMEM/DISCONTIGMEM/SPARSEMEM */
> +#endif /* CONFIG_FLATMEM/SPARSEMEM */
>   
>   /*
>    * Convert a physical address to a Page Frame Number and back
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0d53eba1c383..2b41e252a995 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -738,8 +738,8 @@ struct zonelist {
>   	struct zoneref _zonerefs[MAX_ZONES_PER_ZONELIST + 1];
>   };
>   
> -#ifndef CONFIG_DISCONTIGMEM
> -/* The array of struct pages - for discontigmem use pgdat->lmem_map */
> +#ifdef CONFIG_FLATMEM
> +/* The array of struct pages for flatmem */
>   extern struct page *mem_map;
>   #endif
>   
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 02d44e3420f5..218b96ccc84a 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -19,7 +19,7 @@ choice
>   
>   config FLATMEM_MANUAL
>   	bool "Flat Memory"
> -	depends on !(ARCH_DISCONTIGMEM_ENABLE || ARCH_SPARSEMEM_ENABLE) || ARCH_FLATMEM_ENABLE
> +	depends on !ARCH_SPARSEMEM_ENABLE || ARCH_FLATMEM_ENABLE
>   	help
>   	  This option is best suited for non-NUMA systems with
>   	  flat address space. The FLATMEM is the most efficient
> @@ -32,21 +32,6 @@ config FLATMEM_MANUAL
>   
>   	  If unsure, choose this option (Flat Memory) over any other.
>   
> -config DISCONTIGMEM_MANUAL
> -	bool "Discontiguous Memory"
> -	depends on ARCH_DISCONTIGMEM_ENABLE
> -	help
> -	  This option provides enhanced support for discontiguous
> -	  memory systems, over FLATMEM.  These systems have holes
> -	  in their physical address spaces, and this option provides
> -	  more efficient handling of these holes.
> -
> -	  Although "Discontiguous Memory" is still used by several
> -	  architectures, it is considered deprecated in favor of
> -	  "Sparse Memory".
> -
> -	  If unsure, choose "Sparse Memory" over this option.
> -
>   config SPARSEMEM_MANUAL
>   	bool "Sparse Memory"
>   	depends on ARCH_SPARSEMEM_ENABLE
> @@ -62,17 +47,13 @@ config SPARSEMEM_MANUAL
>   
>   endchoice
>   
> -config DISCONTIGMEM
> -	def_bool y
> -	depends on (!SELECT_MEMORY_MODEL && ARCH_DISCONTIGMEM_ENABLE) || DISCONTIGMEM_MANUAL
> -
>   config SPARSEMEM
>   	def_bool y
>   	depends on (!SELECT_MEMORY_MODEL && ARCH_SPARSEMEM_ENABLE) || SPARSEMEM_MANUAL
>   
>   config FLATMEM
>   	def_bool y
> -	depends on (!DISCONTIGMEM && !SPARSEMEM) || FLATMEM_MANUAL
> +	depends on !SPARSEMEM || FLATMEM_MANUAL
>   
>   config FLAT_NODE_MEM_MAP
>   	def_bool y
> @@ -85,7 +66,7 @@ config FLAT_NODE_MEM_MAP
>   #
>   config NEED_MULTIPLE_NODES
>   	def_bool y
> -	depends on DISCONTIGMEM || NUMA
> +	depends on NUMA
>   
>   #
>   # SPARSEMEM_EXTREME (which is the default) does some bootmem
> diff --git a/mm/memory.c b/mm/memory.c
> index 730daa00952b..7c7b6ea02504 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -90,8 +90,7 @@
>   #warning Unfortunate NUMA and NUMA Balancing config, growing page-frame for last_cpupid.
>   #endif
>   
> -#ifndef CONFIG_NEED_MULTIPLE_NODES
> -/* use the per-pgdat data instead for discontigmem - mbligh */
> +#ifdef CONFIG_FLATMEM
>   unsigned long max_mapnr;
>   EXPORT_SYMBOL(max_mapnr);
>   
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index aaa1655cf682..6fc22482eaa8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -331,20 +331,7 @@ compound_page_dtor * const compound_page_dtors[NR_COMPOUND_DTORS] = {
>   
>   int min_free_kbytes = 1024;
>   int user_min_free_kbytes = -1;
> -#ifdef CONFIG_DISCONTIGMEM
> -/*
> - * DiscontigMem defines memory ranges as separate pg_data_t even if the ranges
> - * are not on separate NUMA nodes. Functionally this works but with
> - * watermark_boost_factor, it can reclaim prematurely as the ranges can be
> - * quite small. By default, do not boost watermarks on discontigmem as in
> - * many cases very high-order allocations like THP are likely to be
> - * unsupported and the premature reclaim offsets the advantage of long-term
> - * fragmentation avoidance.
> - */
> -int watermark_boost_factor __read_mostly;
> -#else
>   int watermark_boost_factor __read_mostly = 15000;
> -#endif
>   int watermark_scale_factor = 10;
>   
>   static unsigned long nr_kernel_pages __initdata;
> 

Nice

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

