Return-Path: <linux-arch+bounces-15886-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B97D3BFB4
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 499B33C30B7
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D223A1E73;
	Tue, 20 Jan 2026 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nPKgQKZQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E39F39A808;
	Tue, 20 Jan 2026 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891439; cv=none; b=CBZ/Lq9U7EMfcIslagKnc93PUcJBQbb4zbp5BiGs0G7YKObVB+Eo7YQd6PakzcdxJUCcZ8FlHDRjWHZn+dkkmUzaDYlzoHXm1CY4C51P0gvXLD+38dCAYWLVHxGWzN0aryjCrlHh+V/7QWKStHGqXJoDFQ98bVa/pOPdLEdExW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891439; c=relaxed/simple;
	bh=lFCdL+6ojHEEiti/5oEEzqcHgGMBpFffGSnL89hXCKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxZlcLg2Wr0qLWDvrQaALZ36fBW02RT7W0VVjtMf9dPxu8RAi5ODLdxPbFq6n2wPqWdcXN8hhoHNhSp0JV+fYKkxm5HQT4gvO610c12OrzDkjK22tK0ShswihaAFdveyU8LUS9k8sIwkSCzJnXrKNI4jji54/ZRxrKx0GHhJcuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nPKgQKZQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 795D320B716D;
	Mon, 19 Jan 2026 22:43:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 795D320B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891431;
	bh=vwKC6HwtuqTh63I/EcCnX9kz02TP/FLMLkDGVcBN5Jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPKgQKZQP36at7Pw9ekyrrLYOUWnS9INVzf/0p/e0spMOrWzbrSFIdbBIYmCgu9Yl
	 48+3TE7z+OgQ6l8v5rUbjC5ExL0L5TS/agbqGuSQ32EEIyWVA0e4BzSdoH7oe9rgAX
	 6TseUo1oxO/Z0ZpmEfj8TIL4CIuSoguKL/aCkpmA=
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
Subject: [PATCH v0 15/15] mshv: Populate mmio mappings for PCI passthru
Date: Mon, 19 Jan 2026 22:42:30 -0800
Message-ID: <20260120064230.3602565-16-mrathor@linux.microsoft.com>
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

Upon guest access, in case of missing mmio mapping, the hypervisor
generates an unmapped gpa intercept. In this path, lookup the PCI
resource pfn for the guest gpa, and ask the hypervisor to map it
via hypercall. The PCI resource pfn is maintained by the VFIO driver,
and obtained via fixup_user_fault call (similar to KVM).

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 115 ++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 03f3aa9f5541..4c8bc7cd0888 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -56,6 +56,14 @@ struct hv_stats_page {
 	};
 } __packed;
 
+bool hv_nofull_mmio;   /* don't map entire mmio region upon fault */
+static int __init setup_hv_full_mmio(char *str)
+{
+	hv_nofull_mmio = true;
+	return 0;
+}
+__setup("hv_nofull_mmio", setup_hv_full_mmio);
+
 struct mshv_root mshv_root;
 
 enum hv_scheduler_type hv_scheduler_type;
@@ -612,6 +620,109 @@ mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
 }
 
 #ifdef CONFIG_X86_64
