Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE77B3979
	for <lists+linux-arch@lfdr.de>; Fri, 29 Sep 2023 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjI2SCR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Sep 2023 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbjI2SCI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Sep 2023 14:02:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3958FCDF;
        Fri, 29 Sep 2023 11:02:05 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3086D20B74CF;
        Fri, 29 Sep 2023 11:01:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3086D20B74CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696010517;
        bh=j5sW5mMEoYHm8DyqU1vnEleiYv6JR/wYpPjIO4U9RC0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gcw2f4Rmk1aH40/en2JxNjJBJcKDjpLXuuh3DYUe8udcIismZkOgUet1zt/OKXKek
         dy00lZWPrIIaYQ4/ud3woRFPajdNMYXJUCLS6BD46uLttFnhpuvJBtKxtpXnCIvdBZ
         UFj/K5W60c4xG3HMHANxWV1clCicz3C+8O0WE150=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v4 08/15] Drivers: hv: Introduce per-cpu event ring tail
Date:   Fri, 29 Sep 2023 11:01:34 -0700
Message-Id: <1696010501-24584-9-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
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
Reviewed-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/hv_common.c         | 28 ++++++++++++++++++++++++++--
 include/asm-generic/mshyperv.h |  2 ++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 9d9f6f90f99e..39077841d518 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -62,6 +62,16 @@ static void hv_kmsg_dump_unregister(void);
 
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
@@ -84,6 +94,9 @@ void __init hv_common_free(void)
 
 	free_percpu(hyperv_pcpu_input_arg);
 	hyperv_pcpu_input_arg = NULL;
+
+	free_percpu(hv_synic_eventring_tail);
+	hv_synic_eventring_tail = NULL;
 }
 
 /*
@@ -333,6 +346,8 @@ int __init hv_common_init(void)
 	if (hv_root_partition) {
 		hyperv_pcpu_output_arg = alloc_percpu(void *);
 		BUG_ON(!hyperv_pcpu_output_arg);
+		hv_synic_eventring_tail = alloc_percpu(u8 *);
+		BUG_ON(hv_synic_eventring_tail == NULL);
 	}
 
 	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
@@ -357,6 +372,7 @@ int __init hv_common_init(void)
 int hv_common_cpu_init(unsigned int cpu)
 {
 	void **inputarg, **outputarg;
+	u8 **synic_eventring_tail;
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
@@ -369,8 +385,8 @@ int hv_common_cpu_init(unsigned int cpu)
 	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	/*
-	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
-	 * allocated if this CPU was previously online and then taken offline
+	 * The per-cpu memory is already allocated if this CPU was previously
+	 * online and then taken offline
 	 */
 	if (!*inputarg) {
 		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
@@ -380,6 +396,14 @@ int hv_common_cpu_init(unsigned int cpu)
 		if (hv_root_partition) {
 			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
+			synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+			*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT, sizeof(u8),
+							flags);
+
+			if (unlikely(!*synic_eventring_tail)) {
+				kfree(mem);
+				return -ENOMEM;
+			}
 		}
 
 		if (!ms_hyperv.paravisor_present &&
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 4f2bb6099063..4e49fd662b2b 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -77,6 +77,8 @@ extern bool hv_nested;
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
 
+extern u8 __percpu **hv_synic_eventring_tail;
+
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 bool hv_isolation_type_snp(void);
-- 
2.25.1

