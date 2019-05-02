Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 949AC11EC3
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbfEBPkO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 May 2019 11:40:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728402AbfEBP3U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 May 2019 11:29:20 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42FS92k139340
        for <linux-arch@vger.kernel.org>; Thu, 2 May 2019 11:29:20 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s800rs83g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2019 11:29:19 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 2 May 2019 16:29:16 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 16:29:07 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42FT6o918022466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 15:29:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E5285204E;
        Thu,  2 May 2019 15:29:06 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.209])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id C6A1352054;
        Thu,  2 May 2019 15:29:01 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 02 May 2019 18:29:00 +0300
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
Subject: [PATCH 03/15] arm: switch to generic version of pte allocation
Date:   Thu,  2 May 2019 18:28:30 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050215-0028-0000-0000-000003699E1F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050215-0029-0000-0000-000024290A09
Message-Id: <1556810922-20248-4-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=889 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020103
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace __get_free_page() and alloc_pages() calls with the generic
__pte_alloc_one_kernel() and __pte_alloc_one().

There is no functional change for the kernel PTE allocation.

The difference for the user PTEs, is that the clear_pte_table() is now
called after pgtable_page_ctor() and the addition of __GFP_ACCOUNT to the
GFP flags.

The conversion to the generic version of pte_free_kernel() removes the NULL
check for pte.

The pte_free() version on arm is identical to the generic one and can be
simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/include/asm/pgalloc.h | 41 +++++++++++++----------------------------
 arch/arm/mm/mmu.c              |  2 +-
 2 files changed, 14 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 17ab72f..13c5a9d 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -57,8 +57,6 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
-#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
-
 static inline void clean_pte_table(pte_t *pte)
 {
 	clean_dcache_area(pte + PTE_HWTABLE_PTRS, PTE_HWTABLE_SIZE);
@@ -80,54 +78,41 @@ static inline void clean_pte_table(pte_t *pte)
  *  |  h/w pt 1  |
  *  +------------+
  */
+
+#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
+#define __HAVE_ARCH_PTE_ALLOC_ONE
+#include <asm-generic/pgalloc.h>
+
 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	pte_t *pte;
+	pte_t *pte = __pte_alloc_one_kernel(mm);
 
-	pte = (pte_t *)__get_free_page(PGALLOC_GFP);
 	if (pte)
 		clean_pte_table(pte);
 
 	return pte;
 }
 
+#ifdef CONFIG_HIGHPTE
+#define PGTABLE_HIGHMEM __GFP_HIGHMEM
+#else
+#define PGTABLE_HIGHMEM 0
+#endif
+
 static inline pgtable_t
 pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
 
-#ifdef CONFIG_HIGHPTE
-	pte = alloc_pages(PGALLOC_GFP | __GFP_HIGHMEM, 0);
-#else
-	pte = alloc_pages(PGALLOC_GFP, 0);
-#endif
+	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
 	if (!pte)
 		return NULL;
 	if (!PageHighMem(pte))
 		clean_pte_table(page_address(pte));
-	if (!pgtable_page_ctor(pte)) {
-		__free_page(pte);
-		return NULL;
-	}
 	return pte;
 }
 
-/*
- * Free one PTE table.
- */
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	if (pte)
-		free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	pgtable_page_dtor(pte);
-	__free_page(pte);
-}
-
 static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,
 				  pmdval_t prot)
 {
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f3ce341..e8e0382 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -732,7 +732,7 @@ static void __init *early_alloc(unsigned long sz)
 
 static void *__init late_alloc(unsigned long sz)
 {
-	void *ptr = (void *)__get_free_pages(PGALLOC_GFP, get_order(sz));
+	void *ptr = (void *)__get_free_pages(GFP_PGTABLE_KERNEL, get_order(sz));
 
 	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
 		BUG();
-- 
2.7.4