+
+/*
+ * Check if uaddr is for mmio range. If yes, return 0 with mmio_pfn filled in
+ * else just return -errno.
+ */
+static int mshv_chk_get_mmio_start_pfn(struct mshv_partition *pt, u64 gfn,
+				       u64 *mmio_pfnp)
+{
+	struct vm_area_struct *vma;
+	bool is_mmio;
+	u64 uaddr;
+	struct mshv_mem_region *mreg;
+	struct follow_pfnmap_args pfnmap_args;
+	int rc = -EINVAL;
+
+	/*
+	 * Do not allow mem region to be deleted beneath us. VFIO uses
+	 * useraddr vma to lookup pci bar pfn.
+	 */
+	spin_lock(&pt->pt_mem_regions_lock);
+
+	/* Get the region again under the lock */
+	mreg = mshv_partition_region_by_gfn(pt, gfn);
+	if (mreg == NULL || mreg->type != MSHV_REGION_TYPE_MMIO)
+		goto unlock_pt_out;
+
+	uaddr = mreg->start_uaddr +
+		((gfn - mreg->start_gfn) << HV_HYP_PAGE_SHIFT);
+
+	mmap_read_lock(current->mm);
+	vma = vma_lookup(current->mm, uaddr);
+	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
+	if (!is_mmio)
+		goto unlock_mmap_out;
+
+	pfnmap_args.vma = vma;
+	pfnmap_args.address = uaddr;
+
+	rc = follow_pfnmap_start(&pfnmap_args);
+	if (rc) {
+		rc = fixup_user_fault(current->mm, uaddr, FAULT_FLAG_WRITE,
+				      NULL);
+		if (rc)
+			goto unlock_mmap_out;
+
+		rc = follow_pfnmap_start(&pfnmap_args);
+		if (rc)
+			goto unlock_mmap_out;
+	}
+
+	*mmio_pfnp = pfnmap_args.pfn;
+	follow_pfnmap_end(&pfnmap_args);
+
+unlock_mmap_out:
+	mmap_read_unlock(current->mm);
+unlock_pt_out:
+	spin_unlock(&pt->pt_mem_regions_lock);
+	return rc;
+}
+
+/*
+ * At present, the only unmapped gpa is mmio space. Verify if it's mmio
+ * and resolve if possible.
+ * Returns: True if valid mmio intercept and it was handled, else false
+ */
+static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp)
+{
+	struct hv_message *hvmsg = vp->vp_intercept_msg_page;
+	struct hv_x64_memory_intercept_message *msg;
+	union hv_x64_memory_access_info accinfo;
+	u64 gfn, mmio_spa, numpgs;
+	struct mshv_mem_region *mreg;
+	int rc;
+	struct mshv_partition *pt = vp->vp_partition;
+
+	msg = (struct hv_x64_memory_intercept_message *)hvmsg->u.payload;
+	accinfo = msg->memory_access_info;
+
+	if (!accinfo.gva_gpa_valid)
+		return false;
+
+	/* Do a fast check and bail if non mmio intercept */
+	gfn = msg->guest_physical_address >> HV_HYP_PAGE_SHIFT;
+	mreg = mshv_partition_region_by_gfn(pt, gfn);
+	if (mreg == NULL || mreg->type != MSHV_REGION_TYPE_MMIO)
+		return false;
+
+	rc = mshv_chk_get_mmio_start_pfn(pt, gfn, &mmio_spa);
+	if (rc)
+		return false;
+
+	if (!hv_nofull_mmio) {		/* default case */
+		gfn = mreg->start_gfn;
+		mmio_spa = mmio_spa - (gfn - mreg->start_gfn);
+		numpgs = mreg->nr_pages;
+	} else
+		numpgs = 1;
+
+	rc = hv_call_map_mmio_pages(pt->pt_id, gfn, mmio_spa, numpgs);
+
+	return rc == 0;
+}
+
 static struct mshv_mem_region *
 mshv_partition_region_by_gfn_get(struct mshv_partition *p, u64 gfn)
 {
@@ -666,13 +777,17 @@ static bool mshv_handle_gpa_intercept(struct mshv_vp *vp)
 
 	return ret;
 }
+
 #else  /* CONFIG_X86_64 */
+static bool mshv_handle_unmapped_gpa(struct mshv_vp *vp) { return false; }
 static bool mshv_handle_gpa_intercept(struct mshv_vp *vp) { return false; }
 #endif /* CONFIG_X86_64 */
 
 static bool mshv_vp_handle_intercept(struct mshv_vp *vp)
 {
 	switch (vp->vp_intercept_msg_page->header.message_type) {
+	case HVMSG_UNMAPPED_GPA:
+		return mshv_handle_unmapped_gpa(vp);
 	case HVMSG_GPA_INTERCEPT:
 		return mshv_handle_gpa_intercept(vp);
 	}
-- 
2.51.2.vfs.0.1


