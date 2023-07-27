Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054D2765C8D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 21:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjG0TzI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 15:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjG0TzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 15:55:00 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C6A030D4;
        Thu, 27 Jul 2023 12:54:59 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3D8EF2383EF5;
        Thu, 27 Jul 2023 12:54:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3D8EF2383EF5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690487697;
        bh=HPETpWBPXcktJiZxDGWrM7Bd3Q7E+nExHqjfNeCbApo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fTWMskoQmaiRKYdKSqF8KN7KIhXNYhlpbivfWu4+Oy1P7HYd9Z+BoDF38kI6TH7b6
         KqqJ1TpASd3aeiNA2Mak+9sdTcFrsiLjjsPwTmYiP1WS/42I6mYZDf5lr7zmQYZZV9
         S7qwQ8Z/HVglVTZKCWImoAOU4lsYLcQXP3OnRoiE=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH 08/15] Drivers: hv: Introduce per-cpu event ring tail
Date:   Thu, 27 Jul 2023 12:54:43 -0700
Message-Id: <1690487690-2428-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/hv/hv_common.c         | 25 +++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 9f9c3dc89bb2..99d9b262b8a7 100644
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
@@ -332,6 +342,8 @@ int __init hv_common_init(void)
 	if (hv_root_partition) {
 		hyperv_pcpu_output_arg = alloc_percpu(void *);
 		BUG_ON(!hyperv_pcpu_output_arg);
+		hv_synic_eventring_tail = alloc_percpu(u8 *);
+		BUG_ON(hv_synic_eventring_tail == NULL);
 	}
 
 	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
@@ -356,6 +368,7 @@ int __init hv_common_init(void)
 int hv_common_cpu_init(unsigned int cpu)
 {
 	void **inputarg, **outputarg;
+	u8 **synic_eventring_tail;
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
@@ -371,6 +384,14 @@ int hv_common_cpu_init(unsigned int cpu)
 	if (hv_root_partition) {
 		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+		*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT, sizeof(u8),
+						flags);
+
+		if (unlikely(!*synic_eventring_tail)) {
+			kfree(*inputarg);
+			return -ENOMEM;
+		}
 	}
 
 	msr_vp_index = hv_get_register(HV_MSR_VP_INDEX);
@@ -387,6 +408,7 @@ int hv_common_cpu_die(unsigned int cpu)
 {
 	unsigned long flags;
 	void **inputarg, **outputarg;
+	u8 **synic_eventring_tail;
 	void *mem;
 
 	local_irq_save(flags);
@@ -398,6 +420,9 @@ int hv_common_cpu_die(unsigned int cpu)
 	if (hv_root_partition) {
 		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*outputarg = NULL;
+		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+		kfree(*synic_eventring_tail);
+		*synic_eventring_tail = NULL;
 	}
 
 	local_irq_restore(flags);
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

