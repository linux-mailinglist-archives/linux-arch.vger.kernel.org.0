Return-Path: <linux-arch+bounces-15890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2F3D3BFC4
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 07:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 55DF93C5454
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jan 2026 06:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508B3A1CFF;
	Tue, 20 Jan 2026 06:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WlEk+tNC"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6A238E5CC;
	Tue, 20 Jan 2026 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891447; cv=none; b=iGb1kQu0SwvYsJyWZd1iXRxydoOJP/9UxZGbKw6y4RKTmmdUOVmDb0a2//vd3EU7JxoogR23cLwtka94MACv0HAkE3TNdfzVwcomI40LVGPcY/LL86ACAB17vzin6BMmbT2eLktrZdZJZ/w7ld3suGvc4saUSUkYlW6EgjdtTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891447; c=relaxed/simple;
	bh=RDvcS+h33cIpJKdFYlOV52Rf72yNdrYVt9mQnQYRMmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN2FI9cu7CYi21OMMix2KhRRQ3PX9mj4ErV8YfG+b+lVzroH3UaoWL675NV+OilGneaPf26P1Oo3eq7fZrxuH8C7iCp2G3Kt5KIpyrlOg24rxSbAGsD9w8kue0Q+1rMXHocdG/Zj7Cip2gM9OI65oknaZySzVm3ikdErUwzjVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WlEk+tNC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id B514820B716B;
	Mon, 19 Jan 2026 22:43:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B514820B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768891426;
	bh=LALVYDoDS9Z7foVmNCACVg/mKXscj2r1Oweg1CvTLTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlEk+tNC2kjElZfsfFls162d6n9mkQ1TwXBVjgIsKiP5hv8/5hMcAlQy6RRd6h6Rd
	 pcL0I2/FZ9Y53OeKUB5pkSg8raA+UqyeoXD5T2bId3m3JsGtpn/gnYv/Av0OE6CTGf
	 zJwVVjmWKlPMxHikKBsumMs92svA6FYh5bmUNIyU=
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
Subject: [PATCH v0 12/15] x86/hyperv: Implement hyperv virtual iommu
Date: Mon, 19 Jan 2026 22:42:27 -0800
Message-ID: <20260120064230.3602565-13-mrathor@linux.microsoft.com>
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

Add a new file to implement management of device domains, mapping and
unmapping of iommu memory, and other iommu_ops to fit within the VFIO
framework for PCI passthru on Hyper-V running Linux as root or L1VH
parent. This also implements direct attach mechanism for PCI passthru,
and it is also made to work within the VFIO framework.

At a high level, during boot the hypervisor creates a default identity
domain and attaches all devices to it. This nicely maps to Linux iommu
subsystem IOMMU_DOMAIN_IDENTITY domain. As a result, Linux does not
need to explicitly ask Hyper-V to attach devices and do maps/unmaps
during boot. As mentioned previously, Hyper-V supports two ways to do
PCI passthru:

  1. Device Domain: root must create a device domain in the hypervisor,
     and do map/unmap hypercalls for mapping and unmapping guest RAM.
     All hypervisor communications use device id of type PCI for
     identifying and referencing the device.

  2. Direct Attach: the hypervisor will simply use the guest's HW
     page table for mappings, thus the host need not do map/unmap
     device memory hypercalls. As such, direct attach passthru setup
     during guest boot is extremely fast. A direct attached device
     must be referenced via logical device id and not via the PCI
     device id.

At present, L1VH root/parent only supports direct attaches. Also direct
attach is default in non-L1VH cases because there are some significant
performance issues with device domain implementation currently for guests
with higher RAM (say more than 8GB), and that unfortunately cannot be
addressed in the short term.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 MAINTAINERS                     |   1 +
 arch/x86/include/asm/mshyperv.h |   7 +-
 arch/x86/kernel/pci-dma.c       |   2 +
 drivers/iommu/Makefile          |   2 +-
 drivers/iommu/hyperv-iommu.c    | 876 ++++++++++++++++++++++++++++++++
 include/linux/hyperv.h          |   6 +
 6 files changed, 890 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/hyperv-iommu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 381a0e086382..63160cee942c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11741,6 +11741,7 @@ F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/infiniband/hw/mana/
 F:	drivers/input/serio/hyperv-keyboard.c
+F:	drivers/iommu/hyperv-iommu.c
 F:	drivers/iommu/hyperv-irq.c
 F:	drivers/net/ethernet/microsoft/
 F:	drivers/net/hyperv/
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 97477c5a8487..e4ccdbbf1d12 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -189,16 +189,17 @@ static inline void hv_apic_init(void) {}
 #endif
 
 #if IS_ENABLED(CONFIG_HYPERV_IOMMU)
