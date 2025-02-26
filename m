Return-Path: <linux-arch+bounces-10398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF36A46F14
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEED518867AF
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA6D25F794;
	Wed, 26 Feb 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AV3Efyp2"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DA41C6FF1;
	Wed, 26 Feb 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611341; cv=none; b=ofPJ35Mg9xWe58uvc0g8cLaMoHexBaHzKKixCXzzn52W+LvnBsIwQ6vRBhqMTXv/wW3NbARZ7rBlNAft6I9XOyTxME2VOqoNVX1yfBJnrUHKnTD4Cxasd+ngMc0+vGNFcDFs8LKmkv/Xqzmm3xNaR5TyXwS+/wfi5wBNVB9i7vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611341; c=relaxed/simple;
	bh=se8xPJh9ifrXytq1K1xqCf/FiD0K5jz05hbJQTotQww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cbKgbT/+iGLCP+6onJ/ySk8T1dhAtzco6Y7FMDbH115G6G4yOGLQ9QiF8zxkqetNHeZoYOYxXDlMpCpUJ14gEt85mX8SMG3yv6sh1/WYyeGZSIWVNOedV72sfrATVnpzFMbup0oglFvYDlPn2eTu+eALN5YmW1lJyvZcx3i2x+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AV3Efyp2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 93ABE210EAC3;
	Wed, 26 Feb 2025 15:08:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93ABE210EAC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740611338;
	bh=jCprf6m6V/RVFEkrjK2ZIkjoEDCOU2UlWDGLVJXKEkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AV3Efyp2O59YTtjwzWU+O9Wq6+cFvOyZ+rKo2Fd/hqgwefW2KANMlF7jVWafRYUJn
	 cHXs9J9Te3GbK1v91/SlogkBSAsXheJOXNGiHC3RrxtwUIDCXlWiKUXEvO3g98FtS1
	 9kxoXPeXrv24zBnRfTZazvkgQXEH1LGG1Gm847bU=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com,
	stanislav.kinsburskiy@gmail.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com,
	prapal@linux.microsoft.com,
	muislam@microsoft.com,
	anrayabh@linux.microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net
Subject: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
Date: Wed, 26 Feb 2025 15:07:55 -0800
Message-Id: <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Introduce hv_result_to_string() for this purpose. This allows
hypercall failures to be debugged more easily with dmesg.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/hv_common.c         | 65 ++++++++++++++++++++++++++++++++++
 drivers/hv/hv_proc.c           | 13 ++++---
 include/asm-generic/mshyperv.h |  1 +
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 9804adb4cc56..ce20818688fe 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -740,3 +740,68 @@ void hv_identify_partition_type(void)
 			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
 	}
 }
