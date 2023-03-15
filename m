Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3017A6BAF48
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjCOLb7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 07:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjCOLbr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:31:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5B965C47;
        Wed, 15 Mar 2023 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678879906; x=1710415906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=52iLXUh9Y9J9QoTpEvXDHrqTMiCmRpr/0OkWw2Dmeo4=;
  b=n4qGSVd1KWwKf79MuJ+BWAiNhFJ/0cplH9BwCSUBi1SiKIl6/qJKh7K/
   hUa+QY8L59Ugses5W+Wptllm24q0s8aiRZQ8US7skxhUrMFYitRhicw2k
   Gfq8U515nc+uCXnbTPkDrizOUgFdLzLYWAV/RZoNJD4plkHZ/ROCh3215
   zcI39ZhPFwpsUP43lXMpizls8xdI0fzlleAgI8w5Ce5Z7yCHEfMvSZinF
   XCg6hUopBxNA4KVDUTw4v8KOTBPysR40ePTrR92bj6Y1TUEePfU6/OrgD
   k2fF4B9P+qucZjk+UIkHywzdQPRcw+8TP9tx5jR4Me2C7cO5CTn+6cLyn
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="340040125"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340040125"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768456012"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="768456012"
Received: from nopopovi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.48])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:43 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id E47DB10D684; Wed, 15 Mar 2023 14:31:35 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 08/10] mm/slub: Fix MAX_ORDER usage in calculate_order()
Date:   Wed, 15 Mar 2023 14:31:31 +0300
Message-Id: <20230315113133.11326-9-kirill.shutemov@linux.intel.com>
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

Fix MAX_ORDER usage in calculate_order().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 39327e98fce3..32eb6b50fe18 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4171,7 +4171,7 @@ static inline int calculate_order(unsigned int size)
 	/*
 	 * Doh this slab cannot be placed using slub_max_order.
 	 */
-	order = calc_slab_order(size, 1, MAX_ORDER, 1);
+	order = calc_slab_order(size, 1, MAX_ORDER - 1, 1);
 	if (order < MAX_ORDER)
 		return order;
 	return -ENOSYS;
-- 
2.39.2

