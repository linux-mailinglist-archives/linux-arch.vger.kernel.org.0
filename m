Return-Path: <linux-arch+bounces-15878-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 011BAD3BF97
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D493D34AD35
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD84396B8C;
	Tue, 20 Jan 2026 06:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AFMIPpY6"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3438B7DE;
	Tue, 20 Jan 2026 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891426; cv=none; b=S9QDc6ra/L/gWhEqGG2qVbK8L9Mnwwxi4E++f25nYJYRsURAx/pSQl3jf6s8w+wzbfOMC2zhYch6uSrFW2d9Ak28ownOjafzpoo6m8K2OJ5F6pjt2tTUaDmp32tG3cnlG/6Q/T1wPi1wfvU/So8skSeZTstWvsG376Iiy0P+oTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891426; c=relaxed/simple;
	bh=JMe5l6JLGKke32CXM+7TnJxiKSkmgTGBXD5PSTwA/SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYKO/rDDHaQOCOiR3sXKSott1cwYHCKyVOsb5GDoxV5WRDNmdg8K/7Jl9+8Dn/hwYLMeXQi2p1E+6wIzsRyHzxeRaPoa0KsRooBU7wGb/aL/hgOWkr5ko1M1ZTRW7CQ+4ObWUVqM51lgD3ScBxFRh+oJcxa7hBULk5NSW7naCm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AFMIPpY6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 305DB20B716D;
	Mon, 19 Jan 2026 22:43:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 305DB20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891411;
	bh=usRPxgl1amP/v9n1SLf7SAiI18LuyGFVnItwiHNDJxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AFMIPpY6TAiuIZv+8jTFocdvb6bDbOjidIdTfShgZ/xxmsSw89ShdkgVGXcpmIi0a
	 uqU3YdVEEs1oymmxBJNjCltMFdDLzFigaa4fuIlemUvg+4jc3mQbADgxz0xjUC5u9B
	 GG7ZGEq4SoiolDL1XVlZ5e9MX+LXwD8K65AF0h+A=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	joro@8bytes.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	nunodasneves@linux.microsoft.com,
	mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: [PATCH v0 04/15] mshv: Provide a way to get partition id if running in a VMM process
Date: Mon, 19 Jan 2026 22:42:19 -0800
Message-ID: <20260120064230.3602565-5-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Rathor <mrathor@linux.microsoft.com>

Many PCI passthru related hypercalls require partition id of the target
guest. Guests are actually managed by MSHV driver and the partition id
is only maintained there. Add a field in the partition struct in MSHV
driver to save the tgid of the VMM process creating the partition,
and add a function there to retrieve partition id if valid VMM tgid.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root.h         |  1 +
 drivers/hv/mshv_root_main.c    | 35 +++++++++++++++++++++++++++-------
 include/asm-generic/mshyperv.h |  1 +
 3 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 3c1d88b36741..c3753b009fd8 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -134,6 +134,7 @@ struct mshv_partition {
 
 	struct mshv_girq_routing_table __rcu *pt_girq_tbl;
 	u64 isolation_type;
+	pid_t pt_vmm_tgid;
 	bool import_completed;
 	bool pt_initialized;
 };
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 1134a82c7881..83c7bad269a0 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1823,6 +1823,20 @@ mshv_partition_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/* Given a process tgid, return partition id if it is a VMM process */
+u64 mshv_pid_to_partid(pid_t tgid)
+{
+	struct mshv_partition *pt;
+	int i;
+
+	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode)
+		if (pt->pt_vmm_tgid == tgid)
+			return pt->pt_id;
+
+	return HV_PARTITION_ID_INVALID;
+}
+EXPORT_SYMBOL_GPL(mshv_pid_to_partid);
+
 static int
 add_partition(struct mshv_partition *partition)
 {
@@ -1987,13 +2001,20 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 		goto delete_partition;
 
 	ret = mshv_init_async_handler(partition);
-	if (!ret) {
-		ret = FD_ADD(O_CLOEXEC, anon_inode_getfile("mshv_partition",
-							   &mshv_partition_fops,
-							   partition, O_RDWR));
-		if (ret >= 0)
-			return ret;
-	}
+	if (ret)
+		goto rem_partition;
+
+	ret = FD_ADD(O_CLOEXEC, anon_inode_getfile("mshv_partition",
+						   &mshv_partition_fops,
+						   partition, O_RDWR));
+	if (ret < 0)
+		goto rem_partition;
+
+	partition->pt_vmm_tgid = current->tgid;
+
+	return ret;
+
+rem_partition:
 	remove_partition(partition);
 delete_partition:
 	hv_call_delete_partition(partition->pt_id);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ecedab554c80..e46a38916e76 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -211,6 +211,7 @@ void __init ms_hyperv_late_init(void);
 int hv_common_cpu_init(unsigned int cpu);
 int hv_common_cpu_die(unsigned int cpu);
 void hv_identify_partition_type(void);
+u64 mshv_pid_to_partid(pid_t tgid);
 
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
-- 
2.51.2.vfs.0.1


