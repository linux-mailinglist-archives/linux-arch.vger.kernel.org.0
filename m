Return-Path: <linux-arch+bounces-10259-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6E5A3E3FA
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 19:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C9F3B1F6F
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2025 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBD421505F;
	Thu, 20 Feb 2025 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="riMuDRXF"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4783B1EF0AD;
	Thu, 20 Feb 2025 18:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076427; cv=none; b=vCteLAAfVW1OwceXmOclCDsk4KKS3MvUxFe9ndsfOQd9RUtaxeWwmGwz3c8ddHKoCHlzNRmqimkLJ4IAOVOALO5WV35lzt9KYqATYEpd5yq1WjSU/5ISXw+R/+X7PxKuYjJSJj9mwB3Wk+OmQ51T5yPBW5whrPVF8l0fJZiOgc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076427; c=relaxed/simple;
	bh=dCo5tf5oqq8DnoKMYcjEAOuoFJXVw82+a6wUFM4UunU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nnDVSFAcIAb5cm7g2mHSM8M/1kU7ycXId41L7Ih5yNfPFVnaklo3C7m0cx/9fivFaAhOD+wzE31kuZ7D644lc4o5CGCskuF6DmLDzBTrQthBuVbiwFbHRJ861aeUeqvWiOwh7y2LeoWo1ht2SO+m6c8C4u50nPwG7ru9xEt9zg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=riMuDRXF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id DFEFA2059191;
	Thu, 20 Feb 2025 10:33:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DFEFA2059191
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740076417;
	bh=0fn8eyV18yxCTnMNhouAa9P8o6Ll/x9PQQR7/BYuNOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=riMuDRXFbteJfQ7inyNmRQExFTEvEXiXAy3qM6ZQ95qbyidI9rpJRsPh2YmLPLk/I
	 qLHcAofmgSJau6/E6D9iFUvZbehJdiiddBcRz+ysHVyHLv1zQ6JQKiq07RBjd0zoa/
	 +rQggpMdeN9BXk1J+5Zl5FZAhiA0XVVTYYWEFm0s=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	iommu@lists.linux.dev,
	mhklinux@outlook.com,
	eahariha@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: [PATCH v2 1/3] hyperv: Convert hypercall statuses to linux error codes
Date: Thu, 20 Feb 2025 10:33:14 -0800
Message-Id: <1740076396-15086-2-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1740076396-15086-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Return linux-friendly error codes from hypercall helper functions,
which allows them to be used more flexibly.

Introduce hv_result_to_errno() for this purpose, which also handles
the special value U64_MAX returned from hv_do_hypercall().

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/hv_common.c         | 34 ++++++++++++++++++++++++++++++++++
 drivers/hv/hv_proc.c           |  6 +++---
 include/asm-generic/mshyperv.h |  1 +
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ee3083937b4f..2120aead98d9 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -683,3 +683,37 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 	return HV_STATUS_INVALID_PARAMETER;
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
+
+/* Convert a hypercall result into a linux-friendly error code. */
+int hv_result_to_errno(u64 status)
+{
+	/* hv_do_hypercall() may return U64_MAX, hypercalls aren't possible */
+	if (unlikely(status == U64_MAX))
+		return -EOPNOTSUPP;
+	/*
+	 * A failed hypercall is usually only recoverable (or loggable) near
+	 * the call site where the HV_STATUS_* code is known. So the errno
+	 * it gets converted to is not too useful further up the stack.
+	 * Provice a few mappings that could be useful, and revert to -EIO
+	 * as a fallback.
+	 */
+	switch (hv_result(status)) {
+	case HV_STATUS_SUCCESS:
+		return 0;
+	case HV_STATUS_INVALID_HYPERCALL_CODE:
+	case HV_STATUS_INVALID_HYPERCALL_INPUT:
+	case HV_STATUS_INVALID_PARAMETER:
+	case HV_STATUS_INVALID_PARTITION_ID:
+	case HV_STATUS_INVALID_VP_INDEX:
+	case HV_STATUS_INVALID_PORT_ID:
+	case HV_STATUS_INVALID_CONNECTION_ID:
+	case HV_STATUS_INVALID_LP_INDEX:
+	case HV_STATUS_INVALID_REGISTER_VALUE:
+		return -EINVAL;
+	case HV_STATUS_INSUFFICIENT_MEMORY:
+		return -ENOMEM;
+	default:
+		break;
+	}
+	return -EIO;
+}
diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 3e410489f480..72b09f1cfa3e 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -88,7 +88,7 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	local_irq_restore(flags);
 	if (!hv_result_success(status)) {
 		pr_err("Failed to deposit pages: %lld\n", status);
-		ret = hv_result(status);
+		ret = hv_result_to_errno(status);
 		goto err_free_allocations;
 	}
 
@@ -139,7 +139,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 			if (!hv_result_success(status)) {
 				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
 				       lp_index, apic_id, status);
-				ret = hv_result(status);
+				ret = hv_result_to_errno(status);
 			}
 			break;
 		}
@@ -181,7 +181,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
 			if (!hv_result_success(status)) {
 				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
 				       vp_index, flags, status);
-				ret = hv_result(status);
+				ret = hv_result_to_errno(status);
 			}
 			break;
 		}
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 7adc10a4fa3e..3f115e2bcdaa 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -297,6 +297,7 @@ static inline int cpumask_to_vpset_skip(struct hv_vpset *vpset,
 	return __cpumask_to_vpset(vpset, cpus, func);
 }
 
+int hv_result_to_errno(u64 status);
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
-- 
2.34.1


