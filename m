Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540FF6BAF45
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCOLb6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 07:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCOLbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:31:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6EA0637F7;
        Wed, 15 Mar 2023 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678879905; x=1710415905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UWzGGkVyoi9uLhDhUj8Gm1X5MYwKK4ubOq9Kr6YKifI=;
  b=LP5If7LQQDIeFvZKfUTepVi+kW5v9SUL6pXdWk+G3wJHtdSOMAV1AGiE
   byOTvtaQin2k+ta54sO95fL514S3vDcD8h9ctYE4uzyzwIzWXOs3RGcrs
   gVR0LhPukfSjx8YAN8LwEZoSG/12KuAvs0wArL+1ARApTGu6qBaJtzAiO
   17sEQA1oDzZc+/uxY3ugwbzF0R6n/UgGCHfGUPzZGTDHEhQsKLMAJY24L
   84WlrTKJeL6+NIHe+aQbeFYbqf2RK8A9W71cQAdDtorNFRJu3QvS7fXkd
   UlO6jl5mg5JPgAa5FqaHNGXApnRW5AX9Q/LCxN78Wxkrnf+jowf+velyY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="340040119"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340040119"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768456010"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="768456010"
Received: from nopopovi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.48])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:42 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CAC6910CCA1; Wed, 15 Mar 2023 14:31:35 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Frank Haverkamp <haver@linux.ibm.com>
Subject: [PATCH 05/10] genwqe: Fix MAX_ORDER usage
Date:   Wed, 15 Mar 2023 14:31:28 +0300
Message-Id: <20230315113133.11326-6-kirill.shutemov@linux.intel.com>
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

Fix MAX_ORDER usage in genwqe driver.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Frank Haverkamp <haver@linux.ibm.com>
---
 drivers/misc/genwqe/card_dev.c   | 2 +-
 drivers/misc/genwqe/card_utils.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 55fc5b80e649..d0e27438a73c 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -443,7 +443,7 @@ static int genwqe_mmap(struct file *filp, struct vm_area_struct *vma)
 	if (vsize == 0)
 		return -EINVAL;
 
-	if (get_order(vsize) > MAX_ORDER)
+	if (get_order(vsize) >= MAX_ORDER)
 		return -ENOMEM;
 
 	dma_map = kzalloc(sizeof(struct dma_mapping), GFP_KERNEL);
diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
index f778e11237a6..ac29698d085a 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -308,7 +308,7 @@ int genwqe_alloc_sync_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 	sgl->write = write;
 	sgl->sgl_size = genwqe_sgl_size(sgl->nr_pages);
 
-	if (get_order(sgl->sgl_size) > MAX_ORDER) {
+	if (get_order(sgl->sgl_size) >= MAX_ORDER) {
 		dev_err(&pci_dev->dev,
 			"[%s] err: too much memory requested!\n", __func__);
 		return ret;
-- 
2.39.2

