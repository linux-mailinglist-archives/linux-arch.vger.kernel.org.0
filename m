Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A60A73A951
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 22:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjFVUH3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 16:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVUH3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 16:07:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CABD1FF0;
        Thu, 22 Jun 2023 13:07:26 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id B368821C20B1;
        Thu, 22 Jun 2023 13:07:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B368821C20B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687464445;
        bh=G/L27QpOPIVcLupzo2qhywZyKrjocR4zy910V2nTJ3Q=;
        h=From:To:Subject:Date:From;
        b=CHwBNOAGtb54sJpZs0trgyKQPSn1QcomzqZfVavEKCk6c383qsZXoKkCBmQqXTgon
         PL4SJuAZBz7cyuCavNNvjChhWlkcoKJbiuQk+Q5xs261zb11r/1FxlgIgcH09kI5z3
         WgnVT1ElRsYbOqgzp9ckzda3IwyTYcBY5ORKDpLk=
From:   Kameron Carr <kameroncarr@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH] Drivers: hv: Change hv_free_hyperv_page() to take void * argument
Date:   Thu, 22 Jun 2023 13:07:07 -0700
Message-Id: <1687464427-4722-1-git-send-email-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Currently hv_free_hyperv_page() takes an unsigned long argument, which
is inconsistent with the void * return value from the corresponding
hv_alloc_hyperv_page() function and variants. This creates unnecessary
extra casting.

Change the hv_free_hyperv_page() argument type to void *.
Also remove redundant casts from invocations of
hv_alloc_hyperv_page() and variants.
---
 drivers/hv/connection.c        | 13 ++++++-------
 drivers/hv/hv_common.c         | 10 +++++-----
 include/asm-generic/mshyperv.h |  2 +-
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 5978e9d..ebf15f3 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -209,8 +209,7 @@ int vmbus_connect(void)
 	 * Setup the vmbus event connection for channel interrupt
 	 * abstraction stuff
 	 */
-	vmbus_connection.int_page =
-	(void *)hv_alloc_hyperv_zeroed_page();
+	vmbus_connection.int_page = hv_alloc_hyperv_zeroed_page();
 	if (vmbus_connection.int_page == NULL) {
 		ret = -ENOMEM;
 		goto cleanup;
@@ -225,8 +224,8 @@ int vmbus_connect(void)
 	 * Setup the monitor notification facility. The 1st page for
 	 * parent->child and the 2nd page for child->parent
 	 */
-	vmbus_connection.monitor_pages[0] = (void *)hv_alloc_hyperv_page();
-	vmbus_connection.monitor_pages[1] = (void *)hv_alloc_hyperv_page();
+	vmbus_connection.monitor_pages[0] = hv_alloc_hyperv_page();
+	vmbus_connection.monitor_pages[1] = hv_alloc_hyperv_page();
 	if ((vmbus_connection.monitor_pages[0] == NULL) ||
 	    (vmbus_connection.monitor_pages[1] == NULL)) {
 		ret = -ENOMEM;
@@ -333,15 +332,15 @@ void vmbus_disconnect(void)
 		destroy_workqueue(vmbus_connection.work_queue);
 
 	if (vmbus_connection.int_page) {
-		hv_free_hyperv_page((unsigned long)vmbus_connection.int_page);
+		hv_free_hyperv_page(vmbus_connection.int_page);
 		vmbus_connection.int_page = NULL;
 	}
 
 	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], 1);
 	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], 1);
 
-	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[0]);
-	hv_free_hyperv_page((unsigned long)vmbus_connection.monitor_pages[1]);
+	hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
+	hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
 	vmbus_connection.monitor_pages[0] = NULL;
 	vmbus_connection.monitor_pages[1] = NULL;
 }
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 542a1d5..6a2258f 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -115,12 +115,12 @@ void *hv_alloc_hyperv_zeroed_page(void)
 }
 EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
 
-void hv_free_hyperv_page(unsigned long addr)
+void hv_free_hyperv_page(void *addr)
 {
 	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		free_page(addr);
+		free_page((unsigned long)addr);
 	else
-		kfree((void *)addr);
+		kfree(addr);
 }
 EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
 
@@ -253,7 +253,7 @@ static void hv_kmsg_dump_unregister(void)
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &hyperv_panic_report_block);
 
-	hv_free_hyperv_page((unsigned long)hv_panic_page);
+	hv_free_hyperv_page(hv_panic_page);
 	hv_panic_page = NULL;
 }
 
@@ -270,7 +270,7 @@ static void hv_kmsg_dump_register(void)
 	ret = kmsg_dump_register(&hv_kmsg_dumper);
 	if (ret) {
 		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
-		hv_free_hyperv_page((unsigned long)hv_panic_page);
+		hv_free_hyperv_page(hv_panic_page);
 		hv_panic_page = NULL;
 	}
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 402a8c1..a8f4b65 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -190,7 +190,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 
 void *hv_alloc_hyperv_page(void);
 void *hv_alloc_hyperv_zeroed_page(void);
-void hv_free_hyperv_page(unsigned long addr);
+void hv_free_hyperv_page(void *addr);
 
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
-- 
1.8.3.1

