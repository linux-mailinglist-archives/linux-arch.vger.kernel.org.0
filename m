Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBDA6A6184
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 22:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjB1VjA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 16:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjB1ViF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 16:38:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59F33401F;
        Tue, 28 Feb 2023 13:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OsGw+Kta3YWjQfJb2PytPQ2Q1ww6/aja6t5dfRe0Qq4=; b=rMDBeLPmVy/kg7VjEW0+V+mfrZ
        lKyuBvqhfx1BjW9Zuwx44oDQcbTer4re2OMXNroGqqGxQhEAf2SSYunPi/vpenpVcDBDCoVE1Snen
        1eFC9Wns0R6xq9fq2jKRtj6r6IO0MxL6T/YimB5wQY8ItbD2uI7GphlMWfK5Y7sVrwoOF/1WhR34z
        Y8HnMMK0+lAeaswImqwwHTbCM4jjuUw+7MST7gy/EVKYwTvAaLoR6N7jGY3p+YwvhpVCH5lyC7B+U
        MnToir81ROGosZPKkD/HG2y3Q9I/Jag2e1EmeqAYvNGojQTho3bVX8Zp8n8qvubagR8ZVl/B+IUhB
        kfLELGYA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX7fJ-0018q2-M1; Tue, 28 Feb 2023 21:37:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH v3 21/34] s390: Implement the new page table range API
Date:   Tue, 28 Feb 2023 21:37:24 +0000
Message-Id: <20230228213738.272178-22-willy@infradead.org>
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

Add set_ptes() and update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/pgtable.h | 34 ++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2c70b4d1263d..46bf475116f1 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -50,6 +50,7 @@ void arch_report_meminfo(struct seq_file *m);
  * tables contain all the necessary information.
  */
 #define update_mmu_cache(vma, address, ptep)     do { } while (0)
+#define update_mmu_cache_range(vma, addr, ptep, nr)	do { } while (0)
 #define update_mmu_cache_pmd(vma, address, ptep) do { } while (0)
 
 /*
@@ -1317,21 +1318,36 @@ pgprot_t pgprot_writecombine(pgprot_t prot);
 pgprot_t pgprot_writethrough(pgprot_t prot);
 
 /*
- * Certain architectures need to do special things when PTEs
- * within a page table are directly modified.  Thus, the following
- * hook is made available.
+ * Set multiple PTEs to consecutive pages with a single call.  All PTEs
+ * are within the same folio, PMD and VMA.
  */
-static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, pte_t entry)
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t entry, unsigned int nr)
 {
 	if (pte_present(entry))
 		entry = clear_pte_bit(entry, __pgprot(_PAGE_UNUSED));
-	if (mm_has_pgste(mm))
-		ptep_set_pte_at(mm, addr, ptep, entry);
-	else
-		set_pte(ptep, entry);
+	if (mm_has_pgste(mm)) {
+		for (;;) {
+			ptep_set_pte_at(mm, addr, ptep, entry);
+			if (--nr == 0)
+				break;
+			ptep++;
+			entry = __pte(pte_val(entry) + PAGE_SIZE);
+			addr += PAGE_SIZE;
+		}
+	} else {
+		for (;;) {
+			set_pte(ptep, entry);
+			if (--nr == 0)
+				break;
+			ptep++;
+			entry = __pte(pte_val(entry) + PAGE_SIZE);
+		}
+	}
 }
 
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
+
 /*
  * Conversion functions: convert a page and protection to a page entry,
  * and a page entry and page directory to the page they refer to.
-- 
2.39.1

