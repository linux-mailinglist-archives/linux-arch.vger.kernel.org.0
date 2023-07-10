Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FDB74DFAE
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjGJUpN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjGJUo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32278E7A;
        Mon, 10 Jul 2023 13:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=3MITzrjsscz3EOfHnUvCpgkBiqSORw5f6CrRiwc69RA=; b=c4AwRiQVrDhrNfG53FzdnE3K+f
        r0ZI918ORvWE+/rlklI90tC0rTzLt/bZqIrIPosed6W8sSGZxn5juLhXXar5zemsZK9Vcqxkkq584
        hDoHHqbFMo7S/5Kft9b2sm/K+b4TNB+bz5U1evgEm9J9ZpskVhypF9jwxVDDkfidplEasdsIZjYqO
        hH7enTDz4wEm9cPzJr4rkEdVKpTkoNXBC4520HuxwPXnYULE3dtoqo3/DlkNRUpSSrtJge5TyrO3P
        66GSziBTrEilNJlA1FCPqBoUjxKyXL04BGstWBXnLIjizU1uhiKJbsmRFrSuJbkOfbXM/ZC6jW7yK
        Q5ywJ05w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjV-00Eurk-IK; Mon, 10 Jul 2023 20:43:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 37/38] filemap: Batch PTE mappings
Date:   Mon, 10 Jul 2023 21:43:38 +0100
Message-Id: <20230710204339.3554919-38-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yin Fengwei <fengwei.yin@intel.com>

Call set_pte_range() once per contiguous range of the folio instead
of once per page.  This batches the updates to mm counters and the
rmap.

With a will-it-scale.page_fault3 like app (change file write
fault testing to read fault testing. Trying to upstream it to
will-it-scale at [1]) got 15% performance gain on a 48C/96T
Cascade Lake test box with 96 processes running against xfs.

Perf data collected before/after the change:
  18.73%--page_add_file_rmap
          |
           --11.60%--__mod_lruvec_page_state
                     |
                     |--7.40%--__mod_memcg_lruvec_state
                     |          |
                     |           --5.58%--cgroup_rstat_updated
                     |
                      --2.53%--__mod_lruvec_state
                                |
                                 --1.48%--__mod_node_page_state

  9.93%--page_add_file_rmap_range
         |
          --2.67%--__mod_lruvec_page_state
                    |
                    |--1.95%--__mod_memcg_lruvec_state
                    |          |
                    |           --1.57%--cgroup_rstat_updated
                    |
                     --0.61%--__mod_lruvec_state
                               |
                                --0.54%--__mod_node_page_state

The running time of __mode_lruvec_page_state() is reduced about 9%.

[1]: https://github.com/antonblanchard/will-it-scale/pull/37

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c06e9d331416..014b73eb96a1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3480,11 +3480,12 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	struct file *file = vma->vm_file;
 	struct page *page = folio_page(folio, start);
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
-	unsigned int ref_count = 0, count = 0;
+	unsigned int count = 0;
+	pte_t *old_ptep = vmf->pte;
 
 	do {
-		if (PageHWPoison(page))
-			continue;
+		if (PageHWPoison(page + count))
+			goto skip;
 
 		if (mmap_miss > 0)
 			mmap_miss--;
@@ -3494,20 +3495,34 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		 * handled in the specific fault path, and it'll prohibit the
 		 * fault-around logic.
 		 */
-		if (!pte_none(*vmf->pte))
-			continue;
-
-		if (vmf->address == addr)
-			ret = VM_FAULT_NOPAGE;
+		if (!pte_none(vmf->pte[count]))
+			goto skip;
 
-		ref_count++;
-		set_pte_range(vmf, folio, page, 1, addr);
-	} while (vmf->pte++, page++, addr += PAGE_SIZE, ++count < nr_pages);
+		count++;
+		continue;
+skip:
+		if (count) {
+			set_pte_range(vmf, folio, page, count, addr);
+			folio_ref_add(folio, count);
+			if (in_range(vmf->address, addr, count))
+				ret = VM_FAULT_NOPAGE;
+		}
 
-	/* Restore the vmf->pte */
-	vmf->pte -= nr_pages;
+		count++;
+		page += count;
+		vmf->pte += count;
+		addr += count * PAGE_SIZE;
+		count = 0;
+	} while (--nr_pages > 0);
+
+	if (count) {
+		set_pte_range(vmf, folio, page, count, addr);
+		folio_ref_add(folio, count);
+		if (in_range(vmf->address, addr, count))
+			ret = VM_FAULT_NOPAGE;
+	}
 
-	folio_ref_add(folio, ref_count);
+	vmf->pte = old_ptep;
 	WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss);
 
 	return ret;
-- 
2.39.2

