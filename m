Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460E469383D
	for <lists+linux-arch@lfdr.de>; Sun, 12 Feb 2023 16:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjBLPvh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 10:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBLPvh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 10:51:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503A7EFB2
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 07:51:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC9D9B80D21
        for <linux-arch@vger.kernel.org>; Sun, 12 Feb 2023 15:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E16C433D2;
        Sun, 12 Feb 2023 15:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676217090;
        bh=ETtghzt2GtCgdTJuGSePN/aSkjSfhuJOAPiOwP8SSS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PbLMAROZkaKtskdecmZ+f23GLJGXH3qXgd3JY5T6K66bpmahYh8/FzF0KOCnnJe5F
         MvmMb24tAMMskvogOhr4kTxpU+hL7as7QjdlF87+TdMwMoAja8iIg4jvhS4U19n4K8
         Hi1G+rzyWqdvZuiTgVM5nMyGd4EEw7Wx31THm0qZUBQAsgc8tS08BdT0NvcF+PEHVI
         qzveL7zhPkqq1DXiQo6AkblREhwWje82wh0mtBJzGXzq3u93Im5jZoj7Ftt5T4XLz9
         ++kr+tHAc/2QdsRUWvISnevd3+Vlfb9D7ke0tEEvUKO4Gc1Vjga6U1Mzy5dsEun+s2
         7yyVaaTuamKOQ==
Date:   Sun, 12 Feb 2023 17:51:18 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/7] mm: Remove ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
Message-ID: <Y+kK9qXSKXv+PrqA@kernel.org>
References: <20230211033948.891959-1-willy@infradead.org>
 <20230211033948.891959-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211033948.891959-5-willy@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 11, 2023 at 03:39:45AM +0000, Matthew Wilcox (Oracle) wrote:
> Current best practice is to reuse the name of the function as a define
> to indicate that the function is implemented by the architecture.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/cacheflush.h | 4 ++--
>  mm/util.c                  | 2 +-

I'd expect a change in arch/ that removes
ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO and adds #define flush_dcache_folio

What am I missing?

>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/cacheflush.h b/include/linux/cacheflush.h
> index a6189d21f2ba..82136f3fcf54 100644
> --- a/include/linux/cacheflush.h
> +++ b/include/linux/cacheflush.h
> @@ -7,14 +7,14 @@
>  struct folio;
>  
>  #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> -#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
> +#ifndef flush_dcache_folio
>  void flush_dcache_folio(struct folio *folio);
>  #endif
>  #else
>  static inline void flush_dcache_folio(struct folio *folio)
>  {
>  }
> -#define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO 0
> +#define flush_dcache_folio flush_dcache_folio
>  #endif /* ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE */
>  
>  #endif /* _LINUX_CACHEFLUSH_H */
> diff --git a/mm/util.c b/mm/util.c
> index cec9327b27b4..39ea7af8171c 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -1124,7 +1124,7 @@ void page_offline_end(void)
>  }
>  EXPORT_SYMBOL(page_offline_end);
>  
> -#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
> +#ifndef flush_dcache_folio
>  void flush_dcache_folio(struct folio *folio)
>  {
>  	long i, nr = folio_nr_pages(folio);
> -- 
> 2.39.1
> 
> 

-- 
Sincerely yours,
Mike.
