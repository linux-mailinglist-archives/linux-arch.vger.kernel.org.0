Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3911ECB
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 17:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfEBPkd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 May 2019 11:40:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727696AbfEBP3L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 May 2019 11:29:11 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42FSA0G139453
        for <linux-arch@vger.kernel.org>; Thu, 2 May 2019 11:29:11 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s800rs7th-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2019 11:29:10 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 2 May 2019 16:29:05 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 16:28:56 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42FSt5x49152192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 15:28:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2463CA4062;
        Thu,  2 May 2019 15:28:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F1F3A4054;
        Thu,  2 May 2019 15:28:50 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.209])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  2 May 2019 15:28:50 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 02 May 2019 18:28:49 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Guo Ren <guoren@kernel.org>,
        Helge Deller <deller@gmx.de>, Ley Foon Tan <lftan@altera.com>,
        Matthew Wilcox <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Burton <paul.burton@mips.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Sam Creasey <sammy@sammy.net>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        nios2-dev@lists.rocketboards.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 01/15] asm-generic, x86: introduce generic pte_{alloc,free}_one[_kernel]
Date:   Thu,  2 May 2019 18:28:28 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050215-0008-0000-0000-000002E29917
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050215-0009-0000-0000-0000224F082E
Message-Id: <1556810922-20248-2-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020103
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Most architectures have identical or very similar implementation of
pte_alloc_one_kernel(), pte_alloc_one(), pte_free_kernel() and pte_free().

Add a generic implementation that can be reused across architectures and
enable its use on x86.

The generic implementation uses

	GFP_KERNEL | __GFP_ZERO

for the kernel page tables and

	GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT

for the user page tables.

The "base" functions for PTE allocation, namely __pte_alloc_one_kernel()
and __pte_alloc_one() are intended for the architectures that require
additional actions after actual memory allocation or must use non-default
GFP flags.

x86 is switched to use generic pte_alloc_one_kernel(), pte_free_kernel() and
pte_free().

x86 still implements pte_alloc_one() to allow run-time control of GFP flags
required for "userpte" command line option.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/include/asm/pgalloc.h |  19 ++------
 arch/x86/mm/pgtable.c          |  33 ++++---------
 include/asm-generic/pgalloc.h  | 107 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 115 insertions(+), 44 deletions(-)

diff --git a/arch/x86/include/asm/pgalloc.h b/arch/x86/include/asm/pgalloc.h
index a281e61..29aa785 100644
--- a/arch/x86/include/asm/pgalloc.h
+++ b/arch/x86/include/asm/pgalloc.h
@@ -6,6 +6,9 @@
 #include <linux/mm.h>		/* for struct page */
 #include <linux/pagemap.h>
 
+#define __HAVE_ARCH_PTE_ALLOC_ONE
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 static inline int  __paravirt_pgd_alloc(struct mm_struct *mm) { return 0; }
 
 #ifdef CONFIG_PARAVIRT_XXL
@@ -47,24 +50,8 @@ extern gfp_t __userpte_alloc_gfp;
 extern pgd_t *pgd_alloc(struct mm_struct *);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *);
 extern pgtable_t pte_alloc_one(struct mm_struct *);
 
-/* Should really implement gc for free page table pages. This could be
-   done with a reference count in struct page. */
-
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	BUG_ON((unsigned long)pte & (PAGE_SIZE-1));
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, struct page *pte)
-{
-	pgtable_page_dtor(pte);
-	__free_page(pte);
-}
-
 extern void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte);
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *pte,
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7bd0170..aaca89b 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -13,33 +13,17 @@ phys_addr_t physical_mask __ro_after_init = (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
 EXPORT_SYMBOL(physical_mask);
 #endif
 
-#define PGALLOC_GFP (GFP_KERNEL_ACCOUNT | __GFP_ZERO)
-
 #ifdef CONFIG_HIGHPTE
-#define PGALLOC_USER_GFP __GFP_HIGHMEM
+#define PGTABLE_HIGHMEM __GFP_HIGHMEM
 #else
-#define PGALLOC_USER_GFP 0
+#define PGTABLE_HIGHMEM 0
 #endif
 
-gfp_t __userpte_alloc_gfp = PGALLOC_GFP | PGALLOC_USER_GFP;
-
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)__get_free_page(PGALLOC_GFP & ~__GFP_ACCOUNT);
-}
+gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
 
 pgtable_t pte_alloc_one(struct mm_struct *mm)
 {
-	struct page *pte;
-
-	pte = alloc_pages(__userpte_alloc_gfp, 0);
-	if (!pte)
-		return NULL;
-	if (!pgtable_page_ctor(pte)) {
-		__free_page(pte);
-		return NULL;
-	}
-	return pte;
+	return __pte_alloc_one(mm, __userpte_alloc_gfp);
 }
 
 static int __init setup_userpte(char *arg)
