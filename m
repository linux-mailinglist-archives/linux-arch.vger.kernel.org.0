Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4EE7300A0
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 15:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245256AbjFNNwB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 09:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245217AbjFNNv6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 09:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0441FFD;
        Wed, 14 Jun 2023 06:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15D1563768;
        Wed, 14 Jun 2023 13:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7653EC433C0;
        Wed, 14 Jun 2023 13:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686750710;
        bh=MAYhMoo3f8WL6wMqKE5pm7ocfhsiks+frK6iH2blioo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEIirlFbT/jXJvHUAqdydA59j1RgDZUUfgyOKgwNndXqGOEHUHhZfOzL8/NQgVHWq
         /q8XC8zbUoWUdbEY52nA6n3QMoY+5uT3nVSo46hX3ckloa8Tsk20nvsFk+nFyI69rq
         kqHKU2qNg4cLDxDKYqW/CF0jwV3eWOULQ1qERJP4E28CBFcj6QUn7snwpsx+9K+Qu2
         POIbcaK1ERRHtrayBYsdhpVVMqCnIj3U/FswN9W3HiA4Vsg6KhJEbi7yWjCVgy7Bim
         qkQ5e6uOUhmZCAZAp2Mldqm52UMAWsfOcJWE7Vw1mqKjcEoYqpl1pq42H9ff1U9Ztz
         NxXUpOfWIJH1g==
Date:   Wed, 14 Jun 2023 16:51:12 +0300
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
Subject: Re: [PATCH v4 06/34] mm: Convert pmd_pgtable_page() to pmd_ptdesc()
Message-ID: <20230614135112.GE52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-7-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-7-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:03:55PM -0700, Vishal Moola (Oracle) wrote:
> Converts pmd_pgtable_page() to pmd_ptdesc() and all its callers. This
> removes some direct accesses to struct page, working towards splitting
> out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f184f1eba85d..088b7664f897 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2931,15 +2931,15 @@ static inline void pgtable_pte_page_dtor(struct page *page)
>  
>  #if USE_SPLIT_PMD_PTLOCKS
>  
> -static inline struct page *pmd_pgtable_page(pmd_t *pmd)
> +static inline struct ptdesc *pmd_ptdesc(pmd_t *pmd)
>  {
>  	unsigned long mask = ~(PTRS_PER_PMD * sizeof(pmd_t) - 1);
> -	return virt_to_page((void *)((unsigned long) pmd & mask));
> +	return virt_to_ptdesc((void *)((unsigned long) pmd & mask));
>  }
>  
>  static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  {
> -	return ptlock_ptr(pmd_pgtable_page(pmd));
> +	return ptlock_ptr(ptdesc_page(pmd_ptdesc(pmd)));
>  }
>  
>  static inline bool pmd_ptlock_init(struct page *page)
> @@ -2958,7 +2958,7 @@ static inline void pmd_ptlock_free(struct page *page)
>  	ptlock_free(page);
>  }
>  
> -#define pmd_huge_pte(mm, pmd) (pmd_pgtable_page(pmd)->pmd_huge_pte)
> +#define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
>  
>  #else
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
