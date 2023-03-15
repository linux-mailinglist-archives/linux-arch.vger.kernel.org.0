Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C91D6BA695
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 06:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCOFOv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 01:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCOFOt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 01:14:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629E1ACFF;
        Tue, 14 Mar 2023 22:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X05vtzdRVOUEmVQt9LM7AcBEpxNUJlW1nSjcvx+k4II=; b=ZBRpDJQfOF7dP3sJ9sUGQlY4E8
        Wd8C+NXeZORB60wcJXsshX0L6WAkHB4NpK9zDfaQqAbYw0JJZV7N07uJp2EomGOpgBy9gfRTk3lg/
        Ox+YILpn/XDq0gn2XR8EhTlSWztyzXp+irDBpVS7R1MHTA27ryXzwUjDzLAKIYJHTKC6TAFQ2fg4Y
        T6A23P2KcdW4SSUO2o3P5VaPVXw2jTWXijCa5fiXyZPotPa67xVomAze7tB4zplYixC4Od/95hGLo
        LRn3w1db8qtNliXIYmFz7fWIJWpYeRWP3KCroHCN4OLdSxm/wTND17EAjE+rBnFJebCCC+nEBhkqD
        K7FsR6Tg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pcJTK-00DYB3-SQ; Wed, 15 Mar 2023 05:14:46 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v4 05/36] mm: Add default definition of set_ptes()
Date:   Wed, 15 Mar 2023 05:14:13 +0000
Message-Id: <20230315051444.3229621-6-willy@infradead.org>
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

Most architectures can just define set_pte() and PFN_PTE_SHIFT to
use this definition.  It's also a handy spot to document the guarantees
provided by the MM.

Suggested-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pgtable.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index c5a51481bbb9..a755fe94b4b4 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -172,6 +172,43 @@ static inline int pmd_young(pmd_t pmd)
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

