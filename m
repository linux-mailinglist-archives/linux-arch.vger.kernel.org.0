Return-Path: <linux-arch+bounces-10829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B05AA61A7A
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C697ACCAF
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888CB2054F3;
	Fri, 14 Mar 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LJHeMn5y"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14319204F65;
	Fri, 14 Mar 2025 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980566; cv=none; b=TMUr4GrlS3yVoVr6WowvISqx4l62n+jKzDafcL0XS542NRtIA4rpXKhHYlKngtHhXYwuLhHm2DV+P8XicJYrlxCMYJONN4Nfxq+F/8Uis1Iyl5AYJJePxxiwwdpBa87AA66fpBUrbUUStbKsqWXG6Y8Yxd/c53DRazak2smKFAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980566; c=relaxed/simple;
	bh=V6/a/l1LIEQDtZUWC3im2eRpM0YRTiouLsYlGTsKSss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=K+dsbx4HhRFwQW0mAVn8z+laZbUWQJ+UGPeRBQdmqWsETr3ADzY+mi8W2FzQtO1koe7Kd0/Q5g6r6dDtSqe5At/k/w5eV1lHEU39h8K0mBsk9HRRvNrwhbPEDCAbH0EgIZcgYwwjrWur4He29zSfVFycgqaD0ShHcHGHZQvG2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LJHeMn5y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7AC4F203345B;
	Fri, 14 Mar 2025 12:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7AC4F203345B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741980564;
	bh=utJMkJZ9Gl5P1DrxVDG/0o+Zv8qkpo1fMxwwRlX4UR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJHeMn5yTvvBeQxzdXDTwSuQizpptvJ+Kxp/xmBk/lsEbzFRS7ETcGe8ZOP744RJ+
	 XEelsIIyeM2OzNUwiSuNWnVnmcDVt/YIGUPlmgXjMjIUyk3NOYuCbk3rUkXKFozzRg
	 l0j5z1FyepIE2G2v6FP0NcaDSOUzzfOwovKQeIsM=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com,
	ltykernel@gmail.com,
	stanislav.kinsburskiy@gmail.com,
	linux-acpi@vger.kernel.org,
	eahariha@linux.microsoft.com,
	jeff.johnson@oss.qualcomm.com
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
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com,
	prapal@linux.microsoft.com,
	anrayabh@linux.microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net
Subject: [PATCH v6 04/10] hyperv: Introduce hv_recommend_using_aeoi()
Date: Fri, 14 Mar 2025 12:28:50 -0700
Message-Id: <1741980536-3865-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Factor out the check for enabling auto eoi, to be reused in root
partition code.

No functional changes.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/hv/hv.c                | 12 +-----------
 include/asm-generic/mshyperv.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index a38f84548bc2..308c8f279df8 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -313,17 +313,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
-
-	/*
-	 * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
-	 * it doesn't provide a recommendation flag and AEOI must be disabled.
-	 */
-#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
-	shared_sint.auto_eoi =
-			!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
-#else
-	shared_sint.auto_eoi = 0;
-#endif
+	shared_sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_msr(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
 
 	/* Enable the global synic bit */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index c3697bc0598d..8519b8ec8e9d 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -77,6 +77,19 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 
+/*
+ * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
+ * it doesn't provide a recommendation flag and AEOI must be disabled.
+ */
+static inline bool hv_recommend_using_aeoi(void)
+{
+#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
+	return !(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
+#else
+	return false;
+#endif
+}
+
 static inline struct hv_proximity_domain_info hv_numa_node_to_pxm_info(int node)
 {
 	struct hv_proximity_domain_info pxm_info = {};
-- 
2.34.1


