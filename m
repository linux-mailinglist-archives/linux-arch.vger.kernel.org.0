Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEAA11EBB
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2019 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfEBPj6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 May 2019 11:39:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53660 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728425AbfEBP30 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 May 2019 11:29:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42FSNP1046365
        for <linux-arch@vger.kernel.org>; Thu, 2 May 2019 11:29:26 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s81yqbj75-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 02 May 2019 11:29:25 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 2 May 2019 16:29:20 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 16:29:13 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42FTCa332702616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 15:29:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 059C142042;
        Thu,  2 May 2019 15:29:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E40A4203F;
        Thu,  2 May 2019 15:29:07 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.205.209])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  2 May 2019 15:29:07 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 02 May 2019 18:29:06 +0300
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
Subject: [PATCH 04/15] arm64: switch to generic version of pte allocation
Date:   Thu,  2 May 2019 18:28:31 +0300
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
References: <1556810922-20248-1-git-send-email-rppt@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050215-0020-0000-0000-00000338991C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050215-0021-0000-0000-0000218B21CF
Message-Id: <1556810922-20248-5-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=837 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020103
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The PTE allocations in arm64 are identical to the generic ones modulo the
GFP flags.

Using the generic pte_alloc_one() functions ensures that the user page
tables are allocated with __GFP_ACCOUNT set.

The arm64 definition of PGALLOC_GFP is removed and replaced with
GFP_PGTABLE_USER for p[gum]d_alloc_one() and for KVM memory cache.

The mappings created with create_pgd_mapping() are now using
GFP_PGTABLE_KERNEL.

The conversion to the generic version of pte_free_kernel() removes the NULL
check for pte.

The pte_free() version on arm64 is identical to the generic one and
can be simply dropped.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/pgalloc.h | 43 ++++------------------------------------
 arch/arm64/mm/mmu.c              |  2 +-
 arch/arm64/mm/pgd.c              |  4 ++--
 virt/kvm/arm/mmu.c               |  2 +-
 4 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 52fa47c..3293b8b 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -24,16 +24,17 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+#include <asm-generic/pgalloc.h>	/* for pte_{alloc,free}_one */
+
 #define check_pgt_cache()		do { } while (0)
 
-#define PGALLOC_GFP	(GFP_KERNEL | __GFP_ZERO)
 #define PGD_SIZE	(PTRS_PER_PGD * sizeof(pgd_t))
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
 static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pmd_t *)__get_free_page(PGALLOC_GFP);
+	return (pmd_t *)__get_free_page(GFP_PGTABLE_USER);
 }
 
 static inline void pmd_free(struct mm_struct *mm, pmd_t *pmdp)
@@ -62,7 +63,7 @@ static inline void __pud_populate(pud_t *pudp, phys_addr_t pmdp, pudval_t prot)
 
 static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	return (pud_t *)__get_free_page(PGALLOC_GFP);
+	return (pud_t *)__get_free_page(GFP_PGTABLE_USER);
 }
 
 static inline void pud_free(struct mm_struct *mm, pud_t *pudp)
@@ -90,42 +91,6 @@ static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t pudp, pgdval_t prot)
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 extern void pgd_free(struct mm_struct *mm, pgd_t *pgdp);
 
-static inline pte_t *
-pte_alloc_one_kernel(struct mm_struct *mm)
-{
-	return (pte_t *)__get_free_page(PGALLOC_GFP);
-}
-
-static inline pgtable_t
-pte_alloc_one(struct mm_struct *mm)
-{
-	struct page *pte;
-
-	pte = alloc_pages(PGALLOC_GFP, 0);
-	if (!pte)
-		return NULL;
-	if (!pgtable_page_ctor(pte)) {
-		__free_page(pte);
-		return NULL;
-	}
-	return pte;
-}
-
-/*
- * Free a PTE table.
- */
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *ptep)
-{
-	if (ptep)
-		free_page((unsigned long)ptep);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t pte)
-{
-	pgtable_page_dtor(pte);
-	__free_page(pte);
-}
-
 static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t ptep,
 				  pmdval_t prot)
 {
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e97f018..d5178c5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -373,7 +373,7 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 
 static phys_addr_t pgd_pgtable_alloc(void)
 {
-	void *ptr = (void *)__get_free_page(PGALLOC_GFP);
+	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
 	if (!ptr || !pgtable_page_ctor(virt_to_page(ptr)))
 		BUG();
 
diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
index 289f911..2ef1a53 100644
--- a/arch/arm64/mm/pgd.c
+++ b/arch/arm64/mm/pgd.c
@@ -31,9 +31,9 @@ static struct kmem_cache *pgd_cache __ro_after_init;
 pgd_t *pgd_alloc(struct mm_struct *mm)
 {
 	if (PGD_SIZE == PAGE_SIZE)
-		return (pgd_t *)__get_free_page(PGALLOC_GFP);
+		return (pgd_t *)__get_free_page(GFP_PGTABLE_USER);
 	else
-		return kmem_cache_alloc(pgd_cache, PGALLOC_GFP);
+		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_USER);
 }
 
 void pgd_free(struct mm_struct *mm, pgd_t *pgd)
diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 27c9583..9f6f638 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -141,7 +141,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
 	if (cache->nobjs >= min)
 		return 0;
 	while (cache->nobjs < max) {
-		page = (void *)__get_free_page(PGALLOC_GFP);
+		page = (void *)__get_free_page(GFP_PGTABLE_USER);
 		if (!page)
 			return -ENOMEM;
 		cache->objects[cache->nobjs++] = page;
-- 
2.7.4

