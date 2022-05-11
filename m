Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1612952327D
	for <lists+linux-arch@lfdr.de>; Wed, 11 May 2022 14:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbiEKMFQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 May 2022 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241512AbiEKMFG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 11 May 2022 08:05:06 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0870F2457BC;
        Wed, 11 May 2022 05:04:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=32;SR=0;TI=SMTPD_---0VCw.GA4_1652270672;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCw.GA4_1652270672)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 May 2022 20:04:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com
Cc:     catalin.marinas@arm.com, will@kernel.org, songmuchun@bytedance.com,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de, baolin.wang@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v4 1/3] mm: change huge_ptep_clear_flush() to return the original pte
Date:   Wed, 11 May 2022 20:04:17 +0800
Message-Id: <20f77ddab90baa249bd24504c413189b82acde69.1652270205.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
References: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
References: <cover.1652270205.git.baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

It is incorrect to use ptep_clear_flush() to nuke a hugetlb page
table when unmapping or migrating a hugetlb page, and will change
to use huge_ptep_clear_flush() instead in the following patches.

So this is a preparation patch, which changes the huge_ptep_clear_flush()
to return the original pte to help to nuke a hugetlb page table.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/arm64/include/asm/hugetlb.h   |  4 ++--
 arch/arm64/mm/hugetlbpage.c        | 12 +++++-------
 arch/ia64/include/asm/hugetlb.h    |  5 +++--
 arch/mips/include/asm/hugetlb.h    |  9 ++++++---
 arch/parisc/include/asm/hugetlb.h  |  5 +++--
 arch/powerpc/include/asm/hugetlb.h |  9 ++++++---
 arch/s390/include/asm/hugetlb.h    |  6 +++---
 arch/sh/include/asm/hugetlb.h      |  5 +++--
 arch/sparc/include/asm/hugetlb.h   |  5 +++--
 include/asm-generic/hugetlb.h      |  4 ++--
 10 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 1242f71..616b2ca 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -39,8 +39,8 @@ extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-extern void huge_ptep_clear_flush(struct vm_area_struct *vma,
-				  unsigned long addr, pte_t *ptep);
+extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+				   unsigned long addr, pte_t *ptep);
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index cbace1c..ca8e65c 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -486,19 +486,17 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 		set_pte_at(mm, addr, ptep, pfn_pte(pfn, hugeprot));
 }
 
-void huge_ptep_clear_flush(struct vm_area_struct *vma,
-			   unsigned long addr, pte_t *ptep)
+pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+			    unsigned long addr, pte_t *ptep)
 {
 	size_t pgsize;
 	int ncontig;
 
-	if (!pte_cont(READ_ONCE(*ptep))) {
-		ptep_clear_flush(vma, addr, ptep);
-		return;
-	}
+	if (!pte_cont(READ_ONCE(*ptep)))
+		return ptep_clear_flush(vma, addr, ptep);
 
 	ncontig = find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
-	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
 }
 
 static int __init hugetlbpage_init(void)
diff --git a/arch/ia64/include/asm/hugetlb.h b/arch/ia64/include/asm/hugetlb.h
index 7e46ebd..026ead4 100644
--- a/arch/ia64/include/asm/hugetlb.h
+++ b/arch/ia64/include/asm/hugetlb.h
@@ -23,9 +23,10 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 #define is_hugepage_only_range is_hugepage_only_range
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
-					 unsigned long addr, pte_t *ptep)
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep)
 {
+	return *ptep;
 }
 
 #include <asm-generic/hugetlb.h>
diff --git a/arch/mips/include/asm/hugetlb.h b/arch/mips/include/asm/hugetlb.h
index c214440..fd69c88 100644
--- a/arch/mips/include/asm/hugetlb.h
+++ b/arch/mips/include/asm/hugetlb.h
@@ -43,16 +43,19 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
-					 unsigned long addr, pte_t *ptep)
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep)
 {
+	pte_t pte;
+
 	/*
 	 * clear the huge pte entry firstly, so that the other smp threads will
 	 * not get old pte entry after finishing flush_tlb_page and before
 	 * setting new huge pte entry
 	 */
-	huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
 	flush_tlb_page(vma, addr);
+	return pte;
 }
 
 #define __HAVE_ARCH_HUGE_PTE_NONE
diff --git a/arch/parisc/include/asm/hugetlb.h b/arch/parisc/include/asm/hugetlb.h
index a69cf9e..f7f078c 100644
--- a/arch/parisc/include/asm/hugetlb.h
+++ b/arch/parisc/include/asm/hugetlb.h
@@ -28,9 +28,10 @@ static inline int prepare_hugepage_range(struct file *file,
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
-					 unsigned long addr, pte_t *ptep)
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep)
 {
+	return *ptep;
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 6a1a1ac..8a5674f 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -43,11 +43,14 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
-					 unsigned long addr, pte_t *ptep)
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep)
 {
-	huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
+	pte_t pte;
+
+	pte = huge_ptep_get_and_clear(vma->vm_mm, addr, ptep);
 	flush_hugetlb_page(vma, addr);
+	return pte;
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_SET_ACCESS_FLAGS
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 32c3fd6..f22beda 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -50,10 +50,10 @@ static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 		set_pte(ptep, __pte(_SEGMENT_ENTRY_EMPTY));
 }
 
-static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
-					 unsigned long address, pte_t *ptep)
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+					  unsigned long address, pte_t *ptep)
 {
-	huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
+	return huge_ptep_get_and_clear(vma->vm_mm, address, ptep);
 }
 
 static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
diff --git a/arch/sh/include/asm/hugetlb.h b/arch/sh/include/asm/hugetlb.h
index ae4de7b..4d3ba39 100644
--- a/arch/sh/include/asm/hugetlb.h
+++ b/arch/sh/include/asm/hugetlb.h
@@ -21,9 +21,10 @@ static inline int prepare_hugepage_range(struct file *file,
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
-					 unsigned long addr, pte_t *ptep)
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep)
 {
+	return *ptep;
 }
 
 static inline void arch_clear_hugepage_flags(struct page *page)
diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/hugetlb.h
index 53838a1..0a26cca 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -21,9 +21,10 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep);
 
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
-					 unsigned long addr, pte_t *ptep)
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep)
 {
+	return *ptep;
 }
 
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
diff --git a/include/asm-generic/hugetlb.h b/include/asm-generic/hugetlb.h
index 896f341..a57d667 100644
--- a/include/asm-generic/hugetlb.h
+++ b/include/asm-generic/hugetlb.h
@@ -84,10 +84,10 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 #endif
 
 #ifndef __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep)
 {
-	ptep_clear_flush(vma, addr, ptep);
+	return ptep_clear_flush(vma, addr, ptep);
 }
 #endif
 
-- 
1.8.3.1

