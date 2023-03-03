Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FEE6A954B
	for <lists+linux-arch@lfdr.de>; Fri,  3 Mar 2023 11:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjCCKeM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Mar 2023 05:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCCKeL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2023 05:34:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA3D23C78;
        Fri,  3 Mar 2023 02:34:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AA8EB81646;
        Fri,  3 Mar 2023 10:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BF8C433EF;
        Fri,  3 Mar 2023 10:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677839648;
        bh=XKj25EOwdMQ/e4nJyVZY9U2p6+v/6uaMPztAGk8sI44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PFQVdQ5/nUJ1aYxf3f9wyV08jeot6+gIuwrVHyhxveL2saZ8afYaTpmnSkOP8jlae
         8pctxGHg3RoQdj35MmDA4D8uZ5jYplxx1gIaIS2thfzGTTmZJwlrdi2lgdT5noOuNv
         Ym5lO1lx8MgqIDooD6yjnQzh3pnT/OePZl7rKVeXKDrnvKpYtc4zBsJeQdECjY9bWy
         Qm2Rp0lmnF3AgJjC/06Y61owRlWGk0xKqjW5JpORgCkTDczyJad/vrXy606d7jWM+Y
         noWlFsFRHzvdK48dgLKC17enu3IaWTCDd5TcR5D19ZDDmMzvPgFiLAhVTkM0Gmn3bV
         vSTvHWkVgmnvw==
Date:   Fri, 3 Mar 2023 12:33:55 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/34] mm: Add folio_flush_mapping()
Message-ID: <ZAHNEwN7pXoFHcp9@kernel.org>
References: <20230228213738.272178-1-willy@infradead.org>
 <20230228213738.272178-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228213738.272178-4-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 28, 2023 at 09:37:06PM +0000, Matthew Wilcox (Oracle) wrote:
> This is the folio equivalent of page_mapping_file(), but rename it
> to make it clear that it's very different from page_file_mapping().
> Theoretically, there's nothing flush-only about it, but there are no
> other users today, and I doubt there will be; it's almost always more
> useful to know the swapfile's mapping or the swapcache's mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 51b75b89730e..1b1ba3d5100d 100644
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

      ^ folio ?

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
> 2.39.1
> 

-- 
Sincerely yours,
Mike.
