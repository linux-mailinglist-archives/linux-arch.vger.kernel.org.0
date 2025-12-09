Return-Path: <linux-arch+bounces-15313-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C91ECAEECE
	for <lists+linux-arch@lfdr.de>; Tue, 09 Dec 2025 06:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2555130A5228
	for <lists+linux-arch@lfdr.de>; Tue,  9 Dec 2025 05:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F727AC28;
	Tue,  9 Dec 2025 05:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sLrPF2Jp"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB17627935F;
	Tue,  9 Dec 2025 05:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765257118; cv=none; b=XBnvJnHitfLPflx1CeCu0y1jGn0gc7OnfO5x++9EGveAOcAHAd2wPs719mnC6rFeP9ODIhluG9xWroobntXblmoeJGkHgvEJsFLJYz13SPsnnu02ZCNL/yH+/udtWgN5Wl4a2n/osObhr2AB4ua8G2NcCcC83W9ncCJsCp+fLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765257118; c=relaxed/simple;
	bh=V//6OM2Jz+dzKFoZiudlThjDt6NL+I1qWnnI6UTQ2Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwpKN7S5MW5x4Wxi0GyJn5MNJ1qkcfzwBPd20s+Gh/6ASMcTKy5Vb7rFyyl5No+ONmgVRepQlGAeJ9OGJVBIeoLUc2UcSidb9Cj98fJZvKLyXjcoSQZEXMqPaQ8pTmwzu7AW5ogcxKRaMGqsyyuiI34ZlLi8kw+7r/sMJIZXaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sLrPF2Jp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2F0142015692;
	Mon,  8 Dec 2025 21:11:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F0142015692
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765257115;
	bh=kgOzUp6enPiadf1QwJ7kHsJyJDKUdcrrZkezB6/Q3dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sLrPF2JpxoHOxPm0XW1E8Wpq00u2QbQbf1Gtjk4U7DRPE30OcdnHCxgAkSE5/xnIH
	 d5rqFLixR4Y9+bNH60Hd7WtP06IjJq10D3hBW1cS+jn0vx4/7jxDCqKl2es+CsWD6y
	 6Wk4iCJsvaIeWqbCZO5lae+m9SHkiQTJdALB/Kc4=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	easwar.hariharan@linux.microsoft.com,
	jacob.pan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	peterz@infradead.org,
	linux-arch@vger.kernel.org
Subject: [RFC v1 4/5] hyperv: allow hypercall output pages to be allocated for child partitions
Date: Tue,  9 Dec 2025 13:11:27 +0800
Message-ID: <20251209051128.76913-5-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, the allocation of per-CPU output argument pages was restricted
to root partitions or those operating in VTL mode.

Remove this restriction to support guest IOMMU related hypercalls, which
require valid output pages to function correctly.

While unconditionally allocating per-CPU output pages scales with the number
of vCPUs, and potentially adding overhead for guests that may not utilize the
IOMMU, this change anticipates that future hypercalls from child partitions
may also require these output pages.

Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 drivers/hv/hv_common.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e109a620c83f..034fb2592884 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -255,11 +255,6 @@ static void hv_kmsg_dump_register(void)
 	}
 }
 
-static inline bool hv_output_page_exists(void)
-{
-	return hv_parent_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
-}
-
 void __init hv_get_partition_id(void)
 {
 	struct hv_output_get_partition_id *output;
@@ -371,11 +366,9 @@ int __init hv_common_init(void)
 	hyperv_pcpu_input_arg = alloc_percpu(void  *);
 	BUG_ON(!hyperv_pcpu_input_arg);
 
-	/* Allocate the per-CPU state for output arg for root */
-	if (hv_output_page_exists()) {
-		hyperv_pcpu_output_arg = alloc_percpu(void *);
-		BUG_ON(!hyperv_pcpu_output_arg);
-	}
+	/* Allocate the per-CPU state for output arg*/
+	hyperv_pcpu_output_arg = alloc_percpu(void *);
+	BUG_ON(!hyperv_pcpu_output_arg);
 
 	if (hv_parent_partition()) {
 		hv_synic_eventring_tail = alloc_percpu(u8 *);
@@ -473,7 +466,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u8 **synic_eventring_tail;
 	u64 msr_vp_index;
 	gfp_t flags;
-	const int pgcount = hv_output_page_exists() ? 2 : 1;
+	const int pgcount = 2;
 	void *mem;
 	int ret = 0;
 
@@ -491,10 +484,8 @@ int hv_common_cpu_init(unsigned int cpu)
 		if (!mem)
 			return -ENOMEM;
 
-		if (hv_output_page_exists()) {
-			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
-		}
+		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+		*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 
 		if (!ms_hyperv.paravisor_present &&
 		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
-- 
2.49.0


