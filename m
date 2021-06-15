Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEB43A7D42
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 13:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhFOLeu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 07:34:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230236AbhFOLet (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 07:34:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15FBF22d115060;
        Tue, 15 Jun 2021 07:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Iqm3Fgzf26WsoyAdzyp37W9UIZYX5LKF8+rvmRpcpRA=;
 b=DOdl0Vo+r9XESD+a0U0EMoze6ErnoIjzXF3MPpDo1TtA/7ZQxiEdunUXc8wiV2FoGI0N
 /pGx45dPrpkBAGetqs+zk5pdxVkQtyaLVByRMJSXk3R+I5G6rlCBOwvirNw/K0X/4Bq7
 2I4zsaF8hzwDDJdD8OMtVaZDIyDMlvNaUC/MyymyfJKqvfs1G5T0C/Lhe93NVYDfqjZq
 EUsj6clxE0cVZpfNrvuR02l4qBzN5aotuHCvkoGODig3APeBTpnfSKNlP1i536KbYUvR
 PuknCby/W8wv+yosOMQMOoiN689g+PqjpbtiG5Mlg1vrFLuxW8NkRpAwjvjplSFPPtQr lQ== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 396u5s8eh0-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 07:32:05 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15FB8Edk014699;
        Tue, 15 Jun 2021 11:09:20 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04dal.us.ibm.com with ESMTP id 3965ytj7t4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 11:09:19 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15FB9JOd16777584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Jun 2021 11:09:19 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C29AEAE05F;
        Tue, 15 Jun 2021 11:09:18 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6671BAE076;
        Tue, 15 Jun 2021 11:09:13 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.199.54.82])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 15 Jun 2021 11:09:13 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 1/2] mm: rename pud_page_vaddr to pud_pgtable and make it return pmd_t *
Date:   Tue, 15 Jun 2021 16:38:58 +0530
Message-Id: <20210615110859.320299-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9u8EASiRB3rZzk7qN054tV9AdQnaPH_F
X-Proofpoint-GUID: 9u8EASiRB3rZzk7qN054tV9AdQnaPH_F
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_04:2021-06-14,2021-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=979 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106150070
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No functional change in this patch.

Cc: linux-alpha@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org

Link: https://lore.kernel.org/linuxppc-dev/CAHk-=wi+J+iodze9FtjM3Zi4j4OeS+qqbKxME9QN4roxPEXH9Q@mail.gmail.com/
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/alpha/include/asm/pgtable.h             | 8 +++++---
 arch/arm/include/asm/pgtable-3level.h        | 2 +-
 arch/arm64/include/asm/pgtable.h             | 4 ++--
 arch/ia64/include/asm/pgtable.h              | 2 +-
 arch/m68k/include/asm/motorola_pgtable.h     | 2 +-
 arch/mips/include/asm/pgtable-64.h           | 4 ++--
 arch/parisc/include/asm/pgtable.h            | 4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h | 6 +++++-
 arch/powerpc/include/asm/nohash/64/pgtable.h | 6 +++++-
 arch/powerpc/mm/book3s64/radix_pgtable.c     | 4 ++--
 arch/powerpc/mm/pgtable_64.c                 | 2 +-
 arch/riscv/include/asm/pgtable-64.h          | 4 ++--
 arch/sh/include/asm/pgtable-3level.h         | 4 ++--
 arch/sparc/include/asm/pgtable_32.h          | 4 ++--
 arch/sparc/include/asm/pgtable_64.h          | 6 +++---
 arch/um/include/asm/pgtable-3level.h         | 2 +-
 arch/x86/include/asm/pgtable.h               | 4 ++--
 arch/x86/mm/pat/set_memory.c                 | 4 ++--
 arch/x86/mm/pgtable.c                        | 2 +-
 include/asm-generic/pgtable-nopmd.h          | 2 +-
 include/asm-generic/pgtable-nopud.h          | 2 +-
 include/linux/pgtable.h                      | 2 +-
 22 files changed, 45 insertions(+), 35 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 8d856c62e22a..be02e4e403d1 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -239,8 +239,10 @@ pmd_page_vaddr(pmd_t pmd)
 #define pmd_page(pmd)	(pfn_to_page(pmd_val(pmd) >> 32))
 #define pud_page(pud)	(pfn_to_page(pud_val(pud) >> 32))
 
