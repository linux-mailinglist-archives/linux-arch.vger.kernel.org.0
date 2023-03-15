Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508906BA694
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCOFOu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCOFOt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:14:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE24199C2;
        Tue, 14 Mar 2023 22:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n6Ti8OhlWeNjG2zsHJM+UjK+Z9Pmy+kwTwNJ+mNPVvs=; b=jXJA/lY+mNfxjhnHMcPpOcZktl
        OP+tmmLUZQplcYMr969H3MlWVh4M8UbWKPP0xxgrWVRdnUZfOR6zLHYFG5wszll0o8pRkCNcOL1JY
        16o+kcpPH9LNx1+TKFXHq8TGywKk7dGmxX4G+FSKewMk4lNllHqIF8s8FE+JBz4BDhl7hboF4RL+i
        CcXrAlV4h3+QyiJJ86OYjHScPv47+m2a0lvGzrAztGy1kUuS1eyTHhvuhboviz5liEIJSJiRABoHg
        aTUpEB1zZKKrLCb3K+tpcEVwrXjhbemDdSy63QoH8fw5+QNfVJStj6gMw88C4OF4r1znXsskP0ZQ2
        +NIVpg0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTK-00DYAv-LY; Wed, 15 Mar 2023 05:14:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/36] mm: Add folio_flush_mapping()
Date:   Wed, 15 Mar 2023 05:14:11 +0000
Message-Id: <20230315051444.3229621-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230315051444.3229621-1-willy@infradead.org>
References: <20230315051444.3229621-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index a56308a9d1a4..e56c2023aa0e 100644
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
+		return NULL;
+
+	return folio_mapping(folio);
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
2.39.2

