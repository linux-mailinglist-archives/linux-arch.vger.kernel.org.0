Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569D77AB956
	for <lists+linux-arch@lfdr.de>; Fri, 22 Sep 2023 20:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjIVSi4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 Sep 2023 14:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjIVSit (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2023 14:38:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 840A8C6;
        Fri, 22 Sep 2023 11:38:43 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7F852212C5D8;
        Fri, 22 Sep 2023 11:38:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7F852212C5D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695407921;
        bh=Fls3+8cOkcPPF+xp1YpnsiwxxsYXbao07BmTgws1cL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYkcLAgjqgDmIYJGjrrp4S1ulj0OljuzZ4Pdyq3ZVnpVCVcYYE0vpu3VxNOlOoCDE
         /kWd/tYR69xCh+unJ9nff1mK9f6QXofVVGsdUExMy+bITQkKtf6jTAabZj5sTRaOfn
         RM67+D6PGiVJQXIpKCUIw66ta8wMVKBS2NvWq8QM=
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
Subject: [PATCH v3 06/15] hyperv-tlfs: Introduce hv_status_to_string and hv_status_to_errno
Date:   Fri, 22 Sep 2023 11:38:26 -0700
Message-Id: <1695407915-12216-7-git-send-email-nunodasneves@linux.microsoft.com>
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

hv_status_to_errno translates hyperv statuses to linux error codes.
This is useful for returning something linux-friendly from a hypercall
helper function.

hv_status_to_string improves clarity of error messages.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/hv_init.c         |  2 +-
 arch/x86/hyperv/hv_proc.c         |  6 ++--
 include/asm-generic/hyperv-tlfs.h | 47 ++++++++++++++++++++++---------
 include/asm-generic/mshyperv.h    | 33 ++++++++++++++++++++++
 4 files changed, 71 insertions(+), 17 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 2b0124394e24..5b679bfbc7f7 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -386,7 +386,7 @@ static void __init hv_get_partition_id(void)
 	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
 	if (!hv_result_success(status)) {
 		/* No point in proceeding if this failed */
-		pr_err("Failed to get partition ID: %lld\n", status);
+		pr_err("Failed to get partition ID: %s\n", hv_status_to_string(status));
 		BUG();
 	}
 	hv_current_partition_id = output_page->partition_id;
diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 5ba5ca1b2089..ed80da64649e 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -144,9 +144,9 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 
 		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (!hv_result_success(status)) {
-				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
-				       lp_index, apic_id, status);
-				ret = hv_result(status);
+				pr_err("%s: cpu %u apic ID %u, %s\n", __func__,
+				       lp_index, apic_id, hv_status_to_string(status));
+				ret = hv_status_to_errno(status);
 			}
 			break;
 		}
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 1316584983c1..8d76661a8c9f 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -212,19 +212,40 @@ enum HV_GENERIC_SET_FORMAT {
 					 HV_HYPERCALL_RSVD2_MASK)
 
 /* hypercall status code */
