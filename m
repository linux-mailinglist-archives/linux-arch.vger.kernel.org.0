Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0298911E0B
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 17:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbfEBPa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 May 2019 11:30:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728739AbfEBPa3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 May 2019 11:30:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42FS9CR127401
        for <linux-arch@vger.kernel.org>; Thu, 2 May 2019 11:30:27 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s81ej5e7j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2019 11:30:27 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 2 May 2019 16:30:24 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 16:30:15 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42FUEvu28835860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 15:30:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56FB84C058;
        Thu,  2 May 2019 15:30:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E40C54C052;
        Thu,  2 May 2019 15:30:09 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.209])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  2 May 2019 15:30:09 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 02 May 2019 18:30:08 +0300
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
Subject: [PATCH 15/15] unicore32: switch to generic version of pte allocation
Date:   Thu,  2 May 2019 18:28:42 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050215-0020-0000-0000-00000338993E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050215-0021-0000-0000-0000218B21F5
Message-Id: <1556810922-20248-16-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=731 adultscore=0 classifier=spam adjust=0 reason=mlx
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

The pte_free() and pte_free_kernel() versions are identical to the generic
ones and can be simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/unicore32/include/asm/pgalloc.h | 36 ++++++++----------------------------
 1 file changed, 8 insertions(+), 28 deletions(-)

diff --git a/arch/unicore32/include/asm/pgalloc.h b/arch/unicore32/include/asm/pgalloc.h
index 7cceabe..dd09af6 100644
--- a/arch/unicore32/include/asm/pgalloc.h
+++ b/arch/unicore32/include/asm/pgalloc.h
@@ -17,6 +17,10 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
+#define __HAVE_ARCH_PTE_ALLOC_ONE
+#include <asm-generic/pgalloc.h>
+
 #define check_pgt_cache()		do { } while (0)
 
 #define _PAGE_USER_TABLE	(PMD_TYPE_TABLE | PMD_PRESENT)
@@ -28,17 +32,14 @@ extern void free_pgd_slow(struct mm_struct *mm, pgd_t *pgd);
 #define pgd_alloc(mm)			get_pgd_slow(mm)
 #define pgd_free(mm, pgd)		free_pgd_slow(mm, pgd)
 
-#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
-
 /*
  * Allocate one PTE table.
  */
 static inline pte_t *
 pte_alloc_one_kernel(struct mm_struct *mm)
 {
-	pte_t *pte;
+	pte_t *pte = __pte_alloc_one_kernel(mm);
 
-	pte = (pte_t *)__get_free_page(PGALLOC_GFP);
 	if (pte)
 		clean_dcache_area(pte, PTRS_PER_PTE * sizeof(pte_t));
 
@@ -50,35 +51,14 @@ pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
 
-	pte = alloc_pages(PGALLOC_GFP, 0);
+	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
 	if (!pte)
 		return NULL;
-	if (!PageHighMem(pte)) {
-		void *page = page_address(pte);
-		clean_dcache_area(page, PTRS_PER_PTE * sizeof(pte_t));
-	}
-	if (!pgtable_page_ctor(pte)) {
-		__free_page(pte);
-	}
-
+	if (!PageHighMem(pte))
+		clean_pte_table(page_address(pte));
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
 static inline void __pmd_populate(pmd_t *pmdp, unsigned long pmdval)
 {
 	set_pmd(pmdp, __pmd(pmdval));
-- 
2.7.4

