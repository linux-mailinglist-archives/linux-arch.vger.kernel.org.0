Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3207120C22C
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jun 2020 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgF0Ofd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jun 2020 10:35:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgF0Ofc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Jun 2020 10:35:32 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5920C20885;
        Sat, 27 Jun 2020 14:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593268531;
        bh=ug/zgldkEF9Y1EOWxCdQbFhq6W6AubLqDruRfdpZtCU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kGeCaidImTPJgGt9S6wijt8HSPaAsXufRU8Bw3R+Jenx9IwSCz19tOS+s33DYy3Fd
         IcDlElpk6m8c8IYERIfYCh6px/euMBEW7PkfFZkG6NsKEPz+Lcoqc14NcBs88W/xGZ
         9cQUVwRq1YyhbGySMR8ZhKm3fhDosCXptMIYyEmY=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
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
Subject: [PATCH 3/8] xtensa: switch to generic version of pte allocation
Date:   Sat, 27 Jun 2020 17:34:48 +0300
Message-Id: <20200627143453.31835-4-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
References: <20200627143453.31835-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

xtensa clears PTEs during allocation of the page tables and pte_clear()
sets the PTE to a non-zero value. Splitting ptes_clear() helper out of
pte_alloc_one() and pte_alloc_one_kernel() allows reuse of base generic
allocation methods (__pte_alloc_one() and __pte_alloc_one_kernel()) and the
common GFP mask for page table allocations.

The pte_free() and pte_free_kernel() implementations on xtensa are
identical to the generic ones and can be dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/xtensa/include/asm/pgalloc.h | 41 ++++++++++++++-----------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/arch/xtensa/include/asm/pgalloc.h b/arch/xtensa/include/asm/pgalloc.h
index 1d38f0e755ba..60ee94b42850 100644
--- a/arch/xtensa/include/asm/pgalloc.h
+++ b/arch/xtensa/include/asm/pgalloc.h
@@ -8,9 +8,14 @@
 #ifndef _XTENSA_PGALLOC_H
 #define _XTENSA_PGALLOC_H
 
+#ifdef CONFIG_MMU
 #include <linux/highmem.h>
 #include <linux/slab.h>
 
+#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
+#define __HAVE_ARCH_PTE_ALLOC_ONE
+#include <asm-generic/pgalloc.h>
+
 /*
  * Allocating and freeing a pmd is trivial: the 1-entry pmd is
  * inside the pgd, so has no extra memory associated with it.
@@ -33,45 +38,37 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 	free_page((unsigned long)pgd);
 }
 
+static inline void ptes_clear(pte_t *ptep)
+{
+	int i;
+
+	for (i = 0; i < PTRS_PER_PTE; i++)
+		pte_clear(NULL, 0, ptep + i);
+}
+
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 {
 	pte_t *ptep;
-	int i;
 
-	ptep = (pte_t *)__get_free_page(GFP_KERNEL);
+	ptep = (pte_t *)__pte_alloc_one_kernel(mm);
 	if (!ptep)
 		return NULL;
-	for (i = 0; i < 1024; i++)
-		pte_clear(NULL, 0, ptep + i);
+	ptes_clear(ptep);
 	return ptep;
 }
 
 static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	pte_t *pte;
 	struct page *page;
 
-	pte = pte_alloc_one_kernel(mm);
-	if (!pte)
-		return NULL;
-	page = virt_to_page(pte);
-	if (!pgtable_pte_page_ctor(page)) {
-		__free_page(page);
+	page = __pte_alloc_one(mm, GFP_PGTABLE_USER);
+	if (!page)
 		return NULL;
-	}
+	ptes_clear(page_address(page));
 	return page;
 }
 
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	pgtable_pte_page_dtor(pte);
-	__free_page(pte);
-}
 #define pmd_pgtable(pmd) pmd_page(pmd)
+#endif CONFIG_MMU
 
 #endif /* _XTENSA_PGALLOC_H */
-- 
2.26.2