-#define HV_STATUS_SUCCESS			0
-#define HV_STATUS_INVALID_HYPERCALL_CODE	2
-#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
-#define HV_STATUS_INVALID_ALIGNMENT		4
-#define HV_STATUS_INVALID_PARAMETER		5
-#define HV_STATUS_ACCESS_DENIED			6
-#define HV_STATUS_OPERATION_DENIED		8
-#define HV_STATUS_INSUFFICIENT_MEMORY		11
-#define HV_STATUS_INVALID_PORT_ID		17
-#define HV_STATUS_INVALID_CONNECTION_ID		18
-#define HV_STATUS_INSUFFICIENT_BUFFERS		19
-#define HV_STATUS_TIME_OUT                      120
-#define HV_STATUS_VTL_ALREADY_ENABLED		134
+#define __HV_STATUS_DEF(OP) \
+	OP(HV_STATUS_SUCCESS,				0x0) \
+	OP(HV_STATUS_INVALID_HYPERCALL_CODE,		0x2) \
+	OP(HV_STATUS_INVALID_HYPERCALL_INPUT,		0x3) \
+	OP(HV_STATUS_INVALID_ALIGNMENT,			0x4) \
+	OP(HV_STATUS_INVALID_PARAMETER,			0x5) \
+	OP(HV_STATUS_ACCESS_DENIED,			0x6) \
+	OP(HV_STATUS_INVALID_PARTITION_STATE,		0x7) \
+	OP(HV_STATUS_OPERATION_DENIED,			0x8) \
+	OP(HV_STATUS_UNKNOWN_PROPERTY,			0x9) \
+	OP(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	0xA) \
+	OP(HV_STATUS_INSUFFICIENT_MEMORY,		0xB) \
+	OP(HV_STATUS_INVALID_PARTITION_ID,		0xD) \
+	OP(HV_STATUS_INVALID_VP_INDEX,			0xE) \
+	OP(HV_STATUS_NOT_FOUND,				0x10) \
+	OP(HV_STATUS_INVALID_PORT_ID,			0x11) \
+	OP(HV_STATUS_INVALID_CONNECTION_ID,		0x12) \
+	OP(HV_STATUS_INSUFFICIENT_BUFFERS,		0x13) \
+	OP(HV_STATUS_NOT_ACKNOWLEDGED,			0x14) \
+	OP(HV_STATUS_INVALID_VP_STATE,			0x15) \
+	OP(HV_STATUS_NO_RESOURCES,			0x1D) \
+	OP(HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED,	0x20) \
+	OP(HV_STATUS_INVALID_LP_INDEX,			0x41) \
+	OP(HV_STATUS_INVALID_REGISTER_VALUE,		0x50) \
+	OP(HV_STATUS_TIME_OUT,				0x78) \
+	OP(HV_STATUS_CALL_PENDING,			0x79) \
+	OP(HV_STATUS_VTL_ALREADY_ENABLED,		0x86)
+
+#define __HV_MAKE_HV_STATUS_ENUM(NAME, VAL) NAME = (VAL),
+#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);
+
+enum hv_status {
+	__HV_STATUS_DEF(__HV_MAKE_HV_STATUS_ENUM)
+};
 
 /*
  * The Hyper-V TimeRefCount register and the TSC
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c9e166d73fca..81bacd4bce66 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -305,6 +305,39 @@ static inline int cpumask_to_vpset_skip(struct hv_vpset *vpset,
 	return __cpumask_to_vpset(vpset, cpus, func);
 }
 
+
+static inline int hv_status_to_errno(u64 hv_status)
+{
+	switch (hv_result(hv_status)) {
+	case HV_STATUS_SUCCESS:
+		return 0;
+	case HV_STATUS_INVALID_PARAMETER:
+	case HV_STATUS_UNKNOWN_PROPERTY:
+	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
+	case HV_STATUS_INVALID_VP_INDEX:
+	case HV_STATUS_INVALID_REGISTER_VALUE:
+	case HV_STATUS_INVALID_LP_INDEX:
+	case HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED:
+		return -EINVAL;
+	case HV_STATUS_ACCESS_DENIED:
+	case HV_STATUS_OPERATION_DENIED:
+		return -EACCES;
+	case HV_STATUS_NOT_ACKNOWLEDGED:
+	case HV_STATUS_INVALID_VP_STATE:
+	case HV_STATUS_INVALID_PARTITION_STATE:
+		return -EBADFD;
+	}
+	return -ENOTRECOVERABLE;
+}
+
+static inline const char *hv_status_to_string(u64 hv_status)
+{
+	switch (hv_result(hv_status)) {
+	__HV_STATUS_DEF(__HV_MAKE_HV_STATUS_CASE)
+	default : return "Unknown";
+	}
+}
+
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
-- 
2.25.1