@@ -235,7 +219,7 @@ static int preallocate_pmds(struct mm_struct *mm, pmd_t *pmds[], int count)
 {
 	int i;
 	bool failed = false;
-	gfp_t gfp = PGALLOC_GFP;
+	gfp_t gfp = GFP_PGTABLE_USER;
 
 	if (mm == &init_mm)
 		gfp &= ~__GFP_ACCOUNT;
@@ -401,14 +385,14 @@ static inline pgd_t *_pgd_alloc(void)
 	 * We allocate one page for pgd.
 	 */
 	if (!SHARED_KERNEL_PMD)
-		return (pgd_t *)__get_free_pages(PGALLOC_GFP,
+		return (pgd_t *)__get_free_pages(GFP_PGTABLE_USER,
 						 PGD_ALLOCATION_ORDER);
 
 	/*
 	 * Now PAE kernel is not running as a Xen domain. We can allocate
 	 * a 32-byte slab for pgd to save memory space.
 	 */
-	return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
+	return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_USER);
 }
 
 static inline void _pgd_free(pgd_t *pgd)
@@ -422,7 +406,8 @@ static inline void _pgd_free(pgd_t *pgd)
 
 static inline pgd_t *_pgd_alloc(void)
 {
-	return (pgd_t *)__get_free_pages(PGALLOC_GFP, PGD_ALLOCATION_ORDER);
+	return (pgd_t *)__get_free_pages(GFP_PGTABLE_USER,
+					 PGD_ALLOCATION_ORDER);
 }
 
 static inline void _pgd_free(pgd_t *pgd)
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 948714c..efecfb3 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -1,13 +1,112 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __ASM_GENERIC_PGALLOC_H
 #define __ASM_GENERIC_PGALLOC_H
-/*
- * an empty file is enough for a nommu architecture
- */
+
 #ifdef CONFIG_MMU
-#error need to implement an architecture specific asm/pgalloc.h
+
+#define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
+#define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
+
+/**
+ * __pte_alloc_one_kernel - allocate a page for PTE-level kernel page table
+ * @mm: the mm_struct of the current context
+ *
+ * This function is intended for architectures that need
+ * anything beyond simple page allocation.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
+}
+
+#ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
+/**
+ * pte_alloc_one_kernel - allocate a page for PTE-level kernel page table
+ * @mm: the mm_struct of the current context
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	return __pte_alloc_one_kernel(mm);
+}
+#endif
+
+/**
+ * pte_free_kernel - free PTE-level kernel page table page
+ * @mm: the mm_struct of the current context
+ * @pte: pointer to the memory containing the page table
+ */
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+	free_page((unsigned long)pte);
+}
+
+/**
+ * __pte_alloc_one - allocate a page for PTE-level user page table
+ * @mm: the mm_struct of the current context
+ * @gfp: GFP flags to use for the allocation
+ *
+ * Allocates a page and runs the pgtable_page_ctor().
+ *
+ * This function is intended for architectures that need
+ * anything beyond simple page allocation or must have custom GFP flags.
+ *
+ * Return: `struct page` initialized as page table or %NULL on error
+ */
+static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
+{
+	struct page *pte;
+
+	pte = alloc_page(gfp);
+	if (!pte)
+		return NULL;
+	if (!pgtable_page_ctor(pte)) {
+		__free_page(pte);
+		return NULL;
+	}
+
+	return pte;
+}
+
+#ifndef __HAVE_ARCH_PTE_ALLOC_ONE
+/**
+ * pte_alloc_one - allocate a page for PTE-level user page table
+ * @mm: the mm_struct of the current context
+ *
+ * Allocates a page and runs the pgtable_page_ctor().
+ *
+ * Return: `struct page` initialized as page table or %NULL on error
+ */
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
+{
+	return __pte_alloc_one(mm, GFP_PGTABLE_USER);
+}
 #endif
 
+/*
+ * Should really implement gc for free page table pages. This could be
+ * done with a reference count in struct page.
+ */
+
+/**
+ * pte_free_kernel - free PTE-level user page table page
+ * @mm: the mm_struct of the current context
+ * @pte_page: the `struct page` representing the page table
+ */
+static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
+{
+	pgtable_page_dtor(pte_page);
+	__free_page(pte_page);
+}
+
+#else /* CONFIG_MMU */
+
+/* This is enough for a nommu architecture */
 #define check_pgt_cache()          do { } while (0)
 
+#endif /* CONFIG_MMU */
+
 #endif /* __ASM_GENERIC_PGALLOC_H */
-- 
2.7.4

