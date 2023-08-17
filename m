Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E640A780094
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 00:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355524AbjHQWCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 18:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355502AbjHQWCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 18:02:03 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7D213580;
        Thu, 17 Aug 2023 15:02:01 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 92DFD211F7D8;
        Thu, 17 Aug 2023 15:01:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92DFD211F7D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692309719;
        bh=kmnPKnD1YlAKNPwI6Gp4OR/KDSttof8GbD9MPFl6UlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cvobZ94neO7cVcjeNPVqUzM/pqOQu2j4d3vLWUmAffoHeWyh25TtRDyUwlzcpgMBW
         P7gzWPu3NJ/nGAMjbT7OS47wX9Fl+lxoADbJSTB2NIrbfwxggJQwTtnyukfGVkTaiG
         DhekkKHKNUJthpTl1ebrFYQKj+7GouvE+zyImC0g=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v2 08/15] Drivers: hv: Introduce per-cpu event ring tail
Date:   Thu, 17 Aug 2023 15:01:44 -0700
Message-Id: <1692309711-5573-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a pointer hv_synic_eventring_tail to track the tail pointer for the
SynIC event ring buffer for each SINT.

This will be used by the mshv driver, but must be tracked independently
since the driver module could be removed and re-inserted.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/hv_common.c         | 28 ++++++++++++++++++++++++++--
 include/asm-generic/mshyperv.h |  2 ++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 7364ef027cd7..0dd3091beef3 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -61,6 +61,16 @@ static void hv_kmsg_dump_unregister(void);
 
 static struct ctl_table_header *hv_ctl_table_hdr;
 
+/*
+ * Per-cpu array holding the tail pointer for the SynIC event ring buffer
+ * for each SINT.
+ *
+ * We cannot maintain this in mshv driver because the tail pointer should
+ * persist even if the mshv driver is unloaded.
+ */
+u8 __percpu **hv_synic_eventring_tail;
+EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
+
 /*
  * Hyper-V specific initialization and shutdown code that is
  * common across all architectures.  Called from architecture
@@ -83,6 +93,9 @@ void __init hv_common_free(void)
 
 	free_percpu(hyperv_pcpu_input_arg);
 	hyperv_pcpu_input_arg = NULL;
+
+	free_percpu(hv_synic_eventring_tail);
+	hv_synic_eventring_tail = NULL;
 }
 
 /*
@@ -332,6 +345,8 @@ int __init hv_common_init(void)
 	if (hv_root_partition) {
 		hyperv_pcpu_output_arg = alloc_percpu(void *);
 		BUG_ON(!hyperv_pcpu_output_arg);
+		hv_synic_eventring_tail = alloc_percpu(u8 *);
+		BUG_ON(hv_synic_eventring_tail == NULL);
 	}
 
 	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
@@ -356,6 +371,7 @@ int __init hv_common_init(void)
 int hv_common_cpu_init(unsigned int cpu)
 {
 	void **inputarg, **outputarg;
+	u8 **synic_eventring_tail;
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
@@ -366,8 +382,8 @@ int hv_common_cpu_init(unsigned int cpu)
 	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	/*
-	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
-	 * allocated if this CPU was previously online and then taken offline
+	 * The per-cpu memory is already allocated if this CPU was previously
+	 * online and then taken offline
 	 */
 	if (!*inputarg) {
 		*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
@@ -377,6 +393,14 @@ int hv_common_cpu_init(unsigned int cpu)
 		if (hv_root_partition) {
 			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+			synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+			*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT, sizeof(u8),
+							flags);
+
+			if (unlikely(!*synic_eventring_tail)) {
+				kfree(*inputarg);
+				return -ENOMEM;
+			}
 		}
 	}
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 0c94d20b4d44..9118d678b27a 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -73,6 +73,8 @@ extern bool hv_nested;
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
 
+extern u8 __percpu **hv_synic_eventring_tail;
+
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
-- 
2.25.1

