Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6287520C391
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgF0SrC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 14:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgF0SrB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jun 2020 14:47:01 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EB7C061794;
        Sat, 27 Jun 2020 11:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1N0BByy8wh3U5L6kSyD094uOjKmOfferUMmn5EME8io=; b=rt8TkjxM6E+8nmcpYCJvT3+hGr
        H4ecs3CPjquKl0PwNGx/0fLvLzSeMiWcVi9g0WCIz3JnPQUXbHNqxCwsT2ayVaFw3c97wVSQmiW1a
        rRm52Ir+aRTZP4azHkd5YkWRXRczyXy3h3kPFA95NHffmRnSpt92NCElCKtgs9bWeGRSTPeQhCTju
        iPtJAvPHoRFkmTEM1tJ00siPzLuSHbI8lKSLvU4vW88vtaVf2379Kp5XmE9uUb/m7xTPxYufnEdnI
        IEHPwIDOHEDO9KXQeLwESz53maPxEJf9fE+lLaTHw5uxLUAf5caLMZIB5tLXnAC15PHD057E6o2BK
        h9N6MSEQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpFqc-00058E-Db; Sat, 27 Jun 2020 18:46:42 +0000
Date:   Sat, 27 Jun 2020 19:46:42 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org
Subject: [PATCH 9/8] mm: Account PMD tables like PTE tables
Message-ID: <20200627184642.GF25039@casper.infradead.org>
References: <20200627143453.31835-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We account the PTE level of the page tables to the process in order to
make smarter OOM decisions and help diagnose why memory is fragmented.
For these same reasons, we should account pages allocated for PMDs.
With larger process address spaces and ASLR, the number of PMDs in use
is higher than it used to be so the inaccuracy is starting to matter.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dc7b87310c10..b283e25fcffa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2271,7 +2271,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_to_page(pmd));
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page)
+static inline bool pmd_ptlock_init(struct page *page)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	page->pmd_huge_pte = NULL;
@@ -2279,7 +2279,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
 	return ptlock_init(page);
 }
 
-static inline void pgtable_pmd_page_dtor(struct page *page)
+static inline void pmd_ptlock_free(struct page *page)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
@@ -2296,8 +2296,8 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
-static inline bool pgtable_pmd_page_ctor(struct page *page) { return true; }
-static inline void pgtable_pmd_page_dtor(struct page *page) {}
+static inline bool pmd_ptlock_init(struct page *page) { return true; }
+static inline void pmd_ptlock_free(struct page *page) {}
 
 #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
 
@@ -2310,6 +2310,22 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
+static inline bool pgtable_pmd_page_ctor(struct page *page)
+{
+	if (!pmd_ptlock_init(page))
+		return false;
+	__SetPageTable(page);
+	inc_zone_page_state(page, NR_PAGETABLE);
+	return true;
+}
+
+static inline void pgtable_pmd_page_dtor(struct page *page)
+{
+	pmd_ptlock_free(page);
+	__ClearPageTable(page);
+	dec_zone_page_state(page, NR_PAGETABLE);
+}
+
 /*
  * No scalability reason to split PUD locks yet, but follow the same pattern
  * as the PMD locks to make it easier if we decide to.  The VM should not be
-- 
2.27.0

