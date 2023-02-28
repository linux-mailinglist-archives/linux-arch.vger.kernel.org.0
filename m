Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B276A6172
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 22:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjB1Vi1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 16:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjB1ViE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 16:38:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF0A3401C;
        Tue, 28 Feb 2023 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mdaqpw27tgluLSVUfr5NCk7JYy/yOeBvYqmE7YJCi4Q=; b=DrFh2yHP+xndjR7rLzUn2Ia2US
        A9zyiUHLOTEyGpZP45ISo4r/tr45esU8qg5UQYLi1Tg8YmpQVCQFuth04qslUG1emgF5B594UN4+7
        OqklC4ITNVGNREdIx2rLBwu7gfGDKNtcVmXeUlxiHR4acwBEx+18uyz/FMgo6Bg3OCgxbyP2HnkCo
        NtvjjX9fsWSims23QTMn3KVR2VLXfe3bqSN9gmaCMW0sK84KjQparXeo/4XYtu3lOAH8XkACexa6v
        VP06CViu2V6RZ3dqP9iH693OXYOMYPni/zYuFHC2aNm+CiyNLHGA2FHR6T/cIg4qNPPCIyRzhaGzX
        cSaNjUvw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX7fK-0018qR-K2; Tue, 28 Feb 2023 21:37:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 28/34] mm: Remove page_mapping_file()
Date:   Tue, 28 Feb 2023 21:37:31 +0000
Message-Id: <20230228213738.272178-29-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
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

This function has no more users.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 1b1ba3d5100d..c21b3ad1068c 100644
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
2.39.1

