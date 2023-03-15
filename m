Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503016BB91C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 17:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbjCOQIL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjCOQHz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 12:07:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC240DF;
        Wed, 15 Mar 2023 09:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678896448; x=1710432448;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zWuBYVSnC9MhWCnX+eJu2W2TKgqfs4fJzjKWikscQgU=;
  b=Ahstg3QuV6n4iG6Ew/T9K3CYK6nLpOOh7J/g5bmGgE1liIo4f82B4zZe
   Sl/RyfqanyDVbZAXNF3J9sZavSaHEv9G7GR8U5cm0bkZMC7H89ubHnzSu
   V9zHtmHZ9yHEOJTwO7bWJzE/4JTt+ExiKuvAUn1p5iZKpuA4W9bL/4P+r
   zlNrxRKWH4csg/o9bjYKWmoOWrm+PvTPo8ET/qsIMSHRWB98oCSZ80Jee
   SlyhzifoQlIsz7Z9rzCDxjWLG0mQ8DFUrgGHqTT70+/bQQq/XbjxURcLb
   4HBzJtl8mi3fTI4OMbpR92UGpu/fZs/tDRDYYaQn61uQb3lTNPlcNv9El
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="321586795"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="321586795"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 09:03:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="681902753"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="681902753"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 09:03:43 -0700
Date:   Wed, 15 Mar 2023 09:07:39 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 09/10] iommu: Fix MAX_ORDER usage in
 __iommu_dma_alloc_pages()
Message-ID: <20230315090739.128d4341@jacob-builder>
In-Reply-To: <20230315113133.11326-10-kirill.shutemov@linux.intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
        <20230315113133.11326-10-kirill.shutemov@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Kirill,

On Wed, 15 Mar 2023 14:31:32 +0300, "Kirill A. Shutemov"
<kirill.shutemov@linux.intel.com> wrote:

> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.
> 
> Fix MAX_ORDER usage in __iommu_dma_alloc_pages().
> 
> Also use GENMASK() instead of hard to read "(2U << order) - 1" magic.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
> @@ -736,7 +736,7 @@ static struct page **__iommu_dma_alloc_pages(struct
> device *dev, struct page **pages;
>  	unsigned int i = 0, nid = dev_to_node(dev);
>  
> -	order_mask &= (2U << MAX_ORDER) - 1;
> +	order_mask &= GENMASK(MAX_ORDER - 1, 0);
>  	if (!order_mask)
>  		return NULL;
>  
> @@ -756,7 +756,7 @@ static struct page **__iommu_dma_alloc_pages(struct
> device *dev,
>  		 * than a necessity, hence using __GFP_NORETRY until
>  		 * falling back to minimum-order allocations.
>  		 */
> -		for (order_mask &= (2U << __fls(count)) - 1;
> +		for (order_mask &= GENMASK(__fls(count), 0);
>  		     order_mask; order_mask &= ~order_size) {
>  			unsigned int order = __fls(order_mask);
>  			gfp_t alloc_flags = gfp;
Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
(For VT-d part, there is no functional impact at all. We only have 2M and 1G
page sizes, no SZ_8M page)

Thanks,

Jacob
