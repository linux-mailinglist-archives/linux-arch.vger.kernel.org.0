Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAAE736FB3
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjFTPDz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 11:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233563AbjFTPDj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 11:03:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58626199E
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687273081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMVWP9uUwreYp41lBQlzx9rQqv8YUX+d+4RkZ35R+cQ=;
        b=gYUphafO6nGT/p1sVxqEYFC7CeZjjn7z3SxnyWibd9PIQMIJNBmgLBUEYDGfOlK/Q0In8g
        J2/boEFCrxi9iB7mnEhV5cVfQuo6PzpfAMXGTkXDLKWkTcJ0VuBnaX6h/Tge2gWhxh8AyW
        9Q621TiQoixEkMooeLXJzDmdCHwLXBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-582-PGZ8P0JHPzaSP3c_R985HA-1; Tue, 20 Jun 2023 10:54:43 -0400
X-MC-Unique: PGZ8P0JHPzaSP3c_R985HA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFAFA18E0072;
        Tue, 20 Jun 2023 14:46:51 +0000 (UTC)
Received: from ypodemsk.tlv.csb (unknown [10.39.195.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E04889E9C;
        Tue, 20 Jun 2023 14:46:42 +0000 (UTC)
From:   Yair Podemsky <ypodemsk@redhat.com>
To:     mtosatti@redhat.com, ppandit@redhat.com, david@redhat.com,
        linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, keescook@chromium.org, paulmck@kernel.org,
        frederic@kernel.org, will@kernel.org, peterz@infradead.org,
        ardb@kernel.org, samitolvanen@google.com,
        juerg.haefliger@canonical.com, arnd@arndb.de,
        rmk+kernel@armlinux.org.uk, geert+renesas@glider.be,
        linus.walleij@linaro.org, akpm@linux-foundation.org,
        sebastian.reichel@collabora.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     ypodemsk@redhat.com
Subject: [PATCH v2 2/2] mm/mmu_gather: send tlb_remove_table_smp_sync IPI only to MM CPUs
Date:   Tue, 20 Jun 2023 17:46:18 +0300
Message-Id: <20230620144618.125703-3-ypodemsk@redhat.com>
In-Reply-To: <20230620144618.125703-1-ypodemsk@redhat.com>
References: <20230620144618.125703-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently the tlb_remove_table_smp_sync IPI is sent to all CPUs
indiscriminately, this causes unnecessary work and delays notable in
real-time use-cases and isolated cpus.
This patch will limit this IPI on systems with ARCH_HAS_CPUMASK_BITS,
Where the IPI will only be sent to cpus referencing the affected mm.

Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
Suggested-by: David Hildenbrand <david@redhat.com>
---
 include/asm-generic/tlb.h |  4 ++--
 mm/khugepaged.c           |  4 ++--
 mm/mmu_gather.c           | 17 ++++++++++++-----
 3 files changed, 16 insertions(+), 9 deletions(-)

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
index 6b9d39d65b73..3e5cb079d268 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1166,7 +1166,7 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
 	_pmd = pmdp_collapse_flush(vma, address, pmd);
 	spin_unlock(pmd_ptl);
 	mmu_notifier_invalidate_range_end(&range);
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_one(mm);
 
 	spin_lock(pte_ptl);
 	result =  __collapse_huge_page_isolate(vma, address, pte, cc,
@@ -1525,7 +1525,7 @@ static void collapse_and_free_pmd(struct mm_struct *mm, struct vm_area_struct *v
 				addr + HPAGE_PMD_SIZE);
 	mmu_notifier_invalidate_range_start(&range);
 	pmd = pmdp_collapse_flush(vma, addr, pmdp);
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_one(mm);
 	mmu_notifier_invalidate_range_end(&range);
 	mm_dec_nr_ptes(mm);
 	page_table_check_pte_clear_range(mm, addr, pmd);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index ea9683e12936..692d8175a88e 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -191,7 +191,13 @@ static void tlb_remove_table_smp_sync(void *arg)
 	/* Simply deliver the interrupt */
 }
 
-void tlb_remove_table_sync_one(void)
+#ifdef CONFIG_ARCH_HAS_CPUMASK_BITS
+#define REMOVE_TABLE_IPI_MASK mm_cpumask(mm)
+#else
+#define REMOVE_TABLE_IPI_MASK cpu_online_mask
+#endif /* CONFIG_ARCH_HAS_CPUMASK_BITS */
+
+void tlb_remove_table_sync_one(struct mm_struct *mm)
 {
 	/*
 	 * This isn't an RCU grace period and hence the page-tables cannot be
@@ -200,7 +206,8 @@ void tlb_remove_table_sync_one(void)
 	 * It is however sufficient for software page-table walkers that rely on
 	 * IRQ disabling.
 	 */
-	smp_call_function(tlb_remove_table_smp_sync, NULL, 1);
+	on_each_cpu_mask(REMOVE_TABLE_IPI_MASK, tlb_remove_table_smp_sync,
+			NULL, true);
 }
 
 static void tlb_remove_table_rcu(struct rcu_head *head)
@@ -237,9 +244,9 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 	}
 }
 
-static void tlb_remove_table_one(void *table)
+static void tlb_remove_table_one(struct mm_struct *mm, void *table)
 {
-	tlb_remove_table_sync_one();
+	tlb_remove_table_sync_one(mm);
 	__tlb_remove_table(table);
 }
 
@@ -262,7 +269,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
 		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
 		if (*batch == NULL) {
 			tlb_table_invalidate(tlb);
-			tlb_remove_table_one(table);
+			tlb_remove_table_one(tlb->mm, table);
 			return;
 		}
 		(*batch)->nr = 0;
---
v2: replaced no REMOVE_TABLE_IPI_MASK REMOVE_TABLE_IPI_MASK to cpu_online_mask
-- 
2.39.3

