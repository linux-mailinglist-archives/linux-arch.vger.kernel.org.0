Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE14A6BAF3C
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjCOLbo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 07:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjCOLbm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:31:42 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1937864846;
        Wed, 15 Mar 2023 04:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678879902; x=1710415902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CbKC9In0sfgAFhGmEkzB7Bb+JmElN2MpqrLq/60tyc4=;
  b=ElAxf5JwDWlsUz4WnDO0m9NyEmkAV2NOUUFD8qSfgU5WNco8iswrNDK/
   JxrlzVeaTH3ohGiyvpG9OqH6PnQPETgTErrS1IJTHRipzvVjqHA4xHOsW
   u/H3MKTPE9LFLn3n2T1ailbwqD5u7q+ecvpQ+bqdcnga9TtLOP/VbdSle
   Bb7G7iE5RBCnXSmP02CHBt2U1dvgbFoRwkeIWjUVKffnx1tzEe9cug62j
   b7Pn1tNrutSldOoKv2sOzMOfV2TpMRczu252huVVkppqOS/75UCXhcjDJ
   WhVjNtEfeWuHmoXcUneeQHmxR6GVBLY4p3PHXzGI9xRzdGe1zURM6iKeQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317330268"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="317330268"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="925310514"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925310514"
Received: from nopopovi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.48])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:38 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id BB81D10CC9F; Wed, 15 Mar 2023 14:31:35 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 03/10] floppy: Fix MAX_ORDER usage
Date:   Wed, 15 Mar 2023 14:31:26 +0300
Message-Id: <20230315113133.11326-4-kirill.shutemov@linux.intel.com>
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

Fix MAX_ORDER usage in floppy code.

Also allocation buffer exactly PAGE_SIZE << MAX_ORDER bytes is okay. Fix
MAX_LEN check.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 487840e3564d..90d2dfb6448e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3079,7 +3079,7 @@ static void raw_cmd_free(struct floppy_raw_cmd **ptr)
 	}
 }
 
-#define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)
+#define MAX_LEN (1UL << (MAX_ORDER - 1) << PAGE_SHIFT)
 
 static int raw_cmd_copyin(int cmd, void __user *param,
 				 struct floppy_raw_cmd **rcmd)
@@ -3108,7 +3108,7 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 	ptr->resultcode = 0;
 
 	if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
-		if (ptr->length <= 0 || ptr->length >= MAX_LEN)
+		if (ptr->length <= 0 || ptr->length > MAX_LEN)
 			return -EINVAL;
 		ptr->kernel_data = (char *)fd_dma_mem_alloc(ptr->length);
 		fallback_on_nodma_alloc(&ptr->kernel_data, ptr->length);
-- 
2.39.2

