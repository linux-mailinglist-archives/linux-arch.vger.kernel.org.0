Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2672FF59
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbjFNNCr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 09:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244078AbjFNNCq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 09:02:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F0199C;
        Wed, 14 Jun 2023 06:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5675564215;
        Wed, 14 Jun 2023 13:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8321C433CB;
        Wed, 14 Jun 2023 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686747764;
        bh=Z0S2d/Eru6a8jIIub+wJj2QGnnAEIe7xODp5r4XEjY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ij1kaX2f2DmI7HK85FkEb/euMvHbhk1Yl6Bfkym5Y/V3n55SCcwdtHPiMl/Uaznfq
         /JPBcReV4N5cCfLGrjl0lmP3t1/xIRQ0sNu8SuNRKfJvFTG3ehEI7XrnyZzzj/mq5Z
         LIzsfSZJkFEA+VFk5od8SUJmz7a2MZahKi7y83tUViVFyHKqtoU7QmKJKuQUMruG+3
         ZBcXEtH/BdXI8p8nle54zxP2rJXEAQvrH6UElVJeso6ar3qrgbKRU7tK7ulw5ExB7M
         3MJes9iMWx7TD3tX2qF3/3jOSJV75iRXzB8fjYUsip9RPr0GERlktBmW7yBKguUpKQ
         +EDy1u2Ox8vrA==
Date:   Wed, 14 Jun 2023 16:02:07 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 01/34] mm: Add PAGE_TYPE_OP folio functions
Message-ID: <20230614130207.GZ52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-2-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-2-vishal.moola@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:03:50PM -0700, Vishal Moola (Oracle) wrote:
> No folio equivalents for page type operations have been defined, so
> define them for later folio conversions.
> 
> Also changes the Page##uname macros to take in const struct page* since
> we only read the memory here.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/page-flags.h | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 92a2063a0a23..e99a616b9bcd 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -908,6 +908,8 @@ static inline bool is_page_hwpoison(struct page *page)
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> +#define folio_test_type(folio, flag)					\
> +	((folio->page.page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
>  
>  static inline int page_type_has_type(unsigned int page_type)
>  {
> @@ -920,20 +922,34 @@ static inline int page_has_type(struct page *page)
>  }
>  
>  #define PAGE_TYPE_OPS(uname, lname)					\
> -static __always_inline int Page##uname(struct page *page)		\
> +static __always_inline int Page##uname(const struct page *page)		\
>  {									\
>  	return PageType(page, PG_##lname);				\
>  }									\
> +static __always_inline int folio_test_##lname(const struct folio *folio)\
> +{									\
> +	return folio_test_type(folio, PG_##lname);			\
> +}									\
>  static __always_inline void __SetPage##uname(struct page *page)		\
>  {									\
>  	VM_BUG_ON_PAGE(!PageType(page, 0), page);			\
>  	page->page_type &= ~PG_##lname;					\
>  }									\
> +static __always_inline void __folio_set_##lname(struct folio *folio)	\
> +{									\
> +	VM_BUG_ON_FOLIO(!folio_test_type(folio, 0), folio);		\
> +	folio->page.page_type &= ~PG_##lname;				\
> +}									\
>  static __always_inline void __ClearPage##uname(struct page *page)	\
>  {									\
>  	VM_BUG_ON_PAGE(!Page##uname(page), page);			\
>  	page->page_type |= PG_##lname;					\
> -}
> +}									\
> +static __always_inline void __folio_clear_##lname(struct folio *folio)	\
> +{									\
> +	VM_BUG_ON_FOLIO(!folio_test_##lname(folio), folio);		\
> +	folio->page.page_type |= PG_##lname;				\
> +}									\
>  
>  /*
>   * PageBuddy() indicates that the page is free and in the buddy system
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
