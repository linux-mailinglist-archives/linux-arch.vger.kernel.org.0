Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7915C76D172
	for <lists+linux-arch@lfdr.de>; Wed,  2 Aug 2023 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjHBPPW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Aug 2023 11:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjHBPOW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Aug 2023 11:14:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4118A30DD;
        Wed,  2 Aug 2023 08:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=QeDCABsAWpOx649ozVbfmv9UCtQh/TSjAvda51zdKvQ=; b=pdlgDleZUdpe0s2vgiqF1JRXew
        RxlXvTviSK63Rg5cFBeKiH5bUPEQucNliUguVeMyeUW6BBrpyGtKchmRvKBDrcryN9cBY1/PnvsB2
        SXkF0Kcu4LH9AhS7mVjXmL1533HUtRgwR3/gmskJoj90e+5Kw21PpL6/TRpbmLpt6lKBPXeejcd5z
        2mWnEuvGJdjhoc9F4U1oO00CLDJTYYcyOKIwOsU6jzQPd8GM/fMpzifpxCfkLVRKZ6CQmegeQsPDw
        XS5E3s5PQRJfLKaj66flU3uPUzSoFWUQ6E7mHR26uvkOiitMX9BkU8ZTqCrgPim8kyx+ynaJJpgKa
        y6uqTg0Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRDYB-00Ffl6-CQ; Wed, 02 Aug 2023 15:14:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v6 30/38] mm: Remove page_mapping_file()
Date:   Wed,  2 Aug 2023 16:13:58 +0100
Message-Id: <20230802151406.3735276-31-willy@infradead.org>
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

This function has no more users.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/pagemap.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bd522a64b714..6f8d6529b350 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -414,14 +414,6 @@ static inline struct address_space *page_file_mapping(struct page *page)
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
2.40.1

