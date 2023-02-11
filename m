Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C91692DFA
	for <lists+linux-arch@lfdr.de>; Sat, 11 Feb 2023 04:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBKDkE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Feb 2023 22:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBKDkD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Feb 2023 22:40:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C607D37555
        for <linux-arch@vger.kernel.org>; Fri, 10 Feb 2023 19:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aaXlbA2/BvRg6HHDAadnVZCwlkGxkg/4CEs3FrmdfUo=; b=WG+cCCwQUC/ZjIWR94a19/LBWU
        lVGQ77hW0CWVTgjmxOD1LgDbemxdMo08QnirJDUmnVuyhvwWRkEM/syoO2RC6FQNRLMnghc1djwhM
        rGHuc2XWxNjniFmcnC46So5vf5OEvRgFUfMsCWJOCiXP2T9+nSwg4lzGofnlY7KO9Uyk014+AfvZm
        S/ryGW9ZnnIXXfIjqPC780Hz7uihlK9Fgyholr+fIj2ZFurhPmdccXibd3knmsPYfcy277UqvBrFo
        /teaeBbhh1O/UpeW9R2vrL+Gd9WR5k/yNxJ2mA61TYWpOCNT2NfQrkpzXy46rRhv+jl65BXKqN6oC
        r6OWn31w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pQgjv-003k2k-9Y; Sat, 11 Feb 2023 03:39:51 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 3/7] mm: Add folio_flush_mapping()
Date:   Sat, 11 Feb 2023 03:39:44 +0000
Message-Id: <20230211033948.891959-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230211033948.891959-1-willy@infradead.org>
References: <20230211033948.891959-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is the folio equivalent of page_mapping_file(), but rename it
to make it clear that it's very different from page_file_mapping().
Theoretically, there's nothing flush-only about it, but there are no
other users today, and I doubt there will be; it's almost always more
useful to know the swapfile's mapping or the swapcache's mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 51b75b89730e..647c5a036a97 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -369,6 +369,26 @@ static inline struct address_space *folio_file_mapping(struct folio *folio)
 	return folio->mapping;
 }
 
+/**
+ * folio_flush_mapping - Find the file mapping this folio belongs to.
+ * @folio: The folio.
+ *
+ * For folios which are in the page cache, return the mapping that this
+ * page belongs to.  Anonymous folios return NULL, even if they're in
+ * the swap cache.  Other kinds of folio also return NULL.
+ *
+ * This is ONLY used by architecture cache flushing code.  If you aren't
+ * writing cache flushing code, you want either folio_mapping() or
+ * folio_file_mapping().
+ */
+static inline struct address_space *folio_flush_mapping(struct folio *folio)
+{
+	if (unlikely(folio_test_swapcache(folio)))
+		return swapcache_mapping(folio);
+
+	return folio->mapping;
+}
+
 static inline struct address_space *page_file_mapping(struct page *page)
 {
 	return folio_file_mapping(page_folio(page));
@@ -379,11 +399,7 @@ static inline struct address_space *page_file_mapping(struct page *page)
  */
 static inline struct address_space *page_mapping_file(struct page *page)
 {
-	struct folio *folio = page_folio(page);
-
-	if (unlikely(folio_test_swapcache(folio)))
-		return NULL;
-	return folio_mapping(folio);
+	return folio_flush_mapping(page_folio(page));
 }
 
 /**
-- 
2.39.1

