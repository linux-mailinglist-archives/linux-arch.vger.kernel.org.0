Return-Path: <linux-arch+bounces-10400-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0D8A46F1E
	for <lists+linux-arch@lfdr.de>; Thu, 27 Feb 2025 00:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74F3A7A7E3F
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F525F7B3;
	Wed, 26 Feb 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SonOvTLJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF39F25CC81;
	Wed, 26 Feb 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611342; cv=none; b=LuzGsWJld7CRaQX8AFjucbgKJYOPCazuFfMmJGE5RI//iPEish+bkLaOXss7M2hdvXCmEJQZKS5YYQiqdCeJKUWVr+XO3YL8n/MWJLq5ZjZTJ4Ukcy3BtjnaoRoXQsthuGtZ7brCokkEXlyL4kmiXb3u6/XewNcsXcYI9YEOreI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611342; c=relaxed/simple;
	bh=446lq6RS3OXLlVnikTAuRXCO9ulNOHVLr9gZMnV0Kfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HXlygja3KIYaXmGVVc6b2mRIZh5Fb5gbjYyNCA0pmCBimOVzZZtBzPw7p/xgsklm+o4VeK9p3hdz8cwyRKzHyW8sbqHDl92ey08dGntXtGzl4vbLIw/PnkU0uIgZ5sAV2tT/fyQ95AWyV7z/0dGdsXJr9fr1SIb7xaQhcQTC/Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SonOvTLJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BCB6210EACE;
	Wed, 26 Feb 2025 15:08:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BCB6210EACE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740611339;
	bh=7Wj2ugF4n6C55Ao4My0HNfCwkHT/JgqZetZVtKykJY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SonOvTLJF8YOsLyEW7qK7PUUJ3wubXvnGbAAuSEFRgTQUR7IROTvFEYILABtpHAql
	 OnEoqYz8ljX4cKww+isHubWwF8phTgv0foQ//1WBQ1iV5Zn02oUsZgZ+1kWSmvyC3T
	 O9Q5aAqGTbtGBNmu1shtzC1f1YMYhhr88QbgOS1s=
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
Subject: [PATCH v5 07/10] Drivers: hv: Introduce per-cpu event ring tail
Date: Wed, 26 Feb 2025 15:08:01 -0800
Message-Id: <1740611284-27506-8-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
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
---
 drivers/hv/hv_common.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 252fd66ad4db..2763cb6d3678 100644
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
+u8 __percpu **hv_synic_eventring_tail;
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
+		BUG_ON(hv_synic_eventring_tail == NULL);
+	}
+
 	hv_vp_index = kmalloc_array(nr_cpu_ids, sizeof(*hv_vp_index),
 				    GFP_KERNEL);
 	if (!hv_vp_index) {
@@ -460,6 +478,7 @@ void __init ms_hyperv_late_init(void)
 int hv_common_cpu_init(unsigned int cpu)
 {
 	void **inputarg, **outputarg;
+	u8 **synic_eventring_tail;
 	u64 msr_vp_index;
 	gfp_t flags;
 	const int pgcount = hv_output_page_exists() ? 2 : 1;
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
@@ -485,6 +504,17 @@ int hv_common_cpu_init(unsigned int cpu)
 			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 		}
 
+		if (hv_root_partition()) {
+			synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+			*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT,
+							sizeof(u8), flags);
+
+			if (unlikely(!*synic_eventring_tail)) {
+				kfree(mem);
+				return -ENOMEM;
+			}
+		}
+
 		if (!ms_hyperv.paravisor_present &&
 		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
-- 
2.34.1


