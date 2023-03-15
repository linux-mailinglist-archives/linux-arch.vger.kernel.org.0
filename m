Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C956BB086
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 13:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjCOMTF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 08:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjCOMTB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 08:19:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 012CA206B0;
        Wed, 15 Mar 2023 05:18:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E537F2F4;
        Wed, 15 Mar 2023 05:19:21 -0700 (PDT)
Received: from [10.57.53.4] (unknown [10.57.53.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 916863F67D;
        Wed, 15 Mar 2023 05:18:36 -0700 (PDT)
Message-ID: <97aced64-c0ac-6041-41cd-ae3439216089@arm.com>
Date:   Wed, 15 Mar 2023 12:18:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/10] iommu: Fix MAX_ORDER usage in
 __iommu_dma_alloc_pages()
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-10-kirill.shutemov@linux.intel.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230315113133.11326-10-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2023-03-15 11:31, Kirill A. Shutemov wrote:
> MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
> can deliver is MAX_ORDER-1.
> 
> Fix MAX_ORDER usage in __iommu_dma_alloc_pages().

Technically this isn't a major issue - all it means is that if we did 
happen to have a suitable page size which lined up with MAX_ORDER, we'd 
unsuccessfully try the allocation once before falling back to the order 
of the next-smallest page size anyway. Semantically you're correct 
though, and I probably did still misunderstand MAX_ORDER 7 years ago :)

> Also use GENMASK() instead of hard to read "(2U << order) - 1" magic.

ISTR that GENMASK() had a habit of generating pretty terrible code for 
non-constant arguments, but a GCC9 build for arm64 looks fine - in fact 
if anything it seems to be able to optimise out more of the __fls() this 
way and save a couple more instructions, which is nice, so:

Acked-by: Robin Murphy <robin.murphy@arm.com>

I'm guessing you probably want to take this through the mm tree - that 
should be fine since I don't expect any conflicting changes in the IOMMU 
tree for now (cc'ing Joerg just as a heads-up).

Cheers,
Robin.

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/dma-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 99b2646cb5c7..ac996fd6bd9c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -736,7 +736,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   	struct page **pages;
>   	unsigned int i = 0, nid = dev_to_node(dev);
>   
> -	order_mask &= (2U << MAX_ORDER) - 1;
> +	order_mask &= GENMASK(MAX_ORDER - 1, 0);
>   	if (!order_mask)
>   		return NULL;
>   
> @@ -756,7 +756,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>   		 * than a necessity, hence using __GFP_NORETRY until
>   		 * falling back to minimum-order allocations.
>   		 */
> -		for (order_mask &= (2U << __fls(count)) - 1;
> +		for (order_mask &= GENMASK(__fls(count), 0);
>   		     order_mask; order_mask &= ~order_size) {
>   			unsigned int order = __fls(order_mask);
>   			gfp_t alloc_flags = gfp;
