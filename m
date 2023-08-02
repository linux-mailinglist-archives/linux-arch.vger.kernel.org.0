Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F3B76D177
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjHBPP1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbjHBPOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C627B30E0;
        Wed,  2 Aug 2023 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uh/dLU05HXiEbSg20w2LmQ0wgPaOMm+owDlujvnA+nk=; b=QrowCvRJ89eB18rNesY1xCrndt
        rfqJLhx5g6XpNfP22H0oocN9EwYAt5Cc/PboODlXqt5QzyjwDBQ4fNwyoj2aOxATvpaVYYMCyBgY7
        pbAc5FwRFbjtQjrjik2+JD0c2FKxNpzRCCd3DyfuGGmTSM0uWCI49O5ay5Ct3tiU+ej0DDpA210mW
        NaXwpRVsrFDP4Bqmmt3B25hCYTfT9WMn2KmAhvlTIxF2Ygc7nqIQDJdylwaaiGy7Hjk980g/7FROT
        3VrkiMbsI2pQK5PRdr/dMlwNzV6g5TlCp6B+t1Q6AKz/YjdV6yszP1j0tRuRrRPg3Pnvf9BktFT/T
        QV2/NySw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDY8-00Ffii-AF; Wed, 02 Aug 2023 15:14:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v6 04/38] mm: Add folio_flush_mapping()
Date:   Wed,  2 Aug 2023 16:13:32 +0100
Message-Id: <20230802151406.3735276-5-willy@infradead.org>
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

This is the folio equivalent of page_mapping_file(), but rename it
to make it clear that it's very different from page_file_mapping().
Theoretically, there's nothing flush-only about it, but there are no
other users today, and I doubt there will be; it's almost always more
useful to know the swapfile's mapping or the swapcache's mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/pagemap.h | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 04c0fc6f81b3..bd522a64b714 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -389,6 +389,26 @@ static inline struct address_space *folio_file_mapping(struct folio *folio)
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
+		return NULL;
+
+	return folio_mapping(folio);
+}
+
 static inline struct address_space *page_file_mapping(struct page *page)
 {
 	return folio_file_mapping(page_folio(page));
@@ -399,11 +419,7 @@ static inline struct address_space *page_file_mapping(struct page *page)
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
2.40.1

