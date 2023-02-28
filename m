Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A36C6A6178
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 22:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjB1Vik (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 16:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjB1ViF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 16:38:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8C35274;
        Tue, 28 Feb 2023 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Yzj6cO2/vJ4MfYZK59aIBqu3Kv7SFJ8gH5oZ5flVgEs=; b=OD1wQ9FRkxcghMLJg6Ce5C0ga2
        cmeah8bBnDlnApT7w9eP4jLoOHWe5LOWJvaXjzySJToJ/ri5lFa/WPRrYlKCBfTnoTOy61IeVDPmi
        68qgaO505JobxikfyskgY9xbNje+JqFPUysl0cnN+vEVR3pgREX8J89OLKMHl/TqyyAVjEpnol4zA
        mWNvomzEhL2O9QcgO/0OOrJvu8ccybEFryAof/kx97tzFyUluCPOeKa3/0cjX3UTPkb/j9069P53J
        +Cg4IG3uFwzyjrZHabcHWuf84tIb4VxnYUxvHW0kGOEgevnxc29eSy5Y6qNTUzaF2UnG761WUlGH0
        nbiy8g/A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX7fL-0018qr-6O; Tue, 28 Feb 2023 21:37:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 30/34] mm: Use flush_icache_pages() in do_set_pmd()
Date:   Tue, 28 Feb 2023 21:37:33 +0000
Message-Id: <20230228213738.272178-31-willy@infradead.org>
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

Push the iteration over each page down to the architectures (many
can flush the entire THP without iteration).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index bfa3100ec5a3..69e844d5f75c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4222,8 +4222,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (unlikely(!pmd_none(*vmf->pmd)))
 		goto out;
 
-	for (i = 0; i < HPAGE_PMD_NR; i++)
-		flush_icache_page(vma, page + i);
+	flush_icache_pages(vma, page, HPAGE_PMD_NR);
 
 	entry = mk_huge_pmd(page, vma->vm_page_prot);
 	if (write)
-- 
2.39.1