-extern inline unsigned long pud_page_vaddr(pud_t pgd)
-{ return PAGE_OFFSET + ((pud_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)); }
+static inline pmd_t *pud_pgtable(pud_t pgd)
+{
+	return (pmd_t *)(PAGE_OFFSET + ((pud_val(pgd) & _PFN_MASK) >> (32-PAGE_SHIFT)));
+}
 
 extern inline int pte_none(pte_t pte)		{ return !pte_val(pte); }
 extern inline int pte_present(pte_t pte)	{ return pte_val(pte) & _PAGE_VALID; }
@@ -290,7 +292,7 @@ extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; retu
 /* Find an entry in the second-level page table.. */
 extern inline pmd_t * pmd_offset(pud_t * dir, unsigned long address)
 {
-	pmd_t *ret = (pmd_t *) pud_page_vaddr(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
+	pmd_t *ret = pud_pgtable(*dir) + ((address >> PMD_SHIFT) & (PTRS_PER_PAGE - 1));
 	smp_rmb(); /* see above */
 	return ret;
 }
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index d4edab51a77c..eabe72ff7381 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -130,7 +130,7 @@
 		flush_pmd_entry(pudp);	\
 	} while (0)
 
-static inline pmd_t *pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
 }
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b10204e72fc..53a415b329b0 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -636,9 +636,9 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
 	return __pud_to_phys(pud);
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)__va(pud_page_paddr(pud));
+	return (pmd_t *)__va(pud_page_paddr(pud));
 }
 
 /* Find an entry in the second-level page table. */
diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index d765fd948fae..b2ddfbe70365 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -274,7 +274,7 @@ ia64_phys_addr_valid (unsigned long addr)
 #define pud_bad(pud)			(!ia64_phys_addr_valid(pud_val(pud)))
 #define pud_present(pud)		(pud_val(pud) != 0UL)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
-#define pud_page_vaddr(pud)		((unsigned long) __va(pud_val(pud) & _PFN_MASK))
+#define pud_pgtable(pud)		((pmd_t *) __va(pud_val(pud) & _PFN_MASK))
 #define pud_page(pud)			virt_to_page((pud_val(pud) + PAGE_OFFSET))
 
 #if CONFIG_PGTABLE_LEVELS == 4
diff --git a/arch/m68k/include/asm/motorola_pgtable.h b/arch/m68k/include/asm/motorola_pgtable.h
index 8076467eff4b..956c80874f98 100644
--- a/arch/m68k/include/asm/motorola_pgtable.h
+++ b/arch/m68k/include/asm/motorola_pgtable.h
@@ -129,7 +129,7 @@ static inline void pud_set(pud_t *pudp, pmd_t *pmdp)
 
 #define __pte_page(pte) ((unsigned long)__va(pte_val(pte) & PAGE_MASK))
 #define pmd_page_vaddr(pmd) ((unsigned long)__va(pmd_val(pmd) & _TABLE_MASK))
-#define pud_page_vaddr(pud) ((unsigned long)__va(pud_val(pud) & _TABLE_MASK))
+#define pud_pgtable(pud) ((pmd_t *)__va(pud_val(pud) & _TABLE_MASK))
 
 
 #define pte_none(pte)		(!pte_val(pte))
diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
index 1e7d6ce9d8d6..ab305453e90f 100644
--- a/arch/mips/include/asm/pgtable-64.h
+++ b/arch/mips/include/asm/pgtable-64.h
@@ -314,9 +314,9 @@ static inline void pud_clear(pud_t *pudp)
 #endif
 
 #ifndef __PAGETABLE_PMD_FOLDED
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return pud_val(pud);
+	return (pmd_t *)pud_val(pud);
 }
 #define pud_phys(pud)		virt_to_phys((void *)pud_val(pud))
 #define pud_page(pud)		(pfn_to_page(pud_phys(pud) >> PAGE_SHIFT))
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index 39017210dbf0..7218345a447f 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -324,8 +324,8 @@ static inline void pmd_clear(pmd_t *pmd) {
 
 
 #if CONFIG_PGTABLE_LEVELS == 3
-#define pud_page_vaddr(pud) ((unsigned long) __va(pud_address(pud)))
-#define pud_page(pud)	virt_to_page((void *)pud_page_vaddr(pud))
+#define pud_pgtable(pud) ((pmd_t *) __va(pud_address(pud)))
+#define pud_page(pud)	virt_to_page((void *)pud_pgtable(pud))
 
 /* For 64 bit we have three level tables */
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index a666d561b44d..40bafe1e80c9 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1048,9 +1048,13 @@ extern struct page *p4d_page(p4d_t p4d);
 /* Pointers in the page table tree are physical addresses */
 #define __pgtable_ptr_val(ptr)	__pa(ptr)
 
-#define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
 #define p4d_page_vaddr(p4d)	__va(p4d_val(p4d) & ~P4D_MASKED_BITS)
 
+static inline pmd_t *pud_pgtable(pud_t pud)
+{
+	return (pmd_t *)__va(pud_val(pud) & ~PUD_MASKED_BITS);
+}
+
 #define pte_ERROR(e) \
 	pr_err("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
 #define pmd_ERROR(e) \
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 57cd3892bfe0..4158c90c572a 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -164,7 +164,11 @@ static inline void pud_clear(pud_t *pudp)
 #define	pud_bad(pud)		(!is_kernel_addr(pud_val(pud)) \
 				 || (pud_val(pud) & PUD_BAD_BITS))
 #define pud_present(pud)	(pud_val(pud) != 0)
-#define pud_page_vaddr(pud)	(pud_val(pud) & ~PUD_MASKED_BITS)
+
+static inline pmd_t *pud_pgtable(pud_t pud)
+{
+	return (pmd_t *)(pud_val(pud) & ~PUD_MASKED_BITS);
+}
 
 extern struct page *pud_page(pud_t pud);
 
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 5fef8db3b463..b663d8f9f05c 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -825,7 +825,7 @@ static void __meminit remove_pud_table(pud_t *pud_start, unsigned long addr,
 			continue;
 		}
 
-		pmd_base = (pmd_t *)pud_page_vaddr(*pud);
+		pmd_base = pud_pgtable(*pud);
 		remove_pmd_table(pmd_base, addr, next);
 		free_pmd_table(pmd_base, pud);
 	}
@@ -1110,7 +1110,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	pmd_t *pmd;
 	int i;
 
-	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd = pud_pgtable(*pud);
 	pud_clear(pud);
 
 	flush_tlb_kernel_range(addr, addr + PUD_SIZE);
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index cc6e2f94517f..4ba311808bdb 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -115,7 +115,7 @@ struct page *pud_page(pud_t pud)
 		VM_WARN_ON(!pud_huge(pud));
 		return pte_page(pud_pte(pud));
 	}
-	return virt_to_page(pud_page_vaddr(pud));
+	return virt_to_page(pud_pgtable(pud));
 }
 
 /*
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index f3b0da64c6c8..0e863f3f7187 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -60,9 +60,9 @@ static inline void pud_clear(pud_t *pudp)
 	set_pud(pudp, __pud(0));
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
+	return (pmd_t *)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
 }
 
 static inline struct page *pud_page(pud_t pud)
diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
index 82d74472dfcd..56bf35c2f29c 100644
--- a/arch/sh/include/asm/pgtable-3level.h
+++ b/arch/sh/include/asm/pgtable-3level.h
@@ -32,9 +32,9 @@ typedef struct { unsigned long long pmd; } pmd_t;
 #define pmd_val(x)	((x).pmd)
 #define __pmd(x)	((pmd_t) { (x) } )
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return pud_val(pud);
+	return (pmd_t *)pud_val(pud);
 }
 
 /* only used by the stubbed out hugetlb gup code, should never be called */
diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
index a5cf79c149fe..affd70ab02c8 100644
--- a/arch/sparc/include/asm/pgtable_32.h
+++ b/arch/sparc/include/asm/pgtable_32.h
@@ -152,13 +152,13 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return (unsigned long)__nocache_va(v << 4);
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	if (srmmu_device_memory(pud_val(pud))) {
 		return ~0;
 	} else {
 		unsigned long v = pud_val(pud) & SRMMU_PTD_PMASK;
-		return (unsigned long)__nocache_va(v << 4);
+		return (pmd_t *)__nocache_va(v << 4);
 	}
 }
 
diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index 550d3904de65..534ec872fa2c 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -845,18 +845,18 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return ((unsigned long) __va(pfn << PAGE_SHIFT));
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
 	pte_t pte = __pte(pud_val(pud));
 	unsigned long pfn;
 
 	pfn = pte_pfn(pte);
 
-	return ((unsigned long) __va(pfn << PAGE_SHIFT));
+	return ((pmd_t *) __va(pfn << PAGE_SHIFT));
 }
 
 #define pmd_page(pmd) 			virt_to_page((void *)pmd_page_vaddr(pmd))