-static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
-{ return false; }       /* temporary */
+bool hv_pcidev_is_attached_dev(struct pci_dev *pdev);
 u64 hv_build_devid_oftype(struct pci_dev *pdev, enum hv_device_type type);
+u64 hv_iommu_get_curr_partid(void);
 #else	/* CONFIG_HYPERV_IOMMU */
 static inline bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
 { return false; }
-
 static inline u64 hv_build_devid_oftype(struct pci_dev *pdev,
 				       enum hv_device_type type)
 { return 0; }
+static inline u64 hv_iommu_get_curr_partid(void)
+{ return HV_PARTITION_ID_INVALID; }
 
 #endif	/* CONFIG_HYPERV_IOMMU */
 
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 6267363e0189..cfeee6505e17 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -8,6 +8,7 @@
 #include <linux/gfp.h>
 #include <linux/pci.h>
 #include <linux/amd-iommu.h>
+#include <linux/hyperv.h>
 
 #include <asm/proto.h>
 #include <asm/dma.h>
@@ -105,6 +106,7 @@ void __init pci_iommu_alloc(void)
 	gart_iommu_hole_init();
 	amd_iommu_detect();
 	detect_intel_iommu();
+	hv_iommu_detect();
 	swiotlb_init(x86_swiotlb_enable, x86_swiotlb_flags);
 }
 
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 598c39558e7d..cc9774864b00 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -30,7 +30,7 @@ obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
 obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
 obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
 obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
-obj-$(CONFIG_HYPERV_IOMMU) += hyperv-irq.o
+obj-$(CONFIG_HYPERV_IOMMU) += hyperv-irq.o hyperv-iommu.o
 obj-$(CONFIG_VIRTIO_IOMMU) += virtio-iommu.o
 obj-$(CONFIG_IOMMU_SVA) += iommu-sva.o
 obj-$(CONFIG_IOMMU_IOPF) += io-pgfault.o
diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
new file mode 100644
index 000000000000..548483fec6b1
--- /dev/null
+++ b/drivers/iommu/hyperv-iommu.c
@@ -0,0 +1,876 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hyper-V root vIOMMU driver.
+ * Copyright (C) 2026, Microsoft, Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/dmar.h>
+#include <linux/dma-map-ops.h>
+#include <linux/interval_tree.h>
+#include <linux/hyperv.h>
+#include "dma-iommu.h"
+#include <asm/iommu.h>
+#include <asm/mshyperv.h>
+
+/* We will not claim these PCI devices, eg hypervisor needs it for debugger */
+static char *pci_devs_to_skip;
+static int __init hv_iommu_setup_skip(char *str)
+{
+	pci_devs_to_skip = str;
+
+	return 0;
+}
+/* hv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
+__setup("hv_iommu_skip=", hv_iommu_setup_skip);
+
+bool hv_no_attdev;	 /* disable direct device attach for passthru */
+EXPORT_SYMBOL_GPL(hv_no_attdev);
+static int __init setup_hv_no_attdev(char *str)
+{
+	hv_no_attdev = true;
+	return 0;
+}
+__setup("hv_no_attdev", setup_hv_no_attdev);
+
+/* Iommu device that we export to the world. HyperV supports max of one */
+static struct iommu_device hv_virt_iommu;
+
+struct hv_domain {
+	struct iommu_domain iommu_dom;
+	u32 domid_num;			      /* as opposed to domain_id.type */
+	u32 num_attchd;		      /* number of currently attached devices */
+	bool attached_dom;		      /* is this direct attached dom? */
+	spinlock_t mappings_lock;	      /* protects mappings_tree */
+	struct rb_root_cached mappings_tree;  /* iova to pa lookup tree */
+};
+
+#define to_hv_domain(d) container_of(d, struct hv_domain, iommu_dom)
+
+struct hv_iommu_mapping {
+	phys_addr_t paddr;
+	struct interval_tree_node iova;
+	u32 flags;
+};
+
+/*
+ * By default, during boot the hypervisor creates one Stage 2 (S2) default
+ * domain. Stage 2 means that the page table is controlled by the hypervisor.
+ *   S2 default: access to entire root partition memory. This for us easily
+ *		 maps to IOMMU_DOMAIN_IDENTITY in the iommu subsystem, and
+ *		 is called HV_DEVICE_DOMAIN_ID_S2_DEFAULT in the hypervisor.
+ *
+ * Device Management:
+ *   There are two ways to manage device attaches to domains:
+ *     1. Domain Attach: A device domain is created in the hypervisor, the
+ *			 device is attached to this domain, and then memory
+ *			 ranges are mapped in the map callbacks.
+ *     2. Direct Attach: No need to create a domain in the hypervisor for direct
+ *			 attached devices. A hypercall is made to tell the
+ *			 hypervisor to attach the device to a guest. There is
+ *			 no need for explicit memory mappings because the
+ *			 hypervisor will just use the guest HW page table.
+ *
+ * Since a direct attach is much faster, it is the default. This can be
+ * changed via hv_no_attdev.
+ *
+ * L1VH: hypervisor only supports direct attach.
+ */
+
+/*
+ * Create dummy domain to correspond to hypervisor prebuilt default identity
+ * domain (dummy because we do not make hypercall to create them).
+ */
+static struct hv_domain hv_def_identity_dom;
+
+static bool hv_special_domain(struct hv_domain *hvdom)
+{
+	return hvdom == &hv_def_identity_dom;
+}
+
+struct iommu_domain_geometry default_geometry = (struct iommu_domain_geometry) {
+	.aperture_start = 0,
+	.aperture_end = -1UL,
+	.force_aperture = true,
+};
+
+/*
+ * Since the relevant hypercalls can only fit less than 512 PFNs in the pfn
+ * array, report 1M max.
+ */
+#define HV_IOMMU_PGSIZES (SZ_4K | SZ_1M)
+
+static u32 unique_id;	      /* unique numeric id of a new domain */
+
+static void hv_iommu_detach_dev(struct iommu_domain *immdom,
+				struct device *dev);
+static size_t hv_iommu_unmap_pages(struct iommu_domain *immdom, ulong iova,
+				   size_t pgsize, size_t pgcount,
+				   struct iommu_iotlb_gather *gather);
+
+/*
+ * If the current thread is a VMM thread, return the partition id of the VM it
+ * is managing, else return HV_PARTITION_ID_INVALID.
+ */
+u64 hv_iommu_get_curr_partid(void)
+{
+	u64 (*fn)(pid_t pid);
+	u64 partid;
+
+	fn = symbol_get(mshv_pid_to_partid);
+	if (!fn)
+		return HV_PARTITION_ID_INVALID;
+
+	partid = fn(current->tgid);
+	symbol_put(mshv_pid_to_partid);
+
+	return partid;
+}
+
+/* If this is a VMM thread, then this domain is for a guest VM */
+static bool hv_curr_thread_is_vmm(void)
+{
+	return hv_iommu_get_curr_partid() != HV_PARTITION_ID_INVALID;
+}
+
+static bool hv_iommu_capable(struct device *dev, enum iommu_cap cap)
+{
+	switch (cap) {
+	case IOMMU_CAP_CACHE_COHERENCY:
+		return true;
+	default:
+		return false;
+	}
+	return false;
+}
+
+/*
+ * Check if given pci device is a direct attached device. Caller must have
+ * verified pdev is a valid pci device.
+ */
+bool hv_pcidev_is_attached_dev(struct pci_dev *pdev)
+{
+	struct iommu_domain *iommu_domain;
+	struct hv_domain *hvdom;
+	struct device *dev = &pdev->dev;
+
+	iommu_domain = iommu_get_domain_for_dev(dev);
+	if (iommu_domain) {
+		hvdom = to_hv_domain(iommu_domain);
+		return hvdom->attached_dom;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_pcidev_is_attached_dev);
+
+/* Create a new device domain in the hypervisor */
+static int hv_iommu_create_hyp_devdom(struct hv_domain *hvdom)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_device_domain *ddp;
+	struct hv_input_create_device_domain *input;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	ddp = &input->device_domain;
+	ddp->partition_id = HV_PARTITION_ID_SELF;
+	ddp->domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
+	ddp->domain_id.id = hvdom->domid_num;
+
+	input->create_device_domain_flags.forward_progress_required = 1;
+	input->create_device_domain_flags.inherit_owning_vtl = 0;
+
+	status = hv_do_hypercall(HVCALL_CREATE_DEVICE_DOMAIN, input, NULL);
+
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		hv_status_err(status, "\n");
+
+	return hv_result_to_errno(status);
+}
+
+/* During boot, all devices are attached to this */
+static struct iommu_domain *hv_iommu_domain_alloc_identity(struct device *dev)
+{
+	return &hv_def_identity_dom.iommu_dom;
+}
+
+static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *dev)
+{
+	struct hv_domain *hvdom;
+	int rc;
+
+	if (hv_l1vh_partition() && !hv_curr_thread_is_vmm() && !hv_no_attdev) {
+		pr_err("Hyper-V: l1vh iommu does not support host devices\n");
+		return NULL;
+	}
+
+	hvdom = kzalloc(sizeof(struct hv_domain), GFP_KERNEL);
+	if (hvdom == NULL)
+		goto out;
+
+	spin_lock_init(&hvdom->mappings_lock);
+	hvdom->mappings_tree = RB_ROOT_CACHED;
+
+	if (++unique_id == HV_DEVICE_DOMAIN_ID_S2_DEFAULT)   /* ie, 0 */
+		goto out_free;
+
+	hvdom->domid_num = unique_id;
+	hvdom->iommu_dom.geometry = default_geometry;
+	hvdom->iommu_dom.pgsize_bitmap = HV_IOMMU_PGSIZES;
+
+	/* For guests, by default we do direct attaches, so no domain in hyp */
+	if (hv_curr_thread_is_vmm() && !hv_no_attdev)
+		hvdom->attached_dom = true;
+	else {
+		rc = hv_iommu_create_hyp_devdom(hvdom);
+		if (rc)
+			goto out_free_id;
+	}
+
+	return &hvdom->iommu_dom;
+
+out_free_id:
+	unique_id--;
+out_free:
+	kfree(hvdom);
+out:
+	return NULL;
+}
+
+static void hv_iommu_domain_free(struct iommu_domain *immdom)
+{
+	struct hv_domain *hvdom = to_hv_domain(immdom);
+	unsigned long flags;
+	u64 status;
+	struct hv_input_delete_device_domain *input;
+
+	if (hv_special_domain(hvdom))
+		return;
+
+	if (hvdom->num_attchd) {
+		pr_err("Hyper-V: can't free busy iommu domain (%p)\n", immdom);
+		return;
+	}
+
+	if (!hv_curr_thread_is_vmm() || hv_no_attdev) {
+		struct hv_input_device_domain *ddp;
+
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		ddp = &input->device_domain;
+		memset(input, 0, sizeof(*input));
+
+		ddp->partition_id = HV_PARTITION_ID_SELF;
+		ddp->domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
+		ddp->domain_id.id = hvdom->domid_num;
+
+		status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input,
+					 NULL);
+		local_irq_restore(flags);
+
+		if (!hv_result_success(status))
+			hv_status_err(status, "\n");
+	}
+
+	kfree(hvdom);
+}
+
+/* Attach a device to a domain previously created in the hypervisor */
+static int hv_iommu_att_dev2dom(struct hv_domain *hvdom, struct pci_dev *pdev)
+{
+	unsigned long flags;
+	u64 status;
+	enum hv_device_type dev_type;
+	struct hv_input_attach_device_domain *input;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain.partition_id = HV_PARTITION_ID_SELF;
+	input->device_domain.domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
+	input->device_domain.domain_id.id = hvdom->domid_num;
+
+	/* NB: Upon guest shutdown, device is re-attached to the default domain
+	 * without explicit detach.
+	 */
+	if (hv_l1vh_partition())
+		dev_type = HV_DEVICE_TYPE_LOGICAL;
+	else
+		dev_type = HV_DEVICE_TYPE_PCI;
+
+	input->device_id.as_uint64 = hv_build_devid_oftype(pdev, dev_type);
+
+	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		hv_status_err(status, "\n");
+
+	return hv_result_to_errno(status);
+}
+
+/* Caller must have validated that dev is a valid pci dev */
+static int hv_iommu_direct_attach_device(struct pci_dev *pdev)
+{
+	struct hv_input_attach_device *input;
+	u64 status;
+	int rc;
+	unsigned long flags;
+	union hv_device_id host_devid;
+	enum hv_device_type dev_type;
+	u64 ptid = hv_iommu_get_curr_partid();
+
+	if (ptid == HV_PARTITION_ID_INVALID) {
+		pr_err("Hyper-V: Invalid partition id in direct attach\n");
+		return -EINVAL;
+	}
+
+	if (hv_l1vh_partition())
+		dev_type = HV_DEVICE_TYPE_LOGICAL;
+	else
+		dev_type = HV_DEVICE_TYPE_PCI;
+
+	host_devid.as_uint64 = hv_build_devid_oftype(pdev, dev_type);
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input, 0, sizeof(*input));
+		input->partition_id = ptid;
+		input->device_id = host_devid;
+
+		/* Hypervisor associates logical_id with this device, and in
+		 * some hypercalls like retarget interrupts, logical_id must be
+		 * used instead of the BDF. It is a required parameter.
+		 */
+		input->attdev_flags.logical_id = 1;
+		input->logical_devid =
+			   hv_build_devid_oftype(pdev, HV_DEVICE_TYPE_LOGICAL);
+
+		status = hv_do_hypercall(HVCALL_ATTACH_DEVICE, input, NULL);
+		local_irq_restore(flags);
+
+		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
+			rc = hv_call_deposit_pages(NUMA_NO_NODE, ptid, 1);
+			if (rc)
+				break;
+		}
+	} while (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY);
+
+	if (!hv_result_success(status))
+		hv_status_err(status, "\n");
+
+	return hv_result_to_errno(status);
+}
+
+/* This to attach a device to both host app (like DPDK) and a guest VM */
+static int hv_iommu_attach_dev(struct iommu_domain *immdom, struct device *dev,
+			       struct iommu_domain *old)
+{
+	struct pci_dev *pdev;
+	int rc;
+	struct hv_domain *hvdom_new = to_hv_domain(immdom);
+	struct hv_domain *hvdom_prev = dev_iommu_priv_get(dev);
+
+	/* Only allow PCI devices for now */
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+
+	pdev = to_pci_dev(dev);
+
+	/* l1vh does not support host device (eg DPDK) passthru */
+	if (hv_l1vh_partition() && !hv_special_domain(hvdom_new) &&
+	    !hvdom_new->attached_dom)
+		return -EINVAL;
+
+	/*
+	 * VFIO does not do explicit detach calls, hence check first if we need
+	 * to detach first. Also, in case of guest shutdown, it's the VMM
+	 * thread that attaches it back to the hv_def_identity_dom, and
+	 * hvdom_prev will not be null then. It is null during boot.
+	 */
+	if (hvdom_prev)
+		if (!hv_l1vh_partition() || !hv_special_domain(hvdom_prev))
+			hv_iommu_detach_dev(&hvdom_prev->iommu_dom, dev);
+
+	if (hv_l1vh_partition() && hv_special_domain(hvdom_new)) {
+		dev_iommu_priv_set(dev, hvdom_new);  /* sets "private" field */
+		return 0;
+	}
+
+	if (hvdom_new->attached_dom)
+		rc = hv_iommu_direct_attach_device(pdev);
+	else
+		rc = hv_iommu_att_dev2dom(hvdom_new, pdev);
+
+	if (rc && hvdom_prev) {
+		int rc1;
+
+		if (hvdom_prev->attached_dom)
+			rc1 = hv_iommu_direct_attach_device(pdev);
+		else
+			rc1 = hv_iommu_att_dev2dom(hvdom_prev, pdev);
+
+		if (rc1)
+			pr_err("Hyper-V: iommu could not restore orig device state.. dev:%s\n",
+			       dev_name(dev));
+	}
+
+	if (rc == 0) {
+		dev_iommu_priv_set(dev, hvdom_new);  /* sets "private" field */
+		hvdom_new->num_attchd++;
+	}
+
+	return rc;
+}
+
+static void hv_iommu_det_dev_from_guest(struct hv_domain *hvdom,
+					struct pci_dev *pdev)
+{
+	struct hv_input_detach_device *input;
+	u64 status, log_devid;
+	unsigned long flags;
+
+	log_devid = hv_build_devid_oftype(pdev, HV_DEVICE_TYPE_LOGICAL);
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->partition_id = hv_iommu_get_curr_partid();
+	input->logical_devid = log_devid;
+	status = hv_do_hypercall(HVCALL_DETACH_DEVICE, input, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		hv_status_err(status, "\n");
+}
+
+static void hv_iommu_det_dev_from_dom(struct hv_domain *hvdom,
+				      struct pci_dev *pdev)
+{
+	u64 status, devid;
+	unsigned long flags;
+	struct hv_input_detach_device_domain *input;
+
+	devid = hv_build_devid_oftype(pdev, HV_DEVICE_TYPE_PCI);
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->device_id.as_uint64 = devid;
+	status = hv_do_hypercall(HVCALL_DETACH_DEVICE_DOMAIN, input, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		hv_status_err(status, "\n");
+}
+
+static void hv_iommu_detach_dev(struct iommu_domain *immdom, struct device *dev)
+{
+	struct pci_dev *pdev;
+	struct hv_domain *hvdom = to_hv_domain(immdom);
+
+	/* See the attach function, only PCI devices for now */
+	if (!dev_is_pci(dev))
+		return;
+
+	if (hvdom->num_attchd == 0)
+		pr_warn("Hyper-V: num_attchd is zero (%s)\n", dev_name(dev));
+
+	pdev = to_pci_dev(dev);
+
+	if (hvdom->attached_dom) {
+		hv_iommu_det_dev_from_guest(hvdom, pdev);
+
+		/* Do not reset attached_dom, hv_iommu_unmap_pages happens
+		 * next.
+		 */
+	} else {
+		hv_iommu_det_dev_from_dom(hvdom, pdev);
+	}
+
+	hvdom->num_attchd--;
+}
+
+static int hv_iommu_add_tree_mapping(struct hv_domain *hvdom,
+				     unsigned long iova, phys_addr_t paddr,
+				     size_t size, u32 flags)
+{
+	unsigned long irqflags;
+	struct hv_iommu_mapping *mapping;
+
+	mapping = kzalloc(sizeof(*mapping), GFP_ATOMIC);
+	if (!mapping)
+		return -ENOMEM;
+
+	mapping->paddr = paddr;
+	mapping->iova.start = iova;
+	mapping->iova.last = iova + size - 1;
+	mapping->flags = flags;
+
+	spin_lock_irqsave(&hvdom->mappings_lock, irqflags);
+	interval_tree_insert(&mapping->iova, &hvdom->mappings_tree);
+	spin_unlock_irqrestore(&hvdom->mappings_lock, irqflags);
+
+	return 0;
+}
+
+static size_t hv_iommu_del_tree_mappings(struct hv_domain *hvdom,
+					unsigned long iova, size_t size)
+{
+	unsigned long flags;
+	size_t unmapped = 0;
+	unsigned long last = iova + size - 1;
+	struct hv_iommu_mapping *mapping = NULL;
+	struct interval_tree_node *node, *next;
+
+	spin_lock_irqsave(&hvdom->mappings_lock, flags);
+	next = interval_tree_iter_first(&hvdom->mappings_tree, iova, last);
+	while (next) {
+		node = next;
+		mapping = container_of(node, struct hv_iommu_mapping, iova);
+		next = interval_tree_iter_next(node, iova, last);
+
+		/* Trying to split a mapping? Not supported for now. */
+		if (mapping->iova.start < iova)
+			break;
+
+		unmapped += mapping->iova.last - mapping->iova.start + 1;
+
+		interval_tree_remove(node, &hvdom->mappings_tree);
+		kfree(mapping);
+	}
+	spin_unlock_irqrestore(&hvdom->mappings_lock, flags);
+
+	return unmapped;
+}
+
+/* Return: must return exact status from the hypercall without changes */
+static u64 hv_iommu_map_pgs(struct hv_domain *hvdom,
+			    unsigned long iova, phys_addr_t paddr,
+			    unsigned long npages, u32 map_flags)
+{
+	u64 status;
+	int i;
+	struct hv_input_map_device_gpa_pages *input;
+	unsigned long flags, pfn = paddr >> HV_HYP_PAGE_SHIFT;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain.partition_id = HV_PARTITION_ID_SELF;
+	input->device_domain.domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
+	input->device_domain.domain_id.id = hvdom->domid_num;
+	input->map_flags = map_flags;
+	input->target_device_va_base = iova;
+
+	pfn = paddr >> HV_HYP_PAGE_SHIFT;
+	for (i = 0; i < npages; i++, pfn++)
+		input->gpa_page_list[i] = pfn;
+
+	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_GPA_PAGES, npages, 0,
+				     input, NULL);
+
+	local_irq_restore(flags);
+	return status;
+}
+
+/*
+ * The core VFIO code loops over memory ranges calling this function with
+ * the largest size from HV_IOMMU_PGSIZES. cond_resched() is in vfio_iommu_map.
+ */
+static int hv_iommu_map_pages(struct iommu_domain *immdom, ulong iova,
+			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			      int prot, gfp_t gfp, size_t *mapped)
+{
+	u32 map_flags;
+	int ret;
+	u64 status;
+	unsigned long npages, done = 0;
+	struct hv_domain *hvdom = to_hv_domain(immdom);
+	size_t size = pgsize * pgcount;
+
+	map_flags = HV_MAP_GPA_READABLE;	/* required */
+	map_flags |= prot & IOMMU_WRITE ? HV_MAP_GPA_WRITABLE : 0;
+
+	ret = hv_iommu_add_tree_mapping(hvdom, iova, paddr, size, map_flags);
+	if (ret)
+		return ret;
+
+	if (hvdom->attached_dom) {
+		*mapped = size;
+		return 0;
+	}
+
+	npages = size >> HV_HYP_PAGE_SHIFT;
+	while (done < npages) {
+		ulong completed, remain = npages - done;
+
+		status = hv_iommu_map_pgs(hvdom, iova, paddr, remain,
+					  map_flags);
+
+		completed = hv_repcomp(status);
+		done = done + completed;
+		iova = iova + (completed << HV_HYP_PAGE_SHIFT);
+		paddr = paddr + (completed << HV_HYP_PAGE_SHIFT);
+
+		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
+			ret = hv_call_deposit_pages(NUMA_NO_NODE,
+						    hv_current_partition_id,
+						    256);
+			if (ret)
+				break;
+		}
+		if (!hv_result_success(status))
+			break;
+	}
+
+	if (!hv_result_success(status)) {
+		size_t done_size = done << HV_HYP_PAGE_SHIFT;
+
+		hv_status_err(status, "pgs:%lx/%lx iova:%lx\n",
+			      done, npages, iova);
+		/*
+		 * lookup tree has all mappings [0 - size-1]. Below unmap will
+		 * only remove from [0 - done], we need to remove second chunk
+		 * [done+1 - size-1].
+		 */
+		hv_iommu_del_tree_mappings(hvdom, iova, size - done_size);
+		hv_iommu_unmap_pages(immdom, iova - done_size, pgsize,
+				     done, NULL);
+		if (mapped)
+			*mapped = 0;
+	} else
+		if (mapped)
+			*mapped = size;
+
+	return hv_result_to_errno(status);
+}
+
+static size_t hv_iommu_unmap_pages(struct iommu_domain *immdom, ulong iova,
+				   size_t pgsize, size_t pgcount,
+				   struct iommu_iotlb_gather *gather)
+{
+	unsigned long flags, npages;
+	struct hv_input_unmap_device_gpa_pages *input;
+	u64 status;
+	struct hv_domain *hvdom = to_hv_domain(immdom);
+	size_t unmapped, size = pgsize * pgcount;
+
+	unmapped = hv_iommu_del_tree_mappings(hvdom, iova, size);
+	if (unmapped < size)
+		pr_err("%s: could not delete all mappings (%lx:%lx/%lx)\n",
+		       __func__, iova, unmapped, size);
+
+	if (hvdom->attached_dom)
+		return size;
+
+	npages = size >> HV_HYP_PAGE_SHIFT;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+
+	input->device_domain.partition_id = HV_PARTITION_ID_SELF;
+	input->device_domain.domain_id.type = HV_DEVICE_DOMAIN_TYPE_S2;
+	input->device_domain.domain_id.id = hvdom->domid_num;
+	input->target_device_va_base = iova;
+
+	status = hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_GPA_PAGES, npages,
+				     0, input, NULL);
+	local_irq_restore(flags);
+
+	if (!hv_result_success(status))
+		hv_status_err(status, "\n");
+
+	return unmapped;
+}
+
+static phys_addr_t hv_iommu_iova_to_phys(struct iommu_domain *immdom,
+					 dma_addr_t iova)
+{
+	u64 paddr = 0;
+	unsigned long flags;
+	struct hv_iommu_mapping *mapping;
+	struct interval_tree_node *node;
+	struct hv_domain *hvdom = to_hv_domain(immdom);
+
+	spin_lock_irqsave(&hvdom->mappings_lock, flags);
+	node = interval_tree_iter_first(&hvdom->mappings_tree, iova, iova);
+	if (node) {
+		mapping = container_of(node, struct hv_iommu_mapping, iova);
+		paddr = mapping->paddr + (iova - mapping->iova.start);
+	}
+	spin_unlock_irqrestore(&hvdom->mappings_lock, flags);
+
+	return paddr;
+}
+
+/*
+ * Currently, hypervisor does not provide list of devices it is using
+ * dynamically. So use this to allow users to manually specify devices that
+ * should be skipped. (eg. hypervisor debugger using some network device).
+ */
+static struct iommu_device *hv_iommu_probe_device(struct device *dev)
+{
+	if (!dev_is_pci(dev))
+		return ERR_PTR(-ENODEV);
+
+	if (pci_devs_to_skip && *pci_devs_to_skip) {
+		int rc, pos = 0;
+		int parsed;
+		int segment, bus, slot, func;
+		struct pci_dev *pdev = to_pci_dev(dev);
+
+		do {
+			parsed = 0;
+
+			rc = sscanf(pci_devs_to_skip + pos, " (%x:%x:%x.%x) %n",
+				    &segment, &bus, &slot, &func, &parsed);
+			if (rc)
+				break;
+			if (parsed <= 0)
+				break;
+
+			if (pci_domain_nr(pdev->bus) == segment &&
+			    pdev->bus->number == bus &&
+			    PCI_SLOT(pdev->devfn) == slot &&
+			    PCI_FUNC(pdev->devfn) == func) {
+
+				dev_info(dev, "skipped by Hyper-V IOMMU\n");
+				return ERR_PTR(-ENODEV);
+			}
+			pos += parsed;
+
+		} while (pci_devs_to_skip[pos]);
+	}
+
+	/* Device will be explicitly attached to the default domain, so no need
+	 * to do dev_iommu_priv_set() here.
+	 */
+
+	return &hv_virt_iommu;
+}
+
+static void hv_iommu_probe_finalize(struct device *dev)
+{
+	struct iommu_domain *immdom = iommu_get_domain_for_dev(dev);
+
+	if (immdom && immdom->type == IOMMU_DOMAIN_DMA)
+		iommu_setup_dma_ops(dev);
+	else
+		set_dma_ops(dev, NULL);
+}
+
+static void hv_iommu_release_device(struct device *dev)
+{
+	struct hv_domain *hvdom = dev_iommu_priv_get(dev);
+
+	/* Need to detach device from device domain if necessary. */
+	if (hvdom)
+		hv_iommu_detach_dev(&hvdom->iommu_dom, dev);
+
+	dev_iommu_priv_set(dev, NULL);
+	set_dma_ops(dev, NULL);
+}
+
+static struct iommu_group *hv_iommu_device_group(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_device_group(dev);
+	else
+		return generic_device_group(dev);
+}
+
+static int hv_iommu_def_domain_type(struct device *dev)
+{
+	/* The hypervisor always creates this by default during boot */
+	return IOMMU_DOMAIN_IDENTITY;
+}
+
+static struct iommu_ops hv_iommu_ops = {
+	.capable	    = hv_iommu_capable,
+	.domain_alloc_identity	= hv_iommu_domain_alloc_identity,
+	.domain_alloc_paging	= hv_iommu_domain_alloc_paging,
+	.probe_device	    = hv_iommu_probe_device,
+	.probe_finalize     = hv_iommu_probe_finalize,
+	.release_device     = hv_iommu_release_device,
+	.def_domain_type    = hv_iommu_def_domain_type,
+	.device_group	    = hv_iommu_device_group,
+	.default_domain_ops = &(const struct iommu_domain_ops) {
+		.attach_dev   = hv_iommu_attach_dev,
+		.map_pages    = hv_iommu_map_pages,
+		.unmap_pages  = hv_iommu_unmap_pages,
+		.iova_to_phys = hv_iommu_iova_to_phys,
+		.free	      = hv_iommu_domain_free,
+	},
+	.owner		    = THIS_MODULE,
+};
+
+static void __init hv_initialize_special_domains(void)
+{
+	hv_def_identity_dom.iommu_dom.geometry = default_geometry;
+	hv_def_identity_dom.domid_num = HV_DEVICE_DOMAIN_ID_S2_DEFAULT; /* 0 */
+}
+
+static int __init hv_iommu_init(void)
+{
+	int ret;
+	struct iommu_device *iommup = &hv_virt_iommu;
+
+	if (!hv_is_hyperv_initialized())
+		return -ENODEV;
+
+	ret = iommu_device_sysfs_add(iommup, NULL, NULL, "%s", "hyperv-iommu");
+	if (ret) {
+		pr_err("Hyper-V: iommu_device_sysfs_add failed: %d\n", ret);
+		return ret;
+	}
+
+	/* This must come before iommu_device_register because the latter calls
+	 * into the hooks.
+	 */
+	hv_initialize_special_domains();
+
+	ret = iommu_device_register(iommup, &hv_iommu_ops, NULL);
+	if (ret) {
+		pr_err("Hyper-V: iommu_device_register failed: %d\n", ret);
+		goto err_sysfs_remove;
+	}
+
+	pr_info("Hyper-V IOMMU initialized\n");
+
+	return 0;
+
+err_sysfs_remove:
+	iommu_device_sysfs_remove(iommup);
+	return ret;
+}
+
+void __init hv_iommu_detect(void)
+{
+	if (no_iommu || iommu_detected)
+		return;
+
+	/* For l1vh, always expose an iommu unit */
+	if (!hv_l1vh_partition())
+		if (!(ms_hyperv.misc_features & HV_DEVICE_DOMAIN_AVAILABLE))
+			return;
+
+	iommu_detected = 1;
+	x86_init.iommu.iommu_init = hv_iommu_init;
+
+	pci_request_acs();
+}
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dfc516c1c719..2ad111727e82 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1767,4 +1767,10 @@ static inline unsigned long virt_to_hvpfn(void *addr)
 #define HVPFN_DOWN(x)	((x) >> HV_HYP_PAGE_SHIFT)
 #define page_to_hvpfn(page)	(page_to_pfn(page) * NR_HV_HYP_PAGES_IN_PAGE)
 
+#ifdef CONFIG_HYPERV_IOMMU
+void __init hv_iommu_detect(void);
+#else
+static inline void hv_iommu_detect(void) { }
+#endif /* CONFIG_HYPERV_IOMMU */
+
 #endif /* _HYPERV_H */
-- 
2.51.2.vfs.0.1


