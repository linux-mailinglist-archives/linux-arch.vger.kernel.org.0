Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC76BAF40
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjCOLbq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 07:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjCOLbo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:31:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2E6637F7;
        Wed, 15 Mar 2023 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678879903; x=1710415903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AX8fQ9JFCUx8sgKM3jU0DHxltPa90kVlWb8uT8+Z308=;
  b=h/GNn2Qn4BExyno6TU2mepAnbByIuOLSFyB/0bB0ZJZXY8rNcci6lGee
   mBcrT5lJ+BuenVwMzYJSbLsXLOpSX/lTpilqM6aGnfGxawNHe27izFw8o
   fDsCobLXkoLTgIBqGokhTxI5Zy1YE5bIR/7adF2nqAz81p8Vb6DkpMpRs
   ERjheg5H3U/O3Ukc4XKpl6msC1m132AWiaZYnFcGkFeuSNZGMS7h+z85/
   Af2Eyj6NqusuyyxEH60gpbqo6xjmALSSne3/PSlaWLqiX4hTIizNmNY9X
   d8wLI2Pttir7Q4yXOeZN5coAprh20WiWTJXDQRnRvV2D0Dl3Jvyv/bdjG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317330278"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="317330278"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="925310513"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925310513"
Received: from nopopovi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.48])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:38 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id AB8FF10CC9D; Wed, 15 Mar 2023 14:31:35 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>
Subject: [PATCH 01/10] sparc/mm: Fix MAX_ORDER usage in tsb_grow()
Date:   Wed, 15 Mar 2023 14:31:24 +0300
Message-Id: <20230315113133.11326-2-kirill.shutemov@linux.intel.com>
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

Fix MAX_ORDER usage in tsb_grow().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: sparclinux@vger.kernel.org
Cc: David Miller <davem@davemloft.net>
---
 arch/sparc/mm/tsb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index 912205787161..dba8dffe2113 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -402,8 +402,8 @@ void tsb_grow(struct mm_struct *mm, unsigned long tsb_index, unsigned long rss)
 	unsigned long new_rss_limit;
 	gfp_t gfp_flags;
 
-	if (max_tsb_size > (PAGE_SIZE << MAX_ORDER))
-		max_tsb_size = (PAGE_SIZE << MAX_ORDER);
+	if (max_tsb_size > (PAGE_SIZE << (MAX_ORDER - 1)))
+		max_tsb_size = (PAGE_SIZE << (MAX_ORDER - 1));
 
 	new_cache_index = 0;
 	for (new_size = 8192; new_size < max_tsb_size; new_size <<= 1UL) {
-- 
2.39.2

