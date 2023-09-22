Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6969A7AB949
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 20:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbjIVSiw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 14:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjIVSit (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 14:38:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A4BFCA;
        Fri, 22 Sep 2023 11:38:43 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D1C7C212C5CF;
        Fri, 22 Sep 2023 11:38:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D1C7C212C5CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695407921;
        bh=cwj9fix3EwPTsj2jgOlURtKuqXv0kbtpiSQT3yeAd5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bDV1/EccyZmYnhMw8Pm3GCPS4nTyOqW7fgvhu24SAWYdnus3W1XJIdVj03GbdAjvl
         z/xSPNWPoBQxFHSu3cS47VO6sH2GXnDak8E8Rg06I/03ahhRFus1qaA5f44kie6LQB
         aEbD9TImzqZn4CjgjPYcekPJ8ccctFR5TAVij1AY=
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
Subject: [PATCH v3 09/15] Drivers: hv: Introduce hv_output_arg_exists in hv_common.c
Date:   Fri, 22 Sep 2023 11:38:29 -0700
Message-Id: <1695407915-12216-10-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1695407915-12216-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a more flexible approach for determining whether to allocate the
output page.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/hv_common.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index d346ce6adf00..89f5c1fb2a35 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -58,6 +58,14 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 void * __percpu *hyperv_pcpu_output_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
 
+/*
+ * Determine whether output arg is needed
+ */
+static inline bool hv_output_arg_exists(void)
+{
+	return hv_root_partition ? true : false;
+}
+
 static void hv_kmsg_dump_unregister(void);
 
 static struct ctl_table_header *hv_ctl_table_hdr;
@@ -342,10 +350,12 @@ int __init hv_common_init(void)
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
@@ -375,7 +385,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u8 **synic_eventring_tail;
 	u64 msr_vp_index;
 	gfp_t flags;
-	int pgcount = hv_root_partition ? 2 : 1;
+	int pgcount = hv_output_arg_exists() ? 2 : 1;
 	void *mem;
 	int ret;
 
@@ -393,9 +403,12 @@ int hv_common_cpu_init(unsigned int cpu)
 		if (!mem)
 			return -ENOMEM;
 
-		if (hv_root_partition) {
+		if (hv_output_arg_exists()) {
 			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
+		}
+
+		if (hv_root_partition) {
 			synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
 			*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT, sizeof(u8),
 							flags);
-- 
2.25.1

