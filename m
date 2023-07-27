Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D32765C7F
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjG0TzA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 15:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjG0Ty7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 15:54:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42F562D7B;
        Thu, 27 Jul 2023 12:54:57 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id AA90623834D8;
        Thu, 27 Jul 2023 12:54:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA90623834D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690487696;
        bh=lX/Yd7rNSCr3YxLFCMt412GXyk0hTSxOqqx3DJg2Au0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKg2RCzpK8sWiO1Zk8WE7f2f+pRbakMoY4KRfHPmRzADZqhlgwFznmmpm2xPHcmdf
         kyyYQD3dD4x38M5X7P3WBiFbQno75H1CNM9xiNbskS4r44H+uR5Uwhj9LX6vf/m6oA
         9pGEs2KT9vdqOA6pnkwVFUcKqPmhwEAvgbuDq5FY=
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
Subject: [PATCH 03/15] mshyperv: Introduce numa_node_to_proximity_domain_info
Date:   Thu, 27 Jul 2023 12:54:38 -0700
Message-Id: <1690487690-2428-4-git-send-email-nunodasneves@linux.microsoft.com>
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

Factor out logic for converting numa node to proximity domain info into
a helper function, and export it.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/hv_proc.c      |  8 ++------
 drivers/acpi/numa/srat.c       |  1 +
 include/asm-generic/mshyperv.h | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 68a0843d4750..5ba5ca1b2089 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -121,7 +121,6 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 	u64 status;
 	unsigned long flags;
 	int ret = HV_STATUS_SUCCESS;
-	int pxm = node_to_pxm(node);
 
 	/*
 	 * When adding a logical processor, the hypervisor may return
@@ -137,11 +136,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 
 		input->lp_index = lp_index;
 		input->apic_id = apic_id;
-		input->flags = 0;
-		input->proximity_domain_info.domain_id = pxm;
-		input->proximity_domain_info.flags.reserved = 0;
-		input->proximity_domain_info.flags.proximity_info_valid = 1;
-		input->proximity_domain_info.flags.proximity_preferred = 1;
+		input->proximity_domain_info =
+			numa_node_to_proximity_domain_info(node);
 		status = hv_do_hypercall(HVCALL_ADD_LOGICAL_PROCESSOR,
 					 input, output);
 		local_irq_restore(flags);
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 1f4fc5f8a819..0cf9f0574495 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -48,6 +48,7 @@ int node_to_pxm(int node)
 		return PXM_INVAL;
 	return node_to_pxm_map[node];
 }
+EXPORT_SYMBOL(node_to_pxm);
 
 static void __acpi_map_pxm_to_node(int pxm, int node)
 {
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 233c976344e5..447e7ebe67ee 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/atomic.h>
 #include <linux/bitops.h>
+#include <acpi/acpi_numa.h>
 #include <linux/cpumask.h>
 #include <linux/nmi.h>
 #include <asm/ptrace.h>
@@ -28,6 +29,23 @@
 
 #define VTPM_BASE_ADDRESS 0xfed40000
 
+static inline union hv_proximity_domain_info
+numa_node_to_proximity_domain_info(int node)
+{
+	union hv_proximity_domain_info proximity_domain_info;
+
+	if (node != NUMA_NO_NODE) {
+		proximity_domain_info.domain_id = node_to_pxm(node);
+		proximity_domain_info.flags.reserved = 0;
+		proximity_domain_info.flags.proximity_info_valid = 1;
+		proximity_domain_info.flags.proximity_preferred = 1;
+	} else {
+		proximity_domain_info.as_uint64 = 0;
+	}
+
+	return proximity_domain_info;
+}
+
 struct ms_hyperv_info {
 	u32 features;
 	u32 priv_high;
-- 
2.25.1

