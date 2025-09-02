Return-Path: <linux-arch+bounces-13364-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B751B410EF
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 01:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514C75410F9
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 23:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088312EA729;
	Tue,  2 Sep 2025 23:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fbnsFpk8"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A46A2EA475;
	Tue,  2 Sep 2025 23:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856922; cv=none; b=M6kwPx8+tnNo7hE+Xo9CZ5n384cQhPt+8V2gHZ2n89oFFXNoGc6noCOvPHCSPcBotFnyS/tvbiQHL0RdnDqqTpSTwBcku4BiObOP/gU+YHF3vofKgKa2KkMfW8BGR2RTC86T9krxhsLrb2nlMRD0Go7Ay3JOE8CSbtYPqLutqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856922; c=relaxed/simple;
	bh=ZfQO4dndmQC7J+3gLYrtp2NrcKGsCSxOnOBPtTLx9cY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=o3A+fqV9SyWRoSKUtCCTtUVhO36NS1nfVR+6e+yt1oJcn3lx+pxKJzNUjOp6sV6th6KdCPZ5Jnv2pxPTafupTrYhQKyVIikX37oZKQeh9HlP3W+3MKCQfnio62KP5f4RtmZGZS03tIh4fsPi5jgVuiJc8m8PoLeXQoFfndH2JrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fbnsFpk8; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 3A41E211828B; Tue,  2 Sep 2025 16:48:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A41E211828B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756856915;
	bh=3pPUL78pUcMAEVARbGI0M3+yKDS8s2jb8IBBidLtC5w=;
	h=From:To:Cc:Subject:Date:From;
	b=fbnsFpk8YRomQ8Atikj6J8dzkovoorUlQ9X/Sfo5eTlj6mCI8hFbU7mjWUfE6UvJ0
	 S0EB0eeTNUhB0RMj5LxPJBy5fCqDUcoBDW3MT/fNIWOlOtwDJjs/KsoxoDkpOMi1H5
	 vvW+hL4yyEUMAhMobJ2/HA4nNPND+7TP2VDB+V0o=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	arnd@arndb.de,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2] mshv: Add support for a new parent partition configuration
Date: Tue,  2 Sep 2025 16:48:33 -0700
Message-Id: <1756856913-27197-1-git-send-email-nunodasneves@linux.microsoft.com>
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
Acked-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
Changes since v1:
- Fix hypercall output page not being allocated for L1VH
- Clean up scheduler detection code to reduce repetition [Michael Kelley]
---
 drivers/hv/hv_common.c         | 22 +++++++++++++---------
 drivers/hv/mshv_root_main.c    | 26 +++++++++++++-------------
 include/asm-generic/mshyperv.h | 11 +++++++++++
 3 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 49898d10faff..e109a620c83f 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -257,7 +257,7 @@ static void hv_kmsg_dump_register(void)
 
 static inline bool hv_output_page_exists(void)
 {
-	return hv_root_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
+	return hv_parent_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
 }
 
 void __init hv_get_partition_id(void)
@@ -377,7 +377,7 @@ int __init hv_common_init(void)
 		BUG_ON(!hyperv_pcpu_output_arg);
 	}
 
-	if (hv_root_partition()) {
+	if (hv_parent_partition()) {
 		hv_synic_eventring_tail = alloc_percpu(u8 *);
 		BUG_ON(!hv_synic_eventring_tail);
 	}
@@ -531,7 +531,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	if (msr_vp_index > hv_max_vp_index)
 		hv_max_vp_index = msr_vp_index;
 
-	if (hv_root_partition()) {
+	if (hv_parent_partition()) {
 		synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
 		*synic_eventring_tail = kcalloc(HV_SYNIC_SINT_COUNT,
 						sizeof(u8), flags);
@@ -558,7 +558,7 @@ int hv_common_cpu_die(unsigned int cpu)
 	 * originally allocated memory is reused in hv_common_cpu_init().
 	 */
 
-	if (hv_root_partition()) {
+	if (hv_parent_partition()) {
 		synic_eventring_tail = this_cpu_ptr(hv_synic_eventring_tail);
 		kfree(*synic_eventring_tail);
 		*synic_eventring_tail = NULL;
@@ -729,13 +729,17 @@ void hv_identify_partition_type(void)
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
index 72df774e410a..aa20a5c96afa 100644
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
@@ -2074,9 +2068,13 @@ static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
 /* Retrieve and stash the supported scheduler type */
 static int __init mshv_retrieve_scheduler_type(struct device *dev)
 {
-	int ret;
+	int ret = 0;
+
+	if (hv_l1vh_partition())
+		hv_scheduler_type = HV_SCHEDULER_TYPE_CORE_SMT;
+	else
+		ret = hv_retrieve_scheduler_type(&hv_scheduler_type);
 
-	ret = hv_retrieve_scheduler_type(&hv_scheduler_type);
 	if (ret)
 		return ret;
 
@@ -2203,9 +2201,6 @@ static int __init mshv_root_partition_init(struct device *dev)
 {
 	int err;
 
-	if (mshv_retrieve_scheduler_type(dev))
-		return -ENODEV;
-
 	err = root_scheduler_init(dev);
 	if (err)
 		return err;
@@ -2227,7 +2222,7 @@ static int __init mshv_parent_partition_init(void)
 	struct device *dev;
 	union hv_hypervisor_version_info version_info;
 
-	if (!hv_root_partition() || is_kdump_kernel())
+	if (!hv_parent_partition() || is_kdump_kernel())
 		return -ENODEV;
 
 	if (hv_get_hypervisor_version(&version_info))
@@ -2264,7 +2259,12 @@ static int __init mshv_parent_partition_init(void)
 
 	mshv_cpuhp_online = ret;
 
-	ret = mshv_root_partition_init(dev);
+	ret = mshv_retrieve_scheduler_type(dev);
+	if (ret)
+		goto remove_cpu_state;
+
+	if (hv_root_partition())
+		ret = mshv_root_partition_init(dev);
 	if (ret)
 		goto remove_cpu_state;
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a729b77983fa..dbd4c2f3aee3 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -31,6 +31,7 @@
 enum hv_partition_type {
 	HV_PARTITION_TYPE_GUEST,
 	HV_PARTITION_TYPE_ROOT,
+	HV_PARTITION_TYPE_L1VH,
 };
 
 struct ms_hyperv_info {
@@ -354,12 +355,22 @@ static inline bool hv_root_partition(void)
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


