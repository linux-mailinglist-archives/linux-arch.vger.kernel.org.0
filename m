Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFC16BAF4C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbjCOLcD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 07:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjCOLb5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:31:57 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5166F6F629;
        Wed, 15 Mar 2023 04:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678879909; x=1710415909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqwXAyl2Jl7pmzwDfdXypoW87246pyJ3bkPjNFW5WAg=;
  b=lS8vMHlZnp5hCr9HdN/4jahh+XMIIyEyxoQoU9M82vcytcBDx5XLTCMQ
   28Hil5dHOVqHQnafdCk2IsC0WXe2+B2ohrELEMHX58bKqllLOLuwCIMaF
   ivbLatbLgyhw9c1hxu30IUsH64qjj9rf+Y7yPERN9KHhwSJjFRNKR3KV5
   PEerK4IXkiC/+1Ff7DjEqgcfkvBh/ZCk51pPycuzJYeuRnqtO+vpQ9HHh
   8lv+JJ67PNqFLA0tMvN3v9FMhybIMAcyveRk2Rkc+0RApSt4KNNx1DDaJ
   csAvTgBrfaFDrP7dkIrIH62i7y1ufs8lihc4FGvXT34m9fwKqVWHR1QXe
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317330345"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="317330345"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="925310581"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925310581"
Received: from nopopovi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.48])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:43 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id DB6B510CCA3; Wed, 15 Mar 2023 14:31:35 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH 07/10] mm/page_reporting: Fix MAX_ORDER usage in page_reporting_register()
Date:   Wed, 15 Mar 2023 14:31:30 +0300
Message-Id: <20230315113133.11326-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
can deliver is MAX_ORDER-1.

Fix MAX_ORDER usage in page_reporting_register().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/page_reporting.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index c65813a9dc78..275b466de37b 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -370,7 +370,7 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
 	 */
 
 	if (page_reporting_order == -1) {
-		if (prdev->order > 0 && prdev->order <= MAX_ORDER)
+		if (prdev->order > 0 && prdev->order < MAX_ORDER)
 			page_reporting_order = prdev->order;
 		else
 			page_reporting_order = pageblock_order;
-- 
2.39.2

