Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704A36BA6C5
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbjCOFPg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjCOFPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170327982;
        Tue, 14 Mar 2023 22:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rzzYbuX4ToR4PRSGg4gxiQg60PZuy1bmg30AVicE5lc=; b=LFipvvEQakTIInjheUdNgkYGQq
        PQlNsLrLwxSeSBjE9GBWTNlVTV5an9fUmN4eHue46GVqBu5wp0EHoeKdB7HoGOszydP0kOyYoL7bP
        +57XeupqJHTvYryjfwkHT24Dg5ZN1CWuVA5nyVaBITI8APSFSLXxKCji+zmpN6kJA9usBKnKqayRz
        JyLjpYf4dbg9w5l7JG2bNPpcYuiSr/Mimk1ikLjZaFxwxNy2ipQ2GMaqWQ6LhcXNQh9DeYzFrF2qm
        EoaJ5MFMLwBA2cGyS1jlYi3Q8wFWnbrRNwhLuGPfDc3318NHAlhNGbsAaVKOfBb0yrbztvVx4p/3d
        rLZekx0g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTN-00DYDB-U3; Wed, 15 Mar 2023 05:14:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 29/36] mm: Remove page_mapping_file()
Date:   Wed, 15 Mar 2023 05:14:37 +0000
Message-Id: <20230315051444.3229621-30-willy@infradead.org>
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

This function has no more users.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index e56c2023aa0e..a87113055b9c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -394,14 +394,6 @@ static inline struct address_space *page_file_mapping(struct page *page)
 	return folio_file_mapping(page_folio(page));
 }
 
-/*
- * For file cache pages, return the address_space, otherwise return NULL
- */
-static inline struct address_space *page_mapping_file(struct page *page)
-{
-	return folio_flush_mapping(page_folio(page));
-}
-
 /**
  * folio_inode - Get the host inode for this folio.
  * @folio: The folio.
-- 
2.39.2

