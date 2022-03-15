Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802414D9BA6
	for <lists+linux-arch@lfdr.de>; Tue, 15 Mar 2022 13:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348483AbiCOM5J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Mar 2022 08:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiCOM5I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Mar 2022 08:57:08 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 588A54E39E;
        Tue, 15 Mar 2022 05:55:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxWs3KjDBiiMQJAA--.30652S2;
        Tue, 15 Mar 2022 20:55:43 +0800 (CST)
From:   Jianxing Wang <wangjianxing@loongson.cn>
To:     will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jianxing Wang <wangjianxing@loongson.cn>
Subject: [PATCH 1/1] mm/mmu_gather: limit tlb batch count and add schedule point in tlb_batch_pages_flush
Date:   Tue, 15 Mar 2022 08:55:36 -0400
Message-Id: <20220315125536.1036303-1-wangjianxing@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxWs3KjDBiiMQJAA--.30652S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy8trW7GF4fCF4kGw1Utrb_yoW5WFWxpF
        Z8Crs7ZrZ5Gw4UJr4Iy3Wv93sIvanIgrWrAFy8t3sxAr13J34vkFyvy34jgr18CFWrCrWS
        gFZrXr4rXrsFvr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: pzdqwyxldq5xtqj6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

free a large list of pages maybe cause rcu_sched starved on
non-preemptible kernels. howerver free_unref_page_list maybe can't
cond_resched as it maybe called in interrupt or atomic context,
especially can't detect atomic context in CONFIG_PREEMPTION=n.

tlb flush batch count depends on PAGE_SIZE, it's too large if
PAGE_SIZE > 4K, here limit max batch size with 4K.
And add schedule point in tlb_batch_pages_flush.

rcu: rcu_sched kthread starved for 5359 jiffies! g454793 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=19
[...]
Call Trace:
   free_unref_page_list+0x19c/0x270
   release_pages+0x3cc/0x498
   tlb_flush_mmu_free+0x44/0x70
   zap_pte_range+0x450/0x738
   unmap_page_range+0x108/0x240
   unmap_vmas+0x74/0xf0
   unmap_region+0xb0/0x120
   do_munmap+0x264/0x438
   vm_munmap+0x58/0xa0
   sys_munmap+0x10/0x20
   syscall_common+0x24/0x38

Signed-off-by: Jianxing Wang <wangjianxing@loongson.cn>
---
 include/asm-generic/tlb.h | 7 ++++++-
 mm/mmu_gather.c           | 7 +++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 2c68a545ffa7..47c7f93ca695 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -230,8 +230,13 @@ struct mmu_gather_batch {
 	struct page		*pages[0];
 };
 
+#if PAGE_SIZE > 4096UL
+#define MAX_GATHER_BATCH_SZ	4096
+#else
+#define MAX_GATHER_BATCH_SZ	PAGE_SIZE
+#endif
 #define MAX_GATHER_BATCH	\
-	((PAGE_SIZE - sizeof(struct mmu_gather_batch)) / sizeof(void *))
+	((MAX_GATHER_BATCH_SZ - sizeof(struct mmu_gather_batch)) / sizeof(void *))
 
 /*
  * Limit the maximum number of mmu_gather batches to reduce a risk of soft
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index afb7185ffdc4..f2c105810b3f 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -8,6 +8,7 @@
 #include <linux/rcupdate.h>
 #include <linux/smp.h>
 #include <linux/swap.h>
+#include <linux/slab.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -27,7 +28,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
 	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
 		return false;
 
-	batch = (void *)__get_free_pages(GFP_NOWAIT | __GFP_NOWARN, 0);
+	batch = kmalloc(MAX_GATHER_BATCH_SZ, GFP_NOWAIT | __GFP_NOWARN);
 	if (!batch)
 		return false;
 
@@ -49,6 +50,8 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
 		free_pages_and_swap_cache(batch->pages, batch->nr);
 		batch->nr = 0;
+
+		cond_resched();
 	}
 	tlb->active = &tlb->local;
 }
@@ -59,7 +62,7 @@ static void tlb_batch_list_free(struct mmu_gather *tlb)
 
 	for (batch = tlb->local.next; batch; batch = next) {
 		next = batch->next;
-		free_pages((unsigned long)batch, 0);
+		kfree(batch);
 	}
 	tlb->local.next = NULL;
 }
-- 
2.31.1

