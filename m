Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0A6BAF49
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjCOLcA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 07:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjCOLb4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:31:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7AAC65C7D;
        Wed, 15 Mar 2023 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678879906; x=1710415906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wxXpVFa3aHUh2uZGVGV6zRauliwfaR2PzVjPmjMqjVA=;
  b=TljsWKvVt86ufMoAeafYZk4YW/phJKKvSxtJ2QhpA/oxgfeY3UEFH6E0
   D5THCmMYX5kcDqZ1YqNAswb4qv9mJQWKcoptMUvEUuOwTvB9x88J+4Vi2
   GRk4KOUmQTQpbeeGQ4PJDB7PsvgZ8KQmkYnJ/qokpHnVebg8FNm/LQA9O
   50E3tIlf+6mvOHVuUr8tILQGD5D5lcigw478nTz7IcjJVIlWPQMu+cl/R
   lKSPnjqRhjinX8GoyWZxjY22DRv403DvjQnhYuek3LRbj5A8vegqy2/uS
   lf7x/9byjXw/EJqStyqtR8tWcklNMyGd3JPkCoYHmNR+Xto3RH0IsFb3l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="340040134"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340040134"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768456013"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="768456013"
Received: from nopopovi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.48])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:43 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id ED58B10D690; Wed, 15 Mar 2023 14:31:35 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 09/10] iommu: Fix MAX_ORDER usage in __iommu_dma_alloc_pages()
Date:   Wed, 15 Mar 2023 14:31:32 +0300
Message-Id: <20230315113133.11326-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
can deliver is MAX_ORDER-1.

Fix MAX_ORDER usage in __iommu_dma_alloc_pages().

Also use GENMASK() instead of hard to read "(2U << order) - 1" magic.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/dma-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 99b2646cb5c7..ac996fd6bd9c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -736,7 +736,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 	struct page **pages;
 	unsigned int i = 0, nid = dev_to_node(dev);
 
-	order_mask &= (2U << MAX_ORDER) - 1;
+	order_mask &= GENMASK(MAX_ORDER - 1, 0);
 	if (!order_mask)
 		return NULL;
 
@@ -756,7 +756,7 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
 		 * than a necessity, hence using __GFP_NORETRY until
 		 * falling back to minimum-order allocations.
 		 */
-		for (order_mask &= (2U << __fls(count)) - 1;
+		for (order_mask &= GENMASK(__fls(count), 0);
 		     order_mask; order_mask &= ~order_size) {
 			unsigned int order = __fls(order_mask);
 			gfp_t alloc_flags = gfp;
-- 
2.39.2

