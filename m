Return-Path: <linux-arch+bounces-10834-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45AA61A8D
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904147ACEEE
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E56F205E30;
	Fri, 14 Mar 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QSqgRN2e"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801052054EB;
	Fri, 14 Mar 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980568; cv=none; b=MOsv1cm+yHYmxFdm1hyCNcRJff+gR2uAxI7XmwvjI/Z3FLzuc7IJhGzaMkTGHZBWhTpU7CGbnpwp82qb+rX9XaTV/BGwXh1tNHWVw8Btv68apQ6X02IsOsZ5ef+Wl8dNtb/gSI5j1LwTerXLBkbwl5gJGpukuuv+gxq0D909qYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980568; c=relaxed/simple;
	bh=1qlqOfy+n72C/2+/c1TIJejNxLH0AWzHRl2Ri2NdvHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fdTmIzCPgmXXyz46SHvYrNuIIQGvzuyUv6X5y6rRVV+3uNS6+Ib5QV7eZ8PxO1zH+4STMe6gXAFfAI5V4KvXoEN9m5iOuUYM4UMSoVNNpboFd1/nE+3tQYPJ9mFlbcG3vTiMxBpc2hITgWDpnZ5Pd/rlGReTdLotNMEUGU233ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QSqgRN2e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D29982038A52;
	Fri, 14 Mar 2025 12:29:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D29982038A52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741980564;
	bh=oDrv/uiFf6I/CBc/jkbxtnGgzXTM90PbsfJSUc1CXPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSqgRN2eSFL9v1ZQFtA0kI8kpOs8wA979X32O4UUnS5mMT/uW0RWZocOW8laLG7P0
	 x/M05Uy7BtaWIvlNN0C91FhL/jQ/4C3EWFQoTH7yI3r6pIruBlcldN7eQqu4PVQQXa
	 DCo9oCJycJG9dspA4lgqMWph7gXjWmnIFLV6BEMk=
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
Subject: [PATCH v6 07/10] Drivers: hv: Introduce per-cpu event ring tail
Date: Fri, 14 Mar 2025 12:28:53 -0700
Message-Id: <1741980536-3865-8-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Add a pointer hv_synic_eventring_tail to track the tail pointer for the
SynIC event ring buffer for each SINT.

This will be used by the mshv driver, but must be tracked independently
since the driver module could be removed and re-inserted.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_common.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 885bbc3d86d8..3cd9b96ffc67 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -68,6 +68,16 @@ static void hv_kmsg_dump_unregister(void);
 
 static struct ctl_table_header *hv_ctl_table_hdr;
 
+/*
+ * Per-cpu array holding the tail pointer for the SynIC event ring buffer
+ * for each SINT.
+ *
+ * We cannot maintain this in mshv driver because the tail pointer should
+ * persist even if the mshv driver is unloaded.
+ */
+u8 * __percpu *hv_synic_eventring_tail;
+EXPORT_SYMBOL_GPL(hv_synic_eventring_tail);
+
 /*
  * Hyper-V specific initialization and shutdown code that is
  * common across all architectures.  Called from architecture
@@ -90,6 +100,9 @@ void __init hv_common_free(void)
 
 	free_percpu(hyperv_pcpu_input_arg);
 	hyperv_pcpu_input_arg = NULL;
+
+	free_percpu(hv_synic_eventring_tail);
+	hv_synic_eventring_tail = NULL;
 }
 
 /*
@@ -372,6 +385,11 @@ int __init hv_common_init(void)
 		BUG_ON(!hyperv_pcpu_output_arg);
 	}
 
+	if (hv_root_partition()) {
+		hv_synic_eventring_tail = alloc_percpu(u8 *);
+		BUG_ON(!hv_synic_eventring_tail);
+	}
+
 	hv_vp_index = kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
 				    GFP_KERNEL);
 	if (!hv_vp_index) {
@@ -460,11 +478,12 @@ void __init ms_hyperv_late_init(void)
 int hv_common_cpu_init(unsigned int cpu)
 {
 	void **inputarg, **outputarg;
+	u8 **synic_eventring_tail;
 	u64 msr_vp_index;
 	gfp_t flags;
 	const int pgcount = hv_output_page_exists() ? 2 : 1;
 	void *mem;
-	int ret;
+	int ret = 0;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
@@ -472,8 +491,8 @@ int hv_common_cpu_init(unsigned int cpu)
 	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	/*
-	 * hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory is already
-	 * allocated if this CPU was previously online and then taken offline
+	 * The per-cpu memory is already allocated if this CPU was previously
+	 * online and then taken offline
 	 */
 	if (!*inputarg) {
 		mem = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
@@ -520,11 +539,21 @@ int hv_common_cpu_init(unsigned int cpu)
 	if (msr_vp_index > hv_max_vp_index)
 		hv_max_vp_index = msr_vp_index;
 
-	return 0;
+	if (hv_root_partition()) {
+		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+		*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT,
+						sizeof(u8), flags);
+		/* No need to unwind any of the above on failure here */
+		if (unlikely(!*synic_eventring_tail))
+			ret = -ENOMEM;
+	}
+
+	return ret;
 }
 
 int hv_common_cpu_die(unsigned int cpu)
 {
+	u8 **synic_eventring_tail;
 	/*
 	 * The hyperv_pcpu_input_arg and hyperv_pcpu_output_arg memory
 	 * is not freed when the CPU goes offline as the hyperv_pcpu_input_arg
@@ -537,6 +566,10 @@ int hv_common_cpu_die(unsigned int cpu)
 	 * originally allocated memory is reused in hv_common_cpu_init().
 	 */
 
+	synic_eventring_tail = this_cpu_ptr(hv_synic_eventring_tail);
+	kfree(*synic_eventring_tail);
+	*synic_eventring_tail = NULL;
+
 	return 0;
 }
 
-- 
2.34.1


