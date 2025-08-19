Return-Path: <linux-arch+bounces-13194-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD0B2BAB8
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 09:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6453B0C94
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8354B2848B1;
	Tue, 19 Aug 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NQ3JndSi"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D746122D9F7;
	Tue, 19 Aug 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755588564; cv=none; b=IR48N+XVBwG/2UykBV3k3Rwz0uoY83rxydDXhlC2i4w2ndOmUhsk4p3v2ZPrGRj0sI/J5Aueut+5NOlrg6CIzxTxNYGKXNiw4VnAHkTjqvNwBxqPaQJN/FHOoKOj7wOp/Kw9DRFqNZs5OJ/CbUG/BeMwE9O1IIrZbpFKnW1dGJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755588564; c=relaxed/simple;
	bh=zmJ4oEkg/wsHorsGWyyTdx9Ow5bGQ0WGNug4IrVA5ZA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cDp7SU3LLScyObBLay3DyqbvyGlckEy5YEdZ4rdQOE6An6gX2bonUl6j8VMmVLVWoqy5Ll4Bkg8T2fPpnzcbNMVJ36vASBEUsDYv2WhNKpwJSzxHEpV5L/cGfqlSateNjsVz47gA/3C/CXIuqL9X8OzF0bMIMyFxEOx7yVySMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NQ3JndSi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 597D92113369; Tue, 19 Aug 2025 00:29:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 597D92113369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1755588562;
	bh=tUxdMWnI67dhYQwXGjOBEKVZI8EfEtyZKrA8xyUFX7M=;
	h=From:To:Cc:Subject:Date:From;
	b=NQ3JndSidFl3XzfsFMOggAl8X/S92o6u9CxcAmGbifX1dWrdNU1HiBTxqByV6Xf7Y
	 d/uU+96PAChnhvcY1DNVPgq8W3ekFPcn/NwaCY9g7dgStVDRDkj/1G+q5P/Iysfe6R
	 lN4Fre8WrXbU9m7Fcx0yOlZvvxx3L5pUENRVGlk4=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	arnd@arndb.de,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH] mshv: Add support for a new parent partition configuration
Date: Tue, 19 Aug 2025 00:29:19 -0700
Message-Id: <1755588559-29629-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Detect booting as an "L1VH" partition. This is a new scenario very
similar to root partition where the mshv_root driver can be used to
create and manage guest partitions.

It mostly works the same as root partition, but there are some
differences in how various features are handled. hv_l1vh_partition()
is introduced to handle these cases. Add hv_parent_partition()
which returns true for either case, replacing some hv_root_partition()
checks.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/hv_common.c         | 20 ++++++++++++--------
 drivers/hv/mshv_root_main.c    | 22 ++++++++++++++--------
 include/asm-generic/mshyperv.h | 11 +++++++++++
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index cbe4a954ad46..a6839593ca31 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -357,7 +357,7 @@ int __init hv_common_init(void)
 	hyperv_pcpu_arg = alloc_percpu(void  *);
 	BUG_ON(!hyperv_pcpu_arg);
 
