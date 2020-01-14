Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2534E13A4D7
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 11:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgANKCv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 05:02:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24164 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726169AbgANKCa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 05:02:30 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EA2EO9004231;
        Tue, 14 Jan 2020 05:02:18 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvt0gkdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 05:02:18 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00EA1kS1008515;
        Tue, 14 Jan 2020 10:02:16 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 2xf75ks482-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 10:02:16 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00EA2Fs560686770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jan 2020 10:02:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15D89C6062;
        Tue, 14 Jan 2020 10:02:15 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE191C6055;
        Tue, 14 Jan 2020 10:02:12 +0000 (GMT)
Received: from skywalker.in.ibm.com (unknown [9.124.35.105])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 14 Jan 2020 10:02:12 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 7/9] asm-generic/tlb: Rename HAVE_MMU_GATHER_PAGE_SIZE
Date:   Tue, 14 Jan 2020 15:31:43 +0530
Message-Id: <20200114100145.365527-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_02:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=998 suspectscore=2 bulkscore=0 phishscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140090
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Towards a more consistent naming scheme.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/Kconfig              | 2 +-
 arch/powerpc/Kconfig      | 2 +-
 include/asm-generic/tlb.h | 9 ++++++---
 mm/mmu_gather.c           | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 501d565690b5..e8548211b6a9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -396,7 +396,7 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
 config MMU_GATHER_RCU_TABLE_FREE
 	bool
 
-config HAVE_MMU_GATHER_PAGE_SIZE
+config MMU_GATHER_PAGE_SIZE
 	bool
 
 config MMU_GATHER_NO_RANGE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 955759234776..cefacb9c8f48 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,7 +223,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE
-	select HAVE_MMU_GATHER_PAGE_SIZE
+	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 04a1b8f08eea..53befa5acb27 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -121,11 +121,14 @@
  *
  * Additionally there are a few opt-in features:
  *
- *  HAVE_MMU_GATHER_PAGE_SIZE
+ *  MMU_GATHER_PAGE_SIZE
  *
  *  This ensures we call tlb_flush() every time tlb_change_page_size() actually
  *  changes the size and provides mmu_gather::page_size to tlb_flush().
  *
+ *  This might be useful if your architecture has size specific TLB
+ *  invalidation instructions.
+ *
  *  MMU_GATHER_RCU_TABLE_FREE
  *
  *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
@@ -279,7 +282,7 @@ struct mmu_gather {
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
 
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	unsigned int page_size;
 #endif
 #endif
@@ -435,7 +438,7 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	if (tlb->page_size && tlb->page_size != page_size) {
 		if (!tlb->fullmm && !tlb->need_flush_all)
 			tlb_flush_mmu(tlb);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 86bb2176e173..297c70307367 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -69,7 +69,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, struct page *page, int page_
 
 	VM_BUG_ON(!tlb->end);
 
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	VM_WARN_ON(tlb->page_size != page_size);
 #endif
 
@@ -223,7 +223,7 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm,
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb->batch = NULL;
 #endif
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	tlb->page_size = 0;
 #endif
 
-- 
2.24.1

