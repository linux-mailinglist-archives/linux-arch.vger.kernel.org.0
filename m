Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAB86B63D2
	for <lists+linux-arch@lfdr.de>; Sun, 12 Mar 2023 09:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCLIKy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Mar 2023 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCLIKy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Mar 2023 04:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70A34D61F
        for <linux-arch@vger.kernel.org>; Sun, 12 Mar 2023 00:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678608605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wJAgYUosYoqDCfWrXcT8rQOHhqo41K/Tpr4p5XcYly8=;
        b=dmZz/8rF1h/nPs84yBZZxz0o8+dWEivd31Odn4fBcZ3tmuMx4G3paeb05QXqhpiha3CUpQ
        Xj/jE4pvyhhaGsyRONBHGyqJdlEkLuy+bbUpefFl2+hiOm8G2otHdibY2B8EYqvnYpsgtM
        4/fVsGgpkl7Te76vvbB3TofRE327jdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-V4F0EYN3PhS2cNH4jc19xg-1; Sun, 12 Mar 2023 04:10:01 -0400
X-MC-Unique: V4F0EYN3PhS2cNH4jc19xg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93498802D2A;
        Sun, 12 Mar 2023 08:10:00 +0000 (UTC)
Received: from ypodemsk.tlv.csb (unknown [10.39.192.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EA47140EBF4;
        Sun, 12 Mar 2023 08:09:57 +0000 (UTC)
From:   Yair Podemsky <ypodemsk@redhat.com>
To:     will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org,
        arnd@arndb.de, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mtosatti@redhat.com,
        ppandit@redhat.com, alougovs@redhat.com
Cc:     ypodemsk@redhat.com, David Hildenbrand <david@redhat.com>
Subject: [PATCH] mm/mmu_gather: send tlb_remove_table_smp_sync IPI only to MM CPUs
Date:   Sun, 12 Mar 2023 10:09:45 +0200
Message-Id: <20230312080945.14171-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
indiscriminately, this causes unnecessary work and delays notable in
real-time use-cases and isolated cpus, this patch will limit this IPI to
only be sent to cpus referencing the effected mm and are currently in
kernel space.

Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---
 include/asm-generic/tlb.h |  4 ++--
 mm/khugepaged.c           |  4 ++--
 mm/mmu_gather.c           | 20 +++++++++++++++-----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b46617207c93..0b6ba17cc8d3 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -222,7 +222,7 @@ extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
 #define tlb_needs_table_invalidate() (true)
 #endif
 
-void tlb_remove_table_sync_one(void);
+void tlb_remove_table_sync_one(struct mm_struct *mm);
 
 #else
 
@@ -230,7 +230,7 @@ void tlb_remove_table_sync_one(void);
 #error tlb_needs_table_invalidate() requires MMU_GATHER_RCU_TABLE_FREE
 #endif
 
-static inline void tlb_remove_table_sync_one(void) { }
+static inline void tlb_remove_table_sync_one(struct mm_struct *mm) { }
 
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 5cb401aa2b9d..86a82c0ac41f 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1051,7 +1051,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	_pmd = pmdp_collapse_flush(vma, address, pmd);
 	spin_unlock(pmd_ptl);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_one(mm);
 
 	spin_lock(pte_ptl);
 	result =  __collapse_huge_page_isolate(vma, address, pte, cc,
@@ -1408,7 +1408,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 				addr + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	pmd = pmdp_collapse_flush(vma, addr, pmdp);
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_one(mm);
 	mmu_notifier_invalidate_range_end(&range);
 	mm_dec_nr_ptes(mm);
 	page_table_check_pte_clear_range(mm, addr, pmd);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 2b93cf6ac9ae..3b267600a5e9 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -9,6 +9,7 @@
 #include <linux/smp.h>
 #include <linux/swap.h>
 #include <linux/rmap.h>
+#include <linux/context_tracking_state.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -191,7 +192,15 @@ static void tlb_remove_table_smp_sync(void *arg)
 	/* Simply deliver the interrupt */
 }
 
-void tlb_remove_table_sync_one(void)
+static bool cpu_in_kernel(int cpu, void *info)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+	int statue = atomic_read(&ct->state);
+	//will return true only for cpu's in kernel space
+	return !(statue & CT_STATE_MASK);
+}
+
+void tlb_remove_table_sync_one(struct mm_struct *mm)
 {
 	/*
 	 * This isn't an RCU grace period and hence the page-tables cannot be
@@ -200,7 +209,8 @@ void tlb_remove_table_sync_one(void)
 	 * It is however sufficient for software page-table walkers that rely on
 	 * IRQ disabling.
 	 */
-	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
+	on_each_cpu_cond_mask(cpu_in_kernel, tlb_remove_table_smp_sync,
+			NULL, true, mm_cpumask(mm));
 }
 
 static void tlb_remove_table_rcu(struct rcu_head *head)
@@ -237,9 +247,9 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
-static void tlb_remove_table_one(void *table)
+static void tlb_remove_table_one(struct mm_struct *mm, void *table)
 {
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_one(mm);
 	__tlb_remove_table(table);
 }
 
@@ -262,7 +272,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		if (*batch == NULL) {
 			tlb_table_invalidate(tlb);
-			tlb_remove_table_one(table);
+			tlb_remove_table_one(tlb->mm, table);
 			return;
 		}
 		(*batch)->nr = 0;
-- 
2.31.1

