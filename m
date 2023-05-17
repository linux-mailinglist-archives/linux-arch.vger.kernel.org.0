Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13AD706018
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 08:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjEQGaV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 02:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjEQGaU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 02:30:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21081468B;
        Tue, 16 May 2023 23:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S5cEDxvLIXfF6hhPeiKwzMcCpc9yxz2+Gj2aOaYhurM=; b=OiHf3Ei73KQczceza5cq/WYQh4
        Am9CD9gpEjCRUmvhkl1xG7u/iGOdJgbpHXPze13IrKHa4wII2y8jx2oNcaxfMR+gOhl5TSVIsRxWY
        QPpfQcN4qJhRUGL6zhTq8alf9bXPD4Q0sNLMxcA2+bxy6G6XPkpoocLd6PPCS4l46pedkhWpY/9iK
        9zW0zLv8r54JAUSAiUQGMT4M7hxtxqvZoGhv0g06mrcX7ncLrInemXxjh+syjmADMs92jahScH8bh
        x0J0GAbH/lDS3LJj8H6NUA2pDGyH0gSt/x7AcpFBulfQWhVOl6Zc6dacJgFBZzUbJ8KDCzxZggiQd
        OsT0u5NQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzAfY-008T7E-2H;
        Wed, 17 May 2023 06:29:52 +0000
Date:   Tue, 16 May 2023 23:29:52 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, arnd@arndb.de, christophe.leroy@csgroup.eu,
        hch@infradead.org, agordeev@linux.ibm.com,
        wangkefeng.wang@huawei.com, schnelle@linux.ibm.com,
        David.Laight@aculab.com, shorne@gmail.com, willy@infradead.org,
        deller@gmx.de
Subject: Re: [PATCH v5 RESEND 04/17] mm/ioremap: Define
 generic_ioremap_prot() and generic_iounmap()
Message-ID: <ZGR0YP/ky8IXf0oF@infradead.org>
References: <20230515090848.833045-1-bhe@redhat.com>
 <20230515090848.833045-5-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515090848.833045-5-bhe@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 15, 2023 at 05:08:35PM +0800, Baoquan He wrote:
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
> Define a generic version of ioremap_prot() and iounmap() that
> architectures can call after they have performed the necessary
> alteration to parameters and/or necessary verifications.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  include/asm-generic/io.h |  4 ++++
>  mm/ioremap.c             | 22 ++++++++++++++++------
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 587e7e9b9a37..a7ca2099ba19 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -1073,9 +1073,13 @@ static inline bool iounmap_allowed(void *addr)
>  }
>  #endif
>  
> +void __iomem *generic_ioremap_prot(phys_addr_t phys_addr, size_t size,
> +				   pgprot_t prot);
> +

Formatting looks a bit weird here.  The normal styles are either to
indent with two tabs (my preference) or after the opening brace.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
