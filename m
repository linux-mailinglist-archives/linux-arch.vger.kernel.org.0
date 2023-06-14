Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F237302DD
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jun 2023 17:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbjFNPHm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jun 2023 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343494AbjFNPHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jun 2023 11:07:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01166A6;
        Wed, 14 Jun 2023 08:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CEAD60F66;
        Wed, 14 Jun 2023 15:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBECC433C0;
        Wed, 14 Jun 2023 15:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686755259;
        bh=JsVwqtt4rn+oBmP9veLZYMWTShEVF7o+ZQx0DgLi4Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5kIgCv/a7WFPC5tRs5sqFZpJHWZmRkycbqhaUCenxA+sXENaMqraBn8uW0a+QebT
         mZ6OdRi8HqTKN/fLlxiLY+gYTEXBMlPJd7k4eHkAR+MLf6P+LaRVRHLiwBZOMWFPeh
         Fhqqn9UjnVNIm5Q5RdXmqRztziwcn9ltJweM50aQJ0s3juJZJPLTo3DhbuvPdQJPaq
         h2LbrXxJrmkyH9p2jpuC5ESJKX7YVXMhAfWp7vNoPgXlO5lI86wghzWDGdue/lx2YA
         x6FoTUTEZw7X60hwDiqn+akRr/yO0jO9WPeQeAUaQGxHZWlG5RVnPrpPcimJ1Z2/OZ
         FP8RrhHA6VKEw==
Date:   Wed, 14 Jun 2023 18:07:03 +0300
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
        Hugh Dickins <hughd@google.com>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v4 22/34] csky: Convert __pte_free_tlb() to use ptdescs
Message-ID: <20230614150703.GU52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-23-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-23-vishal.moola@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 12, 2023 at 02:04:11PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Guo Ren <guoren@kernel.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/csky/include/asm/pgalloc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
> index 7d57e5da0914..9c84c9012e53 100644
> --- a/arch/csky/include/asm/pgalloc.h
> +++ b/arch/csky/include/asm/pgalloc.h
> @@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  
>  #define __pte_free_tlb(tlb, pte, address)		\
>  do {							\
> -	pgtable_pte_page_dtor(pte);			\
> -	tlb_remove_page(tlb, pte);			\
> +	pagetable_pte_dtor(page_ptdesc(pte));		\
> +	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
>  } while (0)
>  
>  extern void pagetable_init(void);
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.
