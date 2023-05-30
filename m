Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B816A7157F2
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 10:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjE3IGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 04:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjE3IGb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 04:06:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A991118;
        Tue, 30 May 2023 01:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685433979; x=1716969979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OGmxL+UqnOoB6DUSYUyFxvx/lt+FRL5wf9KNfFiPBCY=;
  b=ng9wZFYynhWGKyhXbvZ8W/P5iR1hoO/6ZKbiZ8paLvOcP0prkQBT2Bii
   rYdRFbSVvVFgtjCjQdGvnRHoHcStbvYubxxJKRD4G2AIhsRSlIHoBJGod
   VElCzvwg6bJy6vFyJHy4E9QgM0RcVhwTsb/sOQ1QpNTqzMZhYXubQDcJm
   2qMEq31CD9QtN793Yt64HAtRZwsUWVx4M+06/bd26ixnhB6gS0EHMCijf
   BVNnSW7G/mZ7OIQ/asqB4UajzbbH7+myCLAYB5cZAIiJV2UGkmqkVWIvO
   ARvspQATOe9dyQVBq8oY3MOD8FvoKaFS/+Tvizu1u51b3NzmkEsmTBH38
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="418332094"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="418332094"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="739426336"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="739426336"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga001.jf.intel.com with ESMTP; 30 May 2023 01:06:16 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     willy@infradead.org, ryan.roberts@arm.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     fengwei.yin@intel.com
Subject: [PATCH 1/4] filemap: avoid interfere with xas.xa_index
Date:   Tue, 30 May 2023 16:07:28 +0800
Message-Id: <20230530080731.1462122-2-fengwei.yin@intel.com>
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

Ryan noticed 1% performance regression for kernel build with
the ranged file map with ext4 file system. It was later identified
wrong xas.xa_index update in filemap_map_pages() when folio is
not large folio.

Matthew suggested to use XArray API instead of touch xas.xa_index
directly at [1].

[1] https://lore.kernel.org/linux-mm/ZBho6Q6Xq%2FYqRmBT@casper.infradead.org/

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
---
 mm/filemap.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 40be33b5ee46..fdb3e0a339b3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3416,10 +3416,10 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 	return false;
 }
 
-static struct folio *next_uptodate_page(struct folio *folio,
-				       struct address_space *mapping,
-				       struct xa_state *xas, pgoff_t end_pgoff)
+static struct folio *next_uptodate_folio(struct xa_state *xas,
+		struct address_space *mapping, pgoff_t end_pgoff)
 {
+	struct folio *folio = xas_next_entry(xas, end_pgoff);
 	unsigned long max_idx;
 
 	do {
@@ -3457,22 +3457,6 @@ static struct folio *next_uptodate_page(struct folio *folio,
 	return NULL;
 }
 
-static inline struct folio *first_map_page(struct address_space *mapping,
-					  struct xa_state *xas,
-					  pgoff_t end_pgoff)
-{
-	return next_uptodate_page(xas_find(xas, end_pgoff),
-				  mapping, xas, end_pgoff);
-}
-
-static inline struct folio *next_map_page(struct address_space *mapping,
-					 struct xa_state *xas,
-					 pgoff_t end_pgoff)
-{
-	return next_uptodate_page(xas_next_entry(xas, end_pgoff),
-				  mapping, xas, end_pgoff);
-}
-
 /*
  * Map page range [start_page, start_page + nr_pages) of folio.
  * start_page is gotten from start by folio_page(folio, start)
@@ -3543,12 +3527,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	unsigned long addr;
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
-	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	vm_fault_t ret = 0;
 	int nr_pages = 0;
 
 	rcu_read_lock();
-	folio = first_map_page(mapping, &xas, end_pgoff);
+	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
 	if (!folio)
 		goto out;
 
@@ -3570,15 +3553,14 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 
 		ret |= filemap_map_folio_range(vmf, folio,
 				xas.xa_index - folio->index, addr, nr_pages);
-		xas.xa_index += nr_pages;
 
 		folio_unlock(folio);
 		folio_put(folio);
-	} while ((folio = next_map_page(mapping, &xas, end_pgoff)) != NULL);
+		folio = next_uptodate_folio(&xas, mapping, end_pgoff);
+	} while (folio);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 out:
 	rcu_read_unlock();
-	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 	return ret;
 }
 EXPORT_SYMBOL(filemap_map_pages);
-- 
2.30.2

