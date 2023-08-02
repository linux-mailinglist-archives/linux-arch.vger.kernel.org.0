Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B97676D170
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbjHBPPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbjHBPOV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8630CF;
        Wed,  2 Aug 2023 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=T1BSFaeWVOMDVtOKIkiXYBpk8N9UvaWUSRzfgvCLVV0=; b=Y8yeRgVxKYHnNGwsluFZ1rPAT3
        VMJV1ITjvfKzTieeS6eOjGcGTEOg0fC/aMR487Iu1dEMX9ttlckwuMArtCMAuIecbvIuoJ9aqIoas
        P7Ozy/1xX0QDMsE0N1SUfOm4Pw7TzoBgvBTuwPZjGDKH6mT88PJbCAe+V2vrlaMmxJUU6yj9Pwu5m
        ROJbBRB95rKqE2O5f33eSGHD83hYfJeagG9YIY8NAEBMpPmsbJVgYt690USeD09VCxpYweXuWG0MP
        Qdnv2s/KHSUkPRUQBLj8qWXXBelfdvlCW0wYxus4VjDIP7zJRkdr8IsPCgS+rpMLvsgP/s5veDxlP
        BzEB+uUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDYC-00FfmA-Be; Wed, 02 Aug 2023 15:14:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yin Fengwei <fengwei.yin@intel.com>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v6 37/38] filemap: Batch PTE mappings
Date:   Wed,  2 Aug 2023 16:14:05 +0100
Message-Id: <20230802151406.3735276-38-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230802151406.3735276-1-willy@infradead.org>
References: <20230802151406.3735276-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
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
index 2e7050461a87..bf6219d9aaac 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3485,11 +3485,12 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
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
@@ -3499,20 +3500,34 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
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
2.40.1

