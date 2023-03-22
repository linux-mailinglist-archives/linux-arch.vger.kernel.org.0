Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE35A6C4316
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 07:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjCVGYJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Mar 2023 02:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCVGYI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Mar 2023 02:24:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C644FCFD;
        Tue, 21 Mar 2023 23:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0563B818DC;
        Wed, 22 Mar 2023 06:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E4BC433D2;
        Wed, 22 Mar 2023 06:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679466244;
        bh=cQj5ND6NQ+jRWxCbfQwoB4SOr8K6z0BISCctoUKWGVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4g55mQ4GpArph+pkS+DQ31CizcD7NV2GqC7nU+0eZFeZsNlVkpLotPVaeLBhc+ZJ
         t0hji+++80ENIgmcqns5g37vfI9HzF5YEW9X9LvxWCsL3icilIPJHIHHwkLzyG/GnP
         U34qvhk4vbbvHm50Y/wMjbElLuC0H1bnj3bNVYxbS0zqdm4sxEdzPUeR6gTHwRbGio
         Au29QAEj9fggf14xN984GN2wQ9la2m+2W3YMVEsuGmZZxhyhFNaJhW0ParEpy5jujz
         E7qP1r8C0s5SZlPnZ5rJIis+nSZ5Opxv287UZRMNchX9ZeZaXj80SNxAEhnGgt42B/
         9sqEy/CaHWgzQ==
Date:   Wed, 22 Mar 2023 08:23:51 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm/page_alloc: Make deferred page init free pages in
 MAX_ORDER blocks
Message-ID: <ZBqe97HNpE/gpOX8@kernel.org>
References: <20230321002415.20843-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321002415.20843-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 21, 2023 at 03:24:15AM +0300, Kirill A. Shutemov wrote:
> Normal page init path frees pages during the boot in MAX_ORDER chunks,
> but deferred page init path does it in pageblock blocks.
> 
> Change deferred page init path to work in MAX_ORDER blocks.
> 
> For cases when MAX_ORDER is larger than pageblock, set migrate type to
> MIGRATE_MOVABLE for all pageblocks covered by the page.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> 
> Note: the patch depends on the new definiton of MAX_ORDER.
> 
> v2:
> 
>  - Fix commit message;
> 
> ---
>  include/linux/mmzone.h |  2 ++
>  mm/page_alloc.c        | 19 ++++++++++---------
>  2 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 96599cb9eb62..f53fe3a7ca45 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -32,6 +32,8 @@
>  #endif
>  #define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
>  
> +#define IS_MAX_ORDER_ALIGNED(pfn) IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)
> +
>  /*
>   * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
>   * costly to service.  That is between allocation orders which should
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 87d760236dba..fc02a243425d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1875,9 +1875,10 @@ static void __init deferred_free_range(unsigned long pfn,
>  	page = pfn_to_page(pfn);
>  
>  	/* Free a large naturally-aligned chunk if possible */
> -	if (nr_pages == pageblock_nr_pages && pageblock_aligned(pfn)) {
> -		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
> -		__free_pages_core(page, pageblock_order);
> +	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
> +		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
> +			set_pageblock_migratetype(page + i, MIGRATE_MOVABLE);
> +		__free_pages_core(page, MAX_ORDER);
>  		return;
>  	}
>  
> @@ -1901,19 +1902,19 @@ static inline void __init pgdat_init_report_one_done(void)
>  /*
>   * Returns true if page needs to be initialized or freed to buddy allocator.
>   *
> - * We check if a current large page is valid by only checking the validity
> + * We check if a current MAX_ORDER block is valid by only checking the validity
>   * of the head pfn.
>   */
>  static inline bool __init deferred_pfn_valid(unsigned long pfn)
>  {
> -	if (pageblock_aligned(pfn) && !pfn_valid(pfn))
> +	if (IS_MAX_ORDER_ALIGNED(pfn) && !pfn_valid(pfn))
>  		return false;
>  	return true;
>  }
>  
>  /*
>   * Free pages to buddy allocator. Try to free aligned pages in
> - * pageblock_nr_pages sizes.
> + * MAX_ORDER_NR_PAGES sizes.
>   */
>  static void __init deferred_free_pages(unsigned long pfn,
>  				       unsigned long end_pfn)
> @@ -1924,7 +1925,7 @@ static void __init deferred_free_pages(unsigned long pfn,
>  		if (!deferred_pfn_valid(pfn)) {
>  			deferred_free_range(pfn - nr_free, nr_free);
>  			nr_free = 0;
> -		} else if (pageblock_aligned(pfn)) {
> +		} else if (IS_MAX_ORDER_ALIGNED(pfn)) {
>  			deferred_free_range(pfn - nr_free, nr_free);
>  			nr_free = 1;
>  		} else {
> @@ -1937,7 +1938,7 @@ static void __init deferred_free_pages(unsigned long pfn,
>  
>  /*
>   * Initialize struct pages.  We minimize pfn page lookups and scheduler checks
> - * by performing it only once every pageblock_nr_pages.
> + * by performing it only once every MAX_ORDER_NR_PAGES.
>   * Return number of pages initialized.
>   */
>  static unsigned long  __init deferred_init_pages(struct zone *zone,
> @@ -1953,7 +1954,7 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
>  		if (!deferred_pfn_valid(pfn)) {
>  			page = NULL;
>  			continue;
> -		} else if (!page || pageblock_aligned(pfn)) {
> +		} else if (!page || IS_MAX_ORDER_ALIGNED(pfn)) {
>  			page = pfn_to_page(pfn);
>  		} else {
>  			page++;
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
