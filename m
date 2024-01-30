Return-Path: <linux-arch+bounces-1834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C829841F3B
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA5611F23A2C
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15B459B68;
	Tue, 30 Jan 2024 09:19:14 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397DA5821A;
	Tue, 30 Jan 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706606354; cv=none; b=fD40v8V7tFO8FQlySS+DvEGgm+zaEWrMdyjcqCCUJkymy4F0p5EBT0WfJ0+cC+y9/DuFB3YuOl7GQLTHQ+gDICzl6BakY/um8eApJFu49yPpFav5xDuTYkJqWuryIkZRSBaR3FVFwMYGBCxw7wrrFd5R1yCiFm2MJqjXeQ8nd+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706606354; c=relaxed/simple;
	bh=96TAfdDkpHCSucUS9AjQOlifrvIEsXlMGa/QpT4c67U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGZJKOo+ShcY5XUJ61m/HZoC+k5iIhBipQpFxcQpP/0llzZKsFp1gKmJBdL2KWH6Z/GBEDpTQk3eZ4LQ5MMRnpzbgmRVEk0L7+GiX+OfH9VfsQbeb1J+IUhmzDdp8XedelEaXZaeARF8RPsti208RUGfVtiyoSw60KgopQqhMgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B99EBDA7;
	Tue, 30 Jan 2024 01:19:52 -0800 (PST)