+
+const char *hv_result_to_string(u64 hv_status)
+{
+	switch (hv_result(hv_status)) {
+	case HV_STATUS_SUCCESS:
+		return "HV_STATUS_SUCCESS";
+	case HV_STATUS_INVALID_HYPERCALL_CODE:
+		return "HV_STATUS_INVALID_HYPERCALL_CODE";
+	case HV_STATUS_INVALID_HYPERCALL_INPUT:
+		return "HV_STATUS_INVALID_HYPERCALL_INPUT";
+	case HV_STATUS_INVALID_ALIGNMENT:
+		return "HV_STATUS_INVALID_ALIGNMENT";
+	case HV_STATUS_INVALID_PARAMETER:
+		return "HV_STATUS_INVALID_PARAMETER";
+	case HV_STATUS_ACCESS_DENIED:
+		return "HV_STATUS_ACCESS_DENIED";
+	case HV_STATUS_INVALID_PARTITION_STATE:
+		return "HV_STATUS_INVALID_PARTITION_STATE";
+	case HV_STATUS_OPERATION_DENIED:
+		return "HV_STATUS_OPERATION_DENIED";
+	case HV_STATUS_UNKNOWN_PROPERTY:
+		return "HV_STATUS_UNKNOWN_PROPERTY";
+	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
+		return "HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE";
+	case HV_STATUS_INSUFFICIENT_MEMORY:
+		return "HV_STATUS_INSUFFICIENT_MEMORY";
+	case HV_STATUS_INVALID_PARTITION_ID:
+		return "HV_STATUS_INVALID_PARTITION_ID";
+	case HV_STATUS_INVALID_VP_INDEX:
+		return "HV_STATUS_INVALID_VP_INDEX";
+	case HV_STATUS_NOT_FOUND:
+		return "HV_STATUS_NOT_FOUND";
+	case HV_STATUS_INVALID_PORT_ID:
+		return "HV_STATUS_INVALID_PORT_ID";
+	case HV_STATUS_INVALID_CONNECTION_ID:
+		return "HV_STATUS_INVALID_CONNECTION_ID";
+	case HV_STATUS_INSUFFICIENT_BUFFERS:
+		return "HV_STATUS_INSUFFICIENT_BUFFERS";
+	case HV_STATUS_NOT_ACKNOWLEDGED:
+		return "HV_STATUS_NOT_ACKNOWLEDGED";
+	case HV_STATUS_INVALID_VP_STATE:
+		return "HV_STATUS_INVALID_VP_STATE";
+	case HV_STATUS_NO_RESOURCES:
+		return "HV_STATUS_NO_RESOURCES";
+	case HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED:
+		return "HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED";
+	case HV_STATUS_INVALID_LP_INDEX:
+		return "HV_STATUS_INVALID_LP_INDEX";
+	case HV_STATUS_INVALID_REGISTER_VALUE:
+		return "HV_STATUS_INVALID_REGISTER_VALUE";
+	case HV_STATUS_OPERATION_FAILED:
+		return "HV_STATUS_OPERATION_FAILED";
+	case HV_STATUS_TIME_OUT:
+		return "HV_STATUS_TIME_OUT";
+	case HV_STATUS_CALL_PENDING:
+		return "HV_STATUS_CALL_PENDING";
+	case HV_STATUS_VTL_ALREADY_ENABLED:
+		return "HV_STATUS_VTL_ALREADY_ENABLED";
+	default:
+		return "Unknown";
+	};
+	return "Unknown";
+}
+EXPORT_SYMBOL_GPL(hv_result_to_string);
+
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 2fae18e4f7d2..8fc30f509fa7 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -87,7 +87,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 				     page_count, 0, input_page, NULL);
 	local_irq_restore(flags);
 	if (!hv_result_success(status)) {
-		pr_err("Failed to deposit pages: %lld\n", status);
+		pr_err("%s: Failed to deposit pages: %s\n", __func__,
+		       hv_result_to_string(status));
 		ret = hv_result_to_errno(status);
 		goto err_free_allocations;
 	}
@@ -137,8 +138,9 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 
 		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (!hv_result_success(status)) {
-				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
-				       lp_index, apic_id, status);
+				pr_err("%s: cpu %u apic ID %u, %s\n",
+				       __func__, lp_index, apic_id,
+				       hv_result_to_string(status));
 				ret = hv_result_to_errno(status);
 			}
 			break;
@@ -179,8 +181,9 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 
 		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
 			if (!hv_result_success(status)) {
-				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
-				       vp_index, flags, status);
+				pr_err("%s: vcpu %u, lp %u, %s\n",
+				       __func__, vp_index, flags,
+				       hv_result_to_string(status));
 				ret = hv_result_to_errno(status);
 			}
 			break;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index b13b0cda4ac8..dc4729dba9ef 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -298,6 +298,7 @@ static inline int cpumask_to_vpset_skip(struct hv_vpset *vpset,
 	return __cpumask_to_vpset(vpset, cpus, func);
 }
 
+const char *hv_result_to_string(u64 hv_status);
 int hv_result_to_errno(u64 status);
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 bool hv_is_hyperv_initialized(void);
-- 
2.34.1


