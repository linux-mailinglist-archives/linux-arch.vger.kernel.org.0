Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B5C6BED18
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 16:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjCQPhc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 11:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCQPhI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 11:37:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8D053716;
        Fri, 17 Mar 2023 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679067374; x=1710603374;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JJhHmMEgTKijBL3qP7Bc1Wtdy27vQcYTHcBz2RcuKB8=;
  b=KQNS4LTUKqVIXjovShBwPq3CrLwJUzH+U35Td6V6FtHXjWQjeJ6U/bk6
   /4GISBhZiTgoNsYml3Xg0MvrgzenFLbhS8Jr1MZgVtMOJ8qPOfYa5Rsfm
   1out38TZt1CM5jPLp1XDH5hX11oY+DuOOYcfpAfb+lDfrcQsyM7cSg6qX
   chImrKiOwpr6gyoJJCj+uzh0rM5ztOQndC3P8O1pyVd9iwwoGty8zCjSI
   jEw8lr7rvKEOQGuWNQkipcVv7Tcz4QRXFxKC5qC6VJ9B/nmmGB2sg0J5F
   RWD0LIgmi8Nfr9rF8EQ9JxRC7FsHHt39m3ua3lM97FxvyDrbA9dMzHOSX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="400864271"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="400864271"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 08:35:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="769392505"
X-IronPort-AV: E=Sophos;i="5.98,268,1673942400"; 
   d="scan'208";a="769392505"
Received: from pczabans-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.98])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2023 08:35:04 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 3A10E10D47D; Fri, 17 Mar 2023 18:35:02 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] mm/page_alloc: Make deferred page init free pages in MAX_ORDER blocks
Date:   Fri, 17 Mar 2023 18:35:01 +0300
Message-Id: <20230317153501.19807-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
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

Normal page init path frees pages during the boot in MAX_ORDER chunks,
but deferred page init path does it in pageblock blocks.

Change deferred page init path to work in MAX_ORDER blocks.

For cases when pageblock is larger than MAX_ORDER, set migrate type to
MIGRATE_MOVABLE for all pageblocks covered by the page.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---

Note: the patch depends on the new definiton of MAX_ORDER.

---
 include/linux/mmzone.h |  2 ++
 mm/page_alloc.c        | 19 ++++++++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 96599cb9eb62..f53fe3a7ca45 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -32,6 +32,8 @@
 #endif
 #define MAX_ORDER_NR_PAGES (1 << MAX_ORDER)
 
+#define IS_MAX_ORDER_ALIGNED(pfn) IS_ALIGNED(pfn, MAX_ORDER_NR_PAGES)
+
 /*
  * PAGE_ALLOC_COSTLY_ORDER is the order at which allocations are deemed
  * costly to service.  That is between allocation orders which should
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 87d760236dba..fc02a243425d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1875,9 +1875,10 @@ static void __init deferred_free_range(unsigned long pfn,
 	page = pfn_to_page(pfn);
 
 	/* Free a large naturally-aligned chunk if possible */
-	if (nr_pages == pageblock_nr_pages && pageblock_aligned(pfn)) {
-		set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_core(page, pageblock_order);
+	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
+		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
+			set_pageblock_migratetype(page + i, MIGRATE_MOVABLE);
+		__free_pages_core(page, MAX_ORDER);
 		return;
 	}
 
@@ -1901,19 +1902,19 @@ static inline void __init pgdat_init_report_one_done(void)
 /*
  * Returns true if page needs to be initialized or freed to buddy allocator.
  *
- * We check if a current large page is valid by only checking the validity
+ * We check if a current MAX_ORDER block is valid by only checking the validity
  * of the head pfn.
  */
 static inline bool __init deferred_pfn_valid(unsigned long pfn)
 {
-	if (pageblock_aligned(pfn) && !pfn_valid(pfn))
+	if (IS_MAX_ORDER_ALIGNED(pfn) && !pfn_valid(pfn))
 		return false;
 	return true;
 }
 
 /*
  * Free pages to buddy allocator. Try to free aligned pages in
- * pageblock_nr_pages sizes.
+ * MAX_ORDER_NR_PAGES sizes.
  */
 static void __init deferred_free_pages(unsigned long pfn,
 				       unsigned long end_pfn)
@@ -1924,7 +1925,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 		if (!deferred_pfn_valid(pfn)) {
 			deferred_free_range(pfn - nr_free, nr_free);
 			nr_free = 0;
-		} else if (pageblock_aligned(pfn)) {
+		} else if (IS_MAX_ORDER_ALIGNED(pfn)) {
 			deferred_free_range(pfn - nr_free, nr_free);
 			nr_free = 1;
 		} else {
@@ -1937,7 +1938,7 @@ static void __init deferred_free_pages(unsigned long pfn,
 
 /*
  * Initialize struct pages.  We minimize pfn page lookups and scheduler checks
- * by performing it only once every pageblock_nr_pages.
+ * by performing it only once every MAX_ORDER_NR_PAGES.
  * Return number of pages initialized.
  */
 static unsigned long  __init deferred_init_pages(struct zone *zone,
@@ -1953,7 +1954,7 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 		if (!deferred_pfn_valid(pfn)) {
 			page = NULL;
 			continue;
-		} else if (!page || pageblock_aligned(pfn)) {
+		} else if (!page || IS_MAX_ORDER_ALIGNED(pfn)) {
 			page = pfn_to_page(pfn);
 		} else {
 			page++;
-- 
2.39.2