Received: from [10.163.41.110] (unknown [10.163.41.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 860293F738;
	Tue, 30 Jan 2024 01:18:56 -0800 (PST)
Message-ID: <598c9762-83b3-4517-858c-8349d6dceec2@arm.com>
Date: Tue, 30 Jan 2024 14:48:53 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 10/35] mm: cma: Fast track allocating memory when
 the pages are free
Content-Language: en-US
To: Alexandru Elisei <alexandru.elisei@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, oliver.upton@linux.dev, maz@kernel.org,
 james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 arnd@arndb.de, akpm@linux-foundation.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 mhiramat@kernel.org, rppt@kernel.org, hughd@google.com
Cc: pcc@google.com, steven.price@arm.com, vincenzo.frascino@arm.com,
 david@redhat.com, eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
 <20240125164256.4147-11-alexandru.elisei@arm.com>
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20240125164256.4147-11-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/25/24 22:12, Alexandru Elisei wrote:
> If the pages to be allocated are free, take them directly off the buddy
> allocator, instead of going through alloc_contig_range() and avoiding
> costly calls to lru_cache_disable().
> 
> Only allocations of the same size as the CMA region order are considered,
> to avoid taking the zone spinlock for too long.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

This patch seems to be improving standard cma_alloc() as well as
the previously added new allocator i.e cma_alloc_range() - via a
new helper cma_alloc_pages_fastpath().

Should not any standard cma_alloc() improvement be discussed as
an independent patch separately irrespective of this series. OR
it is some how related to this series which I might be missing ?

> ---
> 
> Changes since rfc v2:
> 
> * New patch. Reworked from the rfc v2 patch #26 ("arm64: mte: Fast track
> reserving tag storage when the block is free") (David Hildenbrand).
> 
>  include/linux/page-flags.h | 15 ++++++++++++--
>  mm/Kconfig                 |  5 +++++
>  mm/cma.c                   | 42 ++++++++++++++++++++++++++++++++++----
>  mm/memory-failure.c        |  8 ++++----
>  mm/page_alloc.c            | 23 ++++++++++++---------
>  5 files changed, 73 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 735cddc13d20..b7237bce7446 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -575,11 +575,22 @@ TESTSCFLAG(HWPoison, hwpoison, PF_ANY)
>  #define MAGIC_HWPOISON	0x48575053U	/* HWPS */
>  extern void SetPageHWPoisonTakenOff(struct page *page);
>  extern void ClearPageHWPoisonTakenOff(struct page *page);
> -extern bool take_page_off_buddy(struct page *page);
> -extern bool put_page_back_buddy(struct page *page);
> +extern bool PageHWPoisonTakenOff(struct page *page);
>  #else
>  PAGEFLAG_FALSE(HWPoison, hwpoison)
> +TESTSCFLAG_FALSE(HWPoison, hwpoison)
>  #define __PG_HWPOISON 0
> +static inline void SetPageHWPoisonTakenOff(struct page *page) { }
> +static inline void ClearPageHWPoisonTakenOff(struct page *page) { }
> +static inline bool PageHWPoisonTakenOff(struct page *page)
> +{
> +      return false;
> +}
> +#endif
> +
> +#ifdef CONFIG_WANTS_TAKE_PAGE_OFF_BUDDY
> +extern bool take_page_off_buddy(struct page *page, bool poison);
> +extern bool put_page_back_buddy(struct page *page, bool unpoison);
>  #endif
>  
>  #if defined(CONFIG_PAGE_IDLE_FLAG) && defined(CONFIG_64BIT)
> diff --git a/mm/Kconfig b/mm/Kconfig
> index ffc3a2ba3a8c..341cf53898db 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -745,12 +745,16 @@ config DEFAULT_MMAP_MIN_ADDR
>  config ARCH_SUPPORTS_MEMORY_FAILURE
>  	bool
>  
> +config WANTS_TAKE_PAGE_OFF_BUDDY
> +	bool> +
>  config MEMORY_FAILURE
>  	depends on MMU
>  	depends on ARCH_SUPPORTS_MEMORY_FAILURE
>  	bool "Enable recovery from hardware memory errors"
>  	select MEMORY_ISOLATION
>  	select RAS
> +	select WANTS_TAKE_PAGE_OFF_BUDDY
>  	help
>  	  Enables code to recover from some memory failures on systems
>  	  with MCA recovery. This allows a system to continue running
> @@ -891,6 +895,7 @@ config CMA
>  	depends on MMU
>  	select MIGRATION
>  	select MEMORY_ISOLATION
> +	select WANTS_TAKE_PAGE_OFF_BUDDY
>  	help
>  	  This enables the Contiguous Memory Allocator which allows other
>  	  subsystems to allocate big physically-contiguous blocks of memory.
> diff --git a/mm/cma.c b/mm/cma.c
> index 2881bab12b01..15663f95d77b 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -444,6 +444,34 @@ static void cma_debug_show_areas(struct cma *cma)
>  static inline void cma_debug_show_areas(struct cma *cma) { }
>  #endif
>  
> +/* Called with the cma mutex held. */
> +static int cma_alloc_pages_fastpath(struct cma *cma, unsigned long start,
> +				    unsigned long end)
> +{
> +	bool success = false;
> +	unsigned long i, j;
> +
> +	/* Avoid contention on the zone lock. */
> +	if (start - end != 1 << cma->order_per_bit)
> +		return -EINVAL;
> +
> +	for (i = start; i < end; i++) {
> +		if (!is_free_buddy_page(pfn_to_page(i)))
> +			break;
> +		success = take_page_off_buddy(pfn_to_page(i), false);
> +		if (!success)
> +			break;
> +	}
> +
> +	if (success)
> +		return 0;
> +
> +	for (j = start; j < i; j++)
> +		put_page_back_buddy(pfn_to_page(j), false);
> +
> +	return -EBUSY;
> +}
> +
>  /**
>   * cma_alloc_range() - allocate pages in a specific range
>   * @cma:   Contiguous memory region for which the allocation is performed.
> @@ -493,7 +521,11 @@ int cma_alloc_range(struct cma *cma, unsigned long start, unsigned long count,
>  
>  	for (i = 0; i < tries; i++) {
>  		mutex_lock(&cma_mutex);
> -		err = alloc_contig_range(start, start + count, MIGRATE_CMA, gfp);
> +		err = cma_alloc_pages_fastpath(cma, start, start + count);
> +		if (err) {
> +			err = alloc_contig_range(start, start + count,
> +						 MIGRATE_CMA, gfp);
> +		}
>  		mutex_unlock(&cma_mutex);
>  
>  		if (err != -EBUSY)
> @@ -529,7 +561,6 @@ int cma_alloc_range(struct cma *cma, unsigned long start, unsigned long count,
>  	return err;
>  }
>  
> -
>  /**
>   * cma_alloc() - allocate pages from contiguous area
>   * @cma:   Contiguous memory region for which the allocation is performed.
> @@ -589,8 +620,11 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  
>  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
>  		mutex_lock(&cma_mutex);
> -		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> -				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
> +		ret = cma_alloc_pages_fastpath(cma, pfn, pfn + count);
> +		if (ret) {
> +			ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> +					GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
> +		}
>  		mutex_unlock(&cma_mutex);
>  		if (ret == 0) {
>  			page = pfn_to_page(pfn);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 4f9b61f4a668..b87b533a9871 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -157,7 +157,7 @@ static int __page_handle_poison(struct page *page)
>  	zone_pcp_disable(page_zone(page));
>  	ret = dissolve_free_huge_page(page);
>  	if (!ret)
> -		ret = take_page_off_buddy(page);
> +		ret = take_page_off_buddy(page, true);
>  	zone_pcp_enable(page_zone(page));
>  
>  	return ret;
> @@ -1353,7 +1353,7 @@ static int page_action(struct page_state *ps, struct page *p,
>  	return action_result(pfn, ps->type, result);
>  }
>  
> -static inline bool PageHWPoisonTakenOff(struct page *page)
> +bool PageHWPoisonTakenOff(struct page *page)
>  {
>  	return PageHWPoison(page) && page_private(page) == MAGIC_HWPOISON;
>  }
> @@ -2247,7 +2247,7 @@ int memory_failure(unsigned long pfn, int flags)
>  		res = get_hwpoison_page(p, flags);
>  		if (!res) {
>  			if (is_free_buddy_page(p)) {
> -				if (take_page_off_buddy(p)) {
> +				if (take_page_off_buddy(p, true)) {
>  					page_ref_inc(p);
>  					res = MF_RECOVERED;
>  				} else {
> @@ -2578,7 +2578,7 @@ int unpoison_memory(unsigned long pfn)
>  		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
>  	} else if (ghp < 0) {
>  		if (ghp == -EHWPOISON) {
> -			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
> +			ret = put_page_back_buddy(p, true) ? 0 : -EBUSY;
>  		} else {
>  			ret = ghp;
>  			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0fa34bcfb1af..502ee3eb8583 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6655,7 +6655,7 @@ bool is_free_buddy_page(struct page *page)
>  }
>  EXPORT_SYMBOL(is_free_buddy_page);
>  
> -#ifdef CONFIG_MEMORY_FAILURE
> +#ifdef CONFIG_WANTS_TAKE_PAGE_OFF_BUDDY
>  /*
>   * Break down a higher-order page in sub-pages, and keep our target out of
>   * buddy allocator.
> @@ -6687,9 +6687,9 @@ static void break_down_buddy_pages(struct zone *zone, struct page *page,
>  }
>  
>  /*
> - * Take a page that will be marked as poisoned off the buddy allocator.
> + * Take a page off the buddy allocator, and optionally mark it as poisoned.
>   */
> -bool take_page_off_buddy(struct page *page)
> +bool take_page_off_buddy(struct page *page, bool poison)
>  {
>  	struct zone *zone = page_zone(page);
>  	unsigned long pfn = page_to_pfn(page);
> @@ -6710,7 +6710,8 @@ bool take_page_off_buddy(struct page *page)
>  			del_page_from_free_list(page_head, zone, page_order);
>  			break_down_buddy_pages(zone, page_head, page, 0,
>  						page_order, migratetype);
> -			SetPageHWPoisonTakenOff(page);
> +			if (poison)
> +				SetPageHWPoisonTakenOff(page);
>  			if (!is_migrate_isolate(migratetype))
>  				__mod_zone_freepage_state(zone, -1, migratetype);
>  			ret = true;
> @@ -6724,9 +6725,10 @@ bool take_page_off_buddy(struct page *page)
>  }
>  
>  /*
> - * Cancel takeoff done by take_page_off_buddy().
> + * Cancel takeoff done by take_page_off_buddy(), and optionally unpoison the
> + * page.
>   */
> -bool put_page_back_buddy(struct page *page)
> +bool put_page_back_buddy(struct page *page, bool unpoison)
>  {
>  	struct zone *zone = page_zone(page);
>  	unsigned long pfn = page_to_pfn(page);
> @@ -6736,17 +6738,18 @@ bool put_page_back_buddy(struct page *page)
>  
>  	spin_lock_irqsave(&zone->lock, flags);
>  	if (put_page_testzero(page)) {
> -		ClearPageHWPoisonTakenOff(page);
> +		VM_WARN_ON_ONCE(PageHWPoisonTakenOff(page) && !unpoison);
> +		if (unpoison)
> +			ClearPageHWPoisonTakenOff(page);
>  		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
> -		if (TestClearPageHWPoison(page)) {
> +		if (!unpoison || (unpoison && TestClearPageHWPoison(page)))
>  			ret = true;
> -		}
>  	}
>  	spin_unlock_irqrestore(&zone->lock, flags);
>  
>  	return ret;
>  }
> -#endif
> +#endif /* CONFIG_WANTS_TAKE_PAGE_OFF_BUDDY */
>  
>  #ifdef CONFIG_ZONE_DMA
>  bool has_managed_dma(void)

