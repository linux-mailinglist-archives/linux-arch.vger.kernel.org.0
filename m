Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D8478009B
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 00:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355530AbjHQWCW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 18:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355500AbjHQWCC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 18:02:02 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2E4B30D4;
        Thu, 17 Aug 2023 15:02:00 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5EB47211F7D1;
        Thu, 17 Aug 2023 15:01:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5EB47211F7D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692309719;
        bh=C+17nMZAJITm0u+TCHonx/XXooVA0Wa8OFGW1qhWDmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ck+LmPFbbZNQXNiYhsQjgtQOafgVoOadTcJBAI+c/pC3DU6MruX9XaO/0bYHjydhC
         rS+dCxxkN+baJG72puwwFrGZuLLNRIOi9G9shtC+93NuqvWwyiLdebRn41EcyvyYrd
         nAV+Y/D7OpmIvj4knAMA482qJvRgwaVBkUNJdvK0=
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
Subject: [PATCH v2 06/15] hyperv-tlfs: Introduce hv_status_to_string and hv_status_to_errno
Date:   Thu, 17 Aug 2023 15:01:42 -0700
Message-Id: <1692309711-5573-7-git-send-email-nunodasneves@linux.microsoft.com>
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

hv_status_to_errno translates hyperv statuses to linux error codes.
This is useful for returning something linux-friendly from a hypercall
helper function.

hv_status_to_string improves clarity of error messages.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c         |  2 +-
 arch/x86/hyperv/hv_proc.c         |  6 ++---
 include/asm-generic/hyperv-tlfs.h | 45 ++++++++++++++++++++++---------
 include/asm-generic/mshyperv.h    | 33 +++++++++++++++++++++++
 4 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6c04b52f139b..5ce4aedc34d6 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -371,7 +371,7 @@ static void __init hv_get_partition_id(void)
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
index 8fc5e5a9d7cb..e7b468f06de7 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -212,18 +212,39 @@ enum HV_GENERIC_SET_FORMAT {
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
index 90fcbb95f1ee..bf87721828f6 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -300,6 +300,39 @@ static inline int cpumask_to_vpset_skip(struct hv_vpset *vpset,
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

