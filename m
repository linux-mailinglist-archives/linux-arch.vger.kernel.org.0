Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A284474DF92
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jul 2023 22:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjGJUpA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Jul 2023 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjGJUoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Jul 2023 16:44:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02645E5D;
        Mon, 10 Jul 2023 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9mxVcCkW583JrlzbOMVQaZnB0bjf4NUO5YrFMq87KVA=; b=tiHU73GtBk0CdV4R8NECb7nrWG
        rlw/hDC8XD9b2zjAZwna48outBRoVxu2IWG4ZicdNlUuRYBDKZRUemkoPgiXlrkf0kVB/sx3qjfs0
        KkxCLgeBb0dGeLCejf0eJpZyZUb0QAlMhBZF+E3fcYghEbOccZYeYRtjGSz0QvTXnX52XdAJw1TXs
        dD9qFxvpT4uZslcdHGUINiZkGgdG7bUfWf+eV3k8ld7aPrcsNPTW5Ce0qlVAzV58FK0Y85gBRJU9t
        +h+io5vedYA2iPQhdC9XJcsDOkWmkXsYFq638vvxWop58dOIBFBXxPiLMZOQ82sbNU0OuAiljU1om
        x2DyixKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIxjT-00EuqC-Se; Mon, 10 Jul 2023 20:43:43 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH v5 23/38] s390: Implement the new page table range API
Date:   Mon, 10 Jul 2023 21:43:24 +0100
Message-Id: <20230710204339.3554919-24-willy@infradead.org>
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

Add set_ptes() and update_mmu_cache_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/include/asm/pgtable.h | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index c55f3c3365af..02973c740a5b 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -47,6 +47,7 @@ static inline void update_page_count(int level, long count)
  * tables contain all the necessary information.
  */
 #define update_mmu_cache(vma, address, ptep)     do { } while (0)
+#define update_mmu_cache_range(vmf, vma, addr, ptep, nr) do { } while (0)
 #define update_mmu_cache_pmd(vma, address, ptep) do { } while (0)
 
 /*
@@ -1316,20 +1317,34 @@ pgprot_t pgprot_writecombine(pgprot_t prot);
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
+#define set_ptes set_ptes
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
-- 
2.39.2

