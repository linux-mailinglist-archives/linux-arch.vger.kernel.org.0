Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C116BA6CB
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjCOFPk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCOFPJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:15:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4009136699;
        Tue, 14 Mar 2023 22:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=73ezd5W5E0KEIO6VAvV47amCBEQJWRQwkcGKvspT3vU=; b=masNXlurESfGKFlz8RtpG3Ix6m
        c4wAtigik6OB2AQV5nlqZHF40DQ4SrO2QghheJqdi4JolrLkVBcE9Yd5IK23rR+n/r9h/QmMvK3ZU
        ElD/3Y4EjDSwQH54M0hFmcONJ2bo+CjcPl3G4AygvaJU0Cy5Gbnnz96Ye7+TAf8rujSVl7nV0lHh/
        7yqn+jtIlBnnXwW3QX20uiMY39Vi/D9atJNh43Eq4qt5SiXsDTJP2Fou6RtcgrVPwLb0vLi/HTe/3
        ktJdJDSo3K4fmYtt1pytHUU5UYwNDRF45mZX+FvpApd2hzNqngqiie8i8+JYj9OeATVTI+fXiWYGQ
        H271YV6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTO-00DYDg-CJ; Wed, 15 Mar 2023 05:14:50 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 32/36] mm: Use flush_icache_pages() in do_set_pmd()
Date:   Wed, 15 Mar 2023 05:14:40 +0000
Message-Id: <20230315051444.3229621-33-willy@infradead.org>
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

Push the iteration over each page down to the architectures (many
can flush the entire THP without iteration).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index c5f1bf906d0c..6aa21e8f3753 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4209,7 +4209,6 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t entry;
-	int i;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
 	if (!transhuge_vma_suitable(vma, haddr))
@@ -4242,8 +4241,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (unlikely(!pmd_none(*vmf->pmd)))
 		goto out;
 
-	for (i = 0; i < HPAGE_PMD_NR; i++)
-		flush_icache_page(vma, page + i);
+	flush_icache_pages(vma, page, HPAGE_PMD_NR);
 
 	entry = mk_huge_pmd(page, vma->vm_page_prot);
 	if (write)
-- 
2.39.2

