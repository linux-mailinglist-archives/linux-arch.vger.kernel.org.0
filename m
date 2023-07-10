Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4851E74E226
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jul 2023 01:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjGJXRb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 19:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjGJXRa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 19:17:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094C69E;
        Mon, 10 Jul 2023 16:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92CC36125F;
        Mon, 10 Jul 2023 23:17:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FA3C433C7;
        Mon, 10 Jul 2023 23:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1689031049;
        bh=7ukpBqH/JEmoGMFAy/Thf+Mx7ToPtH7Q/rOGM1Ckpq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qrES5FI2lpsIScl39Znj/jOshaskk/NkA2AyV6WuOqpYH+1elY3CL6cnOwZPu4ZGY
         6qv03tx+3gYQwG2RRh0zrVI85DPu5QW987ZV827dCV46fmR3nFpjzWKywhx/7jDZVX
         IzZICXcjA1V/Kkyd7eloRoHLZeMi8we/7rwcYkt4=
Date:   Mon, 10 Jul 2023 16:17:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v5 04/38] mm: Add folio_flush_mapping()
Message-Id: <20230710161727.7a676996b64e9885cc15eaeb@linux-foundation.org>
In-Reply-To: <20230710204339.3554919-5-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
        <20230710204339.3554919-5-willy@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 10 Jul 2023 21:43:05 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> This is the folio equivalent of page_mapping_file(), but rename it
> to make it clear that it's very different from page_file_mapping().
> Theoretically, there's nothing flush-only about it, but there are no
> other users today, and I doubt there will be; it's almost always more
> useful to know the swapfile's mapping or the swapcache's mapping.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> +++ b/include/linux/pagemap.h
> @@ -389,6 +389,26 @@ static inline struct address_space *folio_file_mapping(struct folio *folio)
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

The name makes it sound like it flushes something.  Wouldn't
folio_flushable_mapping() be clearer?

>  static inline struct address_space *page_file_mapping(struct page *page)
>  {
>  	return folio_file_mapping(page_folio(page));
> @@ -399,11 +419,7 @@ static inline struct address_space *page_file_mapping(struct page *page)
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

