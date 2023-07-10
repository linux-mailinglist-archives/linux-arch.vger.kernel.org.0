Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFA174DF96
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjGJUpC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjGJUoF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BDF1A2;
        Mon, 10 Jul 2023 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=paPNbsDhrgFpFK66NfUXWHVPB3cHJyjAQhVhGRR5N+U=; b=QUlAJhWRNtFfmO7LZAtZUSyWv3
        Yj6u2SE4iI6rFGiFOGHlKsUXxIapWLmZWsYfFAYfENSbb4vLwByEs/6XN1nlTK/hyUof5bWAqj1dj
        LAku+E4ib0zFnv5xeOROvKW4KEucJNW8DbWcT3FawboddIGTkkMdxX4Bs8w+dO3NhVWk2WVx6hLdJ
        kFvVs8KfTUMemf+kCGffTtHBOEI0wVNJSzi+cXICOq1HuBI6x+sns9KcpYKYB016jvQ5PEw2PlHJ+
        UhkJM6mqe3VtGclFhhf+B9SFjdYsrGwJt82VnL86dE6lfhahmjlfo6re3zLgz8LCtNU5D8iJrUlh9
        LshlmaPw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjU-00Eur6-Sh; Mon, 10 Jul 2023 20:43:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v5 33/38] mm: Use flush_icache_pages() in do_set_pmd()
Date:   Mon, 10 Jul 2023 21:43:34 +0100
Message-Id: <20230710204339.3554919-34-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710204339.3554919-1-willy@infradead.org>
References: <20230710204339.3554919-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Push the iteration over each page down to the architectures (many
can flush the entire THP without iteration).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/memory.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1dada20e3995..ebb4138acdb2 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4258,7 +4258,6 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
 	pmd_t entry;
-	int i;
 	vm_fault_t ret = VM_FAULT_FALLBACK;
 
 	if (!transhuge_vma_suitable(vma, haddr))
@@ -4291,8 +4290,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 	if (unlikely(!pmd_none(*vmf->pmd)))
 		goto out;
 
-	for (i = 0; i < HPAGE_PMD_NR; i++)
-		flush_icache_page(vma, page + i);
+	flush_icache_pages(vma, page, HPAGE_PMD_NR);
 
 	entry = mk_huge_pmd(page, vma->vm_page_prot);
 	if (write)
-- 
2.39.2

