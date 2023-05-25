Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B677102F2
	for <lists+linux-arch@lfdr.de>; Thu, 25 May 2023 04:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjEYCfZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 May 2023 22:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbjEYCfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2023 22:35:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04AA9119;
        Wed, 24 May 2023 19:35:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD5061042;
        Wed, 24 May 2023 19:36:06 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AC6F3F762;
        Wed, 24 May 2023 19:35:20 -0700 (PDT)
Message-ID: <0729b811-92f2-13a7-5f97-8ea249c88adf@arm.com>
Date:   Thu, 25 May 2023 08:05:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 03/36] mm: Add folio_flush_mapping()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-4-willy@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230315051444.3229621-4-willy@infradead.org>
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
> This is the folio equivalent of page_mapping_file(), but rename it
> to make it clear that it's very different from page_file_mapping().
> Theoretically, there's nothing flush-only about it, but there are no
> other users today, and I doubt there will be; it's almost always more
> useful to know the swapfile's mapping or the swapcache's mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/pagemap.h | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index a56308a9d1a4..e56c2023aa0e 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -369,6 +369,26 @@ static inline struct address_space *folio_file_mapping(struct folio *folio)
>  	return folio->mapping;
>  }
>  
> +/**
> + * folio_flush_mapping - Find the file mapping this folio belongs to.
> + * @folio: The folio.
> + *
> + * For folios which are in the page cache, return the mapping that this
> + * page belongs to.  Anonymous folios return NULL, even if they're in
> + * the swap cache.  Other kinds of folio also return NULL.
> + *
> + * This is ONLY used by architecture cache flushing code.  If you aren't
> + * writing cache flushing code, you want either folio_mapping() or
> + * folio_file_mapping().
> + */
> +static inline struct address_space *folio_flush_mapping(struct folio *folio)
> +{
> +	if (unlikely(folio_test_swapcache(folio)))
> +		return NULL;
> +
> +	return folio_mapping(folio);
> +}
> +
>  static inline struct address_space *page_file_mapping(struct page *page)
>  {
>  	return folio_file_mapping(page_folio(page));
> @@ -379,11 +399,7 @@ static inline struct address_space *page_file_mapping(struct page *page)
>   */
>  static inline struct address_space *page_mapping_file(struct page *page)
>  {
> -	struct folio *folio = page_folio(page);
> -
> -	if (unlikely(folio_test_swapcache(folio)))
> -		return NULL;
> -	return folio_mapping(folio);
> +	return folio_flush_mapping(page_folio(page));
>  }
>  
>  /**