-#define pud_page(pud) 			virt_to_page((void *)pud_page_vaddr(pud))
+#define pud_page(pud)			virt_to_page((void *)pud_pgtable(pud))
 #define pmd_clear(pmdp)			(pmd_val(*(pmdp)) = 0UL)
 #define pud_present(pud)		(pud_val(pud) != 0U)
 #define pud_clear(pudp)			(pud_val(*(pudp)) = 0UL)
diff --git a/arch/um/include/asm/pgtable-3level.h b/arch/um/include/asm/pgtable-3level.h
index 7e6a4180db9d..091bff319ccd 100644
--- a/arch/um/include/asm/pgtable-3level.h
+++ b/arch/um/include/asm/pgtable-3level.h
@@ -84,7 +84,7 @@ static inline void pud_clear (pud_t *pud)
 }
 
 #define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
-#define pud_page_vaddr(pud) ((unsigned long) __va(pud_val(pud) & PAGE_MASK))
+#define pud_pgtable(pud) ((pmd_t *) __va(pud_val(pud) & PAGE_MASK))
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b1099f2d9800..35a34ca6f2e9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -865,9 +865,9 @@ static inline int pud_present(pud_t pud)
 	return pud_flags(pud) & _PAGE_PRESENT;
 }
 
-static inline unsigned long pud_page_vaddr(pud_t pud)
+static inline pmd_t *pud_pgtable(pud_t pud)
 {
-	return (unsigned long)__va(pud_val(pud) & pud_pfn_mask(pud));
+	return (pmd_t *)__va(pud_val(pud) & pud_pfn_mask(pud));
 }
 
 /*
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 156cd235659f..ad8a5c586a35 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1134,7 +1134,7 @@ static void __unmap_pmd_range(pud_t *pud, pmd_t *pmd,
 			      unsigned long start, unsigned long end)
 {
 	if (unmap_pte_range(pmd, start, end))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
 
@@ -1178,7 +1178,7 @@ static void unmap_pmd_range(pud_t *pud, unsigned long start, unsigned long end)
 	 * Try again to free the PMD page if haven't succeeded above.
 	 */
 	if (!pud_none(*pud))
-		if (try_to_free_pmd_page((pmd_t *)pud_page_vaddr(*pud)))
+		if (try_to_free_pmd_page(pud_pgtable(*pud)))
 			pud_clear(pud);
 }
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index d27cf69e811d..3481b35cb4ec 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -797,7 +797,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
 	pte_t *pte;
 	int i;
 
-	pmd = (pmd_t *)pud_page_vaddr(*pud);
+	pmd = pud_pgtable(*pud);
 	pmd_sv = (pmd_t *)__get_free_page(GFP_KERNEL);
 	if (!pmd_sv)
 		return 0;
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 3e13acd019ae..10789cf51d16 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -51,7 +51,7 @@ static inline pmd_t * pmd_offset(pud_t * pud, unsigned long address)
 #define __pmd(x)				((pmd_t) { __pud(x) } )
 
 #define pud_page(pud)				(pmd_page((pmd_t){ pud }))
-#define pud_page_vaddr(pud)			(pmd_page_vaddr((pmd_t){ pud }))
+#define pud_pgtable(pud)			((pmd_t *)(pmd_page_vaddr((pmd_t){ pud })))
 
 /*
  * allocating and freeing a pmd is trivial: the 1-entry pmd is
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index a9d751fbda9e..7cbd15f70bf5 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -49,7 +49,7 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 #define __pud(x)				((pud_t) { __p4d(x) })
 
 #define p4d_page(p4d)				(pud_page((pud_t){ p4d }))
-#define p4d_page_vaddr(p4d)			(pud_page_vaddr((pud_t){ p4d }))
+#define p4d_page_vaddr(p4d)			(pud_pgtable((pud_t){ p4d }))
 
 /*
  * allocating and freeing a pud is trivial: the 1-entry pud is
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a43047b1030d..311984f87cf9 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -88,7 +88,7 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 #ifndef pmd_offset
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long address)
 {
-	return (pmd_t *)pud_page_vaddr(*pud) + pmd_index(address);
+	return pud_pgtable(*pud) + pmd_index(address);
 }
 #define pmd_offset pmd_offset
 #endif
-- 
2.31.1

