Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704A56A48BA
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 18:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjB0R5y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 12:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjB0R5y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 12:57:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B475B241C6;
        Mon, 27 Feb 2023 09:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hMFJoNiTv8ERJFzuWrR/5P0mYOI2i9vULkEqsj63YhY=; b=eJibqO57YZFwds944V3v+goNNV
        uL8xM/5dlRClPneYAKfqRqNxOy9AXPlKJbOYwcYSD6xmr1gbh2nXoV2SJ90excX60nNbn4YkfzbJK
        jrFNcGl7JdscQ9qmNEdzF9dtc9/xvIIG9NfXDdiw2w15ps8w961rR0vTrDfnJ+zxF7gA+RaK7HCnr
        ttacLATW7WSZrkHX/D/coc6QziGwa115pKH4T0B2GkTIu5Tj5y98Q1TIOPVNHbRaGJQ0/gYffMm3L
        bOaO5ZUbzBO2xh1y91BH+TvJOV71GYaWaRrFslgqaSndJGwxodoVHPpuCXbE8mErNOigANX9YGZsP
        A61/SyTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWhkt-000IWv-CC; Mon, 27 Feb 2023 17:57:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/30] mm: Remove ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
Date:   Mon, 27 Feb 2023 17:57:15 +0000
Message-Id: <20230227175741.71216-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230227175741.71216-1-willy@infradead.org>
References: <20230227175741.71216-1-willy@infradead.org>
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

Current best practice is to reuse the name of the function as a define
to indicate that the function is implemented by the architecture.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/cacheflush.h | 4 ++--
 mm/util.c                  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/cacheflush.h b/include/linux/cacheflush.h
index a6189d21f2ba..82136f3fcf54 100644
--- a/include/linux/cacheflush.h
+++ b/include/linux/cacheflush.h
@@ -7,14 +7,14 @@
 struct folio;
 
 #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
-#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
+#ifndef flush_dcache_folio
 void flush_dcache_folio(struct folio *folio);
 #endif
 #else
 static inline void flush_dcache_folio(struct folio *folio)
 {
 }
-#define ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO 0
+#define flush_dcache_folio flush_dcache_folio
 #endif /* ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE */
 
 #endif /* _LINUX_CACHEFLUSH_H */
diff --git a/mm/util.c b/mm/util.c
index b8ed9dbc7fd5..f66e0ca82d2d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1124,7 +1124,7 @@ void page_offline_end(void)
 }
 EXPORT_SYMBOL(page_offline_end);
 
-#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_FOLIO
+#ifndef flush_dcache_folio
 void flush_dcache_folio(struct folio *folio)
 {
 	long i, nr = folio_nr_pages(folio);
-- 
2.39.1

