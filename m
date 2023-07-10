Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3632F74DFB6
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjGJUpp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjGJUpE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:45:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ACFE7C;
        Mon, 10 Jul 2023 13:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=MleiOB+O8ZU6a0dknzCAyzLly2run5bVw1iBj0akiwE=; b=hOrOl8ZD1/O2pyYUqReAOMC00Z
        Ieo+CK8byYZFLkPXVV02AsvgNqzM+M+5Hs5ddbEByzw4jdlmGhQdp/hYbYc0Chtr6YA7X44zkC7cb
        pe1kzZ6zaYXY/tk5Mknp8cFObie3KrY7PSTLOEQQfbeyPHvptTFJwVuzbRs9qu2Ux/zoeLgExVs3H
        qBCGNpyIdQBTjcwA8Q/IVBK/VUN1JxCd6Hmdi8nqnJI7p7gN2OpW9rnno24Xe89fsiFv+1diNHG6N
        fi+zCWa8Rzk4rDRFMEoz3N6WnIjgreib+8dORaFDF9C9KDTy6dgeIOpB8RoUxuYjip9hX3iORp+Xt
        tu/fo7mw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjR-00EuoP-KM; Mon, 10 Jul 2023 20:43:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v5 06/38] mm: Add default definition of set_ptes()
Date:   Mon, 10 Jul 2023 21:43:07 +0100
Message-Id: <20230710204339.3554919-7-willy@infradead.org>
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

Most architectures can just define set_pte() and PFN_PTE_SHIFT to
use this definition.  It's also a handy spot to document the guarantees
provided by the MM.

Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 include/linux/pgtable.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 5063b482e34f..22f48f9997d5 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -180,6 +180,43 @@ static inline int pmd_young(pmd_t pmd)
 }
 #endif
 
+#ifndef set_ptes
+#ifdef PFN_PTE_SHIFT
+/**
+ * set_ptes - Map consecutive pages to a contiguous range of addresses.
+ * @mm: Address space to map the pages into.
+ * @addr: Address to map the first page at.
+ * @ptep: Page table pointer for the first entry.
+ * @pte: Page table entry for the first page.
+ * @nr: Number of pages to map.
+ *
+ * May be overridden by the architecture, or the architecture can define
+ * set_pte() and PFN_PTE_SHIFT.
+ *
+ * Context: The caller holds the page table lock.  The pages all belong
+ * to the same folio.  The PTEs are all in the same PMD.
+ */
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	page_table_check_ptes_set(mm, addr, ptep, pte, nr);
+
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte = __pte(pte_val(pte) + (1UL << PFN_PTE_SHIFT));
+	}
+}
+#ifndef set_pte_at
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
+#endif
+#endif
+#else
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 extern int ptep_set_access_flags(struct vm_area_struct *vma,
 				 unsigned long address, pte_t *ptep,
-- 
2.39.2

