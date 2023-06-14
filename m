Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B155673026A
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbjFNOyK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 10:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244580AbjFNOyI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 10:54:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B2A1981;
        Wed, 14 Jun 2023 07:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94CBB6432B;
        Wed, 14 Jun 2023 14:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F20C433C0;
        Wed, 14 Jun 2023 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686754446;
        bh=aUxoRMWQndKzGf4Pu7KWMeOI/WoSZl9BaSxpwilOg7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jZwYpBVV3Znjt/2r1/XmhShCVNutgqeq3trQicfEgjJSgiA24WGgfoHn4JPicd8He
         rS8NLkit65oXPztWCIk1plc/L0WWZ1stJCGO0xc9wMl4POqoTrOZPublJSijHPF4oz
         YlEcjE5Kwe8W73hiYvKQSbG68Y5Kyn6lFrlJJDjGKeMTC6UZAwh79rs3bU7nluQGBU
         tiS60ivJdA1OXEq/xKwuvgxelAM+i8GtKwUxe5gT00CZzdwQsaCSrG5/5u9c1vIGyV
         elULRRCAhePhL/Al9xGEtorsHTDGauC6YCgaYOxRHSZ2eYhHw9pEXNQZFB7ZzH7n03
         HSw2Jfv0l97fA==
Date:   Wed, 14 Jun 2023 17:53:28 +0300
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
Subject: Re: [PATCH v4 18/34] mm: Remove page table members from struct page
Message-ID: <20230614145328.GQ52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-19-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-19-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:04:07PM -0700, Vishal Moola (Oracle) wrote:
> The page table members are now split out into their own ptdesc struct.
> Remove them from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm_types.h | 14 --------------
>  include/linux/pgtable.h  |  3 ---
>  2 files changed, 17 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6161fe1ae5b8..31ffa1be21d0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -141,20 +141,6 @@ struct page {
>  		struct {	/* Tail pages of compound page */
>  			unsigned long compound_head;	/* Bit zero is set */
>  		};
> -		struct {	/* Page table pages */
> -			unsigned long _pt_pad_1;	/* compound_head */
> -			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> -			unsigned long _pt_s390_gaddr;	/* mapping */
> -			union {
> -				struct mm_struct *pt_mm; /* x86 pgds only */
> -				atomic_t pt_frag_refcount; /* powerpc */
> -			};
> -#if ALLOC_SPLIT_PTLOCKS
> -			spinlock_t *ptl;
> -#else
> -			spinlock_t ptl;
> -#endif
> -		};
>  		struct {	/* ZONE_DEVICE pages */
>  			/** @pgmap: Points to the hosting device page map. */
>  			struct dev_pagemap *pgmap;
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index c405f74d3875..33cc19d752b3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1019,10 +1019,7 @@ struct ptdesc {
>  TABLE_MATCH(flags, __page_flags);
>  TABLE_MATCH(compound_head, pt_list);
>  TABLE_MATCH(compound_head, _pt_pad_1);
> -TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
>  TABLE_MATCH(mapping, _pt_s390_gaddr);
> -TABLE_MATCH(pt_mm, pt_mm);
> -TABLE_MATCH(ptl, ptl);
>  #undef TABLE_MATCH
>  static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
