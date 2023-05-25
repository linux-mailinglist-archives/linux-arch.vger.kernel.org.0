Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04B710377
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 05:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjEYDvJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 23:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbjEYDu7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 23:50:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD7FBE7;
        Wed, 24 May 2023 20:50:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EEED1042;
        Wed, 24 May 2023 20:51:42 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9CB93F6C4;
        Wed, 24 May 2023 20:50:50 -0700 (PDT)
Message-ID: <f428a035-4728-1007-e0d5-97988ffe33cc@arm.com>
Date:   Thu, 25 May 2023 09:20:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 29/36] mm: Remove page_mapping_file()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-30-willy@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230315051444.3229621-30-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 3/15/23 10:44, Matthew Wilcox (Oracle) wrote:
> This function has no more users.

On v6.4-rc3, there are still some users. Am I looking into a wrong
tree/branch/tag ?

~/workplace/linux$ git grep page_mapping_file
arch/arc/mm/cache.c:    mapping = page_mapping_file(page);
arch/arm/mm/copypage-v4mc.c:            __flush_dcache_page(page_mapping_file(from), from);
arch/arm/mm/copypage-v6.c:              __flush_dcache_page(page_mapping_file(from), from);
arch/arm/mm/copypage-xscale.c:          __flush_dcache_page(page_mapping_file(from), from);
arch/arm/mm/fault-armv.c:       mapping = page_mapping_file(page);
arch/arm/mm/flush.c:            mapping = page_mapping_file(page);
arch/arm/mm/flush.c:    mapping = page_mapping_file(page);
arch/csky/abiv1/cacheflush.c:   mapping = page_mapping_file(page);
arch/csky/abiv1/cacheflush.c:   if (page_mapping_file(page)) {
arch/mips/mm/cache.c:   struct address_space *mapping = page_mapping_file(page);
arch/nios2/mm/cacheflush.c:     mapping = page_mapping_file(page);
arch/nios2/mm/cacheflush.c:     mapping = page_mapping_file(page);
arch/parisc/kernel/cache.c:     if (page_mapping_file(page) &&
arch/parisc/kernel/cache.c:     struct address_space *mapping = page_mapping_file(page);
arch/sh/mm/cache-sh4.c: struct address_space *mapping = page_mapping_file(page);
arch/sh/mm/cache-sh7705.c:      struct address_space *mapping = page_mapping_file(page);
arch/sparc/kernel/smp_64.c:                          page_mapping_file(page) != NULL));
arch/sparc/kernel/smp_64.c:     if (page_mapping_file(page) != NULL &&
arch/sparc/kernel/smp_64.c:                     if (page_mapping_file(page) != NULL)
arch/sparc/kernel/smp_64.c:             if (page_mapping_file(page) != NULL)
arch/sparc/mm/init_64.c:                             page_mapping_file(page) != NULL));
arch/sparc/mm/init_64.c:        if (page_mapping_file(page) != NULL &&
arch/sparc/mm/init_64.c:        mapping = page_mapping_file(page);
arch/sparc/mm/tlb.c:            mapping = page_mapping_file(page);
arch/xtensa/mm/cache.c: struct address_space *mapping = page_mapping_file(page);

> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index e56c2023aa0e..a87113055b9c 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -394,14 +394,6 @@ static inline struct address_space *page_file_mapping(struct page *page)
>  	return folio_file_mapping(page_folio(page));
>  }
>  
> -/*
> - * For file cache pages, return the address_space, otherwise return NULL
> - */
> -static inline struct address_space *page_mapping_file(struct page *page)
> -{
> -	return folio_flush_mapping(page_folio(page));
> -}
> -
>  /**
>   * folio_inode - Get the host inode for this folio.
>   * @folio: The folio.
