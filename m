Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DFF7157F7
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjE3IHO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 04:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjE3IGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 04:06:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DE3E45;
        Tue, 30 May 2023 01:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685433993; x=1716969993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JECnRzWsjoveNrvZKVFqMJv39FXO8gY9Cjv6t+BF/f4=;
  b=J8yG1yGdFAvuqe/XMreBBHjOZabgraIDKMCmT5mqNPDiaWFYXf8Hnx71
   t0oMh61eU8Om+RHHcg5tC0HWAwQI+SBDNBxPS84OmN75WnMkBEO9GAMLe
   yM16AvbNDUtEGMtrFxoWTEaG6NsYIJ+6DT3eJjVQ01krDwxEYwUBsv/jc
   ZFxGxGy821NvJHXIFB2N4WymJzNbVUAyUWrKPhSjpFgKaUTXUt62jRQDa
   5gN9nMuIAZhDm9Z82M7vm/AOrfeNUIZPHHbw0WEDzWQix09y4waxqPBqO
   Wh7qiinhU7A+K/PxpTzao/5qsr1HnFL22Dy3xv1qMpVpZ+k+l2ZYlQXLT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="418332163"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="418332163"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739426363"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739426363"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga001.jf.intel.com with ESMTP; 30 May 2023 01:06:30 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     willy@infradead.org, ryan.roberts@arm.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     fengwei.yin@intel.com
Subject: [PATCH 2/4] rmap: fix typo in folio_add_file_rmap_range()
Date:   Tue, 30 May 2023 16:07:29 +0800
Message-Id: <20230530080731.1462122-3-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230530080731.1462122-1-fengwei.yin@intel.com>
References: <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
 <20230530080731.1462122-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The "first" should be used to compare with COMPOUND_MAPPED
instead of "nr".

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index ec52d7f264aa..b352c14da16c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1330,7 +1330,7 @@ void folio_add_file_rmap_range(struct folio *folio, struct page *page,
 			first = atomic_inc_and_test(&page->_mapcount);
 			if (first && folio_test_large(folio)) {
 				first = atomic_inc_return_relaxed(mapped);
-				first = (nr < COMPOUND_MAPPED);
+				first = (first < COMPOUND_MAPPED);
 			}
 
 			if (first)
-- 
2.30.2

