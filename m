Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8113A5D0
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgANKDo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 05:03:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729067AbgANKDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 05:03:43 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EA3MjB123813;
        Tue, 14 Jan 2020 05:03:33 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xh8d379xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 05:03:30 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00EA1UHl022453;
        Tue, 14 Jan 2020 10:01:59 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 2xf74p13k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 10:01:59 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00EA1vdS49217992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 10:01:57 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 799B4C605F;
        Tue, 14 Jan 2020 10:01:57 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ED30C6055;
        Tue, 14 Jan 2020 10:01:55 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.35.105])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jan 2020 10:01:54 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 1/9] powerpc/mmu_gather: Enable RCU_TABLE_FREE even for !SMP case
Date:   Tue, 14 Jan 2020 15:31:37 +0530
Message-Id: <20200114100145.365527-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_02:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=2 priorityscore=1501 mlxscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140090
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A follow up patch is going to make sure we correctly invalidate page walk cache
before we free page table pages. In order to keep things simple enable
RCU_TABLE_FREE even for !SMP so that we don't have to fixup the !SMP case
differently in the followup patch

!SMP case is right now broken for radix translation w.r.t page walk cache flush.
We can get interrupted in between page table free and that would imply we
have page walk cache entries pointing to tables which got freed already.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/Kconfig                         | 2 +-
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 8 --------
 arch/powerpc/include/asm/book3s/64/pgalloc.h | 2 --
 arch/powerpc/include/asm/nohash/pgalloc.h    | 8 --------
 arch/powerpc/mm/book3s64/pgtable.c           | 7 -------
 5 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1ec34e16ed65..04240205f38c 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -222,7 +222,7 @@ config PPC
 	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
-	select HAVE_RCU_TABLE_FREE		if SMP
+	select HAVE_RCU_TABLE_FREE
 	select HAVE_RCU_TABLE_NO_INVALIDATE	if HAVE_RCU_TABLE_FREE
 	select HAVE_MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 998317702630..dc5c039eb28e 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -49,7 +49,6 @@ static inline void pgtable_free(void *table, unsigned index_size)
 
 #define get_hugepd_cache_index(x)  (x)
 
-#ifdef CONFIG_SMP
 static inline void pgtable_free_tlb(struct mmu_gather *tlb,
 				    void *table, int shift)
 {
@@ -66,13 +65,6 @@ static inline void __tlb_remove_table(void *_table)
 
 	pgtable_free(table, shift);
 }
-#else
-static inline void pgtable_free_tlb(struct mmu_gather *tlb,
-				    void *table, int shift)
-{
-	pgtable_free(table, shift);
-}
-#endif
 
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
index f6968c811026..a41e91bd0580 100644
--- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
@@ -19,9 +19,7 @@ extern struct vmemmap_backing *vmemmap_list;
 extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
 extern void pmd_fragment_free(unsigned long *);
 extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
-#ifdef CONFIG_SMP
 extern void __tlb_remove_table(void *_table);
-#endif
 void pte_frag_destroy(void *pte_frag);
 
 static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index 332b13b4ecdb..29c43665a753 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -46,7 +46,6 @@ static inline void pgtable_free(void *table, int shift)
 
 #define get_hugepd_cache_index(x)	(x)
 
-#ifdef CONFIG_SMP
 static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
 {
 	unsigned long pgf = (unsigned long)table;
@@ -64,13 +63,6 @@ static inline void __tlb_remove_table(void *_table)
 	pgtable_free(table, shift);
 }
 
-#else
-static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
-{
-	pgtable_free(table, shift);
-}
-#endif
-
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 				  unsigned long address)
 {
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 75483b40fcb1..2bf7e1b4fd82 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -378,7 +378,6 @@ static inline void pgtable_free(void *table, int index)
 	}
 }
 
-#ifdef CONFIG_SMP
 void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
 {
 	unsigned long pgf = (unsigned long)table;
@@ -395,12 +394,6 @@ void __tlb_remove_table(void *_table)
 
 	return pgtable_free(table, index);
 }
-#else
-void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
-{
-	return pgtable_free(table, index);
-}
-#endif
 
 #ifdef CONFIG_PROC_FS
 atomic_long_t direct_pages_count[MMU_PAGE_COUNT];
-- 
2.24.1

