Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8576C2BE2
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 09:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCUIFO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 04:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjCUIFM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 04:05:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D126265B4;
        Tue, 21 Mar 2023 01:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AE241FD72;
        Tue, 21 Mar 2023 08:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679385909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXT6l5aaDTa1oVr79nChExoJR9OyVuFRnefYmGfZyNI=;
        b=sPmhTWCL1og5XFJFy7/1Tq1RRfvzGhkrNQ/Vztc1PgNAzT2u/rM6MnEBc0l928metkIbMn
        tGkwrgBFA+6JSbYSx2IUAbHPMzI35JVKGmougnnY0m9uu/A2lrIlTIjBaV94hjpMfg0HbM
        ZFjFKVfc78CES7zcpHuoxMfxvhvrUt8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679385909;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXT6l5aaDTa1oVr79nChExoJR9OyVuFRnefYmGfZyNI=;
        b=CyiguqYCTTEGICbRQLqnG4suEajOWnsiFXTTuj+cFENhH6vqetZZis+Uh0gv5wAwH4TefH
        xOzaxae7nip7YmAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E56913440;
        Tue, 21 Mar 2023 08:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iry2CjVlGWQ+PAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 08:05:09 +0000
Message-ID: <263a6677-43dc-d138-127d-cfb88d14f305@suse.cz>
Date:   Tue, 21 Mar 2023 09:05:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/10] iommu: Fix MAX_ORDER usage in
 __iommu_dma_alloc_pages()
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-10-kirill.shutemov@linux.intel.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230315113133.11326-10-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/15/23 12:31, Kirill A. Shutemov wrote:
> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.
> 
> Fix MAX_ORDER usage in __iommu_dma_alloc_pages().
> 
> Also use GENMASK() instead of hard to read "(2U << order) - 1" magic.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/dma-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 99b2646cb5c7..ac996fd6bd9c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -736,7 +736,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>  	struct page **pages;
>  	unsigned int i = 0, nid = dev_to_node(dev);
>  
> -	order_mask &= (2U << MAX_ORDER) - 1;
> +	order_mask &= GENMASK(MAX_ORDER - 1, 0);
>  	if (!order_mask)
>  		return NULL;
>  
> @@ -756,7 +756,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>  		 * than a necessity, hence using __GFP_NORETRY until
>  		 * falling back to minimum-order allocations.
>  		 */
> -		for (order_mask &= (2U << __fls(count)) - 1;
> +		for (order_mask &= GENMASK(__fls(count), 0);
>  		     order_mask; order_mask &= ~order_size) {
>  			unsigned int order = __fls(order_mask);
>  			gfp_t alloc_flags = gfp;