-	if (hv_root_partition()) {
+	if (hv_parent_partition()) {
 		hv_synic_eventring_tail = alloc_percpu(u8 *);
 		BUG_ON(!hv_synic_eventring_tail);
 	}
@@ -506,7 +506,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	if (msr_vp_index > hv_max_vp_index)
 		hv_max_vp_index = msr_vp_index;
 
-	if (hv_root_partition()) {
+	if (hv_parent_partition()) {
 		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
 		*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT,
 						sizeof(u8), flags);
@@ -532,7 +532,7 @@ int hv_common_cpu_die(unsigned int cpu)
 	 * originally allocated memory is reused in hv_common_cpu_init().
 	 */
 
-	if (hv_root_partition()) {
+	if (hv_parent_partition()) {
 		synic_eventring_tail = this_cpu_ptr(hv_synic_eventring_tail);
 		kfree(*synic_eventring_tail);
 		*synic_eventring_tail = NULL;
@@ -703,13 +703,17 @@ void hv_identify_partition_type(void)
 	 * the root partition setting if also a Confidential VM.
 	 */
 	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
-	    (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) &&
 	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
-		pr_info("Hyper-V: running as root partition\n");
-		if (IS_ENABLED(CONFIG_MSHV_ROOT))
-			hv_curr_partition_type = HV_PARTITION_TYPE_ROOT;
-		else
+
+		if (!IS_ENABLED(CONFIG_MSHV_ROOT)) {
 			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
+		} else if (ms_hyperv.priv_high & HV_CPU_MANAGEMENT) {
+			pr_info("Hyper-V: running as root partition\n");
+			hv_curr_partition_type = HV_PARTITION_TYPE_ROOT;
+		} else {
+			pr_info("Hyper-V: running as L1VH partition\n");
+			hv_curr_partition_type = HV_PARTITION_TYPE_L1VH;
+		}
 	}
 }
 
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index aca3331ad516..7c710703cd96 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -37,12 +37,6 @@ MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
 
-/* TODO move this to mshyperv.h when needed outside driver */
-static inline bool hv_parent_partition(void)
-{
-	return hv_root_partition();
-}
-
 /* TODO move this to another file when debugfs code is added */
 enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
 #if defined(CONFIG_X86)
@@ -2190,6 +2184,15 @@ struct notifier_block mshv_reboot_nb = {
 	.notifier_call = mshv_reboot_notify,
 };
 
+static int __init mshv_l1vh_partition_init(struct device *dev)
+{
+	hv_scheduler_type = HV_SCHEDULER_TYPE_CORE_SMT;
+	dev_info(dev, "Hypervisor using %s\n",
+		 scheduler_type_to_string(hv_scheduler_type));
+
+	return 0;
+}
+
 static void mshv_root_partition_exit(void)
 {
 	unregister_reboot_notifier(&mshv_reboot_nb);
@@ -2224,7 +2227,7 @@ static int __init mshv_parent_partition_init(void)
 	struct device *dev;
 	union hv_hypervisor_version_info version_info;
 
-	if (!hv_root_partition() || is_kdump_kernel())
+	if (!hv_parent_partition() || is_kdump_kernel())
 		return -ENODEV;
 
 	if (hv_get_hypervisor_version(&version_info))
@@ -2261,7 +2264,10 @@ static int __init mshv_parent_partition_init(void)
 
 	mshv_cpuhp_online = ret;
 
-	ret = mshv_root_partition_init(dev);
+	if (hv_root_partition())
+		ret = mshv_root_partition_init(dev);
+	else
+		ret = mshv_l1vh_partition_init(dev);
 	if (ret)
 		goto remove_cpu_state;
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index dbbacd47ca35..f0f0eacb2eef 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -31,6 +31,7 @@
 enum hv_partition_type {
 	HV_PARTITION_TYPE_GUEST,
 	HV_PARTITION_TYPE_ROOT,
+	HV_PARTITION_TYPE_L1VH,
 };
 
 struct ms_hyperv_info {
@@ -457,12 +458,22 @@ static inline bool hv_root_partition(void)
 {
 	return hv_curr_partition_type == HV_PARTITION_TYPE_ROOT;
 }
+static inline bool hv_l1vh_partition(void)
+{
+	return hv_curr_partition_type == HV_PARTITION_TYPE_L1VH;
+}
+static inline bool hv_parent_partition(void)
+{
+	return hv_root_partition() || hv_l1vh_partition();
+}
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
 #else /* CONFIG_MSHV_ROOT */
 static inline bool hv_root_partition(void) { return false; }
+static inline bool hv_l1vh_partition(void) { return false; }
+static inline bool hv_parent_partition(void) { return false; }
 static inline int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 {
 	return -EOPNOTSUPP;
-- 
2.34.1


