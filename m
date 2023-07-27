Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559CF765C91
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjG0TzJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 15:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjG0TzC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 15:55:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4ED6330DA;
        Thu, 27 Jul 2023 12:54:59 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 587962383EEE;
        Thu, 27 Jul 2023 12:54:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 587962383EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690487697;
        bh=NiawUFGJjTGeRxVPGVpR8qcuG+E+da5tkmNfJ3Hns0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSVqcTGs0sca4q1vp+eV4WQSiNAs5TTc52KIq6JJVagBdaj1RPI+DkDfSC/Fm/F8O
         wpb46/1BPJOv/z8+K67zWwmF47R9fGkNNI4W0IDqtNkii80KxCPzpaJEsEafEocxV6
         BGY+ThBmWfoHnQ9n3Fj1bZFPvCYWrTJAN8gZhcQk=
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
Subject: [PATCH 09/15] Drivers: hv: Introduce hv_output_arg_exists in hv_common
Date:   Thu, 27 Jul 2023 12:54:44 -0700
Message-Id: <1690487690-2428-10-git-send-email-nunodasneves@linux.microsoft.com>
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

This is a more flexible approach for determining whether to allocate the
output page.
This will be used in both mshv_vtl and root partition.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/hv_common.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 99d9b262b8a7..16f069beda78 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -57,6 +57,18 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 void * __percpu *hyperv_pcpu_output_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
 
+/*
+ * Determine whether output arg is in use, for allocation/deallocation
+ */
+static bool hv_output_arg_exists(void)
+{
+	bool ret = hv_root_partition ? true : false;
+#ifdef CONFIG_MSHV_VTL
+	ret = true;
+#endif
+	return ret;
+}
+
 static void hv_kmsg_dump_unregister(void);
 
 static struct ctl_table_header *hv_ctl_table_hdr;
@@ -338,10 +350,12 @@ int __init hv_common_init(void)
 	hyperv_pcpu_input_arg = alloc_percpu(void  *);
 	BUG_ON(!hyperv_pcpu_input_arg);
 
-	/* Allocate the per-CPU state for output arg for root */
-	if (hv_root_partition) {
+	if (hv_output_arg_exists()) {
 		hyperv_pcpu_output_arg = alloc_percpu(void *);
 		BUG_ON(!hyperv_pcpu_output_arg);
+	}
+
+	if (hv_root_partition) {
 		hv_synic_eventring_tail = alloc_percpu(u8 *);
 		BUG_ON(hv_synic_eventring_tail == NULL);
 	}
@@ -371,7 +385,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u8 **synic_eventring_tail;
 	u64 msr_vp_index;
 	gfp_t flags;
-	int pgcount = hv_root_partition ? 2 : 1;
+	int pgcount = hv_output_arg_exists() ? 2 : 1;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
@@ -381,9 +395,12 @@ int hv_common_cpu_init(unsigned int cpu)
 	if (!(*inputarg))
 		return -ENOMEM;
 
-	if (hv_root_partition) {
+	if (hv_output_arg_exists()) {
 		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+	}
+
+	if (hv_root_partition) {
 		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
 		*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT, sizeof(u8),
 						flags);
@@ -417,9 +434,12 @@ int hv_common_cpu_die(unsigned int cpu)
 	mem = *inputarg;
 	*inputarg = NULL;
 
-	if (hv_root_partition) {
+	if (hv_output_arg_exists()) {
 		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*outputarg = NULL;
+	}
+
+	if (hv_root_partition) {
 		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
 		kfree(*synic_eventring_tail);
 		*synic_eventring_tail = NULL;
-- 
2.25.1

