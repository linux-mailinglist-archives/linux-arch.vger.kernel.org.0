Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BAF4DC026
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 08:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiCQHan (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 03:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCQHam (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 03:30:42 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC0A0137F45;
        Thu, 17 Mar 2022 00:29:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxrxM74zJiQbsKAA--.8293S2;
        Thu, 17 Mar 2022 15:29:16 +0800 (CST)
From:   Jianxing Wang <wangjianxing@loongson.cn>
To:     peterz@infradead.org
Cc:     will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jianxing Wang <wangjianxing@loongson.cn>
Subject: [PATCH v2 1/1] mm/mmu_gather: limit free batch count and add schedule point in tlb_batch_pages_flush
Date:   Thu, 17 Mar 2022 03:28:57 -0400
Message-Id: <20220317072857.2635262-1-wangjianxing@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxrxM74zJiQbsKAA--.8293S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryDAF1xuF4xWFW7uFW8Xrb_yoW8CFykpa
        13WwsrCr4rG3yfAr42y3Wv9r9I9a90gFWrArWIyrs8A3sxJ3429F1vyw129rW3GrWrA3y3
        Xr4DXFyfuF4kZr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
PAGE_SIZE > 4K, here limit free batch count with 512.
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
Signed-off-by: Peter Zijlstra <peterz@infradead.org>

---
ChangeLog:
V1 -> V2: limit free batch count directly in tlb_batch_pages_flush
---
---
 mm/mmu_gather.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index afb7185ffdc4..a71924bd38c0 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -47,8 +47,20 @@ static void tlb_batch_pages_flush(struct mmu_gather *tlb)
 	struct mmu_gather_batch *batch;
 
 	for (batch = &tlb->local; batch && batch->nr; batch = batch->next) {
-		free_pages_and_swap_cache(batch->pages, batch->nr);
-		batch->nr = 0;
+		struct page **pages = batch->pages;
+
+		do {
+			/*
+			 * limit free batch count when PAGE_SIZE > 4K
+			 */
+			unsigned int nr = min(512U, batch->nr);
+
+			free_pages_and_swap_cache(pages, nr);
+			pages += nr;
+			batch->nr -= nr;
+
+			cond_resched();
+		} while (batch->nr);
 	}
 	tlb->active = &tlb->local;
 }
-- 
2.31.1

