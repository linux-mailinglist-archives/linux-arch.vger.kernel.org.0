Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D376BAC25
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 10:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCOJ2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjCOJ2r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 05:28:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BCB6A77;
        Wed, 15 Mar 2023 02:28:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8040CB81D76;
        Wed, 15 Mar 2023 09:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E884C433D2;
        Wed, 15 Mar 2023 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678872520;
        bh=iqRg2qO3GWrEc0EoQMp3T6JPcclnenU1RS60M1C2JkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBitN9VYog13FLH/phZ3daXoGBntZuEE/cNH9QXFLtf0rPjEO6Tq3wkFCY2XP24dw
         B8TqSJNqAujFJPOfGFXBKIK4hlAXOqr9sn09jJZvN3W3ktUTmsaDmPez3pwqJZS6Lz
         cIyLRwY9OXu/RwxkCWyEC0LqsXAe/G5SUqEN6H7Zgo6RYu6vBJw1sSA3NS9WoVdng2
         neVDiztIHIvk4Iz8ymdVjTR0QSS6jfQVD0RZCfnkMBn1krGWQCHovqjB5cd9kdv9ln
         F1owxBJbcMhx5fxhhxj1Tn3n/CeN0Iv9wBdXkNGgNcFih1efSQetPNEs+24XpnCnrX
         Djv9ZcxggACcA==
Date:   Wed, 15 Mar 2023 11:28:27 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/36] mm: Add folio_flush_mapping()
Message-ID: <ZBGPu2j1FiknlwPP@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-4-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 05:14:11AM +0000, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_mapping_file(), but rename it
> to make it clear that it's very different from page_file_mapping().
> Theoretically, there's nothing flush-only about it, but there are no
> other users today, and I doubt there will be; it's almost always more
> useful to know the swapfile's mapping or the swapcache's mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

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
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
