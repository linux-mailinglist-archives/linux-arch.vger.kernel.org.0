Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF6C6D639F
	for <lists+linux-arch@lfdr.de>; Tue,  4 Apr 2023 15:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbjDDNoh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Apr 2023 09:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbjDDNoL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Apr 2023 09:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B95CAA
        for <linux-arch@vger.kernel.org>; Tue,  4 Apr 2023 06:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680615799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/5AmH2Sv0AFTXQ2yib2CUEzf+dnZkAWR6OfJs2RIyZU=;
        b=Mb9bMj2zzgtE7XDCfzXqBIiDVZgxtyYfpwxF/R+GSRJqFYJC8ELGzEJChBt2nxYT3s0K+C
        iYlRSHpiriVkbGg7iJ18E6565quh3dPkZn6Un7rW+2kDXzB1YOXayO7dLu5Ms+nHNuLgEV
        0u7qmuTZfewF1AvzovpCUz9lhysZICM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-175-4B_pK5R4OeycA85aaITT_g-1; Tue, 04 Apr 2023 09:43:15 -0400
X-MC-Unique: 4B_pK5R4OeycA85aaITT_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B2548030CD;
        Tue,  4 Apr 2023 13:43:13 +0000 (UTC)
Received: from ypodemsk.tlv.csb (unknown [10.39.194.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A2D02166B26;
        Tue,  4 Apr 2023 13:43:05 +0000 (UTC)
From:   Yair Podemsky <ypodemsk@redhat.com>
To:     linux@armlinux.org.uk, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, will@kernel.org,
        aneesh.kumar@linux.ibm.com, akpm@linux-foundation.org,
        peterz@infradead.org, arnd@arndb.de, keescook@chromium.org,
        paulmck@kernel.org, jpoimboe@kernel.org, samitolvanen@google.com,
        frederic@kernel.org, ardb@kernel.org,
        juerg.haefliger@canonical.com, rmk+kernel@armlinux.org.uk,
        geert+renesas@glider.be, tony@atomide.com,
        linus.walleij@linaro.org, sebastian.reichel@collabora.com,
        nick.hawkins@hpe.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, mtosatti@redhat.com, vschneid@redhat.com,
        dhildenb@redhat.com
Cc:     ypodemsk@redhat.com, alougovs@redhat.com
Subject: [PATCH 3/3] mm/mmu_gather: send tlb_remove_table_smp_sync IPI only to CPUs in kernel mode
Date:   Tue,  4 Apr 2023 16:42:24 +0300
Message-Id: <20230404134224.137038-4-ypodemsk@redhat.com>
In-Reply-To: <20230404134224.137038-1-ypodemsk@redhat.com>
References: <20230404134224.137038-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The tlb_remove_table_smp_sync IPI is used to ensure the outdated tlb page
is not currently being accessed and can be cleared.
This occurs once all CPUs have left the lockless gup code section.
If they reenter the page table walk, the pointers will be to the new
pages.
Therefore the IPI is only needed for CPUs in kernel mode.
By preventing the IPI from being sent to CPUs not in kernel mode,
Latencies are reduced.

Race conditions considerations:
The context state check is vulnerable to race conditions between the
moment the context state is read to when the IPI is sent (or not).

Here are these scenarios.
case 1:
CPU-A                                             CPU-B

                                                  state == CONTEXT_KERNEL
int state = atomic_read(&ct->state);
                                                  Kernel-exit:
                                                  state == CONTEXT_USER
if (state & CT_STATE_MASK == CONTEXT_KERNEL)

In this case, the IPI will be sent to CPU-B despite it is no longer in
the kernel. The consequence of which would be an unnecessary IPI being
handled by CPU-B, causing a reduction in latency.
This would have been the case every time without this patch.

case 2:
CPU-A                                             CPU-B

modify pagetables
tlb_flush (memory barrier)
                                                  state == CONTEXT_USER
int state = atomic_read(&ct->state);
                                                  Kernel-enter:
                                                  state == CONTEXT_KERNEL
                                                  READ(pagetable values)
if (state & CT_STATE_MASK == CONTEXT_USER)

In this case, the IPI will not be sent to CPU-B despite it returning to
the kernel and even reading the pagetable.
However since this CPU-B has entered the pagetable after the
modification it is reading the new, safe values.

The only case when this IPI is truly necessary is when CPU-B has entered
the lockless gup code section before the pagetable modifications and
has yet to exit them, in which case it is still in the kernel.

Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
---
 mm/mmu_gather.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 5ea9be6fb87c..731d955e152d 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -9,6 +9,7 @@
 #include <linux/smp.h>
 #include <linux/swap.h>
 #include <linux/rmap.h>
+#include <linux/context_tracking_state.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -191,6 +192,20 @@ static void tlb_remove_table_smp_sync(void *arg)
 	/* Simply deliver the interrupt */
 }
 
+
+#ifdef CONFIG_CONTEXT_TRACKING
+static bool cpu_in_kernel(int cpu, void *info)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+	int state = atomic_read(&ct->state);
+	/* will return true only for cpus in kernel space */
+	return state & CT_STATE_MASK == CONTEXT_KERNEL;
+}
+#define CONTEXT_PREDICATE cpu_in_kernel
+#else
+#define CONTEXT_PREDICATE NULL
+#endif /* CONFIG_CONTEXT_TRACKING */
+
 #ifdef CONFIG_ARCH_HAS_CPUMASK_BITS
 #define REMOVE_TABLE_IPI_MASK mm_cpumask(mm)
 #else
@@ -206,8 +221,8 @@ void tlb_remove_table_sync_one(struct mm_struct *mm)
 	 * It is however sufficient for software page-table walkers that rely on
 	 * IRQ disabling.
 	 */
-	on_each_cpu_mask(REMOVE_TABLE_IPI_MASK, tlb_remove_table_smp_sync,
-			NULL, true);
+	on_each_cpu_cond_mask(CONTEXT_PREDICATE, tlb_remove_table_smp_sync,
+			NULL, true, REMOVE_TABLE_IPI_MASK);
 }
 
 static void tlb_remove_table_rcu(struct rcu_head *head)
-- 
2.31.1

