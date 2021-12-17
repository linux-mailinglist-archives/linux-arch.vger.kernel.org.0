Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4024A479413
	for <lists+linux-arch@lfdr.de>; Fri, 17 Dec 2021 19:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbhLQS0n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Dec 2021 13:26:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:22510 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231609AbhLQS0m (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Dec 2021 13:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639765602; x=1671301602;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=YH3sM3fKUYX2l1CxZa0lsGrLu2lfb36D5H5JhDFnQAI=;
  b=L3PN1H3M/bNJzN62PNXnr/fCeY0SDdFFA9HKPQdtcERrk2MgQh2VxYR3
   wWYGB7ASeCmhOf5lh7Z5lf4abSC6N9bFxsy0VPCBQ9Upjh7NYspr4aEn2
   fbZMKfdQvBGhduI5VY9hBSGklM5KF0lnOzbcWfBG33ssS0+8hqp6+FCxp
   9hYoRm/bIlmQmrw9cWOuQtuFcGzBd2f8vNTlqNF9Gk1NzhJkxae4DEjLz
   TTo79K2RQ5CYEhhDwWcfzO2oXpZGon0gh5dVy+satjGx3jj9ZsIbX3NEI
   Q2ZTb4vUxbOw94QTqU8/NApWGlkwo3jDqGD1T5CjqOhbOY75OF5tzwtJe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="300582268"
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="300582268"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 10:26:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,214,1635231600"; 
   d="scan'208";a="683475968"
Received: from mkundu-mobl1.amr.corp.intel.com (HELO [10.212.216.75]) ([10.212.216.75])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 10:26:40 -0800
Subject: Re: [PATCH/RFC] mm: add and use batched version of
 __tlb_remove_table()
To:     Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, kernel@openvz.org
References: <20211217081909.596413-1-nikita.yushchenko@virtuozzo.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <fcbb726d-fe6a-8fe4-20fd-6a10cdef007a@intel.com>
Date:   Fri, 17 Dec 2021 10:26:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211217081909.596413-1-nikita.yushchenko@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/17/21 12:19 AM, Nikita Yushchenko wrote:
> When batched page table freeing via struct mmu_table_batch is used, the
> final freeing in __tlb_remove_table_free() executes a loop, calling
> arch hook __tlb_remove_table() to free each table individually.
> 
> Shift that loop down to archs. This allows archs to optimize it, by
> freeing multiple tables in a single release_pages() call. This is
> faster than individual put_page() calls, especially with memcg
> accounting enabled.

Could we quantify "faster"?  There's a non-trivial amount of code being
added here and it would be nice to back it up with some cold-hard numbers.

> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -95,11 +95,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
>  
>  static void __tlb_remove_table_free(struct mmu_table_batch *batch)
>  {
> -	int i;
> -
> -	for (i = 0; i < batch->nr; i++)
> -		__tlb_remove_table(batch->tables[i]);
> -
> +	__tlb_remove_tables(batch->tables, batch->nr);
>  	free_page((unsigned long)batch);
>  }

This leaves a single call-site for __tlb_remove_table():

> static void tlb_remove_table_one(void *table)
> {
>         tlb_remove_table_sync_one();
>         __tlb_remove_table(table);
> }

Is that worth it, or could it just be:

	__tlb_remove_tables(&table, 1);

?

> -void free_pages_and_swap_cache(struct page **pages, int nr)
> +static void __free_pages_and_swap_cache(struct page **pages, int nr,
> +		bool do_lru)
>  {
> -	struct page **pagep = pages;
>  	int i;
>  
> -	lru_add_drain();
> +	if (do_lru)
> +		lru_add_drain();
>  	for (i = 0; i < nr; i++)
> -		free_swap_cache(pagep[i]);
> -	release_pages(pagep, nr);
> +		free_swap_cache(pages[i]);
> +	release_pages(pages, nr);
> +}
> +
> +void free_pages_and_swap_cache(struct page **pages, int nr)
> +{
> +	__free_pages_and_swap_cache(pages, nr, true);
> +}
> +
> +void free_pages_and_swap_cache_nolru(struct page **pages, int nr)
> +{
> +	__free_pages_and_swap_cache(pages, nr, false);
>  }

This went unmentioned in the changelog.  But, it seems like there's a
specific optimization here.  In the exiting code,
free_pages_and_swap_cache() is wasteful if no page in pages[] is on the
LRU.  It doesn't need the lru_add_drain().

Any code that knows it is freeing all non-LRU pages can call
free_pages_and_swap_cache_nolru() which should perform better than
free_pages_and_swap_cache().

Should we add this to the for loop in __free_pages_and_swap_cache()?

	for (i = 0; i < nr; i++) {
		if (!do_lru)
			VM_WARN_ON_ONCE_PAGE(PageLRU(pagep[i]),
					     pagep[i]);
		free_swap_cache(...);
	}

But, even more than that, do all the architectures even need the
free_swap_cache()?  PageSwapCache() will always be false on x86, which
makes the loop kinda silly.  x86 could, for instance, just do:

static inline void __tlb_remove_tables(void **tables, int nr)
{
	release_pages((struct page **)tables, nr);
}

I _think_ this will work everywhere that has whole pages as page tables.
 Taking that one step further, what if we only had one generic:

static inline void tlb_remove_tables(void **tables, int nr)
{
	int i;

#ifdef ARCH_PAGE_TABLES_ARE_FULL_PAGE
	release_pages((struct page **)tables, nr);
#else
	arch_tlb_remove_tables(tables, i);
#endif
}

Architectures that set ARCH_PAGE_TABLES_ARE_FULL_PAGE (or whatever)
don't need to implement __tlb_remove_table() at all *and* can do
release_pages() directly.

This avoids all the  confusion with the swap cache and LRU naming.
